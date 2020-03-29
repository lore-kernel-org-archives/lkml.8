Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8D2206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585499814;
	bh=FMzyHZQaNh9rSSnGoV0uK9HGlBSqJz8wecfpivb2vYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YSURw+505bZzcXmkf545oQndfE9sD0xEvv4O+7I/eTZnAjz36DdYZsONjY2rlW8Cb
	 RIvv4k/NZPQpYvmLUTreR9gSiY9J0zjAYoQlrr0imqczERZSE4xCNLQfJ7jDOiVhGl
	 2Azplv4KWIOcIODAS4szKvc9dnX9A1gZjdzEo/Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgC2Qgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgC2Qgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:36:52 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11E9206CC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585499812;
        bh=FMzyHZQaNh9rSSnGoV0uK9HGlBSqJz8wecfpivb2vYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hogt6nvF+ZaFYDAazFk65Zjw5Up7FM+iupEhANbB/cOf98Ud9e79zXQJp/NYMgKBq
         0/iYCjBFXpTiTIyvSCzh5Ct6xwLR4N1VOozp/2EAYOrUFmIkYJkhVBKHefY0+DOgIb
         GFkyGPC5J8BvcRMRwOOc7RatjFHsjxjFc+RzCgcI=
Received: by mail-wr1-f43.google.com with SMTP id h15so18035450wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 09:36:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1oEi6SrK/s03eQx0bHIvlBs3ggKG/XtLTvAiDi7L3vaIWUpNeX
        QK04xZZbwa2rfvrTtJG2+CoAsSZ1/DA5qKQZUWk=
X-Google-Smtp-Source: ADFU+vuus+o0GpiyX8baecbejTCjcCtvVBUtlbFTDdt2Qa53S2dQx5EulLtLeeYPyI20IUp/svWt9yF+mHdeaiQGGpo=
X-Received: by 2002:a5d:6906:: with SMTP id t6mr5654950wru.64.1585499810267;
 Sun, 29 Mar 2020 09:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200327030414.5903-2-wens@kernel.org> <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
In-Reply-To: <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 30 Mar 2020 00:36:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ayZwN14S-Pzu2ip1K=fgzTbNB=ZzUcpou-jtv8m6vBA@mail.gmail.com>
Message-ID: <CAGb2v65ayZwN14S-Pzu2ip1K=fgzTbNB=ZzUcpou-jtv8m6vBA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC
 numbering for LED triggers
To:     Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 5:58 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Chen-Yu Tsai,
>
> The led node names need some changes.
> 'linux,default-trigger' value does not fit.
>
> From leds-gpio.yaml:
>
> patternProperties:
>   # The first form is preferred, but fall back to just 'led' anywhere in the
>   # node name to at least catch some child nodes.
>   "(^led-[0-9a-f]$|led)":
>     type: object
>
> Rename led nodenames to 'led-0' form
>
> Also include all mail lists found with:
> ./scripts/get_maintainer.pl --nogit-fallback --nogit
>
> devicetree@vger.kernel.org

Oops...

> If you like change the rest of dts with leds as well...
>
>   DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
>   CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
> yellow-led:linux,default-trigger:0: 'mmc0' is not one of ['backlight',
> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
> diy-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
>   DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
>   CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> diy-led:linux,default-trigger:0: 'mmc2' is not one of ['backlight',
> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
> yellow-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']

Maybe we should just get rid of linux,default-trigger then?

Heiko?

ChenYu

> make -k ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > With SDIO now enabled, the numbering of the existing MMC host controllers
> > gets incremented by 1, as the SDIO host is the first one.
> >
> > Increment the numbering of the MMC LED triggers to match.
> >
> > Fixes: cf3c5397835f ("arm64: dts: rockchip: Enable sdio0 and uart0 on rk3399-roc-pc-mezzanine")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts | 8 ++++++++
> >  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi          | 4 ++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> > index 2acb3d500fb9..f0686fc276be 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> > @@ -38,6 +38,10 @@ vcc3v3_pcie: vcc3v3-pcie {
> >       };
> >  };
> >
> > +&diy_led {
> > +     linux,default-trigger = "mmc2";
> > +};
> > +
> >  &pcie_phy {
> >       status = "okay";
> >  };
> > @@ -91,3 +95,7 @@ &uart0 {
> >       pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> >       status = "okay";
> >  };
> > +
> > +&yellow_led {
> > +     linux,default-trigger = "mmc1";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > index 9f225e9c3d54..bc060ac7972d 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> > @@ -70,14 +70,14 @@ work-led {
> >                       linux,default-trigger = "heartbeat";
> >               };
> >
> > -             diy-led {
> > +             diy_led: diy-led {
> >                       label = "red:diy";
> >                       gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> >                       default-state = "off";
> >                       linux,default-trigger = "mmc1";
> >               };
> >
> > -             yellow-led {
> > +             yellow_led: yellow-led {
> >                       label = "yellow:yellow-led";
> >                       gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> >                       default-state = "off";
> > --
> > 2.25.1
>
