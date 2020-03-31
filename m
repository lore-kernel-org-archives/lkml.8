Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E846C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725BB20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZJOQji6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgCaQGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:06:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgCaQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qRwSxdkJvHVO9CkLZvWsN5O2euno318Z4mdLOQ7HH6c=; b=MZJOQji6zdAFUyZaVuBWCB+w1q
        4ZVHLlU+o7L4njebBrdJk5IHN8a+SfwEpY/U9tVwuqF0pDmfkTycFUlwFuzqi769zZVXroNtXugA+
        xEfu36aHljRgKSeQ6RZne3c6+Cgo3MdGeT7xTRA0UVNbDMLOnvTz59hrbb2+VTjIzAck5gFndhULy
        kXvLbb6zKNzK8wnSikNNlR/f/53yzLTGx8NScrLwmHwb8ruEQeDgezYtCHf1qgQnqRlI/ZG6WxPRs
        Q+Oh/odfoL6p84/Xm3LlKRKJCkjidrk7Oooq1r0gZORMoDk7YP84mqcZdZ4mghXuA0ZIyvp/1GYBD
        uptCUYqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJJPW-0000PV-5b; Tue, 31 Mar 2020 16:06:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A1A930015A;
        Tue, 31 Mar 2020 18:06:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 062F329D910F5; Tue, 31 Mar 2020 18:06:39 +0200 (CEST)
Date:   Tue, 31 Mar 2020 18:06:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: [RFC][PATCH] x86,ftrace: Shrink ftrace_regs_caller() by one byte
Message-ID: <20200331160639.GV20730@hirez.programming.kicks-ass.net>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:31:36AM -0400, Steven Rostedt wrote:
> On Tue, 31 Mar 2020 13:16:52 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > @@ -235,8 +237,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> >  
> >  	/* If ORIG_RAX is anything but zero, make this a call to that */
> >  	movq ORIG_RAX(%rsp), %rax
> > -	cmpq	$0, %rax
> > -	je	1f
> > +	testq	%rax, %rax
> > +	jz	1f
> >  
> >  	/* Swap the flags with orig_rax */
> >  	movq MCOUNT_REG_SIZE(%rsp), %rdi
> 
> Hi Peter,
> 
> Can you send this change as a separate patch as it has nothing to do with
> this current change, and is a clean up patch that stands on its own.

Sure. But then I have to like write a Changelog for it... :/

---
Subject: x86,ftrace: Shrink ftrace_regs_caller() by one byte

'Optimize' ftrace_regs_caller. Instead of comparing against an
immediate, the more natural way to test for zero on x86 is: 'test
%r,%r'.

  48 83 f8 00             cmp    $0x0,%rax
  74 49                   je     226 <ftrace_regs_call+0xa3>

  48 85 c0                test   %rax,%rax
  74 49                   je     225 <ftrace_regs_call+0xa2>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 369e61faacfe..8e71c492d623 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -235,8 +235,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 
 	/* If ORIG_RAX is anything but zero, make this a call to that */
 	movq ORIG_RAX(%rsp), %rax
-	cmpq	$0, %rax
-	je	1f
+	testq	%rax, %rax
+	jz	1f
 
 	/* Swap the flags with orig_rax */
 	movq MCOUNT_REG_SIZE(%rsp), %rdi
