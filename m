Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B72B2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FquHVBuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGBFwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:52:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B2C08C5C1;
        Wed,  1 Jul 2020 22:52:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so27705728ejd.13;
        Wed, 01 Jul 2020 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTX8G0FukGDGojl6rKgvGA2fV/um1+DnSL6BGGF5rTk=;
        b=FquHVBuq7KCtLoqPVvMm9HrqdlxcjXKcG1/+uFCoy9V2e1Xg3bw0d7tBmfSyFAGcha
         IgZIgf0l9wD2Joq5cTRKEesJYG7anNVjvVKeExREY9By5CJp7ImSJPFfaXLFBp2QG7kr
         GfcmsNQbJeTmwzK7RPOonHY0aEpzJ3oy+6PpCWlQR9tOE0gkA4aLefcJWAmtGN0DZ/p9
         0iG9N+XmuuBpFtbWok3DgwEfuMNhasYWjk+6ke3z1OwZh2CFg14Uh0A50qN5upQsO04R
         JP6Kg95vi7KGsDdV02vBFfzdaqeQWMTYOb2EDR4Wx8hjOIP4w+GxVz5NKeacl1FmgeNQ
         x0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTX8G0FukGDGojl6rKgvGA2fV/um1+DnSL6BGGF5rTk=;
        b=sz3AADI5Fmk3DzlphFAqu6pgihT2DygZFOX/gIjpKlLVJ+WiNaWBJ0fg97XY2ZJT3w
         iBnMZolPnvXYFtCiIEzpd850a6KnnnpO5DeeqF+dP2pniOA6OxZK1tijWzrWKghYj612
         DSLeHzOUveutbtVnxASlmTvfmFs5jmQjfLn+k6imlFnMnpr6fL7T2JDLH7IbI951QryI
         hxLZBMnT9GOU6xVcUmytgH14T+74ptZpWOYRmbWv5LuYbAYWMiurNqLAIG9RwAmROnGV
         hWI6cB2GyztX94Y3LuIkN7BsaOdYSNOt7wZdRxXAe6nU62BJU50ZIaezHgML13ar2t+X
         iokw==
X-Gm-Message-State: AOAM530imByHfxBfe440ANoVuius4lZoEHebstJ3OGmBwGCxXYu3RsJT
        ovBI1VsZwIFRIojQTaZLM0Fi2ZB19hgK8p2WZZA=
X-Google-Smtp-Source: ABdhPJwMXcuDstpkLDAVFtfvS+c1kcgVHNxhmQy/o9PberFQHvXcCp+0m6rAm/8+6AsWMhEswSifBPT5RBcN2f7BYoU=
X-Received: by 2002:a17:906:e215:: with SMTP id gf21mr20475157ejb.310.1593669132029;
 Wed, 01 Jul 2020 22:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com> <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 13:38:10 +0800
Message-ID: <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:26 AM Anson Huang <anson.huang@nxp.com> wrote:
[...]
> > > @@ -143,16 +148,18 @@ void imx_cscmr1_fixup(u32 *val)
> > >  static int imx_keep_uart_clocks;
> > >  static struct clk ** const *imx_uart_clocks;
> > >
> > > -static int __init imx_keep_uart_clocks_param(char *str)
> > > +static int __maybe_unused imx_keep_uart_clocks_param(char *str)
> > >  {
> > >         imx_keep_uart_clocks = 1;
> > >
> > >         return 0;
> > >  }
> > > +#ifndef MODULE
> > >  __setup_param("earlycon", imx_keep_uart_earlycon,
> > >               imx_keep_uart_clocks_param, 0);
> > >  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> > >               imx_keep_uart_clocks_param, 0);
> >
> > I feel not only the __setup_param, the whole logic of keep_uart_clocks
> > are not needed for Module case. Is it true?
>
> Yes, but the 'keep_uart_clocks' is false by default and the function imx_keep_uart_clocks_param()
> already has '__maybe_unused', it does NOT impact anything if it is for module build, so I did NOT
> add the #ifndef check for them, just to keep code easy and clean.
>

IMHO do not compile them is a more easy and clean way. Then users
don't have to look into the code logic
which is meaingless for Module case.

BTW, it really does not make any sense to only condionally compile
__setup_parm() but left
the param functions definition to be handled by __maybe_unnused.
They're together part of code, aren't they?

Regards
Aisheng

Regards
Aisheng

> Thanks,
> Anson
>
