Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A4922B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFtUrlGZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGPIOiHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgGaJYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732522AbgGaJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:40 -0400
Date:   Fri, 31 Jul 2020 09:23:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oauIFIP8zG2+tb1EiqdYjBDJ6mCxrdAdT6azc6y3VZk=;
        b=RFtUrlGZqCEogvyDbC2YMlLyx38PIHuQrFoTWVuq4k7fqslKfoDPbCWXEjHujgbf6YF3uQ
        /Qt5T/auVJqHjMmKkjfNFInibLFdwEVorjFkXHa/qtbAOjgqRDIJTwFKiB165UOfhS7hwU
        oyd9y1wE09+tx+1RmDMJ5zwWOg5IjRV7qBw4U/9zYqV990Abv8JKiYrFplsAlMOzW4M9Eb
        H99EYHrvaFIkJA2LW15OmMSKs1YzGifh2uH/DdGzLOrsZXHc0Up2wem2TOTBUZyaEXJ3sC
        DZXHV3MQFQBmIVN7rgBZeRfF+aWPRAkQCITsNXCw53X4psN/hduE1XEApaSfuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oauIFIP8zG2+tb1EiqdYjBDJ6mCxrdAdT6azc6y3VZk=;
        b=VGPIOiHsP2I8rd74mFIAK8Qqn+cEcEECNRLgO7yskOoEB3lOWurlGEzbcuLC4Rj0W6iNHI
        ul8ekxrnVYOczPDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add comment documenting rcu_callback_map's purpose
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741794.4006.10712403272167911777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f8466f94685b5bd931384526cf51e090fd2ac706
Gitweb:        https://git.kernel.org/tip/f8466f94685b5bd931384526cf51e090fd2ac706
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 03 May 2020 19:16:09 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

rcu: Add comment documenting rcu_callback_map's purpose

The rcu_callback_map lockdep_map structure was added back in 2013, but
its purpose has become obscure.  This commit therefore documments that the
purpose of rcu_callback map is, in the words of commit 24ef659a857 ("rcu:
Provide better diagnostics for blocking in RCU callback functions"),
to help lockdep to tie an "inappropriate voluntary context switch back
to the fact that the function is being invoked from within a callback."

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f5a82e1..ca17b77 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -279,6 +279,7 @@ struct lockdep_map rcu_sched_lock_map = {
 };
 EXPORT_SYMBOL_GPL(rcu_sched_lock_map);
 
+// Tell lockdep when RCU callbacks are being invoked.
 static struct lock_class_key rcu_callback_key;
 struct lockdep_map rcu_callback_map =
 	STATIC_LOCKDEP_MAP_INIT("rcu_callback", &rcu_callback_key);
