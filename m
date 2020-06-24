Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCA7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1A22080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593028732;
	bh=EgZrAvWzDmQAMyLU+ZPmEcgF2njzyvDT7jV5rtH7w0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GrQflSkXf9JuICvn5zDOVW0WtmOVfpttBLU20bpT96PJZea8M1fAX50jleaKXxNSZ
	 SSxRzLL24i+0Vyd0IUIGhxonVqjz/9Y0Qtdfi6fe6ITjFlYI7CtekJRYE353JNhTI9
	 O9rYPeBOfUc6sMlzoDEhz8P389j0mB83862cDmj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbgFXT6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391358AbgFXT6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:58:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAA22080C;
        Wed, 24 Jun 2020 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593028698;
        bh=EgZrAvWzDmQAMyLU+ZPmEcgF2njzyvDT7jV5rtH7w0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qevz0sOswH+NYnVEoqfSDe22ab9oUfxyRZNGZJBSDbk++UGCVphPSQ2CZQBqLmLNb
         xci9U1vvF0gEzVY0bOIYzIkX+AHRIgYQtE7Md+mylPQ0yHPJm2ek4ex6xmU7iBDKUy
         8XgVq4vw4z/JFGGwDf+sdrhSMxkRzeyL26pFUuXc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXE-006ABu-N4; Wed, 24 Jun 2020 20:58:16 +0100
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
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: [PATCH v2 01/17] genirq: Add fasteoi IPI flow
Date:   Wed, 24 Jun 2020 20:57:55 +0100
Message-Id: <20200624195811.435857-2-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624195811.435857-1-maz@kernel.org>
References: <20200624195811.435857-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For irqchips using the fasteoi flow, IPIs are a bit special.
They need to be EOI'd early (before calling the handler), as
funny things may happen in the handler (they do not necessarily
behave like a normal interrupt).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8d5bc2c237d7..726f94d8b8cc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -621,6 +621,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37a0928..b9c49a61f8bb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -955,6 +955,33 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * The biggest difference with the IRQ version is that the interrupt is
+ * EOIed early, as the IPI could result in a context switch, and we need to
+ * make sure the IPI can fire again. We also assume that the arch code has
+ * registered an action. If not, we are positively doomed.
+ */
+void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	__kstat_incr_irqs_this_cpu(desc);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+}
+
 /**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
-- 
2.27.0

