Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CDBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608F920709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599157966;
	bh=6wub28gs5+fBev2yTGhML3BnUAe8fOFpQvo25K79KTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bv7WexlUeX+sAsX7M05LB6x9HP8/bj0qXGfY2hAP5BpK1tT+X5UaKcnK56eQUU+N6
	 ULWQYQHUHayEKWe5FxoGoS90NIsXuRd7xInU9TEYkXFZDfynAtxqyqXnQ9Dis0NLZZ
	 Xigqdcatzv/wX58PTtD39hXCflPOSUEMEPWlszko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgICScp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgICScb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:32:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0192A2098B;
        Thu,  3 Sep 2020 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157950;
        bh=6wub28gs5+fBev2yTGhML3BnUAe8fOFpQvo25K79KTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpbFukMjTPAa6POxBVrBgqiRXhGQDb1VSe6zQ1l8vw9HRdLKzuqt59A9nud39V8xT
         yV16mCjoIldLQqQ/MIAaw3+mwaEzyTFGtKmX895Pv0q8ZCdthy5hZex2/IUZ/nEqaw
         FtvovhrrvqhgpMp0XguBlpLj0gLx2oBsreCVlGjY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDu28-008xrJ-9t; Thu, 03 Sep 2020 19:32:28 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v2 4/4] irqchip/gic-v2, v3: Prevent SW resends entirely
Date:   Thu,  3 Sep 2020 19:32:06 +0100
Message-Id: <20200903183206.104838-5-maz@kernel.org>
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

The GIC irqchips can now use a HW resend when a retrigger is invoked by
check_irq_resend(). However, should the HW resend fail, check_irq_resend()
will still attempt to trigger a SW resend, which is still a bad idea for
the GICs.

Prevent this from happening by setting IRQD_HANDLE_ENFORCE_IRQCTX on all
GIC IRQs. Technically per-cpu IRQs do not need this, as their flow handlers
never set IRQS_PENDING, but this aligns all IRQs wrt context enforcement:
this also forces all GIC IRQ handling to happen in IRQ context (as defined
by in_irq()).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-3-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 drivers/irqchip/irq-gic.c    | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b507bc7c5cda..4e9387aafed8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1279,6 +1279,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &gic_chip;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
@@ -1296,7 +1297,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 		break;
 
 	case LPI_RANGE:
@@ -1310,6 +1311,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	}
 
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e92ee2b6d7a5..b59bcef69bf3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -975,6 +975,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
 	struct gic_chip_data *gic = d->host_data;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
@@ -984,8 +985,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 	}
+
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
-- 
2.28.0

