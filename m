Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08520663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="js8lpNnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGOPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGOPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:40:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:40:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so2240252pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQe4iE2lEc8KbaoXcjCkGmCXRZkns9DplK1eRb6FSaA=;
        b=js8lpNnl+5nO5894nRPVPli8gj7zwFSYMGTbKYzwwRzRwRR6RhGtsAv44ZFYoFdvhg
         ucdpTndZA4z0g/UA/cq/TfS0UQqyUNWVgz9H9w3oenT8YTUK1Lk5VHT678VJBPUp9ddn
         k1H57IMdMtO2aHdrASaJLGWhbIG/eOAjCJtAjaeeLM4VJPoK2Oh+w2ZVsMft8hM+j5V9
         rOikWy4kn1V6pssmTyYFSRNqrBdISRStPY85fPPbFDlJOzQUEF6dDQuYb4YHY2p/N12g
         rtwdvmu7yxcCxM2qd9kt3AdX6j4jsp4al16GFera2iO+m8jJdsUolOZ7Cw3Wr/5UkuZY
         fcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQe4iE2lEc8KbaoXcjCkGmCXRZkns9DplK1eRb6FSaA=;
        b=nM/AEuzvf6nRlqmQVWYwsgR1v75ix5Z6SveDx9qvmEmgWFsFS3X6ZKDmrUsdCTOe5Q
         8Ke1V42YLir2eOmprsZP6vnGEs1piGTjnsZjdHYRrTSr3KQCOhgvLMKQcMURFs+l/0Ea
         TPY1nW2psQM+vKwtgvU0mlkWLBFkBIBpJsa5pujRQJqvVvkZTbYZ+GRJqSb5qJhpqDk1
         ko2tUyCMqrI3VeocacRNWvRVnm5TG/Uu5Sj8EzzD+7XNueTYjLAvP3sb2BMOvs+61NTy
         IG+4qQRPnam1Wh8Ru5JRT8XaTrdghtqwYJ8l9Ex2yrqKg8j9LvkIWaMNSn51FSS/xAma
         r9sg==
X-Gm-Message-State: AOAM532AvayIdXa6+VBd+gk+6AZ0azeIbrLbJm1rJ3hrd3n9pLioiThA
        EMveJ0vNwYahruCW7KOOL5Q+kA==
X-Google-Smtp-Source: ABdhPJwh3QJDYfjYI9PLfUXPUsptAlEnjHLf87evFd3jK1SkvSxwb05NBa0xwKxaAgKooeETzkqq6g==
X-Received: by 2002:a63:d44e:: with SMTP id i14mr283502pgj.280.1594827604920;
        Wed, 15 Jul 2020 08:40:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id m16sm2565384pfd.101.2020.07.15.08.39.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 08:40:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:39:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] arm64: perf: Implement correct cap_user_time
Message-ID: <20200715153958.GB16686@leoy-ThinkPad-X240s>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-3-leo.yan@linaro.org>
 <20200715083800.GC10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715083800.GC10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jul 15, 2020 at 10:38:00AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 15, 2020 at 10:05:08AM +0800, Leo Yan wrote:
> 
> > [leoyan: Use quot/rem to convert cyc to ns to avoid overflow]
> 
> > +		quot = rd->epoch_cyc >> rd->shift;
> > +		rem = rd->epoch_cyc & (((u64)1 << rd->shift) - 1);
> > +		ns = quot * rd->mult + ((rem * rd->mult) >> rd->shift);
> > +		userpg->time_zero -= ns;
> 
> I think we have mul_u64_u32_shr() for that.

Will fix it in next spin.

Thanks for suggestion,
Leo
