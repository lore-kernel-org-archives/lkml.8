Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2153520737
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgCOPQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50154 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgCOPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:17 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzp-0001hv-BW; Sun, 15 Mar 2020 16:16:09 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6336B101305;
        Sun, 15 Mar 2020 16:16:08 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.6-rc6
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Message-ID: <158428527863.14940.18079500436167505465.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-03-15

up to:  92c227554c8e: Merge tag 'irqchip-fixes-5.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A single commit to handle an erratum in Cavium ThunderX to prevent access
to GIC registers which miss in the implementation.

Thanks,

	tglx

------------------>
Marc Zyngier (1):
      irqchip/gic-v3: Workaround Cavium erratum 38539 when reading GICD_TYPER2


 Documentation/arm64/silicon-errata.rst |  2 ++
 drivers/irqchip/irq-gic-v3.c           | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9120e59578dc..2c08c628febd 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -110,6 +110,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
 +----------------+-----------------+-----------------+-----------------------------+
+| Cavium         | ThunderX GICv3  | #38539          | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c1f7af9d9ae7..1eec9d4649d5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -34,6 +34,7 @@
 #define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
+#define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 
 struct redist_region {
 	void __iomem		*redist_base;
@@ -1464,6 +1465,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_cavium_38539(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539;
+
+	return true;
+}
+
 static bool gic_enable_quirk_hip06_07(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1502,6 +1512,19 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= gic_enable_quirk_hip06_07,
 	},
+	{
+		/*
+		 * Reserved register accesses generate a Synchronous
+		 * External Abort. This erratum applies to:
+		 * - ThunderX: CN88xx
+		 * - OCTEON TX: CN83xx, CN81xx
+		 * - OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
+		 */
+		.desc	= "GICv3: Cavium erratum 38539",
+		.iidr	= 0xa000034c,
+		.mask	= 0xe8f00fff,
+		.init	= gic_enable_quirk_cavium_38539,
+	},
 	{
 	}
 };
@@ -1577,7 +1600,12 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
 
-	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
+	/*
+	 * ThunderX1 explodes on reading GICD_TYPER2, in violation of the
+	 * architecture spec (which says that reserved registers are RES0).
+	 */
+	if (!(gic_data.flags & FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539))
+		gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);

