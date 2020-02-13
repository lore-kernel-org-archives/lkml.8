Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543DDC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96521734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKMEN31/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgBMH6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:58:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37681 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBMH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:58:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id c188so4823068qkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63SchGggoiyVI5EN3ryL83QTa83h0sF68yqzlCCOYPA=;
        b=dKMEN31/0+UPjXjjiovyaJUVBlun8Po5VfH13AHcZMUXJDuSs1EI8nWJXKA7w7uhm7
         ZFZz9QipKQ788oZVIHCnev3yFTRL7P+gk1Dj0VbcEMXdofR1rbh4c1ZuIizRumh9PFo7
         XasDtmmhv2Ji6x1dAjrj+mXlEzg1Y9xWMKswM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63SchGggoiyVI5EN3ryL83QTa83h0sF68yqzlCCOYPA=;
        b=EqH6e9P9dLvAkpme12qmcYT/js8RPmQ2WGRRXgwhNztXT6u3LLTZJoi/oCoMB45DJZ
         nD9+fGI6EAJaYlKV05q4Iw9R1E6cgq/7jrj2mx3mEhBMQBTKyxp2xXHDi33Nhe7oJITA
         RVygL28iRzAYM7FL5jdezJefD+6XnCyImBWMCDf/Su21jku9e6zq1ygfafKiZKk8V4cr
         g/KTRI2vG2R/tk9YokJQdpup3WfTMx9Ose3+bkLlh2g0VKpWDVzG3ukgh2oc4+xq1Ssp
         h10uY/qSQ3iqJ/n8EnVL3v/zy2659K1PxcFbSGScqF8nJ0KVuYmAPTVopGwknA00mU3R
         OmDw==
X-Gm-Message-State: APjAAAXww9M9kAveahu7EHgi01JRYnk+OaJUsFQOW/B4EKRJU/a3/V+z
        20a8qrDrLV94UJ6dRHqEK3+TulU1G00REmIML4lyJA==
X-Google-Smtp-Source: APXvYqxdfgmZS7tZ6HGaEuN1SVX0b/SGRzgpoe8N6khQQjmKFbfTE+Cbo3vlrlKewIFqbPKGpw+YYWx3Re780dY9rnc=
X-Received: by 2002:a37:6595:: with SMTP id z143mr11648233qkb.457.1581580683445;
 Wed, 12 Feb 2020 23:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-8-drinkcat@chromium.org> <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
 <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
In-Reply-To: <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 13 Feb 2020 15:57:52 +0800
Message-ID: <CANMq1KCn5rrOrv2GjFh5Aau5Los4VVk=NMWAsvZiNuwoxyMVHA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2 regulators
To:     Rob Herring <robh+dt@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Nick Fan <nick.fan@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Weiyi Lu +Nick Fan @MTK who may have more ideas.

On Thu, Feb 13, 2020 at 2:14 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Feb 12, 2020 at 2:49 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > +Viresh Kumar +Stephen Boyd for clock advice.
> >
> > On Fri, Feb 7, 2020 at 1:27 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
> > > devfreq, and provides OPP table with 2 sets of voltages.
> > >
> > > TODO: This is incomplete as we'll need add support for setting
> > > a pair of voltages as well.
> >
> > So all we need for this to work (at least apparently, that is, I can
> > change frequency) is this:
> > https://lore.kernel.org/patchwork/patch/1192945/
> > (ah well, Viresh just replied, so, probably not, I'll check that out
> > and use the correct API)
> >
> > But then there's a slight problem: panfrost_devfreq uses a bunch of
> > clk_get_rate calls, and the clock PLLs (at least on MTK platform) are
> > never fully precise, so we get back 299999955 for 300 Mhz and
> > 799999878 for 800 Mhz. That means that the kernel is unable to keep
> > devfreq stats as neither of these values are in the table:
> > [ 4802.470952] devfreq devfreq1: Couldn't update frequency transition
> > information.
> > The kbase driver fixes this by remembering the last set frequency, and
> > reporting that to devfreq. Should we do that as well or is there a
> > better fix?
> >
> > Another thing that I'm not implementing is the dance that Mediatek
> > does in their kbase driver when changing the clock (described in patch
> > 2/7):
> > ""
> > The binding we use with out-of-tree Mali drivers includes more
> > clocks, this is used for devfreq: the out-of-tree driver switches
> > clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> > switches clk_mux back to clk_main_parent:
> > (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> > clocks =
> >         <&topckgen CLK_TOP_MFGPLL_CK>,
> >         <&topckgen CLK_TOP_MUX_MFG>,
> >         <&clk26m>,
> >         <&mfgcfg CLK_MFG_BG3D>;
> > clock-names =
> >         "clk_main_parent",
> >         "clk_mux",
> >         "clk_sub_parent",
> >         "subsys_mfg_cg";
> > ""
> > Is there a clean/simple way to implement this in the clock
> > framework/device tree? Or should we implement something in the
> > panfrost driver?
>
> Putting parent clocks into 'clocks' for a device is a pretty common
> abuse. The 'assigned-clocks' binding is what's used for parent clock
> setup. Not sure that's going to help here though. Is this dance
> because the parent clock frequency can't be changed cleanly?

Nick/Weiyi, any idea why we do that dance in the first place? (maybe
the PLL clock is unstable while it's being changed?)

If we really need it, can we move that logic to the clock core?

> If up to
> me, I'd put that dance in the clock driver. The GPU shouldn't have to
> care.
>
> Rob
