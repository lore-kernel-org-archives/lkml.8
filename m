Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C9CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F77206EB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCOJzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:55:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgCOJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:55:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jDPzg-0007OS-2W; Sun, 15 Mar 2020 10:55:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 823BB1C1A14;
        Sun, 15 Mar 2020 10:55:39 +0100 (CET)
Date:   Sun, 15 Mar 2020 09:55:39 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3: Workaround Cavium erratum 38539
 when reading GICD_TYPER2
Cc:     Marc Zyngier <maz@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Mark Salter <msalter@redhat.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191027144234.8395-11-maz@kernel.org>
References: <20191027144234.8395-11-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158426613916.28353.17185941880218823765.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d01fd161e85904064290435f67f4ed59af5daf74
Gitweb:        https://git.kernel.org/tip/d01fd161e85904064290435f67f4ed59af5daf74
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 11 Mar 2020 11:56:49 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 14 Mar 2020 10:15:19 

irqchip/gic-v3: Workaround Cavium erratum 38539 when reading GICD_TYPER2

Despite the architecture spec requiring that reserved registers in the GIC
distributor memory map are RES0 (and thus are not allowed to generate
an exception), the Cavium ThunderX (aka TX1) SoC explodes as such:

[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 128 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc4-00035-g3cf6a3d5725f #7956
[    0.000000] Hardware name: cavium,thunder-88xx (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : __raw_readl+0x0/0x8
[    0.000000] lr : gic_init_bases+0x110/0x560
[    0.000000] sp : ffff800011243d90
[    0.000000] x29: ffff800011243d90 x28: 0000000000000000
[    0.000000] x27: 0000000000000018 x26: 0000000000000002
[    0.000000] x25: ffff8000116f0000 x24: ffff000fbe6a2c80
[    0.000000] x23: 0000000000000000 x22: ffff010fdc322b68
[    0.000000] x21: ffff800010a7a208 x20: 00000000009b0404
[    0.000000] x19: ffff80001124dad0 x18: 0000000000000010
[    0.000000] x17: 000000004d8d492b x16: 00000000f67eb9af
[    0.000000] x15: ffffffffffffffff x14: ffff800011249908
[    0.000000] x13: ffff800091243ae7 x12: ffff800011243af4
[    0.000000] x11: ffff80001126e000 x10: ffff800011243a70
[    0.000000] x9 : 00000000ffffffd0 x8 : ffff80001069c828
[    0.000000] x7 : 0000000000000059 x6 : ffff8000113fb4d1
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
[    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
[    0.000000] x1 : 0000000000000000 x0 : ffff8000116f000c
[    0.000000] Call trace:
[    0.000000]  __raw_readl+0x0/0x8
[    0.000000]  gic_of_init+0x188/0x224
[    0.000000]  of_irq_init+0x200/0x3cc
[    0.000000]  irqchip_init+0x1c/0x40
[    0.000000]  init_IRQ+0x160/0x1d0
[    0.000000]  start_kernel+0x2ec/0x4b8
[    0.000000] Code: a8c47bfd d65f03c0 d538d080 d65f03c0 (b9400000)

when reading the GICv4.1 GICD_TYPER2 register, which is unexpected...

Work around it by adding a new quirk for the following variants:

 ThunderX: CN88xx
 OCTEON TX: CN83xx, CN81xx
 OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*

and use this flag to avoid accessing GICD_TYPER2. Note that all
reserved registers (including redistributors and ITS) are impacted
by this erratum, but that only GICD_TYPER2 has to be worked around
so far.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Robert Richter <rrichter@marvell.com>
Tested-by: Mark Salter <msalter@redhat.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Robert Richter <rrichter@marvell.com>
Link: https://lore.kernel.org/r/20191027144234.8395-11-maz@kernel.org
Link: https://lore.kernel.org/r/20200311115649.26060-1-maz@kernel.org
---
 Documentation/arm64/silicon-errata.rst |  2 ++-
 drivers/irqchip/irq-gic-v3.c           | 30 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 99b2545..a1563da 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -108,6 +108,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
 +----------------+-----------------+-----------------+-----------------------------+
+| Cavium         | ThunderX GICv3  | #38539          | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c1f7af9..1eec9d4 100644
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
@@ -1503,6 +1513,19 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_hip06_07,
 	},
 	{
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
+	{
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
