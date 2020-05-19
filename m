Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3620878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905108;
	bh=ETceS5yARBIur5hySytUSkticz4wlgZ6d9YCm3cxtPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SMtil8HXpQUek/zzXSaR5+5Kwnpqrv3dHfM7EnWFbV2zFTvbNCt2doLkoBgHHLcSg
	 uBogG20LIwh1iYC/gWxDP5QiEUgZ7qVWKL8YPc1QB+wZ/Gz0Su8a7wUBdEE2GQDeqr
	 zT0GbjdZom//Kw0ue9Bfj9943LEHKZMeSkHnz8dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgESQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B142081A;
        Tue, 19 May 2020 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905102;
        bh=ETceS5yARBIur5hySytUSkticz4wlgZ6d9YCm3cxtPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3yZhUlGNvJcRentzFVvLNeLIyti5dro9BGoBLWzXGOCw9ZpaxMTHWk9kUwZxuT3d
         MxFmp0fiJeK3uDMYmnao8e8HIguvnsF5UDrii/DgLlaC2/Qblj3zXE22znL5P4bzgk
         MI2gLoZBr+AH1PIrqdcPmOJKV98gF6MD5C39CrDU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4we-00Decy-QX; Tue, 19 May 2020 17:18:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 01/11] genirq: Add fasteoi IPI flow
Date:   Tue, 19 May 2020 17:17:45 +0100
Message-Id: <20200519161755.209565-2-maz@kernel.org>
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

For irqchips using the fasteoi flow, IPIs are a bit special.

They need to be EOId early (before calling the handler), as
funny things may happen in the handler (they do not necessarily
behave like a normal interrupt), and that the arch code is
already handling the stats.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 41e7e37a0928..7b0b789cfed4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -955,6 +955,32 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * The biggest differences with the IRQ version are that:
+ * - the interrupt is EOIed early, as the IPI could result in a context
+ *   switch, and we need to make sure the IPI can fire again
+ * - Stats are usually handled at the architecture level, so we ignore them
+ *   here
+ */
+void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
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
2.26.2

