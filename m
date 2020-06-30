Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB28C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475E32073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPGbQ8sI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3epm60U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbgF3KME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbgF3KLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:11:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC944C03E979;
        Tue, 30 Jun 2020 03:11:52 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593511911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoujhNZEUXnfVLu7O8Ad2WynRdcdYfgaBs6bK4tDNIc=;
        b=HPGbQ8sIDpmJTG2t76BTTXj28h6D8oblKZIxMx5DRj5VERqSUIOC3+mfwIwN2mVyiBTRqp
        yAQjsYteRwqoiIgVFxE2HzkDolNe6uYtSMLtdS43TAb1HbtGz87W4WY+Y3Kuh2TIrGKYHU
        uhZcK+l9VSVP2KsuAHXV/b3xf4zKCezSFqtJiphUdgRXE1/M2COtlIt/yZe3P8Y5fX5MwI
        sQPb3grucmx5KnFJLi3OQ9ii4MbkL5WXzRj28pkivqXqAEFVZHihDKj+prGkHabzeweE3S
        R9Oi809pNcLRAfob7M8Z3aS0Lr54Df+AJhhJBRJlTCvw08t/OuzQS8NUPiotsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593511911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoujhNZEUXnfVLu7O8Ad2WynRdcdYfgaBs6bK4tDNIc=;
        b=G3epm60UnWNDsOQX+9zDNdo0vMQpBEgxgqroWQ/NhYTt1eRocYTOfEkkUmiqOIW2PDQGQD
        FCULZX065I5ZBuCg==
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Use readx_poll_timeout_atomic()
 to fix sleep in atomic
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200605052345.1494-1-yuzenghui@huawei.com>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <159351191045.4006.6389349419327393336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     31dbb6b1d025506b3b8b8b74e9b697df47b9f696
Gitweb:        https://git.kernel.org/tip/31dbb6b1d025506b3b8b8b74e9b697df47b9f696
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Fri, 05 Jun 2020 13:23:45 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 21 Jun 2020 15:13:11 +01:00

irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic

readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
and is therefore unsafe to be used inside the atomic context, which is
this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
irq_set_vcpu_affinity() callback.

Let's convert to its atomic version instead which helps to get the v4.1
board back to life!

Fixes: 96806229ca03 ("irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200605052345.1494-1-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd685f5..6a5a87f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3797,10 +3797,10 @@ static void its_wait_vpt_parse_complete(void)
 	if (!gic_rdists->has_vpend_valid_dirty)
 		return;
 
-	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
-						val,
-						!(val & GICR_VPENDBASER_Dirty),
-						10, 500));
+	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
+						       val,
+						       !(val & GICR_VPENDBASER_Dirty),
+						       10, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
