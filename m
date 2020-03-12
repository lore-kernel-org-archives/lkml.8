Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91743C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651CB2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eiLA87mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCLNvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:51:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgCLNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6bbE2GpnlDAjnqkrXQiOeX0mGieefOOogMwttobSej8=; b=eiLA87mD5s9G7uaZekLuVfHqJK
        h0r9k8hIcycEBfzrqjWj1PFZ4MZcNJ3J8ZWg7EiPpxtpjzcGY70R+cYPL3DcgZJEtPkSeTlMjgKuh
        UlfZ1cNXf3plB1TwsIBWFniKsFojqo7b8AZdjU11Fr3TNK3glVrkb6ppPzmj1m8yibdKPSCFRZ6uM
        prk3WfCGBw3jld247jAIR+DDPjMBpROn9b97j1sh0XgyFkUoTTJYX/hn0Kc3oiBhlf5p9MaaR8Y0n
        XGdY+ax2oAZWxSb7p1r/5X/Dv7CrkPUqJDCKswtQ8Rp3anxiVM3/kQSop9z9uUTra9tTX8Cu0G+8f
        Sg7oxqRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFM-0006WU-4T; Thu, 12 Mar 2020 13:51:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1240C300328;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0585E2B7403AA; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312134107.700205216@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These patches extend objtool to be able to run on vmlinux.o and validate
Thomas's proposed noinstr annotation:

  https://lkml.kernel.org/r/20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org

 "That's why we want the sections and the annotation. If something calls
  out of a noinstr section into a regular text section and the call is not
  annotated at the call site, then objtool can complain and tell you. What
  Peter and I came up with looks like this:

  noinstr foo()
	do_protected(); <- Safe because in the noinstr section
	instr_begin();  <- Marks the begin of a safe region, ignored
			   by objtool
	do_stuff();     <- All good
	instr_end();    <- End of the safe region. objtool starts
			   looking again
	do_other_stuff();  <- Unsafe because do_other_stuff() is
			      not protected

  and:

  noinstr do_protected()
	bar();          <- objtool will complain here
  "

It should be accompanied by something like the below; which you'll find in a
series by Thomas.

---  

--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -53,6 +53,9 @@ extern char __ctors_start[], __ctors_end
 /* Start and end of .opd section - used for function descriptors. */
 extern char __start_opd[], __end_opd[];
 
+/* Start and end of instrumentation protected text section */
+extern char __noinstr_text_start[], __noinstr_text_end[];
+
 extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -550,6 +550,10 @@
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		ALIGN_FUNCTION();					\
+		__noinstr_text_start = .;				\
+		*(.noinstr.text)					\
+		__noinstr_text_end = .;					\
 		*(.text..refcount)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text*)						\
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,12 +120,37 @@ void ftrace_likely_update(struct ftrace_
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
+/* Begin/end of an instrumentation safe region */
+#define instr_begin() ({						\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.instr_begin\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+
+#define instr_end() ({							\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.instr_end\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
+#define instr_begin()		do { } while(0)
+#define instr_end()		do { } while(0)
 #endif
 
+#define INSTR(expr) ({			\
+	typeof(({ expr; })) __ret;	\
+	instr_begin();			\
+	__ret = ({ expr; });		\
+	instr_end();			\
+	__ret;				\
+})
+
 #ifndef ASM_UNREACHABLE
 # define ASM_UNREACHABLE
 #endif
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -118,6 +118,11 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
+/* Section for code which can't be instrumented at all */
+#define noinstr								\
+	notrace __attribute((__section__(".noinstr.text")))
+
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -953,7 +953,7 @@ static void check_section(const char *mo
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
-		".kprobes.text", ".cpuidle.text"
+		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
 		".coldtext"

