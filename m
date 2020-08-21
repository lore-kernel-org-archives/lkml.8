Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E176C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F96207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeS8ObJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHUJgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:36:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B2C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:36:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v16so642918plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HnZXM8XOnRw3EyhQGuLTicUwiSSuNeJMLzprIDO7NXw=;
        b=PeS8ObJCcwZEGgfznTBsrVSezMqW4Gb0fKStJLyCe53r801ikPbXeKCVVRQZ9aStcE
         /mylhuh7W2sPnj8wyLQwkmQMJtg7PrtA1gtRFw+tnw3AsMBkAGyZNS0VZR7KXgpLJ1XF
         O9aU3Bv4sNdD0Ax/tf/eSCgQt/Y96zr/zArNqkwR73VEsyuJs2jRG3Ke2QGaBDXU4lwU
         IXAPk8zngb0qn2QzfMBjhwPoofgbiPMcMDfHYr0m3PdLEOw9B8VF6tTYpIzi+wL7iY82
         ++HTYnN0Vyg7LIO2lQZ/bNuzB+JX8LD6I7Prw8VFH9gcKvSPqF8xkUQv+NzbnJN9Ffxv
         FXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HnZXM8XOnRw3EyhQGuLTicUwiSSuNeJMLzprIDO7NXw=;
        b=Fps6I8uEjNRSHfg+d6ALU1ygSfAaMg48hHwE2lX6iQzkyZi7bDkA6k/lcRTA6Q5Eot
         3j++lVT7jMr2Imdp9Pfa9MaQxx24o6EwaOIz6A9vTmtyJLpHyqht+t/JRUe5V+qumMB5
         QD6rw7Ez/YtuotXhVrk5K6E7sqiFR1DgBiCD/14YnjsnQiQSsuVtwUkSMawOBzj8L7X/
         WCbROAicOANWhrwTuCC5hlmeiyYUlPLROE3W3HeGbUONh0Ea2fPWscSR75ZtZthxUnra
         SbYrX4LIfMfS9RNDvKXm/eak1j9gKNWsVuSDZ3tDsnRH1aPrC4StCUpbIzEO8ux5KzmO
         PyAw==
X-Gm-Message-State: AOAM531aE9e2ug0b4EyC+1HHj3UpbeEjZMdHY3SBS2XMZMnizMdI3hAV
        vXT1Se7vjR/Bhf/Jg0EQSq9hUA==
X-Google-Smtp-Source: ABdhPJylj9eRj8V9uKB44pf5NOj4natO5nO3lvOWEjkNwhLdD/LGaXrciFtGCOefcZmPPwL8wj0MqA==
X-Received: by 2002:a17:902:a9cb:: with SMTP id b11mr1724652plr.1.1598002602851;
        Fri, 21 Aug 2020 02:36:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w16sm1585855pjd.50.2020.08.21.02.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 02:36:42 -0700 (PDT)
Date:   Fri, 21 Aug 2020 17:36:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf tools: Support Arm arch timer counter
Message-ID: <20200821093632.GA22365@leoy-ThinkPad-X240s>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <20200807071620.11907-2-leo.yan@linaro.org>
 <27ed6ebf-d9e6-e0ea-1577-2bba3d6f35c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ed6ebf-d9e6-e0ea-1577-2bba3d6f35c1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Thu, Aug 20, 2020 at 10:56:46AM +0800, liwei (GF) wrote:

[...]

> > +int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
> > +				    struct perf_arch_timer_conversion *tc)
> > +{
> > +	bool cap_user_time_zero, cap_user_time_short;
> > +	u32 seq;
> > +	int i = 0;
> > +
> > +	while (1) {
> > +		seq = pc->lock;
> > +		/* Add barrier between the sequence lock and data accessing */
> > +		rmb();
> > +
> > +		tc->time_mult = pc->time_mult;
> > +		tc->time_shift = pc->time_shift;
> > +		tc->time_zero = pc->time_zero;
> > +		tc->time_cycles = pc->time_cycles;
> > +		tc->time_mask = pc->time_mask;
> > +		cap_user_time_zero = pc->cap_user_time_zero;
> > +		cap_user_time_short = pc->cap_user_time_short;
> > +
> > +		/* Add barrier between the data accessing and sequence lock */
> > +		rmb();
> > +		if (pc->lock == seq && !(seq & 1))
> > +			break;
> > +		if (++i > 10000) {
> > +			pr_debug("%s: failed to get perf_event_mmap_page lock\n",
> > +				 __func__);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!cap_user_time_zero || !cap_user_time_short)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> 
> Should we implement the perf_event__synth_time_conv() method? As it can be supported
> on arm64 arch now.

Thanks a lot for pointing out, agree that we should implement
perf_event__synth_time_conv() for Arm64.  Will do it in next spin.

> These is also a tsc get method called rdtsc(), weak implementation in 'tools/perf/util/tsc.c',
> maybe we should rename it to an arch independent name, and implement the arm64 version
> (read_cntvct_el0 in patch 3) here.

If connect with your comment in patch 02, I think you are asking to
consolidate for TSC common APIs and operations.  I took time to review
the codes for conversion between timer counter and time stamp, your
suggestion is reasonable and feasible for me.

But the consolidation will impact the existed x86 implementation, before
proceed to this direction for the next patch set, I'd like to get some
review from x86's developers.

@PeterZ, could you take a look for this and let me know if you have any
concern for the consolidation?

> Thus we can also make the testcase generic,
> instead of adding a new one for arm64 :).

Exactly.  Will do this if we get agreement for consolidation.

Thanks for the reviewing,
Leo
