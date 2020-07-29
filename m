Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C20C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16EE207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aYMO2nWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2Lhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Lhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:37:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39EBC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=An6TpoUKg3WCau/inEvSwInZHOWFx2ZCQCj4oJPDHP8=; b=aYMO2nWLzrk9uO8jt/GY9jR84O
        tfWAJxthdJnOegxiFL7ayfJV386JsKV9Y0+ptbwXOmpgRLD8pfi9X0ZnahmYJt0tXBHfUw423niv/
        NxeDjUWlxdZwIXPC6kHVn4TWXS+3GNr/1PDSAqpRJPrbrMKkwmlyAjaKKGeCD9up+JL+9auA/2Ija
        hxvgTI2HDaEcAu842cj7QfcqrdGQjBItWbKS4Sty6QQPIzJrgPgHOvKDAtsMvbO0xTTv3Z+qF2Szr
        AOZCKWEb7mBAK79PZMntWq7Bty+nNNPXgD63vuYtyYG8cMmzl1UijRY2w6SsAoaI+5/zvNXEZZmAD
        +u7Pacqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0kOs-0002FJ-J0; Wed, 29 Jul 2020 11:37:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 902CA304BAE;
        Wed, 29 Jul 2020 13:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BC06205B8B6F; Wed, 29 Jul 2020 13:37:31 +0200 (CEST)
Date:   Wed, 29 Jul 2020 13:37:31 +0200
From:   peterz@infradead.org
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain
 the old value
Message-ID: <20200729113731.GA2678@hirez.programming.kicks-ass.net>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
 <20200729111120.GA2638@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:11:20PM +0200, peterz@infradead.org wrote:

> Subject: locking/refcount: Provide __refcount API to obtain the old value
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Jul 29 13:00:57 CEST 2020
> 
> David requested means to obtain the old/previous value from the
> refcount API for tracing purposes.
> 
> Duplicate (most of) the API as __refcount*() with an additional
> 'int *' argument into which, if !NULL, the old value will be stored.
> 
> Requested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/refcount.h |   65 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 57 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -165,7 +165,7 @@ static inline unsigned int refcount_read
>   *
>   * Return: false if the passed refcount is 0, true otherwise
>   */
> -static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> +static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
>  {
>  	int old = refcount_read(r);
>  
> @@ -174,12 +174,20 @@ static inline __must_check bool refcount
>  			break;
>  	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
>  
> +	if (oldp)
> +		*oldp = old;
> +
>  	if (unlikely(old < 0 || old + i < 0))
>  		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
>  
>  	return old;
>  }
>  
> +static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> +{
> +	return __refcount_add_not_zero(i, r, NULL);
> +}

so, I could also emulate C++'s

bool refcount_add_not_zero(int i, refcount_t *r, int *oldp = NULL)

style by going to town on this with a bunch of CPP magic, but I don't
think that'll actually make things clearer.

It'll look something like:

#define __REF_ARGS(_0, _1, _2, _3, _n, X...) _n
#define REG_ARGS(X...) __REF_ARGS(, ##X, 3, 2, 1, 0)

#define __REF_CONCAT(a, b) a ## b
#define REF_CONCAT(a, b) __REF_CONCAT(a, b)

#define REF_UNARY_2(func, arg1, arg2)	func(arg1, arg2)
#define REF_UNARY_1(func, arg1)		func(arg1, NULL)
#define REF_UNARY(func, X...) REF_CONCAT(REF_UNARY_, REF_ARGS(X))(func, X)

#define REF_BINARY_3(func, arg1, arg2, arg3)	func(arg1, arg2, arg3)
#define REF_BINARY_2(func, arg1, arg2)		func(arg1, arg2, NULL)
#define REF_BINARY(func, X...) REF_CONCAT(REF_BINARY_, REF_ARGS(X))(func, X)

#define refcount_add(X...)	REF_BINARY(__refcount_add, X)
#define refcount_inc(X...)	REF_UNARY(__refcount_inc, X)

Opinions?
