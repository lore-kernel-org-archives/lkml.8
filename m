Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2FC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531D206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Rqs+HXHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgBJOF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:05:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgBJOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:05:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so7835047wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8FFBZ4EmUJ2sQFQ1DDNcdrgqC6kUmB5uAQPKVaNLzU=;
        b=Rqs+HXHuiiNBwJQP4FbTc4kVoPrJ//wgQ0Dcq2j+jS9JZLWqeotZ8CqIoKYSvSqwr5
         q1Z+wT0AH4oE44cjXHAzaoNXK+rSmm9QsJ9VC3J8sPtWma2jCS7W4cuJXj5G6n07Oyfb
         WVgbefzz+R67/r2Oor5fOTqPdyQ1O3s0Db3o5pL0dt3o7hGC6SL69YbJZuUQSs1Cb1wn
         5oZcH9iqmy9IQfMIHInD+N3hJuBuWDcV4IJiRdHkVXABT52TtckaFUmLwVTurO/ffdLT
         t3jTxBaf+DBSu774ozgKt3jm3vYyX/m07K8zrvslLL6pHJvHl4cW2IPT/IbQZdGsI/Pg
         v6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8FFBZ4EmUJ2sQFQ1DDNcdrgqC6kUmB5uAQPKVaNLzU=;
        b=TqjA1n7dsHn1pscd+Tq6fEO/+5fBaj9tzWi2dvLTqEUdpWP7ePNP1pWSe1HOZxLB8v
         7VHYOT9wNIAXSdZ8/z2rzrpjBNTMIw6hVVLN2CiAJPwcGp/kFt7zXJqtYt2exfmHxddE
         nYEJWybnmGXeHIuEY6ioPe8LKMrl802VFV4g+CJxkg1EIGSAfGL8yaAXZpFv7jdWBezx
         p7YRJKU2wZyz0kBRI4sR2t70BTAiutlgRSLcPhuzHGBo67uWeT46b2miKy2ifV+99N7q
         GoAk+32ui93ownFUklwWWd0t4ebGCQnAM7HJv1yjVHwNJD9H+oERQ/8PO+SKWFd0JHBz
         gmLw==
X-Gm-Message-State: APjAAAUa7oGCLcxZ2bi3OvuW8o8RU8ehEOwW6nZWkrtS4sHUxowFf49/
        gXn55kfMgLwiOPQMymWrlRBJJQ==
X-Google-Smtp-Source: APXvYqymzDGwZeK3FYvhJTH7FdWpl3rn8axdrSv2oIPWjx0F6zznT1GXOe458XNMwzVC7wA0xHVHSw==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr2130617wrx.136.1581343551296;
        Mon, 10 Feb 2020 06:05:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y20sm646715wmi.25.2020.02.10.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:05:50 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-4.19-stable 1/2] x86/stackframe: Move ENCODE_FRAME_POINTER to asm/frame.h
Date:   Mon, 10 Feb 2020 14:05:42 +0000
Message-Id: <20200210140543.79641-2-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210140543.79641-1-dima@arista.com>
References: <20200210140543.79641-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit a9b3c6998d4a7d53a787cf4d0fd4a4c11239e517 ]

In preparation for wider use, move the ENCODE_FRAME_POINTER macros to
a common header and provide inline asm versions.

These macros are used to encode a pt_regs frame for the unwinder; see
unwind_frame.c:decode_frame_pointer().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/calling.h     | 15 -----------
 arch/x86/entry/entry_32.S    | 16 ------------
 arch/x86/include/asm/frame.h | 49 ++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 578b5455334f..31fbb4a7d9f6 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -172,21 +172,6 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just setting the LSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
- * the original rbp.
- */
-.macro ENCODE_FRAME_POINTER ptregs_offset=0
-#ifdef CONFIG_FRAME_POINTER
-	leaq 1+\ptregs_offset(%rsp), %rbp
-#endif
-.endm
-
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
 /*
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 8059d4fd915c..d07432062ee6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -245,22 +245,6 @@
 .Lend_\@:
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just clearing the MSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
- * original rbp.
- */
-.macro ENCODE_FRAME_POINTER
-#ifdef CONFIG_FRAME_POINTER
-	mov %esp, %ebp
-	andl $0x7fffffff, %ebp
-#endif
-.endm
-
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 5cbce6fbb534..296b346184b2 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -22,6 +22,35 @@
 	pop %_ASM_BP
 .endm
 
+#ifdef CONFIG_X86_64
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just setting the LSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
+ * the original rbp.
+ */
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+	leaq 1+\ptregs_offset(%rsp), %rbp
+.endm
+#else /* !CONFIG_X86_64 */
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just clearing the MSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
+ * original ebp.
+ */
+.macro ENCODE_FRAME_POINTER
+	mov %esp, %ebp
+	andl $0x7fffffff, %ebp
+.endm
+#endif /* CONFIG_X86_64 */
+
 #else /* !__ASSEMBLY__ */
 
 #define FRAME_BEGIN				\
@@ -30,12 +59,32 @@
 
 #define FRAME_END "pop %" _ASM_BP "\n"
 
+#ifdef CONFIG_X86_64
+#define ENCODE_FRAME_POINTER			\
+	"lea 1(%rsp), %rbp\n\t"
+#else /* !CONFIG_X86_64 */
+#define ENCODE_FRAME_POINTER			\
+	"movl %esp, %ebp\n\t"			\
+	"andl $0x7fffffff, %ebp\n\t"
+#endif /* CONFIG_X86_64 */
+
 #endif /* __ASSEMBLY__ */
 
 #define FRAME_OFFSET __ASM_SEL(4, 8)
 
 #else /* !CONFIG_FRAME_POINTER */
 
+#ifdef __ASSEMBLY__
+
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+.endm
+
+#else /* !__ASSEMBLY */
+
+#define ENCODE_FRAME_POINTER
+
+#endif
+
 #define FRAME_BEGIN
 #define FRAME_END
 #define FRAME_OFFSET 0
-- 
2.25.0

