Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD70C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBCB21D7A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWuXG4b4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGNKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:03:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7CC061755;
        Tue, 14 Jul 2020 03:03:33 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so16407362edq.8;
        Tue, 14 Jul 2020 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKp4hLtxETvkv2CWahEKcfbp1IqsM/1I1uhcW5o/wdY=;
        b=PWuXG4b4cpqYFf2T4pSBWibdehnMvZPSt8U8it8Y5Vr8G4jATwgScAO7URB+xYsDIk
         ko9j8deE86NN89zX1NpP0ZD8NnsgJ0aEsk4cQyxlHIy8LnqMWPhINDEoCUH+Djt7fk/y
         q304ihm+M83eb/bwQu6b+Toz8dSHDcE0hrBPElnsKJmwQ/199siBC15iLpr7S6Mdo26K
         vdr863REyILYzvb0IRSz4DmkuUysNw/HjI1lpJ9FWPSxQUoSsDOCsqrIO/oIhPu2wevy
         DXrW7iyxD/djeMfYG+35wUH6epFRuZ2OkKCh2tIw8JBTqudzg5N70NnfjZTINxnOUN9i
         HZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKp4hLtxETvkv2CWahEKcfbp1IqsM/1I1uhcW5o/wdY=;
        b=PGluHX4elZ+dcwPspx60tBqVbXgy86oSlzCTXYv3j6X3c/EisdII8vTZzw4GOYaGNd
         BQpeqiPE2nCq9IZYPkwlr7KhTWRlbLh8oqGhZnLLmq7womYf8PWPU7IUuN0D2VY8JPQS
         h5eL+Gvo4kt6naDYSBA+Y/9sWfsfOS1p68uq4IezbmNJWsCMCxLJxrEIAYuBjCx99HqK
         tLkkPLkhGEL2lLlA0ZlexzLm20HnP0YkjvS6Jker7DoYj6CnFgAjQO7+nUYXM9MmHLK+
         Y0267C1yYAJ2jZpNYKanHN5qyCWVTRT9C0ULXRnjb4kzzIG6wrF4nL7HdbnOeJS01sU6
         BwZw==
X-Gm-Message-State: AOAM532UEIib8a1rzLgnGuHW/PaeGVwFKjx3a2f6p//aWmm2WuXlKkIB
        URgMHG0IaCY/XIJ43Dlx7WW4aZG/bzw+9e8tRUE=
X-Google-Smtp-Source: ABdhPJzMuF8S5wkwmiZSLv/BO2k8Uh6Rq8XGYvR9lfAW1FMCP6K5LDh1XPrNn+57jDHjM8t8/P6yahksikRVd7DQfbE=
X-Received: by 2002:a50:d55b:: with SMTP id f27mr3747046edj.312.1594721012001;
 Tue, 14 Jul 2020 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-2-bruno.thomsen@gmail.com> <20200713025246.GY21277@dragon>
In-Reply-To: <20200713025246.GY21277@dragon>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Tue, 14 Jul 2020 12:03:16 +0200
Message-ID: <CAH+2xPAHKY6YfhO-jXfKN+TRN5LDT1Kkn8a8HUj_EOqFt=75nQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den man. 13. jul. 2020 kl. 04.52 skrev Shawn Guo <shawnguo@kernel.org>:
>
> On Mon, Jun 29, 2020 at 01:49:26PM +0200, Bruno Thomsen wrote:
> > +&fec1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_enet1>;
> > +     phy-mode = "rmii";
> > +     phy-reset-gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> > +     phy-reset-duration = <100>;
> > +     phy-reset-post-delay = <1000>;
>
> These properties are deprecated.

Thanks for review Shawn.

I have not yet been successful in converting the deprecated properties
to generic phy properties, so hoping I could get a hit.

Kernel error messages:
mdio_bus 30be0000.ethernet-1: MDIO device at address 1 is missing.
fec 30be0000.ethernet eth0: Unable to connect to phy

Updated device tree section:
&fec1 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_enet1>;
        phy-mode = "rmii";
        phy-handle = <&ethphy>;
        status = "okay";

        mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                ethphy: ethernet-phy@1 {
                        /* Micrel KSZ8051RNLV */
                        compatible = "ethernet-phy-ieee802.3-c22";
                        reg = <1>;
                        max-speed = <100>;

                        reset-assert-us = <100000>;
                        reset-deassert-us = <1000000>;
                        reset-gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
                };
        };
};

/Bruno

> > +     phy-handle = <&ethphy>;
> > +     status = "okay";
> > +
> > +     mdio {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             ethphy: ethernet-phy@1 {
> > +                     /* Micrel KSZ8051RNLV */
> > +                     compatible = "ethernet-phy-ieee802.3-c22";
> > +                     reg = <1>;
> > +             };
> > +     };
> > +};
