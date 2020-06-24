Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FE02073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Gs5a8ysD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405001AbgFXQfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404625AbgFXQft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:35:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24AC061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:35:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so2759149iox.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp0WLMHGJPSAAMQoilN1mZe9srYQKmzrBKtnNiwXpVs=;
        b=Gs5a8ysDongBqjpVPsiQWEdpD5YRNoaq5AdJr4nWs/zYkTf9M+ghwGa2A+vl53WV6M
         JRhhJVQhyuX8Tjd445UrEkqaFeRBOHvtFUzLBeMPO0HX9mrLGqK4lDzsj6o3kvYnXAtP
         U9yDgHUDz7mk9brV9quovHVYMfYdpE1wplg8iEBwg4dESo1GeYGKG147fTWViUWPXVaS
         FR6tX7MIy3c334Uz8RjbHxPZg9QBgw0WiGsyG1tVXNjq2ij/nw+U3r3cmvFLDwDYK1qw
         EoXeQw+M9J5xE1EYWjQsHsb+8MY6uK1Y0nyljUOAVmAheLR3MwqkhUPIAU1EoVLOMvau
         PLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp0WLMHGJPSAAMQoilN1mZe9srYQKmzrBKtnNiwXpVs=;
        b=WuqlveTp0QD8JzeCI1VxcIbapzZD4khsPkNHX83GJnnQdBH9IkkWtonhefReUxUKOI
         xOsnXC3jwAVP8wB393ryq5hKzDriAUQRTMdiW2gjvydDjyVg1vQFpH0iblcRMhqphzYv
         RjP/BnkodnzvWN5QUcPf4UWVej7hvGW5RAIKIsn2tL5mBfsQJrDPVi+hCRpc9s18OInF
         6ssy8Ok/UQQFK7nbFXify9sYxuU3q0HOOAtM0/VEeYxkez/OGduRVEpHeRGkN91h0X6+
         PLjQxkoFOFBbXMGm8Y+1i8xbY22NEn3HpUUr4CLz5oYT2HszuU0gNNS1Z0OmvZ7OF9k1
         wIAw==
X-Gm-Message-State: AOAM531c9rADHsf8YTCoZ7XVHAEfsZJJHSmtd82eveeUACTgoy5gzaqf
        NN/SW9KgaUKcKguCYYRqBRhGU7EB4BVPvWfTHVd91w==
X-Google-Smtp-Source: ABdhPJxqogL8HjW0xO8Djm9BN68/4TRrqeL4aSvgA3Rvp4v39IWyLfFQicLhQQMp3WEw0MNQuACTa3lGvzsxsAPhLOs=
X-Received: by 2002:a6b:b252:: with SMTP id b79mr32690628iof.31.1593016548397;
 Wed, 24 Jun 2020 09:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200622093744.13685-1-brgl@bgdev.pl> <20200622093744.13685-10-brgl@bgdev.pl>
 <20200622133940.GL338481@lunn.ch> <20200622135106.GK4560@sirena.org.uk>
 <dca54c57-a3bd-1147-63b2-4631194963f0@gmail.com> <20200624094302.GA5472@sirena.org.uk>
 <CAMRc=McBxJdujCyjQF3NA=bCWHF1dx8xJ1Nc2snmqukvJ_VyoQ@mail.gmail.com> <f806586d-a6d7-99af-bba4-d1e7d28be192@gmail.com>
In-Reply-To: <f806586d-a6d7-99af-bba4-d1e7d28be192@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 24 Jun 2020 18:35:37 +0200
Message-ID: <CAMRc=MfQFgrJC3nvuJgZobixa6MLeMw-tdg_3e1yNDityU5XSw@mail.gmail.com>
Subject: Re: [PATCH 09/15] net: phy: delay PHY driver probe until PHY registration
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:06 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>

[snip!]

> >
> > This has evolved into several new concepts being proposed vs my
> > use-case which is relatively simple. The former will probably take
> > several months of development, reviews and discussions and it will
> > block supporting the phy supply on pumpkin boards upstream. I would
> > prefer not to redo what other MAC drivers do (phy-supply property on
> > the MAC node, controlling it from the MAC driver itself) if we've
> > already established it's wrong.
>
> You are not new to Linux development, so none of this should come as a
> surprise to you. Your proposed solution has clearly short comings and is
> a hack, especially around the PHY_ID_NONE business to get a phy_device
> only then to have the real PHY device ID. You should also now that "I
> need it now because my product deliverable depends on it" has never been
> received as a valid argument to coerce people into accepting a solution
> for which there are at review time known deficiencies to the proposed
> approach.
>

Don't get me wrong, I understand that full well. On the other hand a
couple years ago I put a significant amount of work into the concept
of early platform device drivers for linux clocksource, clock and
interrupt drivers. Every reviewer had his own preferred approach and
after something like three completely different submissions and
several conversations at conferences I simply gave up due to all the
bikeshedding. It just wasn't moving forward and frankly: I expect any
changes to the core driver model to follow a similar path of most
resistance.

I will give it a shot but at some point getting the job done is better
than not getting it done just because the solution isn't perfect. IMO
this approach is still slightly more correct than controlling the
PHY's supply from the MAC driver.

Bartosz
