Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1EC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786B2206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV4jBZAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgC0KFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:05:51 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41158 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0KFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:05:51 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so4596430ilj.8;
        Fri, 27 Mar 2020 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZsT4s6F+0aWEjdDNvogNg/0Am8gEBeJU1RJCns6caM=;
        b=gV4jBZADPsxxmOevqsFr3dUk30vQu2mpadyao8IthPFKxa47xf5Bz8Nk1TEoRMr5bQ
         /W04tt9V2atdQkWrs8DjoRv2W0Rgu/p8Y4ZFuc2MkZtftHT3QyFS/fu/XPbCZ+IJ753E
         QrHnLyL4zYnNjhab1vVN7k0O8ma3KlAOWSo3OqU+tFXq2ANgsUF9qOsZIjU4b2UgTufy
         YbZQ/EboSRF25ESnLNjo46Wh6tJonA6UbQT9MnSSqgFbzouoXfH4zizbUYigAB9MvR+c
         GO+zmNt/VpfpQTq3oqBQUEV5auZeKEXD59eV4v/EAB9GujHF/nKsfKt74SgwAliDMcWV
         DnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZsT4s6F+0aWEjdDNvogNg/0Am8gEBeJU1RJCns6caM=;
        b=I1MSPA1pxh3qYovgRI/kyLddhnG3s1QOqsd5LyhHT4Tp4wtwbMK+8AT7b4voeYwWN7
         hvBWvf669q2C3XRc7A8cjLPU9bFTiddUe27LBEPeCbDxRRqnh1YLnoTMP8nBiq7HwwBD
         +5MeAu8lUY75r2tFsF7wYTygiZpfEXCCZ8d26z7onmNKv/1oPYQVCT3Pqj9iqWInSpXu
         GsP0A8KxKXV6Ec9ErAwGee16PnCgjE/KQhx5eB459vWRfk2zP1fZHnx+B+UogNfq8/oI
         OE8YM/cwINyR2HaJcwMVd36fZSpUPLJ1uGkL1jj18JHjBjFa6R9yB5sE9tPwatQli3n6
         2hlw==
X-Gm-Message-State: ANhLgQ3bjGlKIVQ8PIdB375TU9nMAghIzcSlV++AG7MQQ3N9+Y2gZFgb
        HFCsO/iespBkKMLj2okLwK9bC17ZtRtOlBVSYTyNIw==
X-Google-Smtp-Source: ADFU+vvAWecQaQ2qW1YgilQmsVI3uI5JqfPepvsYLpxtZV8yAuZIrcbGWhZlHRsV9K6sZHE2tSS+7ODmNEZXozDh5Eo=
X-Received: by 2002:a92:5dc7:: with SMTP id e68mr13177811ilg.205.1585303549723;
 Fri, 27 Mar 2020 03:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200326213251.54457-1-aford173@gmail.com> <CAMuHMdU9tQwQHkX0MdQLkMfz-2ymDzfNTFGnzPoq=JQF+28HOg@mail.gmail.com>
In-Reply-To: <CAMuHMdU9tQwQHkX0MdQLkMfz-2ymDzfNTFGnzPoq=JQF+28HOg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 27 Mar 2020 05:05:38 -0500
Message-ID: <CAHCN7xJ+bhDezLp+0F=WkM65d59RwmWsiFQ5gVD8KDLugFU-Og@mail.gmail.com>
Subject: Re: [RFC] clk: vc5: Add bindings for output configurations
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Charles Stevens <charles.stevens@logicpd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 4:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Adam,
>
> CC Marek
>
> On Thu, Mar 26, 2020 at 10:33 PM Adam Ford <aford173@gmail.com> wrote:
> > The Versaclock can be purchased in a non-programmed configuration.
> > If that is the case, the driver needs to configure the chip to
> > output the correct signal type, voltage and slew.
> >
> > This RFC is proposing an additional binding to allow non-programmed
> > chips to be configured beyond their default configuration.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > index 05a245c9df08..4bc46ed9ba4a 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > @@ -30,6 +30,25 @@ Required properties:
> >                 - 5p49v5933 and
> >                 - 5p49v5935: (optional) property not present or "clkin".
> >
> > +For all output ports, an option child node can be used to specify:
> > +
> > +- mode: can be one of
> > +                 - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> > +                 - CMOS
> > +                 - HCSL
> > +                 - LVDS: Low voltage differential signal
> > +
> > +- voltage-level:  can be one of the following microvolts
> > +                 - 1800000
> > +                 - 2500000
> > +                 - 3300000
> > +-  slew: Percent of normal, can be one of
> > +                 - P80
> > +                 - P85
> > +                 - P90
> > +                 - P100
>
> Why the P prefixes? Can't you just use integer values?
> After the conversion to json-schema, these values can be validated, too.
>
> > +
> > +
> >  ==Mapping between clock specifier and physical pins==
> >
> >  When referencing the provided clock in the DT using phandle and
> > @@ -62,6 +81,8 @@ clock specifier, the following mapping applies:
> >
> >  ==Example==
> >
> > +#include <dt-bindings/versaclock.h>
>
> Does not exist?

Not yet.  Before actually coding anything, I wanted to get feedback on
how the bindings should look.  In this file would be definitions of
terms like P80, CMOS, and the other items that are defined for mode
and slew.

>
> > +
> >  /* 25MHz reference crystal */
> >  ref25: ref25m {
> >         compatible = "fixed-clock";
> > @@ -80,6 +101,13 @@ i2c-master-node {
> >                 /* Connect XIN input to 25MHz reference */
> >                 clocks = <&ref25m>;
> >                 clock-names = "xin";
> > +
> > +               ports@1 {
> > +                       reg = <1>;
> > +                       mode = <CMOS>;
> > +                       pwr_sel = <1800000>;
> > +                       slew = <P80>;
> > +               };
> >         };
> >  };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
