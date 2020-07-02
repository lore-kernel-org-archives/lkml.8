Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE842070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef+WvaDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgGBGkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGBGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:40:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA4C08C5C1;
        Wed,  1 Jul 2020 23:40:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so23460704eje.7;
        Wed, 01 Jul 2020 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZyzkTpWxxyp2jCpCr/H7AQhJTt+1oFIYiYjR40e5k8=;
        b=ef+WvaDI5Nclj/K3DxyTqSSIiMNT70CBd5IP2Oh8mSLH15FENPmZiNclUE54Cef5Y1
         6RdTuKtBentGIP3A2y8+jhPffGc8jn/LJ9ZRvpS5+cdnzDueqkGsNMqAdcQ2qDgBL5Wo
         TR4r7Hj7hcW9Fa31FslEK/MC3djVQaGhgL5PXCN9hyKpqXfd/D5LUR9QMeFLkJwfYtGr
         c1VXFt8rx4+GEz8F2KbqvYBf/wvZh0x/lbvGYN/D1ov/QRi+rZmxUa3/YX4Lp7CDGsUp
         Sn3a39dv13S3DaJ9HcJYmVLqtzeQxsXEN+7YZhkVNi19zDnEO52Wpn6Vu3zpvqI6+MYJ
         bJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZyzkTpWxxyp2jCpCr/H7AQhJTt+1oFIYiYjR40e5k8=;
        b=uKWo4w+TlCG5dFN3sc9xxZU++xqI6+87TKZoy3rDiDlXPvkug6vh4idyUrWH8KSa9x
         TeR7GOmt4ejRkYoNT95R6LxhmbbVeUZgVaT4Es2QC0iWThGoBeiJNj9dlcfREKglpfTy
         O1inPAXrMt4NA4ywBkmkkDLlTXMFztqcRozHMWVDyGWHGlGtyLAnvTlA56LyCPJ7zfIz
         CinBHN62PKgJkZtUxID+8O1q67T+UxS9fDsx0BsJTzRKdYrwuSBVsJNYkuYkryU5SO1t
         AbgEmxMM5RiZ+BO60ja2c3L0rmn6YHrdLJxaZaQpMj9TMYXlEwufv+4L1/dHfmcxdQTe
         yFzA==
X-Gm-Message-State: AOAM533y0TlOKBeIZiVmxpV7mqE/3UtZedfMj77/rn+zOSZrXfdkwtuA
        rui9s2GNWSZ/5Enj/1aDc10aKgWx4nCLoPoJJBs=
X-Google-Smtp-Source: ABdhPJwcdJc+U6kh8u/dlaQKuEdG1Rr872beSa67XPYZJ6AgnTMmZLhLlp9wvGZneXlCk1gmpjEyS7JQdHyVAthcVa8=
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr27575294ejc.67.1593672000556;
 Wed, 01 Jul 2020 23:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com> <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com> <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 14:25:58 +0800
Message-ID: <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
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

On Thu, Jul 2, 2020 at 2:11 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> > Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
> > driver as module
> >
> > On Thu, Jul 2, 2020 at 11:26 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > [...]
> > > > > @@ -143,16 +148,18 @@ void imx_cscmr1_fixup(u32 *val)  static int
> > > > > imx_keep_uart_clocks;  static struct clk ** const
> > > > > *imx_uart_clocks;
> > > > >
> > > > > -static int __init imx_keep_uart_clocks_param(char *str)
> > > > > +static int __maybe_unused imx_keep_uart_clocks_param(char *str)
> > > > >  {
> > > > >         imx_keep_uart_clocks = 1;
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > +#ifndef MODULE
> > > > >  __setup_param("earlycon", imx_keep_uart_earlycon,
> > > > >               imx_keep_uart_clocks_param, 0);
> > > > > __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> > > > >               imx_keep_uart_clocks_param, 0);
> > > >
> > > > I feel not only the __setup_param, the whole logic of
> > > > keep_uart_clocks are not needed for Module case. Is it true?
> > >
> > > Yes, but the 'keep_uart_clocks' is false by default and the function
> > > imx_keep_uart_clocks_param() already has '__maybe_unused', it does NOT
> > > impact anything if it is for module build, so I did NOT add the #ifndef check
> > for them, just to keep code easy and clean.
> > >
> >
> > IMHO do not compile them is a more easy and clean way. Then users don't
> > have to look into the code logic which is meaingless for Module case.
> >
> > BTW, it really does not make any sense to only condionally compile
> > __setup_parm() but left
> > the param functions definition to be handled by __maybe_unnused.
> > They're together part of code, aren't they?
>
> I am fine of adding the '#ifndef MODULE' to imx_clk_disable_uart() and imx_keep_uart_clocks_param()
> as well in next patch series. Others like ' imx_keep_uart_clocks ' and imx_register_uart_clocks() need to
> be kept always built, since they are used by each clock driver no matter built-in or module build.
>
> So that means I have to add another 'ifndef MODULE' or I need to adjust some code sequence to make
> those code can be built-out in same block and just use single 'ifndef MODULE', I think adjust the code
> sequence should be better, will go with this way.

What if we  condionally compile it in clk.h? Will that be easiser?

Regards
Aisheng

>
> Anson
