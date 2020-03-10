Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A2222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866182;
	bh=unCX+t/zqE6eNvK2oVqS1Vr7/wodzuZVkgvAgzYg+gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PIvXSz929Cs4DyBRY9gbHapHhBLVeW0PlKqnezd+LVU6raUlEiL6IGKDy0G7+Rrmd
	 iL3WXEnrJTWypTMX1dLrIklul2Cr7ap6lSPgKYB+bnImcvMBs6SXnWpmaCxZsJ2Oli
	 0Q1c4YiVKdnnYFABLOjlof6qza0CFekAhd5Qm49c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCJStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgCJStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9404320873;
        Tue, 10 Mar 2020 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866170;
        bh=unCX+t/zqE6eNvK2oVqS1Vr7/wodzuZVkgvAgzYg+gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmJu1/U/6X+arNuaUz0kbM5fshnGIOQgGAbFGh8rA/F6TUTjCBBP2O2mydxqnzNP4
         loNOgVAf7RxFZkMnRvg118macTBUuCA1FxuaQYh0jYE0urtSJLfA7Bq5MK2S/F/7gb
         vLHJOH7AAgNz5acJBn2jHcwWP7NSYoMLbiw+zbs4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwW-00Bi6k-SD; Tue, 10 Mar 2020 18:49:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/4] irqchip/atmel-aic5: Fix irq_retrigger callback return value
Date:   Tue, 10 Mar 2020 18:49:19 +0000
Message-Id: <20200310184921.23552-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310184921.23552-1-maz@kernel.org>
References: <20200310184921.23552-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, linux@arm.linux.org.uk, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_retrigger callback is supposed to return 0 when retrigger
has failed, and a non-zero value otherwise. Tell the core code
that the driver has succedded in using the HW to retrigger the
interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 29333497ba10..fc1b3a9cdafc 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -128,7 +128,7 @@ static int aic5_retrigger(struct irq_data *d)
 	irq_reg_writel(bgc, 1, AT91_AIC5_ISCR);
 	irq_gc_unlock(bgc);
 
-	return 0;
+	return 1;
 }
 
 static int aic5_set_type(struct irq_data *d, unsigned type)
-- 
2.20.1

