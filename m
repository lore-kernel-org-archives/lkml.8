Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A2AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EED5206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971484;
	bh=r6OMV+k73c/v0QmL2y5Q7v1wav2v6TvKpqSSTHWVU+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gCzvblrgaOLanvdPt2WVH1jmES90V4H8Us7aGycE8+jmT+2Ijq45QS5sVzGpTxyt
	 neoHZlG6EhRO0RUUc6kLmZrv5sUdmICFoaOtblacJQshy4VbTv8OzblTm0mHwZAGoZ
	 v5Vz0lZqdQmPA4ypG0Q8aOq94+JwwQ39kjX/cBFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIAOom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgIAOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28AA21941;
        Tue,  1 Sep 2020 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971412;
        bh=r6OMV+k73c/v0QmL2y5Q7v1wav2v6TvKpqSSTHWVU+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWwu1BBVScEbx1viQ7lWQQYUeaZcyHkffku82foe5R4M9aVbzbZAdwnDqPI8UW+3J
         xEERTFENt8vsnN44HSEHj4bXB6oXxFOZELdS3k7dNVTrXaumRXYW2SbZCIvhsRwMG7
         +kQ4Bp3uFkIQZckkv6GqBVYulB5ENfAnVBWHOxDs=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VR-008IQP-1j; Tue, 01 Sep 2020 15:43:30 +0100
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
Subject: [PATCH v3 01/16] genirq: Add fasteoi IPI flow
Date:   Tue,  1 Sep 2020 15:43:09 +0100
Message-Id: <20200901144324.1071694-2-maz@kernel.org>
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

For irqchips using the fasteoi flow, IPIs are a bit special.
They need to be EOI'd early (before calling the handler), as
funny things may happen in the handler (they do not necessarily
behave like a normal interrupt).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4dfee35b..57205bbf46bf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -634,6 +634,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 857f5f4c8098..bed517d5aa4d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -944,6 +944,33 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
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

