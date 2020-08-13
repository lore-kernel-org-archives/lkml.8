Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792A220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Frxlqa+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:00:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A55FC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:00:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b16so7413130ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzXeBlakzfAPPBzAY3IVEXgA9jvG+1VSy76HmBZ+Eeo=;
        b=Frxlqa+/7w65h7ujJ6x4K0255V608BE5V93+WqdiJmnuE83RXO6cl7nbP6RRICr/Er
         9afVovZs/0bYli9HlOpK0zlyLPOVax0MZIVYZBJtYKWQCShyAAvDRsm5+nci5RgkfNJ4
         ubew+AI8wwmtV3fPdiLSRBv1xoT7DKGndlMY/7eM4dNWUnk681X2jN0ZF1TC7pYtgUp4
         XZNb368pbIxgUhibNE1k2Dly00yZKvBcm3iG77R3tAvIyxvuG26rdqdCXdwYPH+9d9Ev
         9CFNN3TafecvPq70CeHKlV/xsGEepswBYRBq4aPygL7CrsCPiu71z13CUfo57DQOkdKQ
         +2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzXeBlakzfAPPBzAY3IVEXgA9jvG+1VSy76HmBZ+Eeo=;
        b=Ak9O4Kio22f9e9C1uMqBOI7s273oENIuahJX8r/bYiJGEijMU8SrTGNKCxXb4+M+Pc
         yw0W/NJOQt5JLYgrZRfvnMoyvMYCYzYbqnDaoBOyTluwg/G8Tfl+REIHnrgFI8rgBdpD
         ZUcXGJt9jMIH7glPbCSYYcfHn93PimhkiMelJi0q7wekpnhNIhi7PF7KhBgTXshs4f55
         fHHIRDD22JTEpZ+6doJlTPZtelkQmra5NjYeOuHgq31AoRBpUwvgwA3qO2Wig2mvNQ/6
         xC1qMf/5Q6tQ54EMhmAMaTrgLdguB32MDn6JydXZjPmax/y4UJsWWhq1WLcS5cB3UoIQ
         /Rrg==
X-Gm-Message-State: AOAM5300woXBy1sNolorGcFCl7XFdmd20+u37UCtXHWMfLN9EeT2TUjV
        bgHgA32w1oS8WTMmIxWqMIMPaE0FRdkbYpAMCFFc7g==
X-Google-Smtp-Source: ABdhPJzB3GTeeyPYbcbZosaY+gzQ1Ur88csOtNEtaN+0khwH+hXGAwA50wSehgY59xMIxU0AWtphOXrV/3beCc7SnsM=
X-Received: by 2002:a02:9047:: with SMTP id y7mr5209751jaf.128.1597327252041;
 Thu, 13 Aug 2020 07:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvGXOcsF=70FVwOxqVYOeGTUuzhUzh5od1cKV1hshsW_g@mail.gmail.com>
 <CAK8P3a1ReCDR8REM7AWMisiEJ_D45pC8dXaoYFFVG3aZj91e7Q@mail.gmail.com>
 <159549159798.3847286.18202724980881020289@swboyd.mtv.corp.google.com>
 <CA+G9fYte5U-D7fqps2qJga_LSuGrb6t9Y1rOvPCPzz46BwchyA@mail.gmail.com>
 <159549996283.3847286.2480782726716664105@swboyd.mtv.corp.google.com> <159725426896.33733.4908725817224764584@swboyd.mtv.corp.google.com>
In-Reply-To: <159725426896.33733.4908725817224764584@swboyd.mtv.corp.google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Aug 2020 19:30:40 +0530
Message-ID: <CA+G9fYuVQonk+hcaJWaJ2CNWrsgV5EsRa+1eUr6+UUKxHGB3vw@mail.gmail.com>
Subject: Re: stable-rc 4.14: arm64: Internal error: Oops: clk_reparent
 __clk_set_parent_before on db410c
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux- stable <stable@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 23:14, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Stephen Boyd (2020-07-23 03:26:02)
> > Quoting Naresh Kamboju (2020-07-23 03:10:37)
> > > On Thu, 23 Jul 2020 at 13:36, Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > It sounds like maybe you need this patch?
> > > >
> > > > bdcf1dc25324 ("clk: Evict unregistered clks from parent caches")
> > >
> > > Cherry-pick did not work on stable-rc 4.14
> > > this patch might need backporting.
> > > I am not sure.
> > >
> >
> > Ok. That commit fixes a regression in the 3.x series of the kernel so it
> > should go back to any LTS kernels. It looks like at least on 4.14 it's a
> > trivial conflict. Here's a backport to 4.14
>
> Did this help?

Thanks for your patch.
Sorry for the late reply.
The reported issue is not always reproducible However,
I have tested this for 100 cycles and did not notice the reported problem.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh
