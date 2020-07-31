Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35131C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017EC22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTqr4c65";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbPZ+pPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgGaJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbgGaJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:29 -0400
Date:   Fri, 31 Jul 2020 09:23:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uk6QbaFyEFbHQWQCwzqjpzW6SfdqvbCWlecFl9IFgOM=;
        b=yTqr4c65WIoPyLYQjTrp4ZONohP9fDjkaZ9cQmMoFwgO/uBrpXVcOpsj8OinnU7JoxlhW6
        4q7IBxc3nwieUkGGfkyYdZTQzkE9O3pFkcDPJ6zASjKE47uX6mqJjpq8yKFDRctXDu4hPu
        cF74u4XXKATZ1GVdjPohz49VehFJ3ctJab+2xCtKpPeOZjA03tk4yLjpPmnG3kbwyeWW4g
        jsViZPb/xFcggW/Y6AgFI+jyFUaDWhtb99OgqFXuLEUNGTrORh5AFK0VEYHVVtdAteSXeS
        Bdyl9kFU2yhFuT4MB2YL/0eCFCztqgb9WNPlbVTLEHeRfuW5kTJyDOAGoI3G9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uk6QbaFyEFbHQWQCwzqjpzW6SfdqvbCWlecFl9IFgOM=;
        b=YbPZ+pPC3S908LyR85lvgUeKQocvBx8Yf/Wqdfu/r14fQbr8QyPsvyQaqElY3UCeMcUGoF
        96o9JfJILdxMeCAg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kernel/rcu/tree.c: Fix kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740659.4006.1978880687501106609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c3cb47a6cc74af0b79579ba167d7124eb669fbaa
Gitweb:        https://git.kernel.org/tip/c3cb47a6cc74af0b79579ba167d7124eb669fbaa
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 15 Jun 2020 12:28:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

kernel/rcu/tree.c: Fix kernel-doc warnings

Fix kernel-doc warning:

../kernel/rcu/tree.c:959: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'

Fixes: cf7614e13c8f ("rcu: Refactor rcu_{nmi,irq}_{enter,exit}()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c8196fa..ef05aac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -954,7 +954,6 @@ void __rcu_irq_enter_check_tick(void)
 
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
- * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
