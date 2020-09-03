Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2425EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC27F20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599157961;
	bh=KjzQo3s4NSxmm7KztdtA2PGL3W2R+mEIjOYhxHvZr1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMSitUl+YireEFgIAremN+hGxG/9sx8OCoI0Hpay/bxDAg8uKLOome+YDDNVptFzZ
	 acPg5Gzk2NFzC09iPeUSVUimHXEjYQHqTGkO1Ukpcc+kSv+mGja72FOL7hxP85I6a/
	 MLPIv2/MxaRvnW1kfiXL6HERuVyOeX6QGcMoqtu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgICSck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbgICSc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:32:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0851208CA;
        Thu,  3 Sep 2020 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157948;
        bh=KjzQo3s4NSxmm7KztdtA2PGL3W2R+mEIjOYhxHvZr1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaPa7mVtZeENp1aOBZCK/RHEyumNjKPU32TtAsKt5ZJR2S5Gj53h1w7GvlN+jK79x
         opGAIw5m+nkNI4eSa6tftq5SvTmC88O6CSW6QaJKNOGUgBkctBpqmkczpkxHoaKDAm
         fss4/r4gQpLAOXRETrrgSPXXZDqYPj/mTZVYnlS0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDu26-008xrJ-Jj; Thu, 03 Sep 2020 19:32:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v2 1/4] genirq: Walk the irq_data hierarchy when resending an interrupt
Date:   Thu,  3 Sep 2020 19:32:03 +0100
Message-Id: <20200903183206.104838-2-maz@kernel.org>
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

On resending an interrupt, we only check the topmost irqchip for
a irq_retrigger callback. However, this callback could be implemented
at a lower level. Use irq_chip_retrigger_hierarchy() in this case.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/resend.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index c48ce19a257f..8ccd32a0cc80 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -86,6 +86,18 @@ static int irq_sw_resend(struct irq_desc *desc)
 }
 #endif
 
+static int try_retrigger(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_retrigger)
+		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irq_chip_retrigger_hierarchy(&desc->irq_data);
+#else
+	return 0;
+#endif
+}
+
 /*
  * IRQ resend
  *
@@ -113,8 +125,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
 
 	desc->istate &= ~IRQS_PENDING;
 
-	if (!desc->irq_data.chip->irq_retrigger ||
-	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+	if (!try_retrigger(desc))
 		err = irq_sw_resend(desc);
 
 	/* If the retrigger was successfull, mark it with the REPLAY bit */
-- 
2.28.0

