Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E3CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30959214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BhmQU1wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbgDARp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:45:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbgDARp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNceod/5hgLXbYBp/2zfToAFjlO9fz87Q3vy13K6OqI=; b=BhmQU1wKVt8nenOrvdVu6ALKlS
        DrWmBvZciEzgx7svRe+MmYK8KksPnHCxxkwotdXiStgPt4QtS7zw4Me9MgccCSHn887zH7k012Hbm
        OHy1BKf1+yDbT2hBJBUstq7gQ3xd9xauhxIk5FXacyedq6ryAWl662JxXpJFKN6kn4qT0iExUHYZI
        EymHJYlZuGGOF1nRPCRPQPdIGMRmkTjyJsqGQRJNpdtmJwwl9eZPP/jAYmvOLS8MeYnD1ienCU+Nd
        EPL4PWdsJJrrWJTPoUOfgeAdI9ZKNgHiMJBl9TnI8HZJwdPAlhd8/pRF3x9f2N+jtGfJYth6GakYf
        6WxTdOwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJhQx-0004UC-KX; Wed, 01 Apr 2020 17:45:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 554DD30477A;
        Wed,  1 Apr 2020 19:45:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04B3D20418942; Wed,  1 Apr 2020 19:45:44 +0200 (CEST)
Date:   Wed, 1 Apr 2020 19:45:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401174544.GY20730@hirez.programming.kicks-ass.net>
References: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <20200401133303.6773c574@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401133303.6773c574@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:33:03PM -0400, Steven Rostedt wrote:
> On Wed, 1 Apr 2020 19:09:10 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
> > > > +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))  
> > > 
> > > Isn't that the same thing as "state->cfa.offset !=
> > > initial_func_cfi.cfa.offset + ret_offset" ?  
> > 
> > I'm confused on what cfa.offset is, sometimes it increase with
> > stack_size, sometimes it doesn't.
> 
> I believe what Julien is saying is the above logic is equivalent:
> 
> 	if (x != y &&
> 	    !(z && x == y + z))
> 
> is the same as:
> 
> 	if (x != y + z)

It is not, the former will accept either x==y || x==y+z, while the
latter will only accept x==y+z.

For stack_size, I'm confident in just x==y+z, for offset I saw
conflicting things.

Since the annotation is now used in only a single place, maybe x==y+z
will just work, I'll go try once I've managed to unconfuse myself on the
whole fp-unwind situation.
