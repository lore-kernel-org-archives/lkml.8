Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD36C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B782620724
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg2X3xJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgGBFnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBFnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:43:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79BC08C5C1;
        Wed,  1 Jul 2020 22:43:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so13260485edr.5;
        Wed, 01 Jul 2020 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtjw6ui/18TL1nfopaGxavsYfqOS3W2EnIEUiFfp6xw=;
        b=mg2X3xJLj6ZYbXlN/J/8VDmx5fZmXiFAvQ2DK1MvHv+BTDx6X4UhPUWjziUEO43UBM
         s6LFeprRxelk5RRbu+tGnKJuhgwJbZsZPp6BBQalAuijr2VOITxZ5iuhZrcs7q6U4PXT
         zXGyVfHlUOjFXGjBr324/b3ZsDMLonyUXD+lHFeBDXAk3gPkN0nipBLOpOi3bwVpnHJ4
         jz9uzOWfMAw1XDDBHUwL/RCdPxdKaqe+Qbpu+Lu7PS1yj9ojoTx2JHch1Ke/9q5XETku
         ABmve3gTyQoxgBHNjW45447bqXKZ2MFreIrgz726G+e4FEX0EVP1zOYYcgf+FlRYjwxg
         WX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtjw6ui/18TL1nfopaGxavsYfqOS3W2EnIEUiFfp6xw=;
        b=hVPzjpePRvWcaUZ4q9NQy44OStdTwPXoSmUiq2VKWz5EdZ0GmeWoBTg0Iths0Z1lg4
         LNU3rkQ/H/1rDYphT3ZSf6ire8ziKVpTX09Koz6HcNNzNXyyqzmobk2wXmhUIznpcOZ+
         1+K1ibVkojVwtb1KKdk0ZdlWrN1N3uKI7dq/OVV1yRRaph/uHY3HBO3dQNn5fZavN/69
         ezt6h9uYZe4kcR959b1N+Wqhg0APPW4gyPEgyH9kkNNoFqErCAJNnh/t8YXopL1ecCeI
         VlgRDRk6da/sWDJnN57Psvlw0KHKiPu0qUvWh80ThSpPakIGbvrcOqoK/Nih7w5So/yD
         5GFg==
X-Gm-Message-State: AOAM533RHAZUNu0E/t6cvOnF8kEpSPc9erTw89Obd8fGE80QzosFF3XE
        cuesQLSkepl6XmD4cV8Hmb5VAtrEiuV436Kbzsw=
X-Google-Smtp-Source: ABdhPJxVPRZ5soPcPEPtvHh/3w7o/dz7zDNB/VortJAz8xs6lV1ibpAjrf6VmCI9zBAn+j2H6ys31mbKowR/O9QG7tc=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr32253507edl.119.1593668594000;
 Wed, 01 Jul 2020 22:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com> <CAA+hA=T1+F-oTfWdV22ztUT3Ru-dFPDzhC7aJsdj0R3yP4wzbA@mail.gmail.com>
 <DB3PR0402MB3916713CC9AF95251A3A2BFAF56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916713CC9AF95251A3A2BFAF56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 13:29:12 +0800
Message-ID: <CAA+hA=RqvRVm9c635NXFQSeDekBPz9DU=eP4+LrBQpRR=-swZw@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock
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

On Thu, Jul 2, 2020 at 11:55 AM Anson Huang <anson.huang@nxp.com> wrote:
[...]
> > > +{
> > > +       return platform_driver_register(&imx8qxp_lpcg_clk_driver);
> > > +}
> > > +device_initcall(imx8qxp_lpcg_clk_init);
> >
> > Any reason to change to device_initcall which looks a bit strange?
> > Is it because the following line?
> > +obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
> > But it looks to me they're still two modules. Aren't they?
>
> It is suggested by Arnd to NOT use builtin_platform_driver(), in order to support module
> unload, although the clock driver normally does NOT support remove, but it is better to
> follow the right way.
>

By expanding builtin_platform_driver() marcro, you will find your
patch is exactly doing the same thing
as buildin_platform_driver() which obivously is unneccesary.

#define builtin_platform_driver(__platform_driver) \
        builtin_driver(__platform_driver, platform_driver_register)
#define builtin_driver(__driver, __register, ...) \

static int __init __driver##_init(void) \
{ \
        return __register(&(__driver) , ##__VA_ARGS__); \
} \
device_initcall(__driver##_init);

If we want to support unload, we need a .remove() callback as current
clocks are not allocated by devm_().
If don't support,  we probably can use builtin_platform_driver() first
and switch to module_platform_driver()
in the future once the driver supports release resource properly.

Regards
Aisheng

> The change in Makefile is just to link scu/lpcg library to i.MX8QXP clk driver, so that we can
> get rid of exports and below 2 .ko are needed for all i.MX SoCs with SCU inside as per your
> saying of i.MX8QXP clock driver can be extended for future SoCs with SCU.
>
> clk-imx-lpcg-scu.ko
> clk-imx-scu.ko
>
> Thanks,
> Anson
