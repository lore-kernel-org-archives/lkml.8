Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A15C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465D320B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6DZmlh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgD1SbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgD1Sa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:30:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77BCC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lGqR9F+kdPJv1A8Me44RtuAlEYognn42SVvVNy+QNK4=; b=C6DZmlh+pr+6ZHDsRi3KCUKFEu
        7wBKtqQhf0ASPZx0BdvqZoZ/UIn+SQoAPryACfCRo7z323zTcs/OjYM0rw2qclcwDcocj9o8t/kKU
        wbNXHPtQ6YP0cp3Yoen8GZUr5qpFDQlt4MklKtHUIlHLuITdzs0g726zhdB5B5ibDCwMnrPsr921N
        Fg5dSl9/U7LhdrbhsVP/lVo9oUYe8ig8QQS8Q13+xwQwpAPqobxee6Xhf2A+ok1AEADBlR365StHu
        P+/ELE/qgvvGRu8gN00+f8dymVd3/p8sY2HCq6yXgXYz+jvjHzghZ1KI4lTMFx39qivdHOFRU4kgQ
        wjEr7YDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTV02-0005eD-SV; Tue, 28 Apr 2020 18:30:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A38DF30797F;
        Tue, 28 Apr 2020 20:30:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 874C0201F9F0A; Tue, 28 Apr 2020 20:30:28 +0200 (CEST)
Date:   Tue, 28 Apr 2020 20:30:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH 8/8] x86/retpoline: Fix retpoline unwind
Message-ID: <20200428183028.GB13575@hirez.programming.kicks-ass.net>
References: <20200423125013.452964352@infradead.org>
 <20200423125043.129313983@infradead.org>
 <20200424193028.tecqlugzzue2n5vj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424193028.tecqlugzzue2n5vj@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 02:30:28PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 23, 2020 at 02:47:25PM +0200, Peter Zijlstra wrote:
> >  .macro CALL_NOSPEC reg:req
> >  #ifdef CONFIG_RETPOLINE
> > -	ANNOTATE_NOSPEC_ALTERNATIVE
> > -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),\
> > -		__stringify(RETPOLINE_CALL %\reg), X86_FEATURE_RETPOLINE,\
> > -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
> > +	/*
> > +	 * This cannot be ALTERNATIVE_2 like with JMP_NOSPEC, because ORC
> > +	 * unwind data is alternative invariant and needs stack modifying
> > +	 * instructions to be in the same place for all alternatives.
> > +	 *
> > +	 * IOW the CALL instruction must be at the same offset for all cases.
> > +	 */
> > +	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
> > +	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
> > +		    __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE
> 
> I'm missing why ALTERNATIVE_2 wouldn't work here.  How is the call a
> "stack modifying instruction"?  It's not an intra-function call so it
> shouldn't affect ORC at all, right?

My bad. I find it hard not to consider CALL a stack modification. Let me
fix that.
