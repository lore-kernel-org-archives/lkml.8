Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCE2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68526221F0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lIC+QSi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgIHMb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgIHLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:52:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AFC061786
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 04:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rwZTinpRniPb7Gd1GV/B2gVHbCl/qhwed8EPpBMTgTE=; b=lIC+QSi3V7SId5JZjcNohDmysc
        qmx2MvJwL3IbLHaxbriGHwXNOSqeka81XwOpXNocu2vi8SvFz0ieH/L3eCCU2FwtSjOtsUvtuidou
        Qi5WDVWrAbvYBSMtB+SKXjnTTY1jMOgMMcJ1IFTTKKJlz8w/SKGfeT1gOrd6jvMqwSaqGQSYK/Lwh
        jdM+OGvEQPuxSHnxwR1OmKVbJru2s4Nye7fwdx3WlOZGOAamBQT45aHh+V0Ny9PrU3L1JHeKg6ChL
        cieBfyuJd21PqkAHBicSaljqPfOwAMlsNRRsy+66+4XRFbyHAZHlNT257ViNenkZ63NxmwUQJkjRB
        e7Xr449A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFc3u-0005zW-Do; Tue, 08 Sep 2020 11:45:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F97F304B92;
        Tue,  8 Sep 2020 13:45:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3BED20CB2043; Tue,  8 Sep 2020 13:45:20 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:45:20 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] seqlock: seqcount_LOCKNAME_t: Introduce
 PREEMPT_RT support
Message-ID: <20200908114520.GS1362448@hirez.programming.kicks-ass.net>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
 <20200904153231.11994-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904153231.11994-5-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:32:30PM +0200, Ahmed S. Darwish wrote:
> @@ -406,13 +443,20 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
>  	return __read_seqcount_t_retry(s, start);
>  }
>  
> +/*
> + * Enforce non-preemptibility for all seqcount_LOCKNAME_t writers. Don't
> + * do it for PREEMPT_RT, for the reasons outlined at __SEQ_LOCK().
> + */
> +#define __seq_enforce_writer_non_preemptibility(s)			\
> +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))
> +
>  /**
>   * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
>   * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
>   */
>  #define raw_write_seqcount_begin(s)					\
>  do {									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seq_enforce_writer_non_preemptibility(s))			\
>  		preempt_disable();					\
>  									\
>  	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
> @@ -433,7 +477,7 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
>  do {									\
>  	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
>  									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seq_enforce_writer_non_preemptibility(s))			\
>  		preempt_enable();					\
>  } while (0)
>  
> @@ -456,7 +500,7 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
>  do {									\
>  	__seqcount_assert_lock_held(s);					\
>  									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seq_enforce_writer_non_preemptibility(s))			\
>  		preempt_disable();					\
>  									\
>  	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
> @@ -483,7 +527,7 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
>  do {									\
>  	__seqcount_assert_lock_held(s);					\
>  									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seq_enforce_writer_non_preemptibility(s))			\
>  		preempt_disable();					\
>  									\
>  	write_seqcount_t_begin(__seqcount_ptr(s));			\
> @@ -504,7 +548,7 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
>  do {									\
>  	write_seqcount_t_end(__seqcount_ptr(s));			\
>  									\
> -	if (__seqcount_lock_preemptible(s))				\
> +	if (__seq_enforce_writer_non_preemptibility(s))			\
>  		preempt_enable();					\
>  } while (0)

I've replaced the above with the below, afaict there were no users of
__seqcount_lock_preemptible() left.

--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -228,7 +228,11 @@ __seqprop_##lockname##_sequence(const se
 static __always_inline bool						\
 __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
-	return preemptible;						\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return preemptible;					\
+									\
+	/* PREEMPT_RT relies on the above LOCK+UNLOCK */		\
+	return false;							\
 }									\
 									\
 static __always_inline void						\
