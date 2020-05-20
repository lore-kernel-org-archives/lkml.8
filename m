Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2668C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88891206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTwfs+a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgETPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:24:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52261 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbgETPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589988289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RAAW2dLc29k3ISiLIOXrXt0G/ZR+WHztHlZgdr/wJG0=;
        b=CTwfs+a4QPOkX4HMuqibO2PH+aNqmERzj2rAP0NktQf8jXhThSyIsgfNrMAKUQL7dSMk1t
        lNj7K8egAcW1K+Z+EnU/kSdghm+x/oj0HxTuaYalsygEOp8xpiKR0KV5lvZLcpZjxcqfA8
        vqgvVw8/FABC4YIAKkJhXR2X8vFIzy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-zUJOX02RMHOhlDxOi7R1KQ-1; Wed, 20 May 2020 11:24:47 -0400
X-MC-Unique: zUJOX02RMHOhlDxOi7R1KQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943858018A5;
        Wed, 20 May 2020 15:24:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id BC6D519451;
        Wed, 20 May 2020 15:24:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 May 2020 17:24:46 +0200 (CEST)
Date:   Wed, 20 May 2020 17:24:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200520152439.GC26470@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519172506.GA317395@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19, Peter Zijlstra wrote:
>
> > The new implementation does the additional div64_u64_rem() but according
> > to my naive measurements it is faster on x86_64, much faster if rtime/etc
> > are big enough. See
> >
> > 	https://lore.kernel.org/lkml/20200123130541.GA30620@redhat.com/
>
> Right, so -m32 when ran on x86_64 CPUs isn't really fair, because then
> it still has hardware fls() for ilog2() and a massively fast mult and
> division instruction. Try and run this on a puny 32bit ARM that maybe
> has a hardware multiplier on.

OK,

> Anyway, how about we write it like the below and then when some puny
> architecture comes complaining we can use Linus' original algorithm for
> their arch implementation.

Sure, I am fine either way, but...

> +static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>  {
>  	u64 q;
>  
>  	asm ("mulq %2; divq %3" : "=a" (q)
> -				: "a" (a), "rm" ((u64)mul), "rm" ((u64)div)
> +				: "a" (a), "rm" (mul), "rm" (div)
>  				: "rdx");

...

> +#ifndef mul_u64_u64_div_u64
> +static inline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> +{
> +	u64 res = 0, div, rem;
> +	int shift;
> +
> +	/* can a * b overflow ? */
> +	if (ilog2(a) + ilog2(b) > 62) {
> +		/*
> +		 * (b * a) / c is equal to
> +		 *
> +		 *	(b / c) * a +
> +		 *	(b % c) * a / c
> +		 *
> +		 * if nothing overflows. Can the 1st multiplication
> +		 * overflow? Yes, but we do not care: this can only
> +		 * happen if the end result can't fit in u64 anyway.
> +		 *
> +		 * So the code below does
> +		 *
> +		 *	res = (b / c) * a;
> +		 *	b = b % c;
> +		 */
> +		div = div64_u64_rem(b, c, &rem);
> +		res = div * a;
> +		b = rem;
> +
> +		shift = ilog2(a) + ilog2(b) - 62;
> +		if (shift > 0) {
> +			/* drop precision */
> +			b >>= shift;
> +			c >>= shift;
> +			if (!c)
> +				return res;
> +		}
> +	}
> +
> +	return res + div64_u64(a * b, c);
> +}

Note that according to my measurements the "asm" version is slower than
the generic code above when "a * b" doesn't fit u64.

Nevermind, I agree with your version. Will you send this patch or do you
want me to make V3 ?

Oleg.

