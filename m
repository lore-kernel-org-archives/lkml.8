Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5796C206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbnoOVoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEJ74Uur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgGIJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGIJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:22:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4FC061A0B;
        Thu,  9 Jul 2020 02:22:53 -0700 (PDT)
Date:   Thu, 09 Jul 2020 09:22:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594286571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuqTEWMSDcN/t0XlTdAwoMKu5iKlhhspWjdSYJms6ec=;
        b=dbnoOVoCXyqn5FE7wRSixDhDhdDCErcARGmYERRJfRyfSMlO8kLtIsWQzSwNydB5ok+1/h
        mScZoJlG9vuD9V+EQao4HF4t+H76BVfuE1MPCjyHWIjb4bh3J4MU50AZ+NcMkMf6jdemo5
        qeejYK27AI42kP4jc1Dq/dt+eWRIsjxHY0LefrExNTKPaO6Aiai2PQ9TLE9bIZTI5VnH3y
        ghPbnpVLElni6C4yIvipOR2YPZ0EDr8VxxffEpFlZBr8sPZMbICIo9mzgmEZ6hlTcqmYUj
        5hk5G9puEzf11spAgTgExae4K7G0IloZlJX+lCko1/CdJDybPmtzgi9aKVhshg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594286571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuqTEWMSDcN/t0XlTdAwoMKu5iKlhhspWjdSYJms6ec=;
        b=oEJ74UurMoubeHa3sRGozYPQJCk7fgxnKKpTJ63PFs49pmDQq65eA5a+2GTYVsBZGvDBmZ
        AhQDSu3DlsQ5mBCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/traps: Disable interrupts in exc_aligment_check()
Cc:     syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708192934.076519438@linutronix.de>
References: <20200708192934.076519438@linutronix.de>
MIME-Version: 1.0
Message-ID: <159428657103.4006.18418761196662576494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bce9b042ec73e8662b8119d4ca47e7c78b20d0bf
Gitweb:        https://git.kernel.org/tip/bce9b042ec73e8662b8119d4ca47e7c78b20d0bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Jul 2020 21:28:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jul 2020 11:18:29 +02:00

x86/traps: Disable interrupts in exc_aligment_check()

exc_alignment_check() fails to disable interrupts before returning to the
entry code.

Fixes: ca4c6a9858c2 ("x86/traps: Make interrupt enable/disable symmetric in C code")
Reported-by: syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200708192934.076519438@linutronix.de

---
 arch/x86/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ed8cc5..4f3a509 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -299,6 +299,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 
 	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
 		error_code, BUS_ADRALN, NULL);
+
+	local_irq_disable();
 }
 
 #ifdef CONFIG_VMAP_STACK
