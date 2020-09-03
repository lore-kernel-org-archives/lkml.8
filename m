Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35949C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B020709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599157975;
	bh=mVFpvmgbL9aHM0kUg80E2fSvuXkLZwtJPuuYUdX/F3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GZjeV1uaJ+bfFX+m+7GgSNpDOr2518fgW+sA2zFfXXYonpK3dGMBxfXOnMPT/ZSd
	 4s9EP+zBuj04a+vJNC2+CDxEXj+GLKHfmA6IX0Ve2ZFbSt0ifZvrjT7c7s5No1zon4
	 VSTb3gGw8AeAdhDmkTW84E/4YaWwmCVDdh+I8rxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgICScx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgICSc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:32:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED70208C7;
        Thu,  3 Sep 2020 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157948;
        bh=mVFpvmgbL9aHM0kUg80E2fSvuXkLZwtJPuuYUdX/F3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9xQhkthPp4XX1sCPcQtzZb4P9lPpzJy92vaBrzI/3ZcekzT6RxInICfA7cig8e7W
         vVlyqfeUzuFRIopmPX4E4dOItd0DpaDg7PrBlfQB77yFCm03xgIQ+tKXWafZSK6rKV
         RBCAxjuHPSDT8hfm2dyZZcU9do8eM2SFip8PeWJw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDu27-008xrJ-4I; Thu, 03 Sep 2020 19:32:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v2 2/4] irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
Date:   Thu,  3 Sep 2020 19:32:04 +0100
Message-Id: <20200903183206.104838-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903183206.104838-1-maz@kernel.org>
References: <20200903183206.104838-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net, tglx@linutronix.de, valentin.schneider@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

While digging around IRQCHIP_EOI_IF_HANDLED and irq/resend.c, it has come
to my attention that the IRQ resend situation seems a bit precarious for
the GIC(s).

When marking an IRQ with IRQS_PENDING, handle_fasteoi_irq() will bail out
and issue an irq_eoi(). Should the IRQ in question be re-enabled,
check_irq_resend() will trigger a SW resend, which will go through the flow
handler again and issue *another* irq_eoi() on the *same* IRQ
activation. This is something the GIC spec clearly describes as a bad idea:
any EOI must match a previous ACK.

Implement irq_chip.irq_retrigger() for the GIC chips by setting the GIC
pending bit of the relevant IRQ. After being called by check_irq_resend(),
this will eventually trigger a *new* interrupt which we will handle as usual.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-2-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 324f280ff606..b507bc7c5cda 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 #ifdef CONFIG_CPU_PM
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
@@ -1242,6 +1247,7 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
@@ -1258,6 +1264,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a27ba2cc1dce..e92ee2b6d7a5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -347,6 +347,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -417,6 +422,7 @@ static const struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
-- 
2.28.0

