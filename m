Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB611C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF31A2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jRgJ+VKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgDBHur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:50:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sOBTBRUpbh8YXdcpFE2qq+gU+izZL8xxVOZMV+Zvzmg=; b=jRgJ+VKQkwpxjCzParG0RExRyk
        3dB7GbgwhTZBfOMrvf0RTn5Cr+MtzIKMXwD3CyeuePxJgr4/G3ef0LxGpCNBmGKdZ2YF+u2iBj345
        K5NN+3laVqb0mYDBIobqhwivZAfy9asN7KXoT3ECj7+xST63TbVW5ViYy/Zqirdk+6gAS8Io0ALwu
        5ZboTgEZ6G39/0aFJYQZV8dvUiJ8FWKZufmy4ylLsToFmIVZ0tkCiuHNoWjh2+HTFab4ZMG/KwM0E
        HrNkGkjj6VyaIr1e0ou/BVkNKOnTmhapwqbUGoXQvH0VDuSKui0cvyCK853h7YAIZT50KKNaGvkyY
        4472yqOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJucY-0007Fp-Pm; Thu, 02 Apr 2020 07:50:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C53BA3010BC;
        Thu,  2 Apr 2020 09:50:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77383202451B4; Thu,  2 Apr 2020 09:50:36 +0200 (CEST)
Date:   Thu, 2 Apr 2020 09:50:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200402075036.GA20730@hirez.programming.kicks-ass.net>
References: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:41:46AM +0100, Julien Thierry wrote:
> On 4/1/20 6:09 PM, Peter Zijlstra wrote:

> > The code in question (x86's sync_core()), is an exception return to
> > self. It pushes an exception frame that points to right after the
> > exception return instruction.
> > 
> > This is the only usage of IRET in STT_FUNC symbols.
> > 
> > So rather than teaching objtool how to interpret the whole
> > push;push;push;push;push;iret sequence, teach it how big the frame is
> > (arch_exception_frame_size) and let it continue.
> > 
> > All the other (real) IRETs are in STT_NOTYPE in the entry assembly.
> > 
> 
> Right, I see.. However I'm not completely convinced by this. I must admit I
> haven't followed the whole conversation, but what was the issue with the
> HINT_IRET_SELF? It seemed more elegant, but I might be missing some context.

https://lkml.kernel.org/r/20200331211755.pb7f3wa6oxzjnswc@treble

Josh didn't think it was worth it, I think.

> Otherwise, it might be worth having a comment in the code to point that this
> only handles the sync_core() case.

I can certainly do that. Does ARM have any ERETs sprinkled around in
places it should not have? That is, is this going to be a problem for
you?

> Also, instead of adding a special "arch_exception_frame_size", I could
> suggest:
> - Picking this patch [1] from a completely arbitrary source
> - Getting rid of INSN_STACK type, any instruction could then include stack
> ops on top of their existing semantics, they can just have an empty list if
> they don't touch SP/BP
> - x86 decoder adds a stack_op to the iret to modify the stack pointer by the
> right amount

That's not the worst idea, lemme try that.
