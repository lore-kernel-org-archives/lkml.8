Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C97C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311282074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591255168;
	bh=T6Bc2L9AYNU0jyTMPo3DyvjA3SVK+2ZQMZr6CoJQSNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aalM3VF6L1QIOS7MIb/xTzj8jnM81EwZuFPrzLC4vRx5pNgLS3aQYm0dCFzsptoyG
	 FAfx8tdamFZpDMt51Rlf8gcK/oEX2QpX8Cgl7i6QzuqnWxiE5mqE1rY7jjSIdvUscU
	 f8AXSVEo7jpuhrLfkb3727AcRsXen0gQNU4jzKK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFDHT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgFDHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:19:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67AC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 00:19:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so4135711wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rp/QbeXXw67UXV/kySLbw5yk27PtZEjldICdCw8doXg=;
        b=EBqLJlfC/hr2WIC6bfpF4H18QPiaSx655liBSud772R2p6t1kJFjWmC0XunNfLiU59
         nsmxxXF+tXcuLOfEDXN+iHDD2UcXqEUjMOZq/iyQQLtskQPW86/Zj9NCQOnWd9K0Cg6I
         SFWfZ55W0lftmFnyjqep2K0iIPSB74RCnf6s6UykxevRD+GutZ5+MMwR1Sl8c4rwsDhd
         RmsmDph7TRfYGMZDF2mMQzT6G0rMQzwxg7/feMaGBAln0gWhV9F9ZM3v24tMhVVJ/1ZQ
         COfCLROovZ69IvvvEZTNKBRVY0wa6EyB32AJYwsQA3L0DpOr5U+AaPYOVTp1tobVce8F
         AZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Rp/QbeXXw67UXV/kySLbw5yk27PtZEjldICdCw8doXg=;
        b=RzTNPfA7k7Hbr+nqwN1nJpoUOmSY/U/ZkFmwwmsI9tESFghn252dP/i3PBSQqKvAf5
         KA4UQJXf63HncMctE0ZJS6Io4ac2XxeaW7aIkCQfH4IJA+f2dopmAytOuUNUiCYsDVWm
         1Rz9xznbxo4c4qKwP4FlEQcr8rMtt9JMRdskTejOMRdz8eIQ9DDooAYfhY6/xPIpYfQY
         DrTGUqo9uAs3h0wTPgdssB0N/9hpIVLTQ91zsbcIMF1Jfwno/Q15eEKt1UEyuZM/zV8m
         B64rSX/vndzvSH+9yKcBSXUlRuGGb434pxgdJ5rmlEKPNTEzuz2deCQawriVAQM/MSp4
         KBQQ==
X-Gm-Message-State: AOAM533E6LUZsL6AxSrmwBDKKbzUZTGfSE3kjENHXLXDLb93bTgmNK/s
        KUj1V6xpdxWyzCHBrO2MLda0hkw0
X-Google-Smtp-Source: ABdhPJwq8fZFrxOjZSNbzzOEBd89aH3ZeaCRFwtZgFs4ELnWuighVx+a8MhKgrHIvS89Ye/vA59+1Q==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr2668083wma.54.1591255164550;
        Thu, 04 Jun 2020 00:19:24 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b18sm6269749wrn.88.2020.06.04.00.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:19:23 -0700 (PDT)
Date:   Thu, 4 Jun 2020 09:19:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] compiler.h: Move instrumentation_begin()/end() into new
 <linux/instrumentation.h> header
Message-ID: <20200604071921.GA1361070@gmail.com>
References: <20200601130806.GA746506@gmail.com>
 <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jun 1, 2020 at 6:08 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  include/linux/compiler.h            | 53 +++++++++++++++++++++++
> 
> I have pulled this, but do we really want to add this to a header file
> that is _so_ core that it gets included for basically every single
> file built?
> 
> I don't even see those instrumentation_begin/end() things used
> anywhere right now.
> 
> It seems excessive. That 53 lines is maybe not a lot, but it pushed
> that header file to over 12kB, and while it's mostly comments, it's
> extra IO and parsing basically for _every_ single file compiled in the
> kernel.
> 
> For what appears to be absolutely zero upside right now, and I really
> don't see why this should be in such a core header file!
> 
> I don't even see this as having anything at all to do with
> "compiler.h" in the first place.
> 
> I really think we should think twice about making core header files
> bigger like this. No, we're nowhere the disaster that C++ project
> headers are, but tokenization and parsing is actually a pretty big
> part of the build costs (which may surprise some people who think it's
> all the fancy optimizations that cost a lot of CPU time).

Fully agreed - and I made the attached patch to address this.

The code got cleaner and better structured, but it didn't help much in 
terms of inclusion count:

   2616  total .o files

   2447  <linux/types.h>
   2436  <linux/compiler.h>
   2404  <linux/bug.h>

The reason is that <linux/bug.h> is included almost everywhere as 
well, and the instrumentation_begin()/end() annotations affect the 
BUG*() and WARN*() primitives as well.

At least non-x86 would have less instrumentation related noise, for 
now at least.

Thanks,

	Ingo

==========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 4 Jun 2020 08:36:22 +0200
Subject: [PATCH] compiler.h: Move instrumentation_begin()/end() into new <linux/instrumentation.h> header

Linus pointed out that compiler.h - which is a key header that gets included in every
single of the 28,000+ kernel files files being built - was unnecessarily bloated in:

  655389666643: ("vmlinux.lds.h: Create section for protection against instrumentation")

Move these primitives into a new header: <linux/instrumentation.h>, and include that
header in context_tracking.h and x86/asm/bug.h, which makes use of it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h       |  1 +
 include/linux/compiler.h         | 53 -------------------------------------
 include/linux/context_tracking.h |  2 ++
 include/linux/instrumentation.h  | 57 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index facba9bc30ca..37e4480dba75 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_BUG_H
 
 #include <linux/stringify.h>
+#include <linux/instrumentation.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6325d64e3c3b..448c91bf543b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,65 +120,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
-#ifdef CONFIG_DEBUG_ENTRY
-/* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({					\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
-})
-
-/*
- * Because instrumentation_{begin,end}() can nest, objtool validation considers
- * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
- * When the value is greater than 0, we consider instrumentation allowed.
- *
- * There is a problem with code like:
- *
- * noinstr void foo()
- * {
- *	instrumentation_begin();
- *	...
- *	if (cond) {
- *		instrumentation_begin();
- *		...
- *		instrumentation_end();
- *	}
- *	bar();
- *	instrumentation_end();
- * }
- *
- * If instrumentation_end() would be an empty label, like all the other
- * annotations, the inner _end(), which is at the end of a conditional block,
- * would land on the instruction after the block.
- *
- * If we then consider the sum of the !cond path, we'll see that the call to
- * bar() is with a 0-value, even though, we meant it to happen with a positive
- * value.
- *
- * To avoid this, have _end() be a NOP instruction, this ensures it will be
- * part of the condition block and does not escape.
- */
-#define instrumentation_end() ({					\
-	asm volatile("%c0: nop\n\t"					\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
-})
-#endif /* CONFIG_DEBUG_ENTRY */
-
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
 #endif
 
-#ifndef instrumentation_begin
-#define instrumentation_begin()		do { } while(0)
-#define instrumentation_end()		do { } while(0)
-#endif
-
 #ifndef ASM_UNREACHABLE
 # define ASM_UNREACHABLE
 #endif
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 8cac62ee6add..ad6241c8003d 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,6 +5,8 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/instrumentation.h>
+
 #include <asm/ptrace.h>
 
 
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
new file mode 100644
index 000000000000..19cba99342c2
--- /dev/null
+++ b/include/linux/instrumentation.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_INSTRUMENTATION_H
+#define __LINUX_INSTRUMENTATION_H
+
+#if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
+
+/* Begin/end of an instrumentation safe region */
+#define instrumentation_begin() ({					\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.instr_begin\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+
+/*
+ * Because instrumentation_{begin,end}() can nest, objtool validation considers
+ * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
+ * When the value is greater than 0, we consider instrumentation allowed.
+ *
+ * There is a problem with code like:
+ *
+ * noinstr void foo()
+ * {
+ *	instrumentation_begin();
+ *	...
+ *	if (cond) {
+ *		instrumentation_begin();
+ *		...
+ *		instrumentation_end();
+ *	}
+ *	bar();
+ *	instrumentation_end();
+ * }
+ *
+ * If instrumentation_end() would be an empty label, like all the other
+ * annotations, the inner _end(), which is at the end of a conditional block,
+ * would land on the instruction after the block.
+ *
+ * If we then consider the sum of the !cond path, we'll see that the call to
+ * bar() is with a 0-value, even though, we meant it to happen with a positive
+ * value.
+ *
+ * To avoid this, have _end() be a NOP instruction, this ensures it will be
+ * part of the condition block and does not escape.
+ */
+#define instrumentation_end() ({					\
+	asm volatile("%c0: nop\n\t"					\
+		     ".pushsection .discard.instr_end\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+#else
+# define instrumentation_begin()	do { } while(0)
+# define instrumentation_end()		do { } while(0)
+#endif
+
+#endif /* __LINUX_INSTRUMENTATION_H */

