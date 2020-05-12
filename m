Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4271CC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10ABC20714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o869Ee1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgELJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgELJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D42C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=shK7aR/ydkvsnOWisRj+Fa3yjOqgDfCAxCFNZzyL1cI=; b=o869Ee1yYenCiNHinXAuy9QNzi
        lldL97dLFw0qZTq3V0fXhrmUqlagDm1p1AIshVARtquDckTVA0wQP7iB4yCG378ZAPsywIaBHUSZJ
        T+ShFq5/eFnwZakFcwSCnODyZtanmjH+E0OAue+hxnDaaZIWcViz4cbRjT5GQM09lHuCoZsMjrr02
        fAYPum/x81lFjLrwawzpHGpTs0H68pssEtREJ7eiAEDsaVO1OBtZqBfB7CyNXrj+goEG6YCQ/ZTKN
        +j8JE8q6zjWXZR6hJIt/mGpdi9eMieDQhwTc+P/LcSuL5H0p2dDIwuXATb9tmyYfOc1c5/yek1dmq
        t51VenSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYR4L-0004k1-Er; Tue, 12 May 2020 09:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8A75300261;
        Tue, 12 May 2020 11:19:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBCD3203AA832; Tue, 12 May 2020 11:19:18 +0200 (CEST)
Date:   Tue, 12 May 2020 11:19:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200512091918.GH2978@hirez.programming.kicks-ass.net>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
 <20200511092519.GA3001@hirez.programming.kicks-ass.net>
 <20200512063812.GA20352@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512063812.GA20352@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:38:12PM +0800, Leo Yan wrote:
> @@ -1165,28 +1166,26 @@ device_initcall(armv8_pmu_driver_init)
>  void arch_perf_update_userpage(struct perf_event *event,
>  			       struct perf_event_mmap_page *userpg, u64 now)
>  {
> +	struct clock_read_data *rd;
> +	unsigned int seq;
>  
>  	/*
>  	 * Internal timekeeping for enabled/running/stopped times
>  	 * is always computed with the sched_clock.
>  	 */
>  	userpg->cap_user_time = 1;
> +	userpg->cap_user_time_zero = 1;
>  
> +	do {
> +		rd = sched_clock_read_begin(&seq);
> +
> +		userpg->time_mult = rd->mult;
> +		userpg->time_shift = rd->shift;
> +		userpg->time_zero = rd->epoch_ns;
> +
> +		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;

Damn, I think this is broken vs the counter wrapping.

So what the sched_clock code does is:

	cyc_to_ns((cyc - rd->epoch_cyc) & rd->sched_clock_mask, rd->mult, rd->shift)

But because the perf interface assumes a simple linear relation, we
can't express that properly.

Now, your arm64 counter is 56 bits, so wrapping is rare, but still, we
should probably fix that. And that probably needs an ABI extention
*sigh*.

> +
> +	} while (sched_clock_read_retry(seq));
> +
> +	userpg->time_offset = userpg->time_zero - now;
>  }
