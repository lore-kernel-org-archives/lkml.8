Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93088C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645F420722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sNfyym7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTLhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:37:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4615 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgCTLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:37:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e74aaf50000>; Fri, 20 Mar 2020 04:37:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Mar 2020 04:37:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 04:37:38 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 11:37:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 20 Mar 2020 11:37:38 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.72.141]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e74ab010001>; Fri, 20 Mar 2020 04:37:38 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: Add custom SoC attributes
Date:   Fri, 20 Mar 2020 11:37:16 +0000
Message-ID: <20200320113716.6105-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584704245; bh=y8mJUEHfQPdhcg3b+lgsOBy/trP1EtR0UprZ5H9daTY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=sNfyym7CcbOwFOeJmoXAC5gHRdpSDO7ZnejrymcRWzQlVoJf3mhpqlDFSYu0+BJw2
         7FWAE7QfzQCr/tRvRUcwwwg7/7/NEK39wNbKmK9cRDX9y1c27nTs+3v95ehd6b0BF5
         Lny6jgOzIwtFlpuUgdvg0+Z/PE5Ou/aEPXwvYUspMHauAnm7209L91odT8EhD2xEVf
         nLtyOBiN+9w4te728uOJl9iCMjwZfbB0c0W5BV1Ajat5wCjt8ZxTD1q/CRWBQkWVZi
         6ym68LcBeonD4rRb7SCZuCmwFcFv0sR8k+o48aGNcHsbqJuVfhY4oLpedq2Cvzqfd9
         22ToR4zHSTRLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a custom SoC attribute for Tegra to expose the HIDREV register
contents to userspace via the sysfs. This register provides additional
details about the fabrication and versioning of the device. Exposing
this information is useful for identifying the exact device revision and
device type.

Please note that the fields in this register vary depending on the Tegra
generation and so instead of exposing the individual fields, just expose
the entire contents of the register. Details of the register fields can
be found in the Technical Reference Manual for each Tegra device.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 802717b9f6a3..217e326da232 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -300,6 +300,24 @@ static void tegra_enable_fuse_clk(void __iomem *base)
 	writel(reg, base + 0x14);
 }
 
+static ssize_t tegra_soc_hidrev_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", tegra_read_chipid());
+}
+
+static DEVICE_ATTR(hidrev, S_IRUGO, tegra_soc_hidrev_show,  NULL);
+
+static struct attribute *tegra_soc_attr[] = {
+	&dev_attr_hidrev.attr,
+	NULL,
+};
+
+static const struct attribute_group tegra_soc_attr_group = {
+	.attrs = tegra_soc_attr,
+};
+
 struct device * __init tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
@@ -312,6 +330,7 @@ struct device * __init tegra_soc_device_register(void)
 	attr->family = kasprintf(GFP_KERNEL, "Tegra");
 	attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_sku_info.revision);
 	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
+	attr->custom_attr_group = &tegra_soc_attr_group;
 
 	dev = soc_device_register(attr);
 	if (IS_ERR(dev)) {
-- 
2.17.1

