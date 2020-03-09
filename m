Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81231C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522CC20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aWYnmvWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCIBxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:53:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40584 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgCIBxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:53:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id c18so5047168vsq.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QImbxmTkHKil1pvHr+BDxiJL2XLBZLzoyGW6wsTn3oQ=;
        b=aWYnmvWGdbntSuhyucIIAMxrZHkM4G5/Q9vbOmCQsekZAYHvr4Eog74dsXDkMYl2xD
         KvL1zeXKamlcuQTyyvQgkSKnT1gNRPF5uTVUa4a4fHcg/kx4VnHTixsNdroZ764sU1Uy
         +tKikHrHiZuRBXkYz+/Z8bBjwf8qxvraCz7gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QImbxmTkHKil1pvHr+BDxiJL2XLBZLzoyGW6wsTn3oQ=;
        b=TG11dkfoz2NT6ZPm3UFzVr8NcVo+J9XY4qE1F+VoVaFQumSzRTAtAt9+pingMtV0KN
         ZRJ9sQLjVmLj7Lbp3TUGS9AWl/5mo2pUWIYGIv4z7Bj2jykUOqS1MQKIUinEYMwqr7+O
         u/0YmB0gwyesAXQbHL72gaC/z/RC7gZxaJlClbjJbToyP+TSEzq8xmkINFRaXtTAN7YD
         wk703ytlv5H/eQgM8nPYjLjFdGAO02V4n4PnBsfq2wa1jqu5Tn+/5SfSYxQuRp9EJtQi
         ap61ZlHgqjTaLuwZzV44e4ZJo7YPT1dTbtqpTr8jnb27ooDPc8kRMPscmJKndJRmEnnM
         DBmw==
X-Gm-Message-State: ANhLgQ3G7aKi/8dgB6zJUSa4+wTtKPI4HZBxjYg93m/tm8G+Si3R2s9m
        VBQnxk7iiODACyA/k52WhQTLhnxhGYGBAsTHukcteA==
X-Google-Smtp-Source: ADFU+vvYsFjqtY5zn3zCc01nvvuQjne4/YR7CEb/r3521XiWmW+BqevLE59/BQHtNHTJV1ro52aTXPZEfqp1TtQdFWA=
X-Received: by 2002:a05:6102:9c7:: with SMTP id g7mr8614280vsi.186.1583718826912;
 Sun, 08 Mar 2020 18:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-8-drinkcat@chromium.org> <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
 <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
 <CANMq1KCn5rrOrv2GjFh5Aau5Los4VVk=NMWAsvZiNuwoxyMVHA@mail.gmail.com> <e4e95aa7713344e8b43fe5fad05de3ee@mtkmbs01n1.mediatek.inc>
In-Reply-To: <e4e95aa7713344e8b43fe5fad05de3ee@mtkmbs01n1.mediatek.inc>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 9 Mar 2020 09:53:35 +0800
Message-ID: <CANMq1KDmvxQdKHgyvQb6xChFX5UkBqPyQKXxuxGV70=p1=ezKw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2 regulators
To:     =?UTF-8?B?TmljayBGYW4gKOiMg+WTsue2rSk=?= <Nick.Fan@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?SkIgVHNhaSAo6JSh5b+X5b2sKQ==?= <Jb.Tsai@mediatek.com>,
        =?UTF-8?B?U2ogSHVhbmcgKOm7g+S/oeeSiyk=?= <sj.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looping back on this, after digging a bit deeper...

On Fri, Feb 14, 2020 at 9:38 AM Nick Fan (=E8=8C=83=E5=93=B2=E7=B6=AD) <Nic=
k.Fan@mediatek.com> wrote:
> [snip]
> > > Another thing that I'm not implementing is the dance that Mediatek
> > > does in their kbase driver when changing the clock (described in
> > > patch
> > > 2/7):
> > > ""
> > > The binding we use with out-of-tree Mali drivers includes more
> > > clocks, this is used for devfreq: the out-of-tree driver switches
> > > clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> > > switches clk_mux back to clk_main_parent:
> > > (see
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ch
> > > romeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_run
> > > time_pm.c#423)
> > > clocks =3D
> > >         <&topckgen CLK_TOP_MFGPLL_CK>,
> > >         <&topckgen CLK_TOP_MUX_MFG>,
> > >         <&clk26m>,
> > >         <&mfgcfg CLK_MFG_BG3D>;
> > > clock-names =3D
> > >         "clk_main_parent",
> > >         "clk_mux",
> > >         "clk_sub_parent",
> > >         "subsys_mfg_cg";
> > > ""
> > > Is there a clean/simple way to implement this in the clock
> > > framework/device tree? Or should we implement something in the
> > > panfrost driver?
> >
> > Putting parent clocks into 'clocks' for a device is a pretty common
> > abuse. The 'assigned-clocks' binding is what's used for parent clock
> > setup. Not sure that's going to help here though. Is this dance
> > because the parent clock frequency can't be changed cleanly?
>
> Nick/Weiyi, any idea why we do that dance in the first place? (maybe the =
PLL clock is unstable while it's being changed?)
>
> Clock source may become unstable during clock frequency changes, so it is=
 always safer to switch to a more reliable clock source.
> Otherwise, it may cause some problem in some corner case.
> I would suggest to keep it.

The Mediatek CPUfreq driver actually does a very similar dance:
https://github.com/torvalds/linux/blob/master/drivers/cpufreq/mediatek-cpuf=
req.c#L249

What they have in the device tree is the main clock, and the
"intermediate" clock that is required during switching:
clocks =3D <&mcucfg CLK_MCU_MP0_SEL>, <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
clock-names =3D "cpu", "intermediate";

The topology looks like this:
 clk26m                              15       15        1    26000000
        0     0  50000
    armpll_ll                         1        1        0  1417000000
        0     0  50000
       mcu_mp0_sel                    0        0        0  1417000000
        0     0  50000

And device tree provides mcu_mp0_sel as "cpu", and the armpll_div_pll1
as "intermediate".

The driver looks up armpll_ll by calling get_parent, then:
 - set_parent(mcu_mp0_sel, armpll_div_pll1)
 - set_rate(armpll_ll, new_rate)
 - set_parent(mcu_mp0_sel, armpll_ll)

On MT8183's GPU, the topology is a little bit more complicated (but I
think there should be a way to merge mfg_bg3d an mfg_sel in the clock
core)
 clk26m                              15       15        1    26000000
        0     0  50000
    mfgpll                            1        1        0   419999817
        0     0  50000
       mfgpll_ck                      2        2        0   419999817
        0     0  50000
          mfg_sel                     3        3        0   419999817
        0     0  50000
             mfg_bg3d                 1        1        0   419999817
        0     0  50000

We're going to need a special panfrost devfreq driver for mt8183
anyway (to handle the 2 regulators), so it would be easy to take a
similar approach:
 - Add "intermediate" clock in the device tree (clk26m)
 - Find mfg_sel/mfgpll_ck using 1/2 clk_get_parent calls.
 - Switch mfg_sel to clk26m, set mfgpll_ck rate, switch mfg_sel back
to mfgpll_ck.

(BTW, I tried to look, and couldn't find examples or reparenting
during clock changes in drivers/clk, are there existing drivers doing
similar things? Or this would be new?).
