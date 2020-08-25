Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17BF2078D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nlUWPRBt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o7glE5bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHYXlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYXkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804ADC061574;
        Tue, 25 Aug 2020 16:40:55 -0700 (PDT)
Date:   Tue, 25 Aug 2020 23:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uat1GxpRT7W86ovQZ+jEFRAgk5GSUbOoG1wBQOMnoyM=;
        b=nlUWPRBtYLGeiRj7rU/KL8FDnX0llzVtYw7HEFdRBlSCR9Gzt2EcGuJG9CThlVvPh7KRK4
        yTW4UgteUFnOpuYb6AIJP4dUe3jpYvvOKkv3VGuodxMVK0O+YY/jENJuAnoMS364ehqf+L
        icp0L5jszyhGmu+UA+7GYgLKURtJJy7ZlW0013Tq79WoPeSW49ej40mqFf36DrzF0WEtCN
        Y+8++f0moy09wtkcHYV3avuFc3EyQQfCtKQlMi9aAFA71aED59lGCd3+nToq4ZNiLnnTnP
        jo95H0Jo374duL5UC0O2YKUdDN3Gm4NGTPmyYj5rkTKtWPwVBTSpopvFspE3sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uat1GxpRT7W86ovQZ+jEFRAgk5GSUbOoG1wBQOMnoyM=;
        b=o7glE5bSyZO9iPjB6beOmosMeriXNivkU51/S/5GpOo4KKUO01qj+QwuRIcHE4oguDmVxG
        AtCPKpsVZtkIwuCw==
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ingenic: Leave parent IRQ unmasked on suspend
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819180602.136969-1-paul@crapouillou.net>
References: <20200819180602.136969-1-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <159839885113.389.324860609070402515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     821fc9e261f3af235752f46e59084467cfd440c4
Gitweb:        https://git.kernel.org/tip/821fc9e261f3af235752f46e59084467cfd440c4
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Wed, 19 Aug 2020 20:06:02 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 25 Aug 2020 10:59:29 +01:00

irqchip/ingenic: Leave parent IRQ unmasked on suspend

All the wakeup sources we possibly want will go through the interrupt
controller, so the parent IRQ must not be masked during suspend, or
there won't be any way to wake up the system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200819180602.136969-1-paul@crapouillou.net
---
 drivers/irqchip/irq-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 9f3da42..b61a890 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -125,7 +125,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	if (request_irq(parent_irq, intc_cascade, 0,
+	if (request_irq(parent_irq, intc_cascade, IRQF_NO_SUSPEND,
 			"SoC intc cascade interrupt", NULL))
 		pr_err("Failed to register SoC intc cascade interrupt\n");
 	return 0;
