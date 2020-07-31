Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4075EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D748208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5Cx8Oja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4/fa/Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgGaJZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbgGaJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:32 -0400
Date:   Fri, 31 Jul 2020 09:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JhrRTNkblEy9fiHS7mHtK3ngxNeRI3mHZi3tvKBu/ug=;
        b=Y5Cx8OjaEuSbY26cUG/gaXXF78WJmSSkKUk37E4dfFvQDLyMASK+APa9LxIk4n31NEmpLb
        L0q3Md3TDp5hlFy3RWtWiOgdjhpewbPS5trV4xv6VDqD5KTsyRMAkzThfu4AUFzp2ZRJdI
        MLJpKP1NupArXeuNAxZYVqs93NmKoeBjHXRo7INK1mYXLWWzazssro6G7dTMDJGNBlrIJ2
        cKoGuXMhY0NPFz1P6XH1GhPsI7sSyaM1p/4eAH8aTjtMSCzeLO7vOuTm00KITw/fvWEWAf
        Etw3LaCHXmbYU/WTR0xZyiVIF2vldcPqjn5gbarV22G0odyHyRLKG9pzSRr2hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JhrRTNkblEy9fiHS7mHtK3ngxNeRI3mHZi3tvKBu/ug=;
        b=u4/fa/CwmJSxDNi/p7q4dsqsScnr3YNuDIpmtPbZO2OvgIDjXjVn9eAUKbVqF0+xbRiCW3
        HGDDn7vAqX6/TPAg==
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Replace 1 with true
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740988.4006.10146199172578291285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e40bb921119814c6f746891af9cd37eccda616a4
Gitweb:        https://git.kernel.org/tip/e40bb921119814c6f746891af9cd37eccda616a4
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 01 Jun 2020 19:45:49 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: Replace 1 with true

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is that the variable lastphase is a bool, but is
initialised with integer 1.  This commit therefore replaces the 1 with
a true.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ca17b77..a0ba885 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -207,7 +207,7 @@ void rcu_end_inkernel_boot(void)
 	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
-	rcu_boot_ended = 1;
+	rcu_boot_ended = true;
 }
 
 /*
