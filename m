Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C9CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E43207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhqU8KCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHTBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHTBqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:46:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16294C061383;
        Wed, 19 Aug 2020 18:46:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so743192ejc.2;
        Wed, 19 Aug 2020 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IAtUvlGZi9cZ30c8Tiv2QcGP8j7YjUireQ2hPSqYIc=;
        b=lhqU8KCBq3JcXyLrjR7m1WxXBaJBMXFyOeFY2/f+x7ng6G5zQlWUhOOkz3cJRdbPr0
         fDPjZWPX59w9VLcs3giM+fziJJBtsN8dJW8xIFnSbQNr64LGPjfREopYzlFEvK/t3w6C
         bkHE1V5JX1QnfMcJYrGSJjsbuogziTWPR6YFrNA4Z57AIwLI2YziBXqL8jBcI7kT45H6
         DOHctLZABu2Ie6ADGhzwzow3snknVvnvep4cRodQ2jvn8ew3JBKVdwPJhEtFFyndjkko
         2J83m+iQ94azRYO5bPKbhDJrJPqCm/AIw6xRWgE5Z6qd3t4qoSOgPHQ/jF5Rk3MrFsg7
         z9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IAtUvlGZi9cZ30c8Tiv2QcGP8j7YjUireQ2hPSqYIc=;
        b=qW3dHjqGaKYUIpsu0hZ2CGiAhepc9BRZB+cyFKEgzD38jqz7gll4ljN6ltHM+YhJ1R
         WwohZ9ZTA0HarE5NA1g4xlWa8y796loe8wY+eh88OpX4D0x5OrZISvXUIf9CVhz8YumU
         BrHfcklyugRtWC2SanXvTct/rqfZBtd6epu2PuHorAvp2YV3GdiOJl29tPb2kmJMfrLD
         Jp9MG0DXHeU5oMDyCXtDViTFLb3mUUPppRzadbJrg6DjOw8EJQMHxsSL3pAMw7D8apTY
         n9gwx/QosvEGII28DEntTjS9hQpXJfum27w2+KU/ZEmDn5Tb6LKmBDIoJtTOvvOcaQ5F
         AWyA==
X-Gm-Message-State: AOAM530sx394T9mJTN7RWhm270S8O3EXozKOY5cK/JBJvyEeX9KSqi7x
        4fjdyxdGn5jxdm2W8AEsk4KwRenUVScu539GfCI=
X-Google-Smtp-Source: ABdhPJyE7dDS/w0hK1VUPbkBFQB5sNodimT33cc7agHJsrXQ6a+5qSQ+UFlj1xnEL1rjR8ztnYxPtpo+o8Gs3htaqL8=
X-Received: by 2002:a17:906:78e:: with SMTP id l14mr1160378ejc.67.1597887996730;
 Wed, 19 Aug 2020 18:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-17-git-send-email-abel.vesa@nxp.com> <CAA+hA=S_wdoZvCPamW2F1Vs73t4fgnQa8LouUwzq2Vfpz3SDCg@mail.gmail.com>
 <20200819203734.zbndyvf534xey5xy@fsr-ub1664-175>
In-Reply-To: <20200819203734.zbndyvf534xey5xy@fsr-ub1664-175>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 20 Aug 2020 09:31:27 +0800
Message-ID: <CAA+hA=S6j71M-Bjbkm1C+q6Ke7xGUX3K0TosKwWJ=tegFaBGsQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] arm64: dts: imx8mp: Add media_blk_ctrl node
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Stephen,

On Thu, Aug 20, 2020 at 4:37 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 20-08-18 19:34:14, Dong Aisheng wrote:
> > On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > Some of the features of the media_ctrl will be used by some
> > > different drivers in a way those drivers will know best, so adding the
> > > syscon compatible we allow those to do just that. Only the resets
> > > and the clocks are registered bit the clk-blk-ctrl driver.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index dede0ae..2d6d213 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -736,6 +736,22 @@
> > >                         };
> > >                 };
> > >
> > > +               aips4: bus@32c00000 {
> > > +                       compatible = "simple-bus";
> > > +                       reg = <0x32c00000 0x400000>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <1>;
> > > +                       ranges;
> > > +
> > > +                       media_blk_ctrl: clock-controller@32ec0000 {
> >
> > For this combo device, maybe we can directly name it as blk-ctrl@32ec0000.
> > Rob, do you think if we can do that?
> >
>
> I think it was Stephen who suggested we change it to clock-controller in the
> last's version thread.
>
> TBH, I agree with you here, since it makes more sense to be called blk-ctrl
> provided that this is not really just a clock controller.
>

How do you think?

Regards
Aisheng

> > > +                               compatible = "fsl,imx8mp-media-blk-ctrl", "syscon";
> > > +                               reg = <0x32ec0000 0x10000>;
> > > +
> >
> > Remove unnecessary blank line
> >
>
> Will do.
>
> > Otherwise:
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > Regards
> > Aisheng
> >
> > > +                               #clock-cells = <1>;
> > > +                               #reset-cells = <1>;
> > > +                       };
> > > +               };
> > > +
> > >                 aips5: bus@30c00000 {
> > >                         compatible = "fsl,aips-bus", "simple-bus";
> > >                         reg = <0x30c00000 0x400000>;
> > > --
> > > 2.7.4
> > >
