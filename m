Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD82088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="daddqPR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgGCOXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGCOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:23:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:23:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so34451847ejq.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UQ7G0hA0SMWmSwYjrwUJnEz8j6/Z76OeJEAbHNNj2Ss=;
        b=daddqPR6uTcarHI9HjdPmJ13SV+FKzfQjj05FE/EqRiqx4zNUESoIPIaOket7Ruh5O
         nwYk2nso5xDxsGRYmxDfnLqUkvFfPz8XOyAK5TGWzcs58TR73xhqv2LtNj4+pk0RlZ6k
         vEu50GKqUo+LIPVCdoVFyWsOpceiOx8U6LdkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQ7G0hA0SMWmSwYjrwUJnEz8j6/Z76OeJEAbHNNj2Ss=;
        b=IGXwxbktSZXSfxcm1yTM5A/2dvEjHE+mG71PY0ns3C1zeksPXkDYfLykMdcJbYaaX3
         curNkS1QTrY7iL/H8ZeN7ZgNeN0O9TDcrd2daCecXBX6GuuphwXeptyLf6MuP7pjMH7p
         FcNSh0xXMGzXCSBZlBgXah3p0iJJXAjxbKGhQ4KWCFwRKcIclk1y7w6IkVpMviyDYXBy
         SFqmePowk2qk0gHaLzTmeo0LRhZnBOw9QgulWNKGUSsq7//saB3R/J1kMjvqBhLgNn9T
         kTjhoCuSLh78DFRQ7piBtctaSYUapozLSeVy2Wg90BnwvQY5xI483qScBxy7Di07C1Ng
         2nlA==
X-Gm-Message-State: AOAM530HGXzMJGwjNTUyFx+BS4CnA55gZ2rMmP1+KHmN6jIC4ofNwO7U
        iGJnSAx1eW6YghYgMWrJdEdkvIVp+Dbsacgq0ridaomNUNoaqw==
X-Google-Smtp-Source: ABdhPJwhtCuFZ+xg2dYXyaJW0mF1XhBGQePYnM3MQRQc/8w61ymzMBkDADSR2zuvH7jNLrL8djJ5mTnWs4yzeoe2g4k=
X-Received: by 2002:a17:906:6dda:: with SMTP id j26mr33430732ejt.336.1593786219131;
 Fri, 03 Jul 2020 07:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
 <20200602080644.11333-2-mylene.josserand@collabora.com> <CAMty3ZDx-_-VHEwjbV05GBb-hQbPpo21aZbCrQ+GTaoT_gxAMg@mail.gmail.com>
 <1793210.9Kb5SQUFvz@phil>
In-Reply-To: <1793210.9Kb5SQUFvz@phil>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 3 Jul 2020 19:53:27 +0530
Message-ID: <CAMty3ZB1n5uXmH=U4iXfgpyU-JZff74Rm2Mj+SS2LLtkM2fARQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] clk: rockchip: rk3288: Handle clock tree for rk3288w
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 7:41 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Montag, 29. Juni 2020, 21:11:03 CEST schrieb Jagan Teki:
> > On Tue, Jun 2, 2020 at 1:37 PM Myl=C3=A8ne Josserand
> > <mylene.josserand@collabora.com> wrote:
> > >
> > > The revision rk3288w has a different clock tree about "hclk_vio"
> > > clock, according to the BSP kernel code.
> > >
> > > This patch handles this difference by detecting which device-tree
> > > we are using. If it is a "rockchip,rk3288-cru", let's register
> > > the clock tree as it was before. If the device-tree node is
> > > "rockchip,rk3288w-cru", we will apply the difference with this
> > > version of this SoC.
> > >
> > > Noticed that this new device-tree compatible must be handled in
> > > bootloader such as u-boot.
> > >
> > > Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@collabora.com>
> > > ---
> > >  drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip=
/clk-rk3288.c
> > > index cc2a177bbdbf..204976e2d0cb 100644
> > > --- a/drivers/clk/rockchip/clk-rk3288.c
> > > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > > @@ -425,8 +425,6 @@ static struct rockchip_clk_branch rk3288_clk_bran=
ches[] __initdata =3D {
> > >         COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CL=
K_IGNORE_UNUSED,
> > >                         RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DF=
LAGS,
> > >                         RK3288_CLKGATE_CON(3), 0, GFLAGS),
> > > -       DIV(0, "hclk_vio", "aclk_vio0", 0,
> > > -                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > >         COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CL=
K_IGNORE_UNUSED,
> > >                         RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, D=
FLAGS,
> > >                         RK3288_CLKGATE_CON(3), 2, GFLAGS),
> > > @@ -819,6 +817,16 @@ static struct rockchip_clk_branch rk3288_clk_bra=
nches[] __initdata =3D {
> > >         INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29),=
 3, IFLAGS),
> > >  };
> > >
> > > +static struct rockchip_clk_branch rk3288w_hclkvio_branch[] __initdat=
a =3D {
> > > +       DIV(0, "hclk_vio", "aclk_vio1", 0,
> > > +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > > +};
> > > +
> > > +static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata=
 =3D {
> > > +       DIV(0, "hclk_vio", "aclk_vio0", 0,
> > > +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > > +};
> > > +
> > >  static const char *const rk3288_critical_clocks[] __initconst =3D {
> > >         "aclk_cpu",
> > >         "aclk_peri",
> > > @@ -936,6 +944,14 @@ static void __init rk3288_clk_init(struct device=
_node *np)
> > >                                    RK3288_GRF_SOC_STATUS1);
> > >         rockchip_clk_register_branches(ctx, rk3288_clk_branches,
> > >                                   ARRAY_SIZE(rk3288_clk_branches));
> > > +
> > > +       if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
> > > +               rockchip_clk_register_branches(ctx, rk3288w_hclkvio_b=
ranch,
> > > +                                              ARRAY_SIZE(rk3288w_hcl=
kvio_branch));
> > > +       else
> > > +               rockchip_clk_register_branches(ctx, rk3288_hclkvio_br=
anch,
> > > +                                              ARRAY_SIZE(rk3288_hclk=
vio_branch));
> > > +
> >
> > Sorry for the late query on this. I am a bit unclear about this
> > compatible change, does Linux expect to replace rockchip,rk3288-cru
> > with rockchip,rk3288w-cru in bootloader if the chip is RK3288w? or
> > append the existing cru compatible node with rockchip,rk3288w-cru?
> > because replace new cru node make clock never probe since the
> > CLK_OF_DECLARE checking rockchip,rk3288-cru
>
> I guess right now we'd expect "rockchip,rk3288w-cru", "rockchip,rk3288-cr=
u",
>
> Thinking again about this, I'm wondering if we should switch to having
> only one per variant ... like on the two rk3188 variants,
> so declaring separate rk3288-cru and rk3288w-cru of-clks with shared
> common code.

What if can check the root compatible instead cru compatible for revision W=
 like

-  if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
+ if (of_device_is_compatible(np, "rockchip,rk3288w"))

This way we can have a single compatible update at bootloader that
makes Linux adjust revision W chips code.

Doesn't it make sense?

Jagan.
