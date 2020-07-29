Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F9A20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Onozl2Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2L7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2L7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:59:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296FC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:59:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c2so11340515edx.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QRWy1YBlieNCizCX79fYi5/kvniVQ9BIqFKoJ+v6lY=;
        b=Onozl2PvdryGi9YD+CsC7unot6+rdgNl73NAR/I++XEkM/ICfb2X5HUb9upkVoQ5lR
         LWcTDVhZzlficsyzPt23J8l8HKMfciLClrRJ+X8j5F+jNX7PG89SmCaJQcmujDl47pw5
         hALGlMtR8EwQKPcr6wEtumEdIBpNGCaL8QebI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QRWy1YBlieNCizCX79fYi5/kvniVQ9BIqFKoJ+v6lY=;
        b=JstPOt7pz40D5zjOreVGOO5Z0EN+kiUlruoo9D3eRjJjsr7mKa3ypCPvxIdBORkHL8
         NhV559nPeVluxi1qFy+uy+gSuU2ELNWRb8W2QAdnENkp4Zkofml8rls2fmpboDVbHAfq
         InBAeKasVmenOOacEfNGUB73w9RSlxv19MobPYleZJi/Nyq1SuOt6NqLxAhN0bK3zhSy
         +UhZJOOICi8LzZ3rOHaVspaL/BagkZo4lyOrnlCvxWxfaowN4YTUs+6aIHYuHo3TtSqG
         kZ/M5FTU425gptUtKzTazguSe4urQDWDCBitnvIXCFLXw87685f1IX/HmvtZ7XG34ICI
         e48Q==
X-Gm-Message-State: AOAM531wm0LPzjRJ3BiRc6miN0EwiQaHM4TDXq2BfHNE1YrKLeFVZEbJ
        Z5XlZKc+lZ36PUi8frqsNycKD+ygrXtZS2DH4v53oQ==
X-Google-Smtp-Source: ABdhPJxJTqL+yv4XQZ+e0Yu1p1dYX4jQwhJQ/xCQBLuR5o92WBnb1MdF57usX1MRal33FHuF6Ysjh0ffW2dn1NvjC0w=
X-Received: by 2002:a05:6402:c86:: with SMTP id cm6mr12777305edb.205.1596023958843;
 Wed, 29 Jul 2020 04:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200723090210.41201-1-jagan@amarulasolutions.com> <20200723155028.GA427258@bogus>
In-Reply-To: <20200723155028.GA427258@bogus>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 29 Jul 2020 17:29:07 +0530
Message-ID: <CAMty3ZDgrxeLxshKMMjXgg6wgDsan8mJeLr9d+YC9F=5uLPMqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 9:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jul 23, 2020 at 02:32:07PM +0530, Jagan Teki wrote:
> > ROCKPi 4 has 3 variants of hardware platforms called
> > ROCKPi 4A, 4B, and 4C.
> >
> > - ROCKPi 4A has no Wif/BT.
> > - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> > - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
> >   GPIO pin change compared to 4B, 4C
> >
> > So, update the existing ROCKPi 4 binding to support
> > ROCKPi 4A/B/C hardware platforms.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - new patch
> >
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index db2e35796795..e6f656b0bd56 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -430,8 +430,12 @@ properties:
> >            - const: radxa,rock
> >            - const: rockchip,rk3188
> >
> > -      - description: Radxa ROCK Pi 4
> > +      - description: Radxa ROCK Pi 4A/B/C
> >          items:
> > +          - enum:
> > +              - const: radxa,rockpi4a
> > +              - const: radxa,rockpi4b
> > +              - const: radxa,rockpi4c
> >            - const: radxa,rockpi4
>
> radxa,rockpi4 already meant 'ROCKPi 4A' and should continue to do so.
> Just add 4B and 4C strings. It's up to you if they should be backwards
> compatible with 'radxa,rockpi4' (meaning 4A), but I'd guess not unless
> it's just a board pop option.

At-least from dts nodes enablement point of view the existing dts
(with radxa,rockpi4) is 4B since it has wifi/bt enabled. 4A is the
real name of the board so having a compatible with radxa,rockpi4a is
meaningful as I understood.

So, based on the above statements the respective binding look like

      - description: Radxa ROCK Pi 4A/B/C
        items:
          - enum:
              - radxa,rockpi4a
              - radxa,rockpi4b
              - radxa,rockpi4c
          - const: radxa,rockpi4
          - const: rockchip,rk3399

Comments, please?

Jagan.
