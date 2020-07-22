Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AAAC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1027A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYByS9hO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YOnvBuRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgGVVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:55:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3536FC0619DC;
        Wed, 22 Jul 2020 14:55:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595454936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W47gSk60h1O07w6cMt6J3jJDxvcjGHZE5w0sslJgfkY=;
        b=fYByS9hOO2durPCidnloZMVzV7T8PkyI+LJQ1MkQ8UXYc1OCTDxCe3F7znvQ/gmP3bgM7a
        zUrn7OyGNUjqygyqmyvUjSidRwN2IRFB1FqLHnBnejIgGNNv4NxW40ua40oA48tAB2RvWB
        ZYOLKHXS4N3hN22YpPFmPmbPqxpQve1E3idMyfyD8vYO8BOJDQcNPuY05rgjTWMvkJJV9A
        tek5jIc63HZ2JLs/1EqPC3nJ6mWUMNsO0rpM26l4nf2IS2U1W53x8Ar8MIwAl5nP5zvYoT
        EOvDVYZFzb7EM/4NBKZCv3NNkbn3UXyckVelGGYkYGSCfYAtnjGHn7998zYiLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595454936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W47gSk60h1O07w6cMt6J3jJDxvcjGHZE5w0sslJgfkY=;
        b=YOnvBuRX+ZUyFHUFNl2XxuQfnm9mkRcZFdIR5nJ4yUiNQW9WwPAsJnuBw4mSAv81jCaCEX
        Qx9fJBaIepBYd8Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/dumpstack: Dump user space code correctly again
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87h7tz306w.fsf@nanos.tec.linutronix.de>
References: <87h7tz306w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159545493541.4006.6455328632471771109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d181d2da0141371bbc360eaea78719203e165e1c
Gitweb:        https://git.kernel.org/tip/d181d2da0141371bbc360eaea78719203e165e1c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 10:39:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:47:48 +02:00

x86/dumpstack: Dump user space code correctly again

H.J. reported that post 5.7 a segfault of a user space task does not longer
dump the Code bytes when /proc/sys/debug/exception-trace is enabled. It
prints 'Code: Bad RIP value.' instead.

This was broken by a recent change which made probe_kernel_read() reject
non-kernel addresses.

Update show_opcodes() so it retrieves user space opcodes via
copy_from_user_nmi().

Fixes: 98a23609b103 ("maccess: always use strict semantics for probe_kernel_read")
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87h7tz306w.fsf@nanos.tec.linutronix.de

---
 arch/x86/kernel/dumpstack.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b037cfa..7401cc1 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -71,6 +71,22 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
+		     unsigned int nbytes)
+{
+	if (!user_mode(regs))
+		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
+
+	/*
+	 * Make sure userspace isn't trying to trick us into dumping kernel
+	 * memory by pointing the userspace instruction pointer at it.
+	 */
+	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
+		return -EINVAL;
+
+	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
+}
+
 /*
  * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
  *
@@ -97,17 +113,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
-	bool bad_ip;
-
-	/*
-	 * Make sure userspace isn't trying to trick us into dumping kernel
-	 * memory by pointing the userspace instruction pointer at it.
-	 */
-	bad_ip = user_mode(regs) &&
-		__chk_range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
 
-	if (bad_ip || copy_from_kernel_nofault(opcodes, (u8 *)prologue,
-					OPCODE_BUFSIZE)) {
+	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
 		printk("%sCode: Bad RIP value.\n", loglvl);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
