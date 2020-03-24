Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0906C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD1E208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gu1KIRI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCXLBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:01:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47152 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgCXLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:01:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OB1BJl096531;
        Tue, 24 Mar 2020 06:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585047671;
        bh=mCoC1qcgrvt5Jd1rtbEUopXvfznfiXWOQOm4Oevz5mQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gu1KIRI1aXtBf+31fshbJUyuVqwmK1kn32EJ/a8Jb86gxrChf6K7Um8pIcaKt+H5J
         m8mr5nFC8q7ojbKOaxdYotyhsXiKicGr6fEHzTlOyWxDX28UJsR6QSAxOzTYT+ERNC
         Nd7PzduzeiQmlcI/hX85n246bNwlbUv5q4/t6DUo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02OB1BM5037740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Mar 2020 06:01:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 06:01:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 06:01:10 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OB0rAr008648;
        Tue, 24 Mar 2020 06:01:09 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 07/15] remoteproc/omap: Add support for DRA7xx remote processors
Date:   Tue, 24 Mar 2020 13:00:27 +0200
Message-ID: <20200324110035.29907-8-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324110035.29907-1-t-kristo@ti.com>
References: <20200324110035.29907-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

DRA7xx/AM57xx SoCs have two IPU and up to two DSP processor subsystems
for offloading different computation algorithms. The IPU processor
subsystem contains dual-core ARM Cortex-M4 processors, and is very
similar to those on OMAP5. The DSP processor subsystem is based on
the TI's standard TMS320C66x DSP CorePac core.

Support has been added to the OMAP remoteproc driver through new
DRA7xx specific compatibles for properly probing and booting all
the different processor subsystem instances on DRA7xx/AM57xx
SoCs - IPU1, IPU2, DSP1 & DSP2. A build dependency with SOC_DRA7XX
is added to enable the driver to be built in DRA7xx-only configuration.

The DSP boot address programming needed enhancement for DRA7xx as the
boot register fields are different on DRA7 compared to OMAP4 and OMAP5
SoCs. The register on DRA7xx contains additional fields within the
register and the boot address bit-field is right-shifted by 10 bits.
The internal memory parsing logic has also been updated to compute
the device addresses for the L2 RAM for DSP devices using relative
addressing logic, and to parse two additional RAMs at L1 level - L1P
and L1D. This allows the remoteproc driver to support loading into
these regions for a small subset of firmware images requiring as
such. The most common usage would be to use the L1 programmable
RAMs as L1 Caches.

The firmware lookup logic also has to be adjusted for DRA7xx as
there are (can be) more than one instance of both the IPU and DSP
remote processors for the first time in OMAP4+ SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
[t-kristo@ti.com: moved address translation quirks to pdata]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v9:
  * rebased on top of rproc-next + fixes on earlier part of this eries

 drivers/remoteproc/Kconfig           |  2 +-
 drivers/remoteproc/omap_remoteproc.c | 38 +++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index de3862c15fcc..b52abc2268cc 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -35,7 +35,7 @@ config MTK_SCP
 
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
-	depends on ARCH_OMAP4 || SOC_OMAP5
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
 	depends on OMAP_IOMMU
 	select MAILBOX
 	select OMAP2PLUS_MBOX
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 473d7e3cdef8..604499275896 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -34,10 +34,13 @@
  * struct omap_rproc_boot_data - boot data structure for the DSP omap rprocs
  * @syscon: regmap handle for the system control configuration module
  * @boot_reg: boot register offset within the @syscon regmap
+ * @boot_reg_shift: bit-field shift required for the boot address value in
+ *		    @boot_reg
  */
 struct omap_rproc_boot_data {
 	struct regmap *syscon;
 	unsigned int boot_reg;
+	unsigned int boot_reg_shift;
 };
 
 /**
@@ -161,6 +164,8 @@ static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 	struct omap_rproc *oproc = rproc->priv;
 	struct omap_rproc_boot_data *bdata = oproc->boot_data;
 	u32 offset = bdata->boot_reg;
+	u32 value;
+	u32 mask;
 
 	if (rproc->bootaddr & (SZ_1K - 1)) {
 		dev_err(dev, "invalid boot address 0x%llx, must be aligned on a 1KB boundary\n",
@@ -168,7 +173,10 @@ static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 		return -EINVAL;
 	}
 
-	return regmap_write(bdata->syscon, offset, rproc->bootaddr);
+	value = rproc->bootaddr >> bdata->boot_reg_shift;
+	mask = ~(SZ_1K - 1) >> bdata->boot_reg_shift;
+
+	return regmap_update_bits(bdata->syscon, offset, mask, value);
 }
 
 /*
@@ -297,6 +305,13 @@ static const struct omap_rproc_mem_data ipu_mems[] = {
 	{ },
 };
 
+static const struct omap_rproc_mem_data dra7_dsp_mems[] = {
+	{ .name = "l2ram", .dev_addr = 0x800000 },
+	{ .name = "l1pram", .dev_addr = 0xe00000 },
+	{ .name = "l1dram", .dev_addr = 0xf00000 },
+	{ },
+};
+
 static const struct omap_rproc_dev_data omap4_dsp_dev_data = {
 	.device_name	= "dsp",
 };
@@ -315,6 +330,16 @@ static const struct omap_rproc_dev_data omap5_ipu_dev_data = {
 	.mems		= ipu_mems,
 };
 
+static const struct omap_rproc_dev_data dra7_dsp_dev_data = {
+	.device_name	= "dsp",
+	.mems		= dra7_dsp_mems,
+};
+
+static const struct omap_rproc_dev_data dra7_ipu_dev_data = {
+	.device_name	= "ipu",
+	.mems		= ipu_mems,
+};
+
 static const struct of_device_id omap_rproc_of_match[] = {
 	{
 		.compatible     = "ti,omap4-dsp",
@@ -332,6 +357,14 @@ static const struct of_device_id omap_rproc_of_match[] = {
 		.compatible     = "ti,omap5-ipu",
 		.data           = &omap5_ipu_dev_data,
 	},
+	{
+		.compatible     = "ti,dra7-dsp",
+		.data           = &dra7_dsp_dev_data,
+	},
+	{
+		.compatible     = "ti,dra7-ipu",
+		.data           = &dra7_ipu_dev_data,
+	},
 	{
 		/* end */
 	},
@@ -384,6 +417,9 @@ static int omap_rproc_get_boot_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	of_property_read_u32_index(np, "ti,bootreg", 2,
+				   &oproc->boot_data->boot_reg_shift);
+
 	return 0;
 }
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
