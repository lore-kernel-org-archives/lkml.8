Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD9AC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E88721D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDQJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgDQJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:56:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF43C061A0F;
        Fri, 17 Apr 2020 02:56:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPNjq-0005g1-Nv; Fri, 17 Apr 2020 11:56:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 606541C03A9;
        Fri, 17 Apr 2020 11:56:46 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:56:46 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Add support for VPENDBASER's
 Dirty+Valid signaling
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158711740603.28353.4181366508646401603.tip-bot2@tip-bot2>
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

Commit-ID:     96806229ca033f85310bc5c203410189f8a1d2ee
Gitweb:        https://git.kernel.org/tip/96806229ca033f85310bc5c203410189f8a1d2ee
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 10 Apr 2020 11:13:26 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Apr 2020 10:28:12 +01:00

irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling

When a vPE is made resident, the GIC starts parsing the virtual pending
table to deliver pending interrupts. This takes place asynchronously,
and can at times take a long while. Long enough that the vcpu enters
the guest and hits WFI before any interrupt has been signaled yet.
The vcpu then exits, blocks, and now gets a doorbell. Rince, repeat.

In order to avoid the above, a (optional on GICv4, mandatory on v4.1)
feature allows the GIC to feedback to the hypervisor whether it is
done parsing the VPT by clearing the GICR_VPENDBASER.Dirty bit.
The hypervisor can then wait until the GIC is ready before actually
running the vPE.

Plug the detection code as well as polling on vPE schedule. While
at it, tidy-up the kernel message that displays the GICv4 optional
features.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       | 11 +++++++----
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 54d142c..affd325 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -14,6 +14,7 @@
 #include <linux/dma-iommu.h>
 #include <linux/efi.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/log2.h>
@@ -3672,6 +3673,20 @@ out:
 	return IRQ_SET_MASK_OK_DONE;
 }
 
+static void its_wait_vpt_parse_complete(void)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val;
+
+	if (!gic_rdists->has_vpend_valid_dirty)
+		return;
+
+	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
+						val,
+						!(val & GICR_VPENDBASER_Dirty),
+						10, 500));
+}
+
 static void its_vpe_schedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
@@ -3702,6 +3717,8 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= vpe->idai ? GICR_VPENDBASER_IDAI : 0;
 	val |= GICR_VPENDBASER_Valid;
 	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	its_wait_vpt_parse_complete();
 }
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
@@ -3910,6 +3927,8 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
 
 	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	its_wait_vpt_parse_complete();
 }
 
 static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9dbc81b..d7006ef 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -873,6 +873,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
 	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
 					   gic_data.rdists.has_rvpeid);
+	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
 
 	/* Detect non-sensical configurations */
 	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
@@ -893,10 +894,11 @@ static void gic_update_rdist_properties(void)
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
 	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
-		!gic_data.rdists.has_vlpis ? "no " : "",
-		!gic_data.rdists.has_direct_lpi ? "no " : "",
-		!gic_data.rdists.has_rvpeid ? "no " : "");
+	if (gic_data.rdists.has_vlpis)
+		pr_info("GICv4 features: %s%s%s\n",
+			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
+			gic_data.rdists.has_rvpeid ? "RVPEID " : "",
+			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
 
 /* Check whether it's single security state view */
@@ -1620,6 +1622,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
+	gic_data.rdists.has_vpend_valid_dirty = true;
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 765d9b7..6c36b6c 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -243,6 +243,7 @@
 
 #define GICR_TYPER_PLPIS		(1U << 0)
 #define GICR_TYPER_VLPIS		(1U << 1)
+#define GICR_TYPER_DIRTY		(1U << 2)
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
 #define GICR_TYPER_RVPEID		(1U << 7)
@@ -686,6 +687,7 @@ struct rdists {
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
+	bool			has_vpend_valid_dirty;
 };
 
 struct irq_domain;
