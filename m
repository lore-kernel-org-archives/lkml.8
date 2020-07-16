Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E2B2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8EiHjVu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Erfd0bv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGPPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:30:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgGPPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:30:37 -0400
Date:   Thu, 16 Jul 2020 15:30:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594913435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DCCK8mVk+HskFG6V++QI8sTSi5CIGdPTT0aJ5kjZzI=;
        b=U8EiHjVunrtFn4bSMXFeAfEdJjJqVWRAXNOOpsEOvRKdOGsy2ELmV9GuB7v2b3frf7DKbF
        wBDTj7Y1PgvQ7o3WS2cO0BJFZvmpvHkWHTgJcvHXJE93ydlzQr558lc6ZBxY04S67IUrgM
        zLt01RsWpYHxtFpxncFv6A3UNJdZVjI9RkFAahdd7DGEX4LwI02x7Re9JwHr9d0m0RoM/C
        HU8tbJftza4l4KIYoAUEFQ/Etsj1dSFbeeGiboff9dUEa693z8AoOSIgFT+2dIKwZcukt8
        I60D0dq7UzXriL5jYzbfLiA5UO71UiQp/ApEwarIoDpicMR+R5m/+kX3KDQ+ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594913435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DCCK8mVk+HskFG6V++QI8sTSi5CIGdPTT0aJ5kjZzI=;
        b=Erfd0bv8OYtUWHksHjKmTDlXcTSD53S33rx0mOTAhILEgHrXaA4eaD2nM076WzKCV2dusM
        mvcvs/Sgm37zO0CA==
From:   "tip-bot2 for Jian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Add compatibility with IAS
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200714233024.1789985-1-caij2003@gmail.com>
References: <20200714233024.1789985-1-caij2003@gmail.com>
MIME-Version: 1.0
Message-ID: <159491343466.4006.9823116110789109364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6ee93f8df09c470da1a4af11e394c52d7b62418c
Gitweb:        https://git.kernel.org/tip/6ee93f8df09c470da1a4af11e394c52d7b62418c
Author:        Jian Cai <caij2003@gmail.com>
AuthorDate:    Tue, 14 Jul 2020 16:30:21 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jul 2020 17:25:09 +02:00

x86/entry: Add compatibility with IAS

Clang's integrated assembler does not allow symbols with non-absolute
values to be reassigned. Modify the interrupt entry loop macro to be
compatible with IAS by using a label and an offset.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Jian Cai <caij2003@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> #
Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Link: https://lkml.kernel.org/r/20200714233024.1789985-1-caij2003@gmail.com
---
 arch/x86/include/asm/idtentry.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f3d7083..5efaaed 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    pos = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(irq_entries_start)
 
@@ -486,16 +485,15 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    pos = .
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
 #endif
