Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B36C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A50B206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SZjSHxaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgCaKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:34:01 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1199 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgCaKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:34:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e831c670000>; Tue, 31 Mar 2020 03:33:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 03:34:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 03:34:00 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 10:33:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 31 Mar 2020 10:33:59 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.72.141]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e831c960000>; Tue, 31 Mar 2020 03:33:59 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/3] soc/tegra: fuse: Add custom SoC attributes
Date:   Tue, 31 Mar 2020 11:33:39 +0100
Message-ID: <20200331103341.19571-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585650791; bh=qFWE9zolmdQM2J8Nj3r5beOLH+FBFxp93xzvODPAXQw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=SZjSHxaZoL0mxcZjvs9FOxQN7vMbg+SMrJvDF926o3apt+czre+3RnzZ6kvwG0hj8
         /9zorMrqS9bxlVKNx5CBlHDGMsrhoJMoh9vWsezOEWF46/apgzMAeDT6UM0AM1ZiNw
         9pe9DchyjX6bNi0WyDWoZQ5ANm50Wo7yJonpc0o5BwTd75zliOBcqZ6kWmaQc9I3b3
         5idjywo7QVBV5hzEmzOJdn57PF3pVMrd63butW7qWrPAhuyQFn9FpoiRnCsWxj0CjP
         G0akhgjhU5+8zHMBzvAkH9bRrGOVWxD5gCIs6b5YSCPMUgnbGTAjuhm3HQpsFf5av6
         RMFx/B/kYi21A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a custom SoC attribute for Tegra to expose the HIDREV register
fields to userspace via the sysfs. This register provides additional
details about the type of device (eg, silicon, FPGA, etc) as well as
revision. Exposing this information is useful for identifying the
exact device revision and device type.

For Tegra devices up until Tegra186, the majorrev and minorrev fields of
the HIDREV register are used to determine the device revision and device
type. For Tegra194, the majorrev and minorrev fields only determine the
revision. Starting with Tegra194, there is an additional field,
pre_si_platform (which occupies bits 20-23), that now determines device
type. Therefore, for all Tegra devices, add a custom SoC attribute for
the majorrev and minorrev fields and for Tegra194 add an additional
attribute for the pre_si_platform field.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c    | 51 ++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra20.c  |  1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  6 +++
 drivers/soc/tegra/fuse/fuse.h          |  8 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 10 +++++
 5 files changed, 76 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 802717b9f6a3..639734dca5df 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -300,6 +300,56 @@ static void tegra_enable_fuse_clk(void __iomem *base)
 	writel(reg, base + 0x14);
 }
 
+static ssize_t tegra_soc_majorrev_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return sprintf(buf, "%d\n", tegra_get_major_rev());
+}
+
+static DEVICE_ATTR(majorrev, S_IRUGO, tegra_soc_majorrev_show,  NULL);
+
+static ssize_t tegra_soc_minorrev_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return sprintf(buf, "%d\n", tegra_get_minor_rev());
+}
+
+static DEVICE_ATTR(minorrev, S_IRUGO, tegra_soc_minorrev_show,  NULL);
+
+static struct attribute *tegra_soc_attr[] = {
+	&dev_attr_majorrev.attr,
+	&dev_attr_minorrev.attr,
+	NULL,
+};
+
+const struct attribute_group tegra_soc_attr_group = {
+	.attrs = tegra_soc_attr,
+};
+
+#ifdef CONFIG_ARCH_TEGRA_194_SOC
+static ssize_t tegra_soc_pre_si_plat_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%d\n", (tegra_read_chipid() >> 20) & 0xf);
+}
+
+static DEVICE_ATTR(pre_si_platform, S_IRUGO, tegra_soc_pre_si_plat_show,  NULL);
+
+static struct attribute *tegra194_soc_attr[] = {
+	&dev_attr_majorrev.attr,
+	&dev_attr_minorrev.attr,
+	&dev_attr_pre_si_platform.attr,
+	NULL,
+};
+
+const struct attribute_group tegra194_soc_attr_group = {
+	.attrs = tegra194_soc_attr,
+};
+#endif
+
 struct device * __init tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
@@ -312,6 +362,7 @@ struct device * __init tegra_soc_device_register(void)
 	attr->family = kasprintf(GFP_KERNEL, "Tegra");
 	attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_sku_info.revision);
 	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
+	attr->custom_attr_group = fuse->soc->soc_attr_group;
 
 	dev = soc_device_register(attr);
 	if (IS_ERR(dev)) {
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index d4aef9c4a94c..16aaa28573ac 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -164,4 +164,5 @@ const struct tegra_fuse_soc tegra20_fuse_soc = {
 	.speedo_init = tegra20_init_speedo_data,
 	.probe = tegra20_fuse_probe,
 	.info = &tegra20_fuse_info,
+	.soc_attr_group = &tegra_soc_attr_group,
 };
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e6037f900fb7..85accef41fa1 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -111,6 +111,7 @@ const struct tegra_fuse_soc tegra30_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra30_init_speedo_data,
 	.info = &tegra30_fuse_info,
+	.soc_attr_group = &tegra_soc_attr_group,
 };
 #endif
 
@@ -125,6 +126,7 @@ const struct tegra_fuse_soc tegra114_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra114_init_speedo_data,
 	.info = &tegra114_fuse_info,
+	.soc_attr_group = &tegra_soc_attr_group,
 };
 #endif
 
@@ -205,6 +207,7 @@ const struct tegra_fuse_soc tegra124_fuse_soc = {
 	.info = &tegra124_fuse_info,
 	.lookups = tegra124_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra124_fuse_lookups),
+	.soc_attr_group = &tegra_soc_attr_group,
 };
 #endif
 
@@ -290,6 +293,7 @@ const struct tegra_fuse_soc tegra210_fuse_soc = {
 	.info = &tegra210_fuse_info,
 	.lookups = tegra210_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra210_fuse_lookups),
+	.soc_attr_group = &tegra_soc_attr_group,
 };
 #endif
 
@@ -319,6 +323,7 @@ const struct tegra_fuse_soc tegra186_fuse_soc = {
 	.info = &tegra186_fuse_info,
 	.lookups = tegra186_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra186_fuse_lookups),
+	.soc_attr_group = &tegra_soc_attr_group,
 };
 #endif
 
@@ -348,5 +353,6 @@ const struct tegra_fuse_soc tegra194_fuse_soc = {
 	.info = &tegra194_fuse_info,
 	.lookups = tegra194_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra194_fuse_lookups),
+	.soc_attr_group = &tegra194_soc_attr_group,
 };
 #endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 94a059e577a1..9d4fc315a007 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -32,6 +32,8 @@ struct tegra_fuse_soc {
 
 	const struct nvmem_cell_lookup *lookups;
 	unsigned int num_lookups;
+
+	const struct attribute_group *soc_attr_group;
 };
 
 struct tegra_fuse {
@@ -64,6 +66,11 @@ void tegra_init_apbmisc(void);
 bool __init tegra_fuse_read_spare(unsigned int spare);
 u32 __init tegra_fuse_read_early(unsigned int offset);
 
+u8 tegra_get_major_rev(void);
+u8 tegra_get_minor_rev(void);
+
+extern const struct attribute_group tegra_soc_attr_group;
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_init_speedo_data(struct tegra_sku_info *sku_info);
 #endif
@@ -110,6 +117,7 @@ extern const struct tegra_fuse_soc tegra186_fuse_soc;
 
 #ifdef CONFIG_ARCH_TEGRA_194_SOC
 extern const struct tegra_fuse_soc tegra194_fuse_soc;
+extern const struct attribute_group tegra194_soc_attr_group;
 #endif
 
 #endif
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 089d9340564b..44a154ca16b5 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -37,6 +37,16 @@ u8 tegra_get_chip_id(void)
 	return (tegra_read_chipid() >> 8) & 0xff;
 }
 
+u8 tegra_get_major_rev(void)
+{
+	return (tegra_read_chipid() >> 4) & 0xf;
+}
+
+u8 tegra_get_minor_rev(void)
+{
+	return (tegra_read_chipid() >> 16) & 0xf;
+}
+
 u32 tegra_read_straps(void)
 {
 	WARN(!chipid, "Tegra ABP MISC not yet available\n");
-- 
2.17.1

