Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B33C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7975217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgBMIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:41:21 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40578 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgBMIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:41:21 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 326AA1A4069;
        Thu, 13 Feb 2020 09:41:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B98D1A92A4;
        Thu, 13 Feb 2020 09:41:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3BAC94029B;
        Thu, 13 Feb 2020 16:40:57 +0800 (SGT)
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
Subject: [PATCH V3] ARM: imx: Add missing of_node_put()
Date:   Thu, 13 Feb 2020 16:35:33 +0800
Message-Id: <1581582933-901-1-git-send-email-Anson.Huang@nxp.com>
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
Changes since V2:
	- introduce src_node in anatop.c for second usage of of_find_compatible_node
	  to make of_node_put() more clear for reader.
---
 arch/arm/mach-imx/anatop.c     | 6 ++++--
 arch/arm/mach-imx/gpc.c        | 1 +
 arch/arm/mach-imx/platsmp.c    | 1 +
 arch/arm/mach-imx/pm-imx6.c    | 2 ++
 arch/arm/mach-imx/pm-imx7ulp.c | 1 +
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 8fb68c0..ea4a596 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -94,7 +94,7 @@ void imx_anatop_post_resume(void)
 
 void __init imx_init_revision_from_anatop(void)
 {
-	struct device_node *np;
+	struct device_node *np, *src_np;
 	void __iomem *anatop_base;
 	unsigned int revision;
 	u32 digprog;
@@ -135,9 +135,10 @@ void __init imx_init_revision_from_anatop(void)
 			void __iomem *src_base;
 			u32 sbmr2;
 
-			np = of_find_compatible_node(NULL, NULL,
+			src_np = of_find_compatible_node(NULL, NULL,
 						     "fsl,imx6ul-src");
 			src_base = of_iomap(np, 0);
+			of_node_put(src_np);
 			WARN_ON(!src_base);
 			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
 			iounmap(src_base);
@@ -149,6 +150,7 @@ void __init imx_init_revision_from_anatop(void)
 			}
 		}
 	}
+	of_node_put(np);
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
 	imx_set_soc_revision(revision);
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
index 1c0ecad..dd34dff 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -655,6 +655,8 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
 
 	if (of_property_read_bool(np, "fsl,pmic-stby-poweroff"))
 		imx6_pm_stby_poweroff_probe();
+
+	of_node_put(np);
 }
 
 void __init imx6q_pm_init(void)
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

