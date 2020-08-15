Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71615C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B681204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyRmSqiL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nN7XWbQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgHOVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHOVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392DC09B051;
        Sat, 15 Aug 2020 08:47:04 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fXszv2APHcKmDolqgtZdsS0ielnNdMvQ+ezIc2uA40=;
        b=IyRmSqiLFCP1mofhwaH84KcBX8X+ngd1JIQ+ZsAPHgXnq++DKTT84IucIgxS116pB4K+qq
        zRfqWqZsinI7kM+yZKZ4tzwRole9fXlxjUfqp4pmtCxU5CGFSntPQmob44d/8qJcfP+Jso
        baeL7NPTgKtxKQQSfrzRxKJq2iXAxpilVHbhT9dSjS8TX9Mizjzojqb5kP4+dyHf+j78aI
        meNjqZhnfyMHejvSQxS7KVHwSv3c0GahDAlb6PVwPwuOfHOKQRw14lK5XSQOr060eLG93h
        HKvrLdVvKOwCrFSbZGbops/Yw/CVIe6GhqK/23GjKH656SiF5z3RsZXULn6yww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fXszv2APHcKmDolqgtZdsS0ielnNdMvQ+ezIc2uA40=;
        b=nN7XWbQHARIUtV1aKk/8mYaUtrUJPNwW3MAiDTmZpbfu0dElQCLnVI6FqUZb2mLx9W1aZB
        g0q9uQ7c94F07qDQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Clean up paravirt macros
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815100641.26362-3-jgross@suse.com>
References: <20200815100641.26362-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <159750641236.3192.13754710785295850229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     94b827becc6a87c905ab30b398e12a266518acbb
Gitweb:        https://git.kernel.org/tip/94b827becc6a87c905ab30b398e12a266518acbb
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sat, 15 Aug 2020 12:06:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:52:11 +02:00

x86/paravirt: Clean up paravirt macros

Some paravirt macros are no longer used, delete them.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200815100641.26362-3-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 25c7a73..e02c409 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -586,16 +586,9 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
-#define PV_SAVE_REGS "pushl %ecx; pushl %edx;"
-#define PV_RESTORE_REGS "popl %edx; popl %ecx;"
-
 /* save and restore all caller-save registers, except return value */
 #define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
 #define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
-
-#define PV_FLAGS_ARG "0"
-#define PV_EXTRA_CLOBBERS
-#define PV_VEXTRA_CLOBBERS
 #else
 /* save and restore all caller-save registers, except return value */
 #define PV_SAVE_ALL_CALLER_REGS						\
@@ -616,14 +609,6 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	"pop %rsi;"							\
 	"pop %rdx;"							\
 	"pop %rcx;"
-
-/* We save some registers, but all of them, that's too much. We clobber all
- * caller saved registers but the argument parameter */
-#define PV_SAVE_REGS "pushq %%rdi;"
-#define PV_RESTORE_REGS "popq %%rdi;"
-#define PV_EXTRA_CLOBBERS EXTRA_CLOBBERS, "rcx" , "rdx", "rsi"
-#define PV_VEXTRA_CLOBBERS EXTRA_CLOBBERS, "rdi", "rcx" , "rdx", "rsi"
-#define PV_FLAGS_ARG "D"
 #endif
 
 /*
