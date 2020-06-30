Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C17E206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHgFgfX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgF3Dul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgF3Duk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:50:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B59C061755;
        Mon, 29 Jun 2020 20:50:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so14827196edb.3;
        Mon, 29 Jun 2020 20:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0B1RnHxaLtY6cPxcW/Ojh88m5bGWKbr1d+gTGuWAH4=;
        b=UHgFgfX7LZ4HvRfMESq2Kq8n0hJPcIL804yKZ55/1FpVeZjsjDu3/v0ekUElUaBrwC
         E2lOhbXNVHnWJdE4+QBO76QdX3lETzQdqjCoWiDj+j01cPw/AKE7n8qTlFNit9skHKvn
         f/cF4+zHTicz1LcoxUhBXinMrXP+Bqwex0rVjYYBgwpSiAUFz0ESDiTIx3Z1pt48Lz86
         2IykvzdL475X5mqDgDMGKtqXZeNhzglhOkviJvmU+Tgl15O7xhgbfC+2fYIpOd36BFxk
         /ZYYoLnk5JLiIxuzQ/RQqM73ypMCZsx2pyNkTFEKUjnCuf5dXvR2WeJn4Jwuj5Et92jV
         8mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0B1RnHxaLtY6cPxcW/Ojh88m5bGWKbr1d+gTGuWAH4=;
        b=IrtVY2OX01vWk2Et0oakxHf0ajVrJaIvZU02Ukgr6bUf9oduPC9F73R+63ihTU1hwz
         d26d04KsoAoYbcX7YYFSkefCzC6K0ZYfQbtCEgkGpOVQF3qBXPeJvb5Li0/RqSJvJDc5
         b4lHGtN4R+HwhpHhv8tF0bTbc2dv7ua6mB74LMMFqWPFpTEbvumkVqHkUyYNnAuATuiD
         ONW0Ke7gbs0Qo3LhSCutOfvNChTlG3TSHpORGuXeZxs4B7Xbp9J8IzIxRkhdcf0fhc9V
         DVnQ64jPzxKw7OL9Z2KBi/QWuz9WtrAdcbBedhSE4klLUqj3SLLFIHUBo0VhyiJGDzXs
         5P4A==
X-Gm-Message-State: AOAM531dmUQz5rUiRbUwdb99XtBpjUpMPds3aVJ9uJdCHS2q5nDo2JjI
        MiRsW0K8EhP2woYzHvvULjxBLKtEV73+TYcyIsw=
X-Google-Smtp-Source: ABdhPJyt6zfNzsijRYETNxn9IquHDb/jeqHEdhWfn/iIC7aKhhL00f8sPA87FaGF6UnN/wQZvzTddaNlsz/XIeu8nrc=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr20517050edl.119.1593489038902;
 Mon, 29 Jun 2020 20:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
In-Reply-To: <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 30 Jun 2020 11:36:40 +0800
Message-ID: <CAA+hA=TXQkaFGDv4fQ57Tuj7vUEOM4qUi1i74p8G9KGzmAr4Hw@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anson Huang <anson.huang@nxp.com>,
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

On Tue, Jun 30, 2020 at 3:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jun 29, 2020 at 2:53 PM Anson Huang <anson.huang@nxp.com> wrote:
> > > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
> > > module
> > >
> > > On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com>
> > > wrote:
> > >
> > > > --- a/drivers/clk/imx/Makefile
> > > > +++ b/drivers/clk/imx/Makefile
> > > > @@ -21,9 +21,9 @@ obj-$(CONFIG_MXC_CLK) += \
> > > >         clk-sscg-pll.o \
> > > >         clk-pll14xx.o
> > > >
> > > > -obj-$(CONFIG_MXC_CLK_SCU) += \
> > > > -       clk-scu.o \
> > > > -       clk-lpcg-scu.o
> > > > +mxc-clk-scu-objs += clk-lpcg-scu.o
> > > > +mxc-clk-scu-objs += clk-scu.o
> > > > +obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o
> > >
> > > It looks like the two modules are tightly connected, one is useless without the
> > > other. How about linking them into a combined module and dropping the
> > > export statement?
> > >
> >
> > From HW perspective, the SCU clock driver and LPCG SCU clock driver are different,
> > SCU clock driver is for those clocks controlled by system controller (M4 which runs a firmware),
> > while LPCG SCU clock is for those clock gates inside module, which means AP core can
> > control it directly via register access, no need to via SCU API.
>
> Sorry, I misread the patch in multiple ways. First of all, you already put
> clk-scu.o and clk-lpcg-scu.o files into a combined loadable module, and
> I had only looked at clk-scu.c.
>
> What I actually meant here was to link clk-scu.o together with clk-imx8qxp.o
> (and possibly future chip-specific files) into a loadable module and drop
> the export.

It sounds like a good idea to me.
Actually I planned to combine them into one driver in the future.

Regards
Aisheng

>
> > So, I think it is NOT that tightly connected, it is because they are both for i.MX8 SoCs with SCU
> > inside, so they are put together in the Makefile.
> >
> > If the export statement is acceptable, I think it is better to just keep it, make sense?
>
> There is nothing wrong with the export as such, this was just an
> idea to simplify the logic.
>
>       Arnd
