Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF62C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF2820644
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bwjVOz8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgECM7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgECM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:59:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+lGKzpaVVVlni8cH6s69CJfNRMyq7s1Y6qgdnxsiOts=; b=bwjVOz8aFtYgbZsV15RTsY6Qgv
        qE9VqPxyisj9EZCVpiWapO1IJCdzSn6e8sUtGrRDSoRBxi2e51RKXczZ5qunNXfN37R2RhEixz9vj
        XZq5saawI0BS5KjYjDTNhaeJ5Xm9WHudouZhFgFvHOzmNRis3u6lVg8oy49rBdu6cSKgqKzRRDYZm
        vWw0n4a7oOfZQVvGlPlIC/SdfZ6uJRBS+I6kfj0tYIiylI2SM+m7LvUzALHxV+mnn+XzIwA5cUJT9
        i6mk6YjcNH5KebCvEavgZ35LQX+s3JFJm/qRvbJSKvB2ffp2OJ2m24vCnTfmH05IB9xH/vMQhDR/N
        iAfEap9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVECH-0008Fq-Kb; Sun, 03 May 2020 12:58:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A491730704D;
        Sun,  3 May 2020 14:58:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70B4725BAEC02; Sun,  3 May 2020 14:58:13 +0200 (CEST)
Date:   Sun, 3 May 2020 14:58:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200503125813.GL3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 03:08:00PM +0200, Rasmus Villemoes wrote:
> On 01/05/2020 22.29, Peter Zijlstra wrote:
> > Extend the static_call infrastructure to optimize the following common
> > pattern:
> > 
> > 	if (func_ptr)
> > 		func_ptr(args...)
> > 
> > +
> >  #define static_call(name)	__static_call(name)
> > +#define static_cond_call(name)	(void)__static_call(name)
> >  
> > +
> >  #define static_call(name)	__static_call(name)
> > +#define static_cond_call(name)	(void)__static_call(name)
> >  
> 
> > +#define static_cond_call(name)						\
> > +	if (STATIC_CALL_KEY(name).func)					\
> > +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
> > +
> 
> This addresses neither the READ_ONCE issue nor the fact that,

> AFAICT,
> the semantics of
> 
>   static_cond_call(foo)(i++)
> 
> will depend on CONFIG_HAVE_STATIC_CALL.

True.

So there is something utterly terrible we can do to address both:


void __static_call_nop(void)
{
}

#define __static_cond_call(name) \
({ \
	void *func = READ_ONCE(STATIC_CALL_KEY(name).func); \
	if (!func) \
		func = &__static_call_nop; \
	(typeof(STATIC_CALL_TRAMP(name))*)func; \
})

#define static_cond_call(name) (void)__static_cond_call(name)


This gets us into Undefined Behaviour territory, but it ought to work.

It adds the READ_ONCE(), and it cures the argument evaluation issue.

> Also, I'd have appreciated being
> cc'ed on new revisions instead of stumbling on it by chance.

Sorry, my bad, I forgot about that :-/. I rushed to repost, and simply
forgot a few things.

