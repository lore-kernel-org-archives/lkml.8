Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7559DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4983C2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905135;
	bh=IgiMXXd078i0bvADAKNsFZGGm1aO3D3tizK5eShr9NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kD0KxQsN+V8aVe6g/Hqug/oeCYZQotS2GvL+lArGmYOVR8kujOMDqIIp8zOSIckLc
	 AYSGg5GPJls7KIUUzSouStRAFLHgJzcqDJHob0K8kSTTKe4MUMdbCFTK9JyI9kYNyx
	 rPMLZskhiEJZDjg8Ms8DO8eqO2nvIx6LgUb09zFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgESQSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgESQSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29602207D8;
        Tue, 19 May 2020 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905103;
        bh=IgiMXXd078i0bvADAKNsFZGGm1aO3D3tizK5eShr9NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdLFJs3+IBlicIHXUXreUUgV6J2RRngRlGDmTEGOoSYr0KZZVcg4YVLE0np8JKdyt
         YyMWc4vFPOqqeO01YRa3oiiL4kLhkhJEN1kTLoLpZEMbOoQ3/xn2Vj9dbIug34DtcC
         HESBIavRqWwtV9SXq43Y0l+qendJfHAR3aiAc5Po=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4wf-00Decy-Ev; Tue, 19 May 2020 17:18:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 02/11] genirq: Allow interrupts to be excluded from /proc/interrupts
Date:   Tue, 19 May 2020 17:17:46 +0100
Message-Id: <20200519161755.209565-3-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519161755.209565-1-maz@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of architectures implement IPI statistics directly,
bypassing the core kstat_irqs accounting. As we move IPIs to
being actual IRQs, we would end-up with a confusing display
in /proc/interrupts (where the IPIs would appear twice).

In order to solve this, allow interrupts to be flagged as
"no accounting", which excludes them from /proc/interrupts.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   | 3 ++-
 kernel/irq/debugfs.c  | 1 +
 kernel/irq/proc.c     | 2 +-
 kernel/irq/settings.h | 7 +++++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 726f94d8b8cc..4433c8e765c8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -97,13 +97,14 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
+	IRQ_NO_ACCOUNTING	= (1 << 20),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_NO_ACCOUNTING)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4f9f844074db..9a22eab5537f 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -131,6 +131,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_PER_CPU_DEVID),
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
+	BIT_MASK_DESCR(_IRQ_NO_ACCOUNTING),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d7bc03..87780af13c12 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc)
+	if (!desc || irq_settings_is_no_accounting(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs)
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index e43795cd2ccf..732fc3f2c686 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,6 +17,7 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
+	_IRQ_NO_ACCOUNTING	= IRQ_NO_ACCOUNTING,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -31,6 +32,7 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
+#define IRQ_NO_ACCOUNTING	GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -167,3 +169,8 @@ static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 {
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
 }
+
+static inline bool irq_settings_is_no_accounting(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NO_ACCOUNTING;
+}
-- 
2.26.2

