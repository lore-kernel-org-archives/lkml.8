Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851CDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4820771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVnf+T73";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmqNY99f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMHmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:42:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:42:16 -0400
Date:   Thu, 13 Aug 2020 07:42:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597304534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vsb5e4EQ9u+z+sC8gTRvPpseAUCaW35aJB4LNMO0ENU=;
        b=DVnf+T73VACu9U9Jx+0nft/Zze1O1dRqSSY0Iu2IKfBvX6sh07GjBBBsp4LQFNOHH2OgDX
        zCZFh0H3MIf4izYbyDPMhB9XfDcMbqeYLNUjLlfW12hf+K4Uj5hW50rU0kLcGPIV7g0ep8
        JgnDKUpSw794Ljp+XACEBYCQa2rQ2SIyIJTuCYOtn3hrek1DRKOoFSdrgVEtzh8RPKDiFM
        MknmHiZ/yRA1jLoXGO1cus/akpL8dsj/qI6y/ys62hc2y9gz+Qp9glSDCan6YQEo2o+vwC
        SyaOZNKgIxqrPZLuEfZobh7K0sumu0lfU68b7g4At8j1RjOvKLoymJKhVsj7zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597304534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vsb5e4EQ9u+z+sC8gTRvPpseAUCaW35aJB4LNMO0ENU=;
        b=MmqNY99fL9J7qmHzcirGdgLBSPNg0aLA3zq5Z7Mo40vvMfGgoWQCjzIK8RBcxgjb8sIH1r
        QVon0kP+tM8lNoAw==
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Unlock irq descriptor after errors
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200811180012.80269-1-linux@roeck-us.net>
References: <20200811180012.80269-1-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <159730453302.3192.18071918978987971140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f107cee94ba4d2c7357fde59a1d84346c73d4958
Gitweb:        https://git.kernel.org/tip/f107cee94ba4d2c7357fde59a1d84346c73d4958
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Tue, 11 Aug 2020 11:00:12 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Aug 2020 09:35:59 +02:00

genirq: Unlock irq descriptor after errors

In irq_set_irqchip_state(), the irq descriptor is not unlocked after an
error is encountered. While that should never happen in practice, a buggy
driver may trigger it. This would result in a lockup, so fix it.

Fixes: 1d0326f352bb ("genirq: Check irq_data_get_irq_chip() return value before use")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200811180012.80269-1-linux@roeck-us.net

---
 kernel/irq/manage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d55ba62..52ac539 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2731,8 +2731,10 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip))
-			return -ENODEV;
+		if (WARN_ON_ONCE(!chip)) {
+			err = -ENODEV;
+			goto out_unlock;
+		}
 		if (chip->irq_set_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -2745,6 +2747,7 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 	if (data)
 		err = chip->irq_set_irqchip_state(data, which, val);
 
+out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return err;
 }
