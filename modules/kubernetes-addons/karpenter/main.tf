module "helm_addon" {
  source            = "../helm-addon"
  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  set_values        = local.set_values
  irsa_config       = local.irsa_config
  addon_context     = var.addon_context
}

resource "aws_iam_policy" "karpenter" {
  count       = try(var.addon_config["aws_iam_policy_arn"], "") == "" ? 1 : 0
  name        = "${var.addon_context.eks_cluster_id}-karpenter"
  description = "IAM Policy for Karpenter"
  policy      = data.aws_iam_policy_document.karpenter.json
}
