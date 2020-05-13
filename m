Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E2A20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b32vjakt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgEMLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgEMLPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:15:10 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/Wqq3uOvtKbZfYJc48mNiATxJyfIVdSSR1DgfaLH54=; b=b32vjaktLO98mX8LKLQxIPBAJO
        XfWpic6QU9m6K/Lt9sQ9zp/4xgZLexxa/EyjhsOp/Ns91PCIML33BaxMeP99/SGI3L5U10CGShJwe
        xBUUnFY8t3UE+ufFh/O7uBBhaeQjUWzxiGlOBysHlgg7+YW8hYkzWA6pY+ehH5gjoPmjtPvuQZeda
        LQLdtDiLwI2wpg4gss04jlEYbZFwEZIFQeNSXa3L8DiEoxDh6600x12ITYY8EATZ0j7NrNhxbxe+d
        vAnrbPBg/IPA7YLiWi/b/EaqGGa/OQCQ6L0E81WfI5EFGGOINIwszOCDsSrbXAafrKAaHv/93khGj
        ulY1MT/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpLd-0004dS-Ir; Wed, 13 May 2020 11:14:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE5E7301205;
        Wed, 13 May 2020 13:14:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AF2424C0C643; Wed, 13 May 2020 13:14:47 +0200 (CEST)
Date:   Wed, 13 May 2020 13:14:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, dvyukov@google.com
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513111447.GE3001@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513111057.GN2957@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 01:10:57PM +0200, Peter Zijlstra wrote:

> So then I end up with something like the below, and I've validated that
> does not generate instrumentation... HOWEVER, I now need ~10g of memory
> and many seconds to compile each file in arch/x86/kernel/.

> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 3bb962959d8b..48f85d1d2db6 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -241,7 +241,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * atomicity or dependency ordering guarantees. Note that this may result
>   * in tears!
>   */
> -#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> +#define __READ_ONCE(x)	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x)))
>  
>  #define __READ_ONCE_SCALAR(x)						\
>  ({									\
> @@ -260,7 +260,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  
>  #define __WRITE_ONCE(x, val)						\
>  do {									\
> -	*(volatile typeof(x) *)&(x) = (val);				\
> +	data_race(*(volatile typeof(x) *)&(x) = (val));			\
>  } while (0)
>  
>  #define __WRITE_ONCE_SCALAR(x, val)					\

The above is responsible for that, the below variant is _MUCH_ better
again. It really doesn't like nested data_race(), as in _REALLY_ doesn't
like.

---

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3bb962959d8b..2ea532b19e75 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -241,12 +241,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#define __READ_ONCE(x)	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x)))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);		\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
@@ -260,14 +260,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __WRITE_ONCE(x, val)						\
 do {									\
-	*(volatile typeof(x) *)&(x) = (val);				\
+	data_race(*(volatile typeof(x) *)&(x) = (val));			\
 } while (0)
 
 #define __WRITE_ONCE_SCALAR(x, val)					\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
+	__WRITE_ONCE(*__xp, val);					\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
