Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5EFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68ED206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vN7H2Ca8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgF3EJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgF3EJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:09:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7EC061755;
        Mon, 29 Jun 2020 21:09:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so19059849ejb.2;
        Mon, 29 Jun 2020 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hey9HbRw/dVBfXOWAz6aoDUkLgkP19V6zpTJ8WVJch0=;
        b=vN7H2Ca8sOkOTtvwl3v6foRnaRBZiWn6uKrH2xydPPm7Zed43DfmUIi0f2YjMw6+/x
         uJOGmUrutRMHbnddJOwujquc0X1kJ7fov7nKK7fiFCRDhJzvBJPhxdNj4KGDM+3fBwl0
         qJfUzy8859dmVn9XcRNwo+N1/SJi6tVscANDiThp63DeRsB6xa4lR5KE7C+s2f7lhsIl
         Jbc73GQIE2gYjLF0FMw+1d+apsSfFH16H0RPP2esr545hwkrDhLGoGoyQEuKhmNS1h5N
         YTmZT+KRz0oqQkDD8Fk+AdBfj0OKY3oZ+u5etDDMrKWWMGZ82sh8DfAMGfpdUyvP0jHc
         fClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hey9HbRw/dVBfXOWAz6aoDUkLgkP19V6zpTJ8WVJch0=;
        b=pD08qfLTzgif2v5UZMH4FGerpHLbtr1LbOb0yoPsbIhd/Eip3K/JJ76T8gEbB/PDb9
         kbEVMtj0coNdHnlOpSMSbEAHchdtLa+FuPQfRi1P/x0uZ6zcPkuQ8Y+N2TYI3Pu+DpHq
         r04Fb4fQRCgT/YQ/2IrZJzJAMzCuV7If3Hzy8xn1746DDVbVUr+AN1Wr6Kr/uhpklNUF
         ZVN/3RKg1KjFjjNfc2oBSMx2gDRik4yjqekSMK8bMuRU5Ks1wNVMi/KAxTbNPYPsLwtd
         cUO916NRbnzsp1pJAyix/xXIXPxCGkkRYSPk4lJYNUOVBQZKATQJffKUixnIu3niElpy
         zWRA==
X-Gm-Message-State: AOAM531Yhm5k6PmfOEtVuTlahIr7llI1WZK/fh3KcsndeRX6v65hczoS
        daRf5MWj6wMSNfRF1RSjaknZKsCgbhe3z1jfjss=
X-Google-Smtp-Source: ABdhPJx0k3kHhhcmfRuwSQBAljpirUv4qs2fybiJfDd0o4Bl0x6GWFRJs4MEYUmcn6ESvQyn5fmZWG0OPMsgIoQQ0pM=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr17289015ejt.440.1593490188847;
 Mon, 29 Jun 2020 21:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com> <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 30 Jun 2020 11:55:50 +0800
Message-ID: <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 5:16 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Arnd
>
>
> > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
> > module
> >
> > On Mon, Jun 29, 2020 at 4:52 PM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock
> > > > driver as module On Mon, Jun 29, 2020 at 2:53 PM Anson Huang
> > <anson.huang@nxp.com> wrote:
> > > >
> > > > Sorry, I misread the patch in multiple ways. First of all, you
> > > > already put clk-scu.o and clk-lpcg-scu.o files into a combined
> > > > loadable module, and I had only looked at clk-scu.c.
> > > >
> > > > What I actually meant here was to link clk-scu.o together with
> > > > clk-imx8qxp.o (and possibly future chip-specific files) into a
> > > > loadable module and drop the export.
> > >
> > > Sorry, could you please advise more details about how to do it in Makefile?
> > > I tried below but it looks like NOT working. multiple definition of
> > module_init() error reported.
> > >
> > > obj-$(CONFIG_MXC_CLK_SCU) := clk-imx.o clk-imx-y += clk-scu.o
> > > clk-lpcg-scu.o
> > > clk-imx-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
> >
> > Right, you can't have multiple module_init() in a module, so what I suggested
> > earlier won't work any more as soon as you add a second chip that uses the
> > clk-scu driver, and then you have to use separate modules, or some hack that
> > calls the init functions one at a time, which is probably worse.
> >
> > If it's only imx8qxp, you can do it like this:
> >
> > obj-$(CONFIG_MXC_CLK_SCU) := clk-imx-scu.o clk-imx-lpcg.o
> > clk-imx-scu-y         += clk-scu.o clk-imx8qxp.o
> > clk-imx-lpcq-scu-y += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
> >
> > If you already know that the scu driver is going to be used in future chips, then
> > just stay with what you have now, using a separate module per file, exporting
> > the symbols as needed.
> >
>
> Thanks, and yes, I know that scu clk driver will be used for future i.MX8X chips with
> SCU inside, the current i.MX8QXP clock driver can NOT cover all i.MX8X chips, so
> I will stay with the exporting symbols.
>

SCU clock driver is a common driver for all SCU based platforms.
Current i.MX8QXP SCU clock driver will be extended to support all
future SCU based platforms.
So theoretically clk-scu.o and clk-imx8qxp.o can be combined. LPCG  is similar.
Maybe you can give a try as Arnd suggested.

Regards
Aisheng

> Thanks,
> Anson
