Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC35FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C5220786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hi5oTWy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgGHPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbgGHPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:22:19 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:22:19 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id l12so9745191uak.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KO628LRg0KELEzDGxGBW/eAFQb7hOqQ53yrytEwvgvY=;
        b=hi5oTWy7PCy7YqHRotH3tuH/k2HpctPr7tYVQrxyXCdwfKApDHb6zk8Hv57vOZr7+T
         uPq3gVmSKLp0lfFLbDvVPJM0L70JoAwZ4cie7WIwJNK8QhE26q9c5evYUjyZgyWdScU1
         mb2a+uTp0kfIJg7L3WdoAHaG/3DhMm2oR+B2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KO628LRg0KELEzDGxGBW/eAFQb7hOqQ53yrytEwvgvY=;
        b=Zma1Hu5PJPoU3UDt51qLQkw0DIYKpXOnlU/3maQHaH6Rdfguhi31tM5MyeX32kPKOe
         TrJmtI4Be7r5b9WI1IN54TtRO62M0vBB45nBUdOfZIB993oeTpjmDae8QSnfyikHrWxX
         drqeBT0FkWMfFWbPHoAUyWM8FLVCZUIYTZ8NIo6z2jfFhkg8KHuOjiaj2nCBpR2hCdZ9
         6jwug5m1qYFt1DKWENQzz+t+1ETYpb/dAWOunNHJ86NYmykdduEFaqw581R5B4+1HTNF
         mSglwf/sAHzpx23rPBvCXYazh+X5DP1oQXzMQ6ns572tZAxv4Kyc5cMQuCSpih0pOghh
         7sxw==
X-Gm-Message-State: AOAM533kOdX7VxiCZ6Y+Vami3eihl1Qzh4A30DRkRh2hhluV8/cvQbff
        TVN3hBeiVimvDxuI5JzPpSUF2CzHzrE=
X-Google-Smtp-Source: ABdhPJz/nU6GSZ/a9E+tVtfO3bIZncxN8ePnGrbFywQRBFe2AzF53U3L0jYOYk1fx7yAJioCV6lKDA==
X-Received: by 2002:ab0:6353:: with SMTP id f19mr33360279uap.69.1594221738354;
        Wed, 08 Jul 2020 08:22:18 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id h10sm18242uah.19.2020.07.08.08.22.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:22:17 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id h18so8467027uao.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:22:17 -0700 (PDT)
X-Received: by 2002:ab0:2408:: with SMTP id f8mr34039056uan.91.1594221736757;
 Wed, 08 Jul 2020 08:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
 <20200707120812.GA22129@sirena.org.uk> <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
 <20200708100110.GB4655@sirena.org.uk>
In-Reply-To: <20200708100110.GB4655@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 08:22:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
Message-ID: <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 8, 2020 at 3:01 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 05:53:01AM -0700, Doug Anderson wrote:
> > On Tue, Jul 7, 2020 at 5:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > This doesn't apply against current code, please check and resend.
>
> > As mentioned in the cover letter, I posted this series against the
> > Qualcomm tree.  The commit that it is fixing landed there with your
> > Ack so I was hoping this series could land in the Qualcomm tree with
> > your Ack as well.  Would that be OK?
>
> So I didn't see this until after the patch I applied was queued...  it's
> looking like it would be good to have a cross-tree merge with the
> Qualcomm tree if there's stuff like this - is this on a branch which
> makes that practical?  Otherwise I guess...

It's not too bad.  Of the 5 patches I've sent out (3 for geni SPI, 2
for quad SPI) you've landed just one.  Here's the summary:

a) geni SPI 1/3 (Avoid clock setting): Has your Ack.
b) geni SPI 2/3 (autosuspend delay): Landed in SPI tree
c) geni SPI 3/3 (overhead in prepare_message): Has your Ack.

d) quad SPI 1/2 (Avoid clock setting): Needs your Ack.
e) quad SPI 2/2 (autosuspend delay): Needs your Ack.

Since b) has already landed in your tree, let's just leave it there.
There'll be a bit of a performance hit in the Qualcomm tree, but it'll
still be usable.

Since the rest haven't landed, it would be nice to just land them in
the Qualcomm tree.


I think there's still more work to make the Geni SPI driver more
optimized, but I don't think it'll be as urgent as those patches and I
feel like any more major work could wait a cycle.


-Doug
