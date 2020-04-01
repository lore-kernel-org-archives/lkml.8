Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694DFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387C420CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+Oe4lla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgDAPiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:38:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SZEua1exB+fJhLXEKQKY3fxy8SCkkGqIypKBr5G5eFs=; b=K+Oe4llapIfkNedKpC+wpB1023
        jkFGXLrQNgvhUix8rVaz6J9wf4Ef7fSnIKa/FWx1+qIlPcXm1TU0LRLky4chWFzkm+PpoOMcKQ6rE
        3mGpiJFbwe2HXCupHAWEFn2iEQ2reEOaW4xRbK+DxFBMbKhfXp/4VrZ6S3oHIhwVUUwiOjfYqL4dF
        P8U964wDbeFdhnQ0MxWqGeG7AVjvb7N8jpE7zvddjPbBlFobzWSrksIfDuQeRyY4AvR2GN7REEn+j
        MeZA1UCjE0DAzioqAUoM4c+WbUyDSh1qN8gK4ZdCe9j4F2Pgb9zbyTC41B/aiZHHjoG3zZlE1NxHz
        pU0eD8VA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJfRV-0004bR-3F; Wed, 01 Apr 2020 15:38:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED71C3060FD;
        Wed,  1 Apr 2020 17:38:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A117C2041897F; Wed,  1 Apr 2020 17:38:10 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:38:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401153810.GV20696@hirez.programming.kicks-ass.net>
References: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <20200401141402.m4klvezp5futb7ff@treble>
 <20200401142226.GU20696@hirez.programming.kicks-ass.net>
 <20200401143916.h5keq55yabetyv5u@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401143916.h5keq55yabetyv5u@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:39:16AM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 01, 2020 at 04:22:26PM +0200, Peter Zijlstra wrote:

> > > > @@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
> > > >  	if (WARN_ON(ret < 0))
> > > >  		goto fail;
> > > > 
> > > > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > > > +		ip = ftrace_regs_caller_ret;
> > > > +		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> > > > +		if (WARN_ON(ret < 0))
> > > > +			goto fail;
> > > > +	}
> > > > +

> Right, but 'ip' needs to point to the trampoline's version of
> 'ftrace_regs_caller_ret', not the original ftrace_64 version.

Duh,

		ip = trampline + (ftrace_regs_caller_ret - ftrace_regs_caller);

it is.

Luckily this would've triggerd a splat the first time I'd have actually
booted this, because the regular text is RO, while the trampoline is
still RW here. Still, good spotting.
