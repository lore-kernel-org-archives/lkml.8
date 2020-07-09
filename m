Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F355DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC4620767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PCMgMMIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGIOuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:50:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F9C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:50:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so1220723pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Kim3CdbxyyOIhVT8nqi+K5F5C7o279gFE7n8I2AhGw=;
        b=PCMgMMIMPYgEiSOnn0WY5wKtX6cQ7Z+UAnP1iiRucoEQNv/MdRE5U9c5KpDE2lrLCt
         kkxmc4qkOKMgwTMSCezsgykchuRt1xzNJss9K4+HJBnMdi7Zw5W/8Z+vfTGJXDvz42Q8
         XIw6BtvVUeg3ghXbZOO7MBapqShWQ1NOc4too=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Kim3CdbxyyOIhVT8nqi+K5F5C7o279gFE7n8I2AhGw=;
        b=AptkGjRakr5l9BYuflYdSnR5HQy/PxADCsO9HppGvnapO2bAvOGrSKcYwPiPqM9Cwr
         iKmOBFDGyMra2gKiW/gMXpiesLbHSaGkKA/RXxM4xlJ2rxA571qW/p5vBXR2hAsbqYaU
         NkaJ/22MX6ejPBOT0dChxEH2K87ewM4ktR20DOpaiEN+4eXMxNM55Q8vJaLtmbsoLWXS
         V1nAT57zkRePiuexKwkG3XLEnW7eYm9Q+tHZ/o4uY16TdfWSXi1IiEIg9YrTEe2fQq9b
         btPFgpNoGPtNWXSBGEGCx2Fw6wvTjTll3fNfgvXBTr1mtd8TMm3KoBHRuOwUzq11Atr+
         OlKw==
X-Gm-Message-State: AOAM533oTPTLm8T6mbpm1fLeqjgBPSeHQy+AuBHdhFP6bWoxCZKLP5eO
        YgMPHMl0Pqwed8VPR8zmCOXbu4ILtbw=
X-Google-Smtp-Source: ABdhPJw5RNptGzp6gX+Rzq1D1wNbYOgoBqCHIcMeeAnkJmwsBPRWm24APyxOAGQKrhjEPZpObUTk4w==
X-Received: by 2002:a17:90a:26a4:: with SMTP id m33mr423518pje.124.1594306209193;
        Thu, 09 Jul 2020 07:50:09 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id u20sm3342154pfk.91.2020.07.09.07.50.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:50:09 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id m9so1132819pfh.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:50:08 -0700 (PDT)
X-Received: by 2002:a05:6122:78d:: with SMTP id k13mr41715186vkr.28.1594305878997;
 Thu, 09 Jul 2020 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
 <23e53f2b-02b0-2c9b-a165-4ca5a2c84a89@codeaurora.org>
In-Reply-To: <23e53f2b-02b0-2c9b-a165-4ca5a2c84a89@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 07:44:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrD0TMCNG-2JZ6_f67+yU8Z+2ofkqMvp=uA9rB2bS6og@mail.gmail.com>
Message-ID: <CAD=FV=XrD0TMCNG-2JZ6_f67+yU8Z+2ofkqMvp=uA9rB2bS6og@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime resume
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>, ctheegal@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 1:55 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 7/9/2020 5:09 AM, Douglas Anderson wrote:
> > In the patch ("spi: spi-geni-qcom: Avoid clock setting if not needed")
> > we avoid a whole pile of clock code.  As part of that, we should have
> > restored the clock at runtime resume.  Do that.
> >
> > It turns out that, at least with today's configurations, this doesn't
> > actually matter.  That's because none of the current device trees have
> > an OPP table for geni SPI yet.  That makes dev_pm_opp_set_rate(dev, 0)
> > a no-op.  This is why it wasn't noticed in the testing of the original
> > patch.  It's still a good idea to fix, though.
>
> good catch, without this (and with OPP tables added) we would end up removing
> the performance vote on suspend and never put it back unless the rate changes.
> Perhaps a similar change would be needed for spi-qcom-qspi too?

The quad spi already patch had this fix and it actually mattered
there.  That's what made me go look back and realize that I needed the
fix in the geni SPI.  See:

https://lore.kernel.org/r/20200707131607.1.Ia7cb4f41ce93d37d0a764b47c8a453ce9e9c70ef@changeid

I'll send a v2 of that with Akash's suggestion of checking the return
value, though.

-Doug
