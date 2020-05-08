Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B02C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5337B20720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgvGGxCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgEHNB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728299AbgEHNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:01:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E6C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:01:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so702234pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=o3OgWVB0a6CAcOGM+6MfNaCF+/D3bde7qUFErGIacxg=;
        b=XgvGGxCbe4IdrexJsZdsTskyMr8050LIqTOKyIR6i+tdm6rYZBi70IraVzAT1tpJJP
         yED/sxa2KMV1Rq+l2OkvcS79m4FSlV3dSIwvfR3ZnqtbF9T3dBwjyF68oHInNpQ8PIu9
         DpbOGI+A14IRcqiAOK1DQGBngcBYhVJaBbrZGT/CdEFH6axLir7fcH5qtNWfqH6Dknwg
         IgT4oF7R0SUGUroXCQEu+1MoRJg9c2wN1JLdEw1WgnenEF+ysvdNMNFCnnKH4KiEUiu8
         S3gZysDFRAIwpvXGUc6svR5dekWYCyv/tl0RujwceeP4xLZGbyGA3Q0PeDICNtIPO1/a
         OOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o3OgWVB0a6CAcOGM+6MfNaCF+/D3bde7qUFErGIacxg=;
        b=QG2ZVaTtQqTLb2LmTpOKiElwXuQDxGFknmT05RMMEvR1UBILCskw+gHZsqRGrRaYxh
         5hSnb2j1KhmPISPTsVF7TrjYRL370pAToOUIYQDLMyoIU54Qj7wgsLkKUoshPOR28fZg
         f0rIee0n1pT4VR0BZ+3D1E0s/bHvHbxc36qIIZ2s7CDrN3CILHlCi1oW+NV7yYQlWkbA
         MktLxv1AvQsBGuNJJRtayyRaaN09lsumbd5iWDoEC46D3WbWMAiT6FUbLB8IecpGRP+p
         XwShNXH90ChFoW4UaI1a7PKnSODvWtSnPXyEzMSTArjVXhQ+Xd2sf5odp8MxndQBdnme
         3Eeg==
X-Gm-Message-State: AGi0Pub/iDRVFuuafG0MFfKOPsWCYLyvX7HDy63dZFhKa+AardZvVAmT
        2GdZ51OywQ7G52KxVWxFdzCevUAx
X-Google-Smtp-Source: APiQypI20UAgOtvckviNiNXHkBIdFDDvOKZsxIDH+f60ongVJQYaFnkgcPrifWAmJpGatrs0SF3afw==
X-Received: by 2002:a17:90a:252b:: with SMTP id j40mr5756317pje.60.1588942882724;
        Fri, 08 May 2020 06:01:22 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id e10sm1730528pfl.195.2020.05.08.06.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 06:01:21 -0700 (PDT)
Date:   Fri, 8 May 2020 21:01:18 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200508130118.GA4514@iZj6chx1xj0e0buvshuecpZ>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
 <20200505142711.GA12952@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505142711.GA12952@vingu-book>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:27:11PM +0200, Vincent Guittot wrote:
> Le mardi 05 mai 2020 à 21:40:56 (+0800), Peng Liu a écrit :
> 

[...]

> 
> Your proposal below looks quite complex. IMO, one solution would be to move the
> update of nohz.next_balance before calling rebalance_domains(this_rq, CPU_IDLE)
> so you are back to the previous behavior.
> 
> The only difference is that in case of an break because of need_resched, it
> doesn't update nohz.next_balance. But on the other hand, we haven't yet
> finished run rebalance_domains for all CPUs and some load_balance are still
> pending. In fact, this will be done during next tick by an idle CPU.
> 
> So I would be in favor of something as simple as :
> 

Vincent, could you refine this patch with some changelog?
And have my reported-by if possible.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04098d678f3b..e028bc1c4744 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                 }
>         }
> 
> +       /*
> +        * next_balance will be updated only when there is a need.
> +        * When the CPU is attached to null domain for ex, it will not be
> +        * updated.
> +        */
> +       if (likely(update_next_balance))
> +               nohz.next_balance = next_balance;
> +
>         /* Newly idle CPU doesn't need an update */
>         if (idle != CPU_NEWLY_IDLE) {
>                 update_blocked_averages(this_cpu);
> @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         if (has_blocked_load)
>                 WRITE_ONCE(nohz.has_blocked, 1);
> 
> -       /*
> -        * next_balance will be updated only when there is a need.
> -        * When the CPU is attached to null domain for ex, it will not be
> -        * updated.
> -        */
> -       if (likely(update_next_balance))
> -               nohz.next_balance = next_balance;
> -
>         return ret;
>  }
> 
