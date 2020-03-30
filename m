Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41B5206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ooH3Bs55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgC3U3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:29:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3U3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e36XqhsWCmWrROgZi7Tg4ABqZPt9tjfwFEXpbviu61I=; b=ooH3Bs55FLuUTfvL66qyciHw1c
        fR3Vhg0dqkkGeYgZYZeyIK984nNuPaRqaZBagpq7tlFRboBW0EGwSFgbKKBgqOh59CzLybquvMn5n
        h88RLIRmv4jOwCshmFhlPGZJlGaEokL2wySLHQJ4QTQAu4Y/YrP+l8T+E4C1CHL3vq1WClOor9m1j
        fnDor9Tc9lLpyETE2i38sV83VF6l93Rcb+iOajBcw+7WLJjiOW7wrN7b0ET7IAkgsrN57L55fzrXp
        yEH6XgXwIsjB7EAYwVTB/wEbDUOkmoIWct52GbhiN/3SnYQtItTwMirfOVa5QoU9hTmi2S0Spaiur
        iaPwyhuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ12G-0005XI-R9; Mon, 30 Mar 2020 20:29:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79DD33012D8;
        Mon, 30 Mar 2020 22:29:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32FD720B15B93; Mon, 30 Mar 2020 22:29:27 +0200 (CEST)
Date:   Mon, 30 Mar 2020 22:29:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200330202927.GF20760@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:02:54PM +0200, Peter Zijlstra wrote:
> On Mon, Mar 30, 2020 at 02:02:05PM -0500, Josh Poimboeuf wrote:
> > However sync_core() and ftrace_regs_caller() are very different from
> > each other and I find the RET_TAIL hint usage to be extremely confusing.
> 
> I was going with the pattern:
> 
> 	push target
> 	ret
> 
> which is an indirect tail-call that doesn't need a register. We use it
> in various places. We use it here exactly because it preserves all
> registers, but we use it in function-graph tracer and retprobes to
> insert the return handler. But also in retpoline, because it uses the
> return stack predictor, which by happy accident isn't the indirect
> branch predictor.
> 
> > For example, IRETQ isn't even a tail cail.
> 
> It's the same indirect call, except with a bigger frame ;-)
> 
> 	push # ss
> 	push # rsp
> 	push # flags
> 	push # cs
> 	push # ip
> 	iret
> 
> > And the need for the hint to come *before* the insn which changes the
> > state is different from the other hints.
> 
> makes sense to me... but yah.

Also, naturally, there are no instructions after RET to stick the
annotation to.

