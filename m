Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66AD2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhoDjIEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgFROux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgFROus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:50:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA436C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=W74ES2VEM/SOOB/brWv7H7bbbcUQlUDNFxDXundCrzg=; b=YhoDjIECxd6CN8Qio6IiS0Pcl3
        pcVUOoM4JVdRNZ9NsrQofkBvNNT5tkOwh4k6LaHUO5pKFRFojQbW3KYg2YC9JV4PNKGpEJcv8+Aru
        eEMggw+uNpD63NpB0SU9bROV5Cz16/b4lx1wpyVSI18+PQQJve496zRu2R66Nrh+5O5gkEGOsVeWs
        jPWQagDRtimDxRpeDsTdSn1DS6btuQM+IJL9fq9QvpYZegJLE6GLd1W49CFUtzq0zNFEb96AGwJEs
        lnbCE1hu96TOHGom+7710s/0xYxXUDREoXw04pcmxK6rl4J6lv0xJ6TanGHB2MwlxWtkxjZDboA9S
        GcPXKcAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsA-0002xh-29; Thu, 18 Jun 2020 14:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BAB43074A7;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 260A52146C401; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144801.760070502@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 3/7] x86/entry: Fixup bad_iret vs noinstr
References: <20200618144407.520952071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section

Worse, when KASAN there is no telling what memcpy() actually is. Force
the use of __memcpy() which is our assmebly implementation.

Reported-by: Marco Elver <elver@google.com>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c  |    6 +++---
 arch/x86/lib/memcpy_64.S |    4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -685,13 +685,13 @@ struct bad_iret_stack *fixup_bad_iret(st
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	__memcpy(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -8,6 +8,8 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
+.pushsection .noinstr.text, "ax"
+
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
  * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
@@ -184,6 +186,8 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	retq
 SYM_FUNC_END(memcpy_orig)
 
+.popsection
+
 #ifndef CONFIG_UML
 
 MCSAFE_TEST_CTL


