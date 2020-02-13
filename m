Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE36C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C841B21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgBMFxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:53:13 -0500
Received: from inva020.nxp.com ([92.121.34.13]:54182 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgBMFxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:53:12 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D5AF21A00A6;
        Thu, 13 Feb 2020 06:53:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 747671A5559;
        Thu, 13 Feb 2020 06:53:00 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 386994029B;
        Thu, 13 Feb 2020 13:52:49 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        tglx@linutronix.de, andrew.smirnov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, sakari.ailus@linux.intel.com,
        bhelgaas@google.com, dsterba@suse.com, peng.fan@nxp.com,
        okuno.kohji@jp.panasonic.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: imx: Add missing of_node_put()
Date:   Thu, 13 Feb 2020 13:47:26 +0800
Message-Id: <1581572846-4301-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After finishing using device node got from of_find_compatible_node(),
of_node_put() needs to be called.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/anatop.c     | 2 ++
 arch/arm/mach-imx/gpc.c        | 1 +
 arch/arm/mach-imx/platsmp.c    | 1 +
 arch/arm/mach-imx/pm-imx6.c    | 1 +
 arch/arm/mach-imx/pm-imx7ulp.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 8fb68c0..4fa727f 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -103,6 +103,7 @@ void __init imx_init_revision_from_anatop(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!anatop_base);
 	if (of_device_is_compatible(np, "fsl,imx6sl-anatop"))
 		offset = ANADIG_DIGPROG_IMX6SL;
@@ -138,6 +139,7 @@ void __init imx_init_revision_from_anatop(void)
 			np = of_find_compatible_node(NULL, NULL,
 						     "fsl,imx6ul-src");
 			src_base = of_iomap(np, 0);
+			of_node_put(np);
 			WARN_ON(!src_base);
 			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
 			iounmap(src_base);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index b5b557f..07f1972 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -282,4 +282,5 @@ void __init imx_gpc_check_dt(void)
 		/* map GPC, so that at least CPUidle and WARs keep working */
 		gpc_base = of_iomap(np, 0);
 	}
+	of_node_put(np);
 }
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 2aa2692..cf4e933 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -109,6 +109,7 @@ static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
 	dcfg_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!dcfg_base);
 
 	paddr = __pa_symbol(secondary_startup);
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 1c0ecad..c437f21 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -643,6 +643,7 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
 
 	np = of_find_compatible_node(NULL, NULL, ccm_compat);
 	ccm_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!ccm_base);
 
 	/*
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 7b2f738..2e756d8 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -62,6 +62,7 @@ void __init imx7ulp_pm_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
 	smc1_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!smc1_base);
 
 	imx7ulp_set_lpm(ULP_PM_RUN);
-- 
2.7.4

