Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDEF2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCcrKo0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGOOWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGOOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:22:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDEC061755;
        Wed, 15 Jul 2020 07:22:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so1741283edq.8;
        Wed, 15 Jul 2020 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4YLq7ad8Ku7+EWFa0/mgk39lvRv5vsUDuPSLGAmMis=;
        b=lCcrKo0G+0r8E1QGKPPSeKTD6jPE8Sc6irv4/pOM95bnJP53927eRuCyYXGeGkV9fd
         4mAETYDfMMhmValjwwKkzgyw6wNRUSM7HPaYym0azD4zlCU3nckTdg4+j1Wc53w3nOHA
         O1x4YZWvOSoxt6Ki5XkR4PxFJ2sl5ih71h1LHgcgiViNmWv4Groshm3PXgvKN4TJT7MH
         8TG+hVZ4AaNClt0XH3+2cPGeaAwLX9Nb/XP5ixDGbggf5vtZTfFJFyppqTL9x3mDCHfO
         b4nFyNmrOU8X1KLO5q+5txBX/3CO8n6xnjqpC15H43ua/BRMEViLX4C0QztCHodDD7LN
         K3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4YLq7ad8Ku7+EWFa0/mgk39lvRv5vsUDuPSLGAmMis=;
        b=QnnOxpkqv+u1t8KK3xMYa9Yrr8zxinQg/TiQhXW6HKaqXwTb8YDuxcwcpMg/uSMX8C
         mGJXWH7TrPxXfPxxzI2Y/L9CXae1Z+GCBQseMxcC/sWEe03Qi5pKjiPRxasWZpKlpOfA
         68lV9obOIVHdNEa/A8f/qVSgeBi+0l6agET/daP1o4n7GdHJvGlm1KgmO52NAulYf7E3
         P1nLpLCujJSq8f3c3bUZXr0Xw/XfaKjfU+WUcxmv4hDxB40X3C+p22FHKSiSn7hI2RKm
         ExQRNotLtXYo9lLhlhjG59xNTkCA73A+3qYwg2te5zU3k9tDXdaU3/0G63uhAyoZT7R0
         KW/Q==
X-Gm-Message-State: AOAM530TkmiGvG4+pfIc07Q4Nd9IQ9Ay98/lTwLnRsug4gZmdJm6JKgD
        PR0cQs8nBPpItyZb3qEDKqApGXadPN4DDq3Oxuo=
X-Google-Smtp-Source: ABdhPJw5Rrl8VSXS3LDJXAXOUm42CTHm9/tBMgf95ADIskpTsgsl8yCwuH0vzZ6Rb7gKkig3GTgv+diJgyCwmRsxUnA=
X-Received: by 2002:aa7:c3d7:: with SMTP id l23mr9596809edr.18.1594822931168;
 Wed, 15 Jul 2020 07:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-2-bruno.thomsen@gmail.com> <20200713025246.GY21277@dragon>
 <CAH+2xPAHKY6YfhO-jXfKN+TRN5LDT1Kkn8a8HUj_EOqFt=75nQ@mail.gmail.com> <CAOMZO5DsyqRgD8n-w=6OmnXuMX+1T2DDOjQLNK133=FaqtWXVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DsyqRgD8n-w=6OmnXuMX+1T2DDOjQLNK133=FaqtWXVQ@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Wed, 15 Jul 2020 16:21:55 +0200
Message-ID: <CAH+2xPD31bdb_ZjAi6qo5n25K469Ak-qt2GJCcppHk4FZChdeg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tir. 14. jul. 2020 kl. 13.54 skrev Fabio Estevam <festevam@gmail.com>:
>
> Hi Bruno,
>
> On Tue, Jul 14, 2020 at 7:03 AM Bruno Thomsen <bruno.thomsen@gmail.com> wrote:
>
> > I have not yet been successful in converting the deprecated properties
> > to generic phy properties, so hoping I could get a hit.
> >
> > Kernel error messages:
> > mdio_bus 30be0000.ethernet-1: MDIO device at address 1 is missing.
>
> Please double-check whether 1 is the correct address for the KSZ8051
> Ethernet PHY as per your schematics.

Hi Fabio,

Thanks for the hints.

Yes, the address is correct and configured with external resistors,
but just realised that I wrote the wrong device name in the comment,
it's actually KSZ8081RNB.

Ethernet has been working with multiple mainline kernel versions
(latest being 5.7.8)
for the last year or so when using the DTS in patch. So I am pretty sure
hardware and setup of mux is correct'ish.

Kernel trace from patch version:
kernel: Micrel KSZ8081 or KSZ8091 30be0000.ethernet-1:01: attached PHY driver
 [Micrel KSZ8081 or KSZ8091] (mii_bus:phy_addr=30be0000.ethernet-1:01, irq=POLL)

Error first occurs when switching from fec phy reset to mdio phy reset
code path,
I understand that the fec phy reset is obsolete as phy properties was wrongly
added to the mac and of course should be part of the phy (separate chip).

When debugging it I end up with the get_phy_device() call not working
inside of_mdiobus_register_phy().

Workaround at the moment seems to be extending compatible with
"ethernet-phy-id0022.1560" to disable auto detection of phy type,
and then Ethernet works again. At least the same PHY driver trace
can be found and full transmission speed can be used without packet
errors/loss.

> Are there external pull-up/pull-down resistors for strapping the
> various configuration pins for the PHY? Or are the pull-up/pull-down
> provided by the i.MX7D pins?

Config strapping is done with external resistors.

> If there are no external pull-ups, please make sure to configure the
> pinctrl_enet1 accordingly, so that the Ethernet PHY address can be
> properly configured and then mdio_bus driver can find it at the
> correct address.
>
> Please check in arch/arm/boot/dts/imx6qdl-sr-som.dtsi for an example
> on how to configure the Ethernet PHY pin strapping via iMX IOMUX.

Thanks, good examples can be hard to find.

/Bruno
