Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C222020784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgC2U0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgC2U0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVT-0001JJ-Ex; Sun, 29 Mar 2020 22:26:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0BA341C0334;
        Sun, 29 Mar 2020 22:26:07 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:06 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Move doorbell management to the
 GICv4 abstraction layer
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-14-maz@kernel.org>
References: <20200304203330.4967-14-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551356668.28353.2398446991207213078.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ae699ad348cdcd416cbf28e8a02fc468780161f7
Gitweb:        https://git.kernel.org/tip/ae699ad348cdcd416cbf28e8a02fc468780161f7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:20 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 12:15:51 

irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction layer

In order to hide some of the differences between v4.0 and v4.1, move
the doorbell management out of the KVM code, and into the GICv4-specific
layer. This allows the calling code to ask for the doorbell when blocking,
and otherwise to leave the doorbell permanently disabled.

This matches the v4.1 code perfectly, and only results in a minor
refactoring of the v4.0 code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-14-maz@kernel.org
---
 drivers/irqchip/irq-gic-v4.c       | 45 ++++++++++++++++++++++++++---
 include/kvm/arm_vgic.h             |  1 +-
 include/linux/irqchip/arm-gic-v4.h |  3 +-
 virt/kvm/arm/vgic/vgic-v3.c        |  4 ++-
 virt/kvm/arm/vgic/vgic-v4.c        | 34 +++++++++-------------
 5 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index c01910d..117ba6d 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -87,6 +87,11 @@ static struct irq_domain *gic_domain;
 static const struct irq_domain_ops *vpe_domain_ops;
 static const struct irq_domain_ops *sgi_domain_ops;
 
+static bool has_v4_1(void)
+{
+	return !!sgi_domain_ops;
+}
+
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
 	int vpe_base_irq, i;
@@ -139,18 +144,50 @@ static int its_send_vpe_cmd(struct its_vpe *vpe, struct its_cmd_info *info)
 	return irq_set_vcpu_affinity(vpe->irq, info);
 }
 
-int its_schedule_vpe(struct its_vpe *vpe, bool on)
+int its_make_vpe_non_resident(struct its_vpe *vpe, bool db)
 {
-	struct its_cmd_info info;
+	struct irq_desc *desc = irq_to_desc(vpe->irq);
+	struct its_cmd_info info = { };
 	int ret;
 
 	WARN_ON(preemptible());
 
-	info.cmd_type = on ? SCHEDULE_VPE : DESCHEDULE_VPE;
+	info.cmd_type = DESCHEDULE_VPE;
+	if (has_v4_1()) {
+		/* GICv4.1 can directly deal with doorbells */
+		info.req_db = db;
+	} else {
+		/* Undo the nested disable_irq() calls... */
+		while (db && irqd_irq_disabled(&desc->irq_data))
+			enable_irq(vpe->irq);
+	}
+
+	ret = its_send_vpe_cmd(vpe, &info);
+	if (!ret)
+		vpe->resident = false;
+
+	return ret;
+}
+
+int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en)
+{
+	struct its_cmd_info info = { };
+	int ret;
+
+	WARN_ON(preemptible());
+
+	info.cmd_type = SCHEDULE_VPE;
+	if (has_v4_1()) {
+		info.g0en = g0en;
+		info.g1en = g1en;
+	} else {
+		/* Disabled the doorbell, as we're about to enter the guest */
+		disable_irq_nosync(vpe->irq);
+	}
 
 	ret = its_send_vpe_cmd(vpe, &info);
 	if (!ret)
-		vpe->resident = on;
+		vpe->resident = true;
 
 	return ret;
 }
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 9d53f54..6345790 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -70,6 +70,7 @@ struct vgic_global {
 
 	/* Hardware has GICv4? */
 	bool			has_gicv4;
+	bool			has_gicv4_1;
 
 	/* GIC system register CPU interface */
 	struct static_key_false gicv3_cpuif;
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 1b34100..34ed4b5 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -125,7 +125,8 @@ struct its_cmd_info {
 
 int its_alloc_vcpu_irqs(struct its_vm *vm);
 void its_free_vcpu_irqs(struct its_vm *vm);
-int its_schedule_vpe(struct its_vpe *vpe, bool on);
+int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en);
+int its_make_vpe_non_resident(struct its_vpe *vpe, bool db);
 int its_invall_vpe(struct its_vpe *vpe);
 int its_map_vlpi(int irq, struct its_vlpi_map *map);
 int its_get_vlpi(int irq, struct its_vlpi_map *map);
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index f45635a..1bc09b5 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -595,7 +595,9 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	/* GICv4 support? */
 	if (info->has_v4) {
 		kvm_vgic_global_state.has_gicv4 = gicv4_enable;
-		kvm_info("GICv4 support %sabled\n",
+		kvm_vgic_global_state.has_gicv4_1 = info->has_v4_1 && gicv4_enable;
+		kvm_info("GICv4%s support %sabled\n",
+			 kvm_vgic_global_state.has_gicv4_1 ? ".1" : "",
 			 gicv4_enable ? "en" : "dis");
 	}
 
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 46f8755..1eb0f8c 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -67,10 +67,10 @@
  * it. And if we've migrated our vcpu from one CPU to another, we must
  * tell the ITS (so that the messages reach the right redistributor).
  * This is done in two steps: first issue a irq_set_affinity() on the
- * irq corresponding to the vcpu, then call its_schedule_vpe(). You
- * must be in a non-preemptible context. On exit, another call to
- * its_schedule_vpe() tells the redistributor that we're done with the
- * vcpu.
+ * irq corresponding to the vcpu, then call its_make_vpe_resident().
+ * You must be in a non-preemptible context. On exit, a call to
+ * its_make_vpe_non_resident() tells the redistributor that we're done
+ * with the vcpu.
  *
  * Finally, the doorbell handling: Each vcpu is allocated an interrupt
  * which will fire each time a VLPI is made pending whilst the vcpu is
@@ -86,7 +86,8 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	struct kvm_vcpu *vcpu = info;
 
 	/* We got the message, no need to fire again */
-	if (!irqd_irq_disabled(&irq_to_desc(irq)->irq_data))
+	if (!kvm_vgic_global_state.has_gicv4_1 &&
+	    !irqd_irq_disabled(&irq_to_desc(irq)->irq_data))
 		disable_irq_nosync(irq);
 
 	vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last = true;
@@ -199,19 +200,11 @@ void vgic_v4_teardown(struct kvm *kvm)
 int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
-	struct irq_desc *desc = irq_to_desc(vpe->irq);
 
 	if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
 		return 0;
 
-	/*
-	 * If blocking, a doorbell is required. Undo the nested
-	 * disable_irq() calls...
-	 */
-	while (need_db && irqd_irq_disabled(&desc->irq_data))
-		enable_irq(vpe->irq);
-
-	return its_schedule_vpe(vpe, false);
+	return its_make_vpe_non_resident(vpe, need_db);
 }
 
 int vgic_v4_load(struct kvm_vcpu *vcpu)
@@ -232,18 +225,19 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	/* Disabled the doorbell, as we're about to enter the guest */
-	disable_irq_nosync(vpe->irq);
-
-	err = its_schedule_vpe(vpe, true);
+	err = its_make_vpe_resident(vpe, false, vcpu->kvm->arch.vgic.enabled);
 	if (err)
 		return err;
 
 	/*
 	 * Now that the VPE is resident, let's get rid of a potential
-	 * doorbell interrupt that would still be pending.
+	 * doorbell interrupt that would still be pending. This is a
+	 * GICv4.0 only "feature"...
 	 */
-	return irq_set_irqchip_state(vpe->irq, IRQCHIP_STATE_PENDING, false);
+	if (!kvm_vgic_global_state.has_gicv4_1)
+		err = irq_set_irqchip_state(vpe->irq, IRQCHIP_STATE_PENDING, false);
+
+	return err;
 }
 
 static struct vgic_its *vgic_get_its(struct kvm *kvm,
