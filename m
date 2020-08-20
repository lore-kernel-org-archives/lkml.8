Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629DD207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgoHEPEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHTBzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTBzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:55:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B39C061757;
        Wed, 19 Aug 2020 18:55:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so376172edv.11;
        Wed, 19 Aug 2020 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToacIw0lll2YQvnSO/xL/+VeiTLkY2lOUpjxJou/kXU=;
        b=DgoHEPEwFtQfs9zPlXT3FqbKes+MhIsMXW6UhrO6yny8npEEHTxoxBk2HAiSZ+jSqK
         zlPeWx5brxQw4ZP5AvaE76RGGQK5wYWbjWD32nkN5PUhmwRQW1/DBFmuPSLNTrSr4P16
         TOictmeNLSRoBYq5kz1jAjVx1REVzHAprVjUZ/E8wEIuMci3SrkKBe3y9DmdRBM0nDTk
         0ArMn4HV82cWRQS9Hs8rmas+1zzCuwoZTkeCaXxc9LL7XKVZq7SALbZATXFa8FYkVoBl
         vJkfcMlezXvhvyT6Wp4iJ4lMLBkvK4mrrQU2tMLyhYk4WCNA/DxrOYQz3Aacc9cPFhaR
         FURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToacIw0lll2YQvnSO/xL/+VeiTLkY2lOUpjxJou/kXU=;
        b=ZxW8z01HmKsdRTJ4zCHTMg4L0aGaIG6O3sqcCixiLJUawKBb+0op/OrPSR7vgo3NA6
         NSc/9Oml1RorAste0zOEQ0FtHShsyoaI2BY3ORA1LXkO25p7768xb6TbB8rpdqRd1gQB
         W/BK7Ib0x57/5DDMH6VMkhMQnW8k5ZjRK51/rBIlNDh/W234FqLoSPFDZ22IiVlfR0Zk
         mmdoXL8jMFGgTGYb79Kj3L8aimXgH7WSY2Adqa06CC9ZZL7R9rFvJRng3iGI40T2SfuB
         Jl8u1kx/A6PjNa6qcJiUO+klFrKVflg6N76pSQjG4Ln19c+39Yc4Y5rgjmDh4Qhp4u9F
         htNQ==
X-Gm-Message-State: AOAM532Yb/f50CfIBA9+N81gg7VfT7K92lQ+1ISIALuKhkUYocJO8rsm
        rNImgKA11cRF3BWV8fIOMmb7X/ZKp9qiIxhK8WAU0jkJ
X-Google-Smtp-Source: ABdhPJzxYSbCfjlQL09Z8thB5yHOEcQFVo7lLkpDPs0nvIj5WHBFAY+GGn3P+8fCuAYFRCCOS/XVAMPRi8WTq5KWKBI=
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr846526edb.22.1597888531248;
 Wed, 19 Aug 2020 18:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-12-git-send-email-abel.vesa@nxp.com> <CAA+hA=R9bFBX-tFfSEO3wqC+b4P1nbfSVyBQUOzez=oZ71AhkA@mail.gmail.com>
 <20200819203150.bddziq2m75sccixj@fsr-ub1664-175>
In-Reply-To: <20200819203150.bddziq2m75sccixj@fsr-ub1664-175>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 20 Aug 2020 09:40:22 +0800
Message-ID: <CAA+hA=RiNeruR2d2qVS1A+P31YA42hjvyAo53W0+31zcEei9mg@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
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

On Thu, Aug 20, 2020 at 4:31 AM Abel Vesa <abel.vesa@nxp.com> wrote:
....
> > > +extern const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst;
> > > +extern const struct imx_blk_ctrl_dev_data imx8mp_media_blk_ctrl_dev_data __initconst;
> > > +extern const struct imx_blk_ctrl_dev_data imx8mp_hdmi_blk_ctrl_dev_data __initconst;
> > > +
> >
> > If no special reasons, i may prefer to put those data in either
> > clk-blk-ctrl.c or separate clk-blk-ctrl-data.c
> > because there seems to be no code level dependency on the CCM
> > driver(clk-imx8mq.c) for clk_blk_ctrl drivers.
> > Then we can save those extern variables.
> >
>
> The rationale here is to have the SoC specific definitions in the SoC specific
> clock provider driver. Otherwise with every new SoC that will use the blk_ctl
> IPs we will increase the size of clk-blk-ctrl driver. Plus the kernel names of
> the clocks used by each blk_ctl IP as parents are also defined in the SoC
> specific clock provider driver.
>
> I'll find a way, though, to move those so that they would not be shared between
> all the clock drivers that needs a blk_ctl implementation.
>

Please refer to pinctrl-imx.c to see if we can do similar things for blk-ctrl.

Regards
Aisheng

> > Regards
> > Aisheng
> >
> > > +#endif
> > > +
> > > --
> > > 2.7.4
> > >
