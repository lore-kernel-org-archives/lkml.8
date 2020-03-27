Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F1C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED26206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LG3Ha+qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0KIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:08:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0KIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ow9wspP4ZB5j6pWkHUXbOlu3r+KhuaS3yvNnb3J3+Xo=; b=LG3Ha+qssDr5iexXh9ZU+6Xv9r
        jC2PwRQqxcOsjBKD6T5lOsXEYZM6LBXl7aHA3GfBQ7UmNDMSfvsk0/QXa080B3a1iSnnQRGrxIqz6
        Q6im6mg0znSbenyQMfb4BPTFQOyPDC705a/N85eE2PyS282HqSvCExh+EeKL/cFzcuKF8pY5BBpSj
        T+m9ThDURcPZyB+laOkgxBUDJDsm9g84EK/3PnCx3JB+NH56jpB7fcTc928AtV6x+QJKYnsrARVFp
        BgCqNZKtHeJvVoykBq73cmZzeGjt8vG9KDLZqXpJvKusBdYL1OaObR/TBiBQMX5/tjhfzXBY6RKp2
        cFEoZNdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHluj-0003PM-Kh; Fri, 27 Mar 2020 10:08:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E21D3010C2;
        Fri, 27 Mar 2020 11:08:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 474E129CA13C6; Fri, 27 Mar 2020 11:08:31 +0100 (CET)
Date:   Fri, 27 Mar 2020 11:08:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
Message-ID: <20200327100831.GT20713@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142246.127013582@infradead.org>
 <10ef25bf-87df-6917-1d50-c29ece442766@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ef25bf-87df-6917-1d50-c29ece442766@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:37:35AM +0100, Rasmus Villemoes wrote:
> On 24/03/2020 14.56, Peter Zijlstra wrote:
> > Extend the static_call infrastructure to optimize the following common
> > pattern:
> > 
> > 	if (func_ptr)
> > 		func_ptr(args...)
> > 
> 
> > +#define DEFINE_STATIC_COND_CALL(name, _func)				\
> > +	DECLARE_STATIC_CALL(name, _func);				\
> > +	struct static_call_key STATIC_CALL_NAME(name) = {		\
> > +		.func = NULL,						\
> > +	}
> > +
> >  #define static_call(name)						\
> >  	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
> >  
> > +#define static_cond_call(name)						\
> > +	if (STATIC_CALL_NAME(name).func)				\
> > +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
> > +
> 
> What, apart from fear of being ridiculed by kernel folks, prevents the
> compiler from reloading STATIC_CALL_NAME(name).func ? IOW, doesn't this
> want a READ_ONCE somewhere?

Hurmph.. I suspect you're quite right, but at the same time I can't seem
to write a macro that does that :/ Let me try harder.

> And please remind me, what is the consensus for sizeof(long) loads: does
> static_call() need load-tearing protection or not?

We all like to believe compilers are broken when they tear naturally
aligned words, but we're also not quite comfortable trusting that.
