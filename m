Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C62C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC59206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5uGL7ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgFOPiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgFOPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:38:14 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:38:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id r11so9609697vsj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cN819TKXbJsjMcpNBjbeHjndh7AMERO5YzZiFBrqdI=;
        b=C5uGL7efs5Y4Dh9sG4tceMzBG8eo5VK18lfcoCKmfZSDJLHVeAD1ZNAvPznZn40M4z
         5Gw1MnJqHBuYKJklCbJTpQQLxLPcxMo01yyUjTuUQFtIUti9iMJCAfjjfnUz+9/ba0UF
         Z9pHZMtq2l2Qy6aVzQZ2bYtrTyuORhiInhhFR74Lwp+Il+FWQ3zvFv4vO2EyQy7l45J7
         BxdaeuK3QB2XXdiOI/EGz3G4eK9iHlC7H/XmV0Vl7NXFYyFIelHORmz+yvvTzGZAJ9Yo
         0X59MonX94e2ZpZ+C4fBGya/D2kyMKpInDy023JYEB6+MPZyWuBHOppzAWmywIWneKXe
         eTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cN819TKXbJsjMcpNBjbeHjndh7AMERO5YzZiFBrqdI=;
        b=GhtllgLV+t8CMuCd1zCmt0ZZMcjcZ5fjCrmYGEXLiaS5PI7ztQZrSKcVjGmoAp6rM1
         Vl5UBy1SW/El15CLY6+MewVcW/Ur1tpwiCKnjlj1lN9naCZSMeYI9gUc5zriactj8l/d
         C63pHPfz+8lSJmsn5uAaPDaogSUDusfM5fmCMfoVBtwaLgX68uxZiMO89Xnqc5O2koBx
         1SV45axztd9ZNtvl4qnhtism6yWXOKhqnn2ZsKGaEgJsdJIbC8o0u/I6i+FD3UC6BZj3
         jcDvG8v81yR2wshgL+EY68X0UKnjeWU0Ge4o+q6hNQGtxwbR0FZ7jJPThonlcgZaDKZ+
         2UKA==
X-Gm-Message-State: AOAM533MV3GWqzwal1y/+osjk/z5gubNf9UsDaIQNXzsJzC2IDJ7zzar
        2haVtQsLHD2TDkGYe1SGeI9wSri94+tFMJX4kjAywoEkdfQ=
X-Google-Smtp-Source: ABdhPJyDIavu6hhB4fgxgimT5WGdX+NIHVgvMU+PwT8j9UqCKBb2mrab06rnwQSsh0hFRzzaCy/s4KaXu2a6/YQyCr4=
X-Received: by 2002:a67:ee1b:: with SMTP id f27mr19549160vsp.34.1592235491930;
 Mon, 15 Jun 2020 08:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com> <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk> <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
 <20200601172323.GE45647@sirena.org.uk> <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
 <20200609105115.GA4583@sirena.org.uk> <CAPDyKFohcYjSvBjjB01mg7bOFCJA8XukgRPsZJm48X44sFzeYA@mail.gmail.com>
 <20200615114933.GF4447@sirena.org.uk>
In-Reply-To: <20200615114933.GF4447@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jun 2020 17:37:35 +0200
Message-ID: <CAPDyKFqZDhduLsmM6cgYXzYVFGg8=3thmZCVDsKHp5Udu7hE_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 at 13:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 15, 2020 at 12:27:23PM +0200, Ulf Hansson wrote:
>
> > eMMC is not only about voltage levels, but also about enable/disable
> > of the regulator(s).
>
> > More precisely, one needs to follow the steps specified in the eMMC
> > spec, when disabling the regulator(s).
>
> > In other words, the mmc host driver needs to be probed (consumer of
> > the regulator), before the regulator(s) can be disabled.
>
> Right, though you can generally get away with it if you completely cut
> the power.

Well, there are two regulators.

One is the VCC (vmmc) the other is VCCQ (vqmmc). If you can cut both,
yes, then you are right. However, quite often VCCQ (the rail for the
I/O voltage) is an always-on regulator.

Moreover, even if you can cut both regulators, I wouldn't do that,
unless really necessary. It's always better with a graceful power-off
sequence of a storage device, as otherwise flash corruption and other
bad things can more easily happen.

> The big thing is that as part of this we need to actually do
> the things at the time the driver asks for them to be done rather than
> some other time.

Right.

Kind regards
Uffe
