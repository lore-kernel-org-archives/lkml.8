Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357CDC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103942080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zyuhq2/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgCaT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:58:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCaT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QG7UQL8tRsw2UfkbOmhstfO2K9hyLObwPdmivbUDmzE=; b=Zyuhq2/0oZOc5eo2zOFEAlDoBh
        qPwXUTlCve3dpMr+eyU+yJKLnWZf1zJuAIrw7R4Dy86rYyMJphe8y9N8ERo17hUU2do2IBZe8tGV1
        TqQai+bSSoTwERGxmf6zQ7IUJ84eFFiK6y1pCelkBk4WqgxwIjWktNG0i99sayhhfGfQa9PS3PR3U
        u8BWETvyotqerOllA4PvpDYxPjtw0UILPI70Bp23C/WWzEEtSN+G2Ml/VaZSu2XCsHl1fgRHrpB43
        7fgXYeiegcnWFx7fveJBRf9rJptYR5JSxJ173bs+/6epXCFRFRmm3fP5n0M6xo2+Paq+PRGyjWURb
        hliqPBoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJN24-0000nk-F0; Tue, 31 Mar 2020 19:58:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D880698354A; Tue, 31 Mar 2020 21:58:41 +0200 (CEST)
Date:   Tue, 31 Mar 2020 21:58:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331195841.GE2452@worktop.programming.kicks-ass.net>
References: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331113136.01316614@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113136.01316614@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:31:36AM -0400, Steven Rostedt wrote:

> Can you send this change as a separate patch as it has nothing to do with
> this current change, and is a clean up patch that stands on its own.

I also found this.. should I write it up?

---
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 369e61faacfe..0f108096f278 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -23,7 +23,7 @@
 #endif /* CONFIG_FRAME_POINTER */

 /* Size of stack used to save mcount regs in save_mcount_regs */
-#define MCOUNT_REG_SIZE		(SS+8 + MCOUNT_FRAME_SIZE)
+#define MCOUNT_REG_SIZE		(SIZEOF_PTREGS + MCOUNT_FRAME_SIZE)

 /*
  * gcc -pg option adds a call to 'mcount' in most functions.
@@ -77,7 +77,7 @@
 	/*
 	 * We add enough stack to save all regs.
 	 */
-	subq $(MCOUNT_REG_SIZE - MCOUNT_FRAME_SIZE), %rsp
+	subq $(SIZEOF_PTREGS), %rsp
 	movq %rax, RAX(%rsp)
 	movq %rcx, RCX(%rsp)
 	movq %rdx, RDX(%rsp)
