Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A224120674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4ITW2HJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGJD2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:28:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57EAC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:28:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so1683759plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZxvdxfBILaYnXJQNJZ+x2bh2Jwx9Lc0OH867FBGnbFU=;
        b=f4ITW2HJaDpzmlUOq9gsCcnsNeXZ5kAxGhOJ1WsdU6gBY38JfAB7ZB1Gx59a4IBjah
         zA4j4PHyy+SO/ZuI+Nel6mFtFa33tswvI6qeX9gTLKSF1tDJx6lWL8IaQ1ybtqVB4vP3
         FUgbKXueG7i4hIHeoJnHrFbdDWr9b/AA24yBVyFCU0AqFufs0S130Vik8qr14gB6xOeQ
         LjiLF+PpGsr+x6GRaIC6KqD5KYa+gIri9QIk9/gRFK7Z2/xLLTFiIIuvtW9Fdxr+Wh1C
         /P1PVyt9zt2czjYTNr/6HJ6iLXe4UCCj39nJ/Lj8Euc5P7DX3DrQ9H6WECyHeJNOZi1o
         r7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZxvdxfBILaYnXJQNJZ+x2bh2Jwx9Lc0OH867FBGnbFU=;
        b=p1vcoKp+0uM3tCRwa26jCYBfQ2c6+sYma8HgD5J0MXYuAoCF6LnjYriyPikU6BKbpg
         6mVAnSTsBo059YhZ8IdkDXd+Ga9n31hcJjsTxqtDjqT5ULsW2hlmdchJRmONT42FFRGu
         AQFv9lSQAcGwcqZcxX61k4PjT1Di9gkHJeyOOUBMtDjiwSopJCschVw1n9RrSF0lqxsc
         r6HyZ7tXT5ZaJm62+BwhwsIxpYdjKGcX+wBVgW3sCsQglAkTW/aL0keYrLnGsGECdDm/
         Q22fZ9sT4OXK6QbklGnDQ92hf6ks1VzPYV4t9qkQAf6+R/ersHoTpbDg/m930/rvkzEp
         TMUQ==
X-Gm-Message-State: AOAM530ipl3yPTUif2DKe7TZ8oyelCpNwCxvxHkvQxoE/45zXJSP4Wb6
        W3xvD+GV/xbqHOlpGOliEmOMoQ==
X-Google-Smtp-Source: ABdhPJwC9zCaMf7YyiHY62PJWxCjHJlpdSjtle2sA2rDlVKwWWZXjY3oGD4zZ5m1JyPbt/hCXLnJyw==
X-Received: by 2002:a17:902:ee8b:: with SMTP id a11mr45310502pld.26.1594351695336;
        Thu, 09 Jul 2020 20:28:15 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id a9sm4313852pfr.103.2020.07.09.20.28.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:28:14 -0700 (PDT)
Date:   Fri, 10 Jul 2020 08:58:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Don't support AMU without cpufreq
Message-ID: <20200710032812.s7te6irtjiftljdb@vireshk-i7>
References: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
 <20200709101734.GB5623@arm.com>
 <20200709104048.emwuquj2qkyascb3@vireshk-i7>
 <20200709124630.GB15342@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709124630.GB15342@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 13:46, Ionela Voinescu wrote:
> I saw this case during FVP testing, although I acknowledge the 'virtual'
> part of that platform [1]. But allowing this does enable AMU testing on
> an AEM FVP.

In kernel, we only support things that are in mainline, else we don't
care about them. That's the general rule. And yeah I understand that
this is early support for a new hardware, and so it is better to add
code for things we are sure about.

> While I completely understand the reasoning behind avoiding to introduce
> large changes for small corner-case gains,

I think even that is fine, if there is a problem to be solved it needs
to be solved, big or small doesn't really matter. Just that it needs
to be there in mainline.

> the arguments for this
> support was:
>  - (1) AMUs are a new feature and it will take some time until we see the
>    real usecases. That's always the case with early support for a
>    feature - we want to add it early to enable its use and testing, but
>    it will take some time to establish the true usecases.

Exactly, and so people normally prefer to keep things simple until the
time the needs arises for the same. A patch can be added later, its no
big deal. But it should be added when we need it.

>  - (2) It literally needed 2 lines of code + the weak cpufreq function
>    to support this.

Yeah, small or big doesn't really matter.

> Given that I can't guarantee what hardware will or won't do, and given
> that AMUs are an optional feature, I controlled the only thing I could:
> the software :). By not making assumptions about the hardware, I ensured
> that the code does not break the interaction between cpufreq use or AMU
> use for frequency invariance.
> 
> This will be nicer in the new code as the control will be at CPU level,
> rather than policy level.

I won't try to force you to remove this piece and will leave it for
you to decide.

But, I don't see a future system in mainline which uses AMU but
doesn't have cpufreq for all its CPUs. And so I won't have kept code
for that, even if it is just 2 lines. We can always add it back when
required.

Thanks for the review again Ionela.

-- 
viresh
