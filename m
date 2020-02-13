Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C024673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608911;
	bh=S7bOtw8DY7CZu+78NqMqNEcEoAyaXmvP+s1qMErXI6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNpZCCVHMw7g2CemjVzc89kv4y/YKN+r9RikNKxMw6ZWH9RNpOv11wz0Jxu4YXD0l
	 CtoNcNAwfqaGVnPbmhbprx2owiWxo80rugZzqkSZMYcgFBKz1hRgk0etDFfWptdYbL
	 +EitQNWmrqgHTqFfBUuph7j57pQ5desS1ohhk/UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgBMPs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgBMP04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:56 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B4C2465D;
        Thu, 13 Feb 2020 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607615;
        bh=S7bOtw8DY7CZu+78NqMqNEcEoAyaXmvP+s1qMErXI6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLeSNH9J1f9MJonz0D0Jm+ULZbI7LKM5Bpx31fz39BHrG0XuxvbWLc+QLik/P4kzB
         KdLKfLPUpFoZy0KQrHbRQqgl3G69HLDaSa8oU0xzyQAh9mwUtIcO7WCtu0Nr2atWl7
         e4dEonyJB7UBMn04VAMIbljbvoB6XrgTzRavQJls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4.19 52/52] x86/stackframe, x86/ftrace: Add pt_regs frame annotations
Date:   Thu, 13 Feb 2020 07:21:33 -0800
Message-Id: <20200213151831.169671579@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit ea1ed38dba64b64a245ab8ca1406269d17b99485 upstream.

When CONFIG_FRAME_POINTER, we should mark pt_regs frames.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[4.19 backport; added user-visible changelog]
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/ftrace_32.S |    3 +++
 arch/x86/kernel/ftrace_64.S |    3 +++
 2 files changed, 6 insertions(+)

--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
+#include <asm/frame.h>
 
 #ifdef CC_USING_FENTRY
 # define function_hook	__fentry__
@@ -131,6 +132,8 @@ ENTRY(ftrace_regs_caller)
 	pushl	%ecx
 	pushl	%ebx
 
+	ENCODE_FRAME_POINTER
+
 	movl	12*4(%esp), %eax		/* Load ip (1st parameter) */
 	subl	$MCOUNT_INSN_SIZE, %eax		/* Adjust ip */
 #ifdef CC_USING_FENTRY
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/frame.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -222,6 +223,8 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	ENCODE_FRAME_POINTER
+
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 


