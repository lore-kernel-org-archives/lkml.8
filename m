Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEDC433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDA522B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2hVIImC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXLOtstE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgGVWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:01:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgGVWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:01:12 -0400
Date:   Wed, 22 Jul 2020 22:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vC2rczS7cb9x0lBYxBobwszS5essgctZGSYg+Cq6lk=;
        b=Z2hVIImCXZxMoQFAOaUseQzEhTF1zrhgqrducwKBnstQ+uwgiUfdOjVKJdqAUrl/ON6B0T
        XS9vk9z2LC75g0OJZWpkGcJuhKiVeVyja+7R/NBtrAKEcVQumrR9pbHtcKxlmFOEepCFXA
        VDx3+wKLAr8mezggsAB59PCWTAf0X9z9URFSXnzxXJq/r1jb9F8tel+Q3pfMk7na2yskxL
        MbzYr6dTlSscSo3ljdcG6zE7td9XFTlp/NYuQZaazn5DZk2icbtzoq369AFVW7BG1VjEgV
        TVKCpGvXtRKz31oIqHJCDb5oTLpKqogpqdVe0gUjdD+kEhOqIQhd9hGvltnHeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vC2rczS7cb9x0lBYxBobwszS5essgctZGSYg+Cq6lk=;
        b=KXLOtstEKWVj9ozYSjDx+mB28HwgJpBg7vB98xY3uJoacbvUlyZtkKGXDh5oU2iHxwf4ex
        Yq8y/G/72edzH+Cg==
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/dumpstack: Show registers dump with trace's log level
Cc:     Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200629144847.492794-4-dima@arista.com>
References: <20200629144847.492794-4-dima@arista.com>
MIME-Version: 1.0
Message-ID: <159545526866.4006.11068497413049659542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ef2ff0f5d6008d325c9a068e20981c0d0acc4d6b
Gitweb:        https://git.kernel.org/tip/ef2ff0f5d6008d325c9a068e20981c0d0acc4d6b
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 29 Jun 2020 15:48:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:56:54 +02:00

x86/dumpstack: Show registers dump with trace's log level

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, there is a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

After all preparations are done, provide log_lvl parameter for
show_regs_if_on_stack() and wire up to actual log level used as
an argument for show_trace_log_lvl().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20200629144847.492794-4-dima@arista.com

---
 arch/x86/kernel/dumpstack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 4954d66..f9a3526 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -134,7 +134,7 @@ void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 }
 
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
-				  bool partial)
+				  bool partial, const char *log_lvl)
 {
 	/*
 	 * These on_stack() checks aren't strictly necessary: the unwind code
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, SHOW_REGS_SHORT, KERN_DEFAULT);
+		__show_regs(regs, SHOW_REGS_SHORT, log_lvl);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -155,7 +155,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs, KERN_DEFAULT);
+		show_iret_regs(regs, log_lvl);
 	}
 }
 
@@ -210,7 +210,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			printk("%s <%s>\n", log_lvl, stack_name);
 
 		if (regs)
-			show_regs_if_on_stack(&stack_info, regs, partial);
+			show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 
 		/*
 		 * Scan the stack, printing any text addresses we find.  At the
@@ -271,7 +271,7 @@ next:
 			/* if the frame has entry regs, print them */
 			regs = unwind_get_entry_regs(&state, &partial);
 			if (regs)
-				show_regs_if_on_stack(&stack_info, regs, partial);
+				show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 		}
 
 		if (stack_name)
