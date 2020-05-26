Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100B6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E291520776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUQs/+Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgEZQQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgEZQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:16:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDABC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:16:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j10so5381630wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QAvGGfTFG25ElrhD3qboczTVRvpcoz4/MxDPrOFLyQc=;
        b=jUQs/+XrgKVA+BxYtYwJ9+JuBcKfqE7sTotIk1cJwTjNDdph4q8//KIKCWFWJXjuqF
         bNvHT1mXU4vgLFZtgKfBQQ9XcnIDBptu/akIqUTWHm0cOtz2BEJS1ruk4/MNa1eH4klt
         ZuFTkQLr8+q2ITQVc1NPo2IdaUCyWjFec4BlJyZFu2utsBGt4sDUF8vR2Fhu2Czulcg3
         05T0h5z1DCFPvdQ5za1lUYlAooFdl+a+ZXRSnTlenUopOjd9D60o6A+qkKmbBYHacvu7
         pAgh6ITLIy49AYE+6r1dZg7eAuTHLpX0avsd1ygJ2UgVJBrR1haYqXWV9/vSq/g2zOtc
         35YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAvGGfTFG25ElrhD3qboczTVRvpcoz4/MxDPrOFLyQc=;
        b=LRpL1kwwdCFD7o0NoIrmT1uL/N3joosYFKEg4R8umYezI9KlZ7wXPdVBLjX/Ec1j13
         IjdM7fAsBIhCaOppRLnYlhufVI8v2CtFreXQJdICE3ZnM6TYGIVX+fLU+CQCyS6zAez2
         9sqnmXLMB7yzL3ZDeGo/EEmODkCz303DFzCG/Wq+aTBeFBiv0zybXPodN7jeEJPaXLCe
         /X3nTkTsi9NoTT3hYEHs43c0pqy4qXpI6hmkRnu6KjbLaIhVF9UAfP8rln/wEQRwgDfg
         +ivr54MPLwLT6G6keimCnJb5zU3Ziz7X3sSGdKmbnOrwhZrEL5O3q6rLCrE3Pd+WkTc2
         DTSQ==
X-Gm-Message-State: AOAM5333NpYyS+P0pPW6enWD60JqY1YUAyLXsmzpQUOlCj1mjU7nbw0D
        NQQrYmpIqrHso9B74S/iTycphw==
X-Google-Smtp-Source: ABdhPJw+Wg0GW1oC/oNFNRUHFRzDIfJRTiTYdwrWZ2pGrP6gCaf6ehHa7I8kx27W+5CJXurje+VdMQ==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr17353654wrv.112.1590509783661;
        Tue, 26 May 2020 09:16:23 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q13sm268377wrn.84.2020.05.26.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:16:22 -0700 (PDT)
Date:   Tue, 26 May 2020 17:16:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org
Subject: Re: x86/entry vs kgdb
Message-ID: <20200526161621.7ucj5jn6rm5yednb@holly.lan>
References: <20200525083605.GB317569@hirez.programming.kicks-ass.net>
 <20200525091832.GE325303@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525091832.GE325303@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:18:32AM +0200, Peter Zijlstra wrote:
> On Mon, May 25, 2020 at 10:36:05AM +0200, Peter Zijlstra wrote:
> > Hi!
> > 
> > Since you seem to care about kgdb, I figured you might want to fix this
> > before I mark it broken on x86 (we've been considering doing that for a
> > while).
> > 
> > AFAICT the whole debugreg usage of kgdb-x86_64 is completely hosed; it
> > doesn't respsect the normal exclusion zones as per arch_build_bp_info().
> > 
> > That is, breakpoints must never be in:
> > 
> >   - in the cpu_entry_area
> >   - in .entry.text
> >   - in .noinstr.text
> >   - in anything else marked NOKPROBE
> > 
> > by not respecting these constraints it is trivial to completely and
> > utterly hose the machine. The entry rework that is current underway will
> > explicitly not deal with #DB triggering in any of those places.
> 
> This also very much includes single stepping those bits.  Which KGDB
> obviously also does not respects.

For breakpoints there's already a pre-poke validation hook that
architectures can override if they want to. I can modify the default
implementation to include checking the nokprobe list.

Stepping is a bit more complex. There are hooks for some of the
underlying work but not pre-step validation hook. I'll see if we can add
one.


Daniel.
