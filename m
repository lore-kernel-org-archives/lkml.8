Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334CC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7889A20774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586857909;
	bh=16xysAwkQyw0ZZUcYnRpTMJ9bthS1tFeA/pMqxFyUR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7IZtxX05zxR8NWO/JtUTtvr5zzIXXBqt43oqQeJ8/yaliOkvLEzIfvIbkiNqdiQr
	 noUsAW3klrct0CAqnURvYeVd6yI7TovTead3lL4ae2P0osbsVz/qo0r1rJmSGEhU06
	 FgmBVLm0lnimsTVAAXPijgePRWIyAJqrXbEzUExM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437982AbgDNJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437932AbgDNJuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:50:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77492074D;
        Tue, 14 Apr 2020 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586857820;
        bh=16xysAwkQyw0ZZUcYnRpTMJ9bthS1tFeA/pMqxFyUR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiyZi1+DAriBltQfBn5MeT++nwnFLDJZFoU9ocf/CJqsOqxHz52ekGtp7U6U241Dj
         JdUOTiLu4qmm/hdYoRGFb+PHm4QoNavgw2S1q/z9sDxtetSVrVdT9/R04264BP8Pp9
         l6f83ud/7i7prNwEpwgUpAX9vWj4QVkv3j+Y8PlY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOICw-0036Cw-7r; Tue, 14 Apr 2020 10:50:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling
Date:   Tue, 14 Apr 2020 10:50:12 +0100
Message-Id: <20200414095013.2821418-2-maz@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414095013.2821418-1-maz@kernel.org>
References: <20200414095013.2821418-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, yuzenghui@huawei.com, eric.auger@redhat.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a vPE is made resident, the GIC starts parsing the virtual pending
table to deliver pending interrupts. This takes place asynchronously,
and can at times take a long while. Long enough that the vcpu enters
the guest and hits WFI before any interrupt has been signaled yet.
The vcpu then exits, blocks, and now gets a doorbell. Rince, repeat.

In order to avoid the above, a (optional on GICv4, mandatory on v4.1)
feature allows the GIC to feedback to the hypervisor whether it is
done parsing the VPT by clearing the GICR_VENPENDBASER.Dirty bit.
The hypervisor can then wait until the GIC is ready before actually
running the vPE.

Plug the detection code as well as polling on vPE schedule. While
at it, tidy-up the kernel message that displays the GICv4 optional
features.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       | 11 +++++++----
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 54d142ccc63a..e24a145f17f6 100644
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
@@ -3672,6 +3673,20 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
+static void its_wait_vpend_dirty_clear(void)
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
+	its_wait_vpend_dirty_clear();
 }
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
@@ -3910,6 +3927,8 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
 
 	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	its_wait_vpend_dirty_clear();
 }
 
 static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9dbc81b6f62e..d7006ef18a0d 100644
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
index 765d9b769b69..6c36b6cc3edf 100644
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
-- 
2.25.1

