Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84044C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587D3206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QU0Hse14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHYWbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHYWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:31:43 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8979C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:31:43 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id o2so109241vkn.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLQFPf8fLS7CXO0sqeBay+2q4cQ6HR+2AcELPhdgy+g=;
        b=QU0Hse14Sklyyz5kU3HeafZqqmeR/p+06VxkowHnJejpgNSHFeKynmOmd+F3l2P+ag
         R+GXXBJK1b66xpFAWH7b2a8zD9ShRCjKuhUAM1h2GiN6scO/py9dPVSjEBitpu5lrrvR
         X3TbtAK76P08sTuaeA+WnGrb1oPPfGaCSTgK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLQFPf8fLS7CXO0sqeBay+2q4cQ6HR+2AcELPhdgy+g=;
        b=LQPxyvsKc9qzG7TanBTo+7O+G6JggMuezqvzU6YVf8vf21fPofkDWZXz6sjxKx77Dk
         kAmV5vN3goaSzfSc0Cx5OMehRhTOZXpaofUfLaczH67uWtkzI9LsdsK3wJGMuKzRJJ44
         WAR/qXzUYkGOhx2D/almfQ1CSO2mdpZ6eonxcw+I1TuEKPGfUz+Mt/SAIbr2ZkinkOC5
         tpuUjyCisgN2480Lh+bgM3WXkVyZL5WRE0pBNP18FFhKooKg0Lk5Lz+8ES96Xjbq3pFX
         99lujTIrxxwahWH0sCKLax2Tg7z35RNFyID3FL98I/nuStJ9BRrB87yoSJGLgjwVeIDo
         qTfA==
X-Gm-Message-State: AOAM533nCNDjn0T3mWVf4l5x2UVT4jC77cTXU7kaQJhaHNwC7c6n9hYM
        b1MWSFavUvPLp5Pl34Xv/5sSxEAO0HqzWQ==
X-Google-Smtp-Source: ABdhPJyrq7fOySaL/1Gk/MTPLchjEIzLoA0Qe919I7KkfATdsrPGfMKmW8MevSJ0PBHTK6CAFQZ5dQ==
X-Received: by 2002:a1f:36c2:: with SMTP id d185mr7711066vka.9.1598394702046;
        Tue, 25 Aug 2020 15:31:42 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id v141sm82356vkv.10.2020.08.25.15.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 15:31:41 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id x142so120292vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:31:41 -0700 (PDT)
X-Received: by 2002:a1f:fc02:: with SMTP id a2mr7476528vki.65.1598394700796;
 Tue, 25 Aug 2020 15:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200825003341.1797322-1-robdclark@gmail.com> <159834727050.334488.84544239322533805@swboyd.mtv.corp.google.com>
 <CAF6AEGvNKhFMtMkqS8STaUTcw7z6-NsHROeydWnx-=2=UG357A@mail.gmail.com>
In-Reply-To: <CAF6AEGvNKhFMtMkqS8STaUTcw7z6-NsHROeydWnx-=2=UG357A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 15:31:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLeHN8AH8FFkx2jiPQy6q5n=N=mLOGw0ujpk6rdBRVFw@mail.gmail.com>
Message-ID: <CAD=FV=VLeHN8AH8FFkx2jiPQy6q5n=N=mLOGw0ujpk6rdBRVFw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: add initial trogdor and
 lazor dt
To:     Rob Clark <robdclark@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Atul Dhudase <adhudase@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Alexandru Stan <amstan@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 25, 2020 at 3:22 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 2:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rob Clark (2020-08-24 17:33:39)
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > > new file mode 100644
> > > index 000000000000..b04987ab6c22
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > > @@ -0,0 +1,1364 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > [...]
> > > +
> > > +       gpio_keys: gpio-keys {
> > > +               compatible = "gpio-keys";
> > > +               status = "disabled";
> > > +               pinctrl-names = "default";
> > > +               pinctrl-0 = <&pen_pdct_l>;
> > > +
> > > +               pen-insert {
> > > +                       label = "Pen Insert";
> > > +
> > > +                       /* Insert = low, eject = high */
> > > +                       gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
> > > +                       linux,code = <SW_PEN_INSERTED>;
> > > +                       linux,input-type = <EV_SW>;
> > > +                       wakeup-source;
> > > +               };
> > > +       };
> > > +
> > > +       max98357a: max98357a {
> >
> > Maybe node name should be 'audio-codec' or 'dac' or 'amp' or 'speaker'
> > or 'codec'?
>
> looking at other boards, it looks like 2 votes for "audio-codec-0",
> one vote for "codec0", and 2 votes for "max98357a"..  so seems to be a
> codec rather than amp/speaker.. and "audio-codec" seems to be the
> popular choice..

I'd look at recently landed yaml files under
"Documentation/devicetree/bindings/sound/".  Those have the best
change of having been reviewed by Rob Herring.

Oh, or you could look at the Devicetree Spec [1]

2.2.2 Generic Names Recommendation
...
* audio-codec

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3
