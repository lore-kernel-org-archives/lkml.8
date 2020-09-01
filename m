Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AFFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0621941
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971448;
	bh=VErNzrV3GQ0m6Yw7LkirK9OF7d67zDjQWtyJngmT8SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLHEdN/7aPmTExsPxNF8NUirIKq0PuN7iNvVcvfHlKaIB2pW3p6esxW0dqbDWvHgn
	 QdhohUiLVaQBylbBqQb+9HQZWcVVqWgcosEeT3g3AnykrE/iiWQAFGI2ruYRzpi2gp
	 dVxZ4+WefZ/mqkRnqoh6GIQjJWYyX1dBKmMBJB6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIAOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgIAOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC27C21655;
        Tue,  1 Sep 2020 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971412;
        bh=VErNzrV3GQ0m6Yw7LkirK9OF7d67zDjQWtyJngmT8SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p96r7uXFPh22IbqY/ps+htbDCx8qMCUenmhXESZ0GSsFxO+cGqnMikAn+rPLDw2Nw
         Bg+pspnRuLlK3kIt5r8wc5rt8AmAOafLrzkRtcbytYjv0ZGc8xTF5AIdSPNTIVecyS
         J0+nV3gQVgMSm0XO2vOJJP7Mx4KApmHxOlE5vFfw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VT-008IQP-4K; Tue, 01 Sep 2020 15:43:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 02/16] genirq: Allow interrupts to be excluded from /proc/interrupts
Date:   Tue,  1 Sep 2020 15:43:10 +0100
Message-Id: <20200901144324.1071694-3-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of architectures implement IPI statistics directly,
duplicating the core kstat_irqs accounting. As we move IPIs to
being actual IRQs, we would end-up with a confusing display
in /proc/interrupts (where the IPIs would appear twice).

In order to solve this, allow interrupts to be flagged as
"hidden", which excludes them from /proc/interrupts.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   | 4 +++-
 kernel/irq/debugfs.c  | 1 +
 kernel/irq/proc.c     | 2 +-
 kernel/irq/settings.h | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 57205bbf46bf..63b9d962ee67 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -71,6 +71,7 @@ enum irqchip_irq_state;
  *				  it from the spurious interrupt detection
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
+ * IRQ_HIDDEN			- Don't show up in /proc/interrupts
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -97,13 +98,14 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
+	IRQ_HIDDEN		= (1 << 20),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index b95ff5d5f4bd..acabc0c0e46b 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -136,6 +136,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_PER_CPU_DEVID),
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
+	BIT_MASK_DESCR(_IRQ_HIDDEN),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d7bc03..72513ed2a5fc 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc)
+	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs)
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index e43795cd2ccf..403378b9947b 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,6 +17,7 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
+	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -31,6 +32,7 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
+#define IRQ_HIDDEN		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -167,3 +169,8 @@ static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 {
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
 }
+
+static inline bool irq_settings_is_hidden(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_HIDDEN;
+}
-- 
2.27.0

