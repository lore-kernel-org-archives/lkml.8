Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07D620C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+/niy0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgH1Iaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgH1Iab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:30:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E202C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U2ldR6xzPBv+6k+oJRaius2b5lZqMbGSNQquGmhHMdo=; b=Y+/niy0dQsqt6fTP2Sx45/kBCt
        3KkQ61Loc0XLxreekumo+EctLcAD0TBEy4NDBhZXy+euo71i9lNlGHnci9scSvHI2R9TrWJdZ41Lo
        2h0GgozNqHwl2Lwkn34LxCjwPEsr/w+C0o/yiRtkxuzsaDAQ+vflEWzDMyyxUZwD5QGCkV9Z+oklT
        hpNDukZiWBn+WFdOzzbaEqe6w2wXPbJDd0yaKk4oN/crMGhScvDtfvqyJvxxQ5wCEPfbbZRTAujNt
        HlXdGtcaKw47dosnDXTvlOiD6PzXChpyCOubdTkpb0SjADv0HrQ4trl8rwszd2QKYsrMdyFrWsXPX
        FtbeCQ3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBZmB-00046c-0e; Fri, 28 Aug 2020 08:30:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C65A300238;
        Fri, 28 Aug 2020 10:30:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42CFB2C5F134B; Fri, 28 Aug 2020 10:30:22 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:30:22 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] seqlock: seqcount_t: Implement all read APIs as
 statement expressions
Message-ID: <20200828083022.GO1362448@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-4-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-4-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:08AM +0200, Ahmed S. Darwish wrote:
>  #define __read_seqcount_begin(s)					\
> +({									\
> +	unsigned seq;							\
> +									\
> +	do {								\
> +		seq = __seqcount_sequence(s);				\
> +		if (likely(! (seq & 1)))				\
> +			break;						\
> +		cpu_relax();						\
> +	} while (true);							\
> +									\
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
> +	seq;								\
> +})

Since we're there anyway, does it make sense to (re)write this like:

	while ((seq = __seqcount_sequence(s)) & 1)
		cpu_relax();

?

