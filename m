Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F4C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33AB20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599157959;
	bh=Q2iRI2iRpNGltGA1cFaXvw0AZzOxzUGNruBxVIqsAWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/oWijCPZ7h3o+vYrQkiVzLxb+Ulgssu7ZSaTJ8uAuPzHrfrXvrGs+cQcEnpvRc/C
	 y6Xs0NpQBdEslnMFAiz6a2VJfPqgdNeJmRp7tg5fsx8iCYgQBwgE2ZWYaiHvk5tqE3
	 QDEKGrnN49zOLeA6kY0TAb17XW0fP71Oo8aYY/LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgICSci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgICSca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:32:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3EE208FE;
        Thu,  3 Sep 2020 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157949;
        bh=Q2iRI2iRpNGltGA1cFaXvw0AZzOxzUGNruBxVIqsAWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvUuuUZ6IesPY7ZnQ797u4acnXVzHNUP5aMd+z0eDNgfrrIdiYQq5Qq6s5W6GW5u9
         XD89EYCC/6VVKXucWxG39fOXE5/agoHa04x3k1mlTJ1N4goJWpnlwWKSsbLTX07pIT
         0QCYtzDiaY6ytUaC3F78ZLgU6aJbypy4MwjL4fAo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDu27-008xrJ-OE; Thu, 03 Sep 2020 19:32:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v2 3/4] irqchip/git-v3-its: Implement irq_retrigger callback for device-triggered LPIs
Date:   Thu,  3 Sep 2020 19:32:05 +0100
Message-Id: <20200903183206.104838-4-maz@kernel.org>
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

It is pretty easy to provide a retrigger callback for the ITS,
as it we already have the required support in terms of
irq_set_irqchip_state().

Note that this only works for device-generated LPIs, and not
the GICv4 doorbells, which should never have to be retriggered
anyway.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 95f097448f97..2808545a963e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1720,6 +1720,11 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_irq_retrigger(struct irq_data *d)
+{
+	return !its_irq_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
+}
+
 /*
  * Two favourable cases:
  *
@@ -1971,6 +1976,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
+	.irq_retrigger		= its_irq_retrigger,
 	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
-- 
2.28.0

