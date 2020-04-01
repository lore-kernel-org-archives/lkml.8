Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2DC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC98320857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyxhtlak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgDAOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:51:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41292 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgDAOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:51:56 -0400
Received: by mail-il1-f193.google.com with SMTP id t6so168773ilj.8;
        Wed, 01 Apr 2020 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBp1FovwiRzN5kcrVx2NRVEpxFgLUtHlh+hAWfBd26g=;
        b=EyxhtlakoVnrr8qvrvwRE10imgby2JoLMFMbmztmlu93p9XFX9yiJHU1k9kO0Mee+9
         rL3wpoK8ZnklX1EtvvpUyc6aHSpBfvJm9Ei9AvqHbOSOfygx8YSLT40T1aofUPDSFwuS
         GUs/smZEA0Ooy11SjyqD78OABlq5U/CIarCI1jWB3ApOME9A6UswKkUDnWZcKBBhqiVO
         1NQUpKyO+kcdqnaN2MERdpiXrwVbk046RnMCaN3fCktMRA3FbmnXN8wcUUMN/LEAMfKZ
         43/zaCuG56VfSZ0wdwDLmk1pxV0VL9LIZmpQpkcC46BOxQOQ8sTpazzgFtwnqsZXqHOl
         2txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBp1FovwiRzN5kcrVx2NRVEpxFgLUtHlh+hAWfBd26g=;
        b=BOXZENkHgBE9z6FEoBXB8rlbSN5ZwuR1P3Vzz+DRaT7pgsB28a+wRzBLg6RNSHq1oT
         GsXfnWAaxtI7HY4DD1Pj6tP2AQB+cPa/25vx7rJrchBdfZv5ea55A0vjVhWeIEZESrNA
         ERhaJjRN8uLzJLiJIXZsua/Z0D05PUu+atlfXVC58oLd8KyQfSkr5nWNGx2Lp0OXCYZa
         C+QXy7iVojV91hxF/UtmPu6nic9joUSrU/1Z2qBKmY6dt6+bbl4hyb+k1ir2/zIVvA3a
         jjdlILH5+0faTnuU+BFZ8iFz4BlC0SqZBexY9qjWnVrY8/YUxzhvbyLjwBLx9MhcQpOs
         jLTA==
X-Gm-Message-State: ANhLgQ1VRfz02B/i40Jhh0yuB+nmWW37gLSbahoLZCXg4TPFsHN0gaN9
        9Ap7MYSQQWMfgr3cyr94OdCfw7M95FE7+l18VePaSwgB
X-Google-Smtp-Source: ADFU+vvpHo8+Hk4I69a5RWLc2KY2jcMh/c8jfX7sJ97ptPx1yG6GFnFtNfOoHS8fpjvDMZOyap3cWL0xvjFBm5nB9hU=
X-Received: by 2002:a05:6e02:41:: with SMTP id i1mr16412755ilr.78.1585752714886;
 Wed, 01 Apr 2020 07:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200326213251.54457-1-aford173@gmail.com> <CAMuHMdU9tQwQHkX0MdQLkMfz-2ymDzfNTFGnzPoq=JQF+28HOg@mail.gmail.com>
 <CAHCN7xJ+bhDezLp+0F=WkM65d59RwmWsiFQ5gVD8KDLugFU-Og@mail.gmail.com>
In-Reply-To: <CAHCN7xJ+bhDezLp+0F=WkM65d59RwmWsiFQ5gVD8KDLugFU-Og@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 1 Apr 2020 09:51:43 -0500
Message-ID: <CAHCN7xLqxYS6ROYSQymVHg5BWocGO+jO1XjJq8zLVvZTmmZU8w@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 5:05 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Mar 27, 2020 at 4:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Adam,
> >
> > CC Marek
> >
> > On Thu, Mar 26, 2020 at 10:33 PM Adam Ford <aford173@gmail.com> wrote:
> > > The Versaclock can be purchased in a non-programmed configuration.
> > > If that is the case, the driver needs to configure the chip to
> > > output the correct signal type, voltage and slew.
> > >
> > > This RFC is proposing an additional binding to allow non-programmed
> > > chips to be configured beyond their default configuration.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > > index 05a245c9df08..4bc46ed9ba4a 100644
> > > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> > > @@ -30,6 +30,25 @@ Required properties:
> > >                 - 5p49v5933 and
> > >                 - 5p49v5935: (optional) property not present or "clkin".
> > >
> > > +For all output ports, an option child node can be used to specify:
> > > +
> > > +- mode: can be one of
> > > +                 - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> > > +                 - CMOS
> > > +                 - HCSL
> > > +                 - LVDS: Low voltage differential signal
> > > +
> > > +- voltage-level:  can be one of the following microvolts
> > > +                 - 1800000
> > > +                 - 2500000
> > > +                 - 3300000
> > > +-  slew: Percent of normal, can be one of
> > > +                 - P80
> > > +                 - P85
> > > +                 - P90
> > > +                 - P100
> >
> > Why the P prefixes? Can't you just use integer values?
> > After the conversion to json-schema, these values can be validated, too.

That makes sense.  We can just use numbers.

> >
> > > +
> > > +
> > >  ==Mapping between clock specifier and physical pins==
> > >
> > >  When referencing the provided clock in the DT using phandle and
> > > @@ -62,6 +81,8 @@ clock specifier, the following mapping applies:
> > >
> > >  ==Example==
> > >
> > > +#include <dt-bindings/versaclock.h>
> >
> > Does not exist?
>
> Not yet.  Before actually coding anything, I wanted to get feedback on
> how the bindings should look.  In this file would be definitions of
> terms like P80, CMOS, and the other items that are defined for mode
> and slew.

The intent was to create this file and define a sensible translation
between the arbitrary the numbers 0 to 7 and the acronyms for "output
type". Would it be better to just use strings for output type (and not
create this header file)? I think I've seen something like that in a
TI driver. I hesitate to put a bunch of string compares in a driver.
Is there another way? Could we use properties and only allow one?

>
> >
> > > +
> > >  /* 25MHz reference crystal */
> > >  ref25: ref25m {
> > >         compatible = "fixed-clock";
> > > @@ -80,6 +101,13 @@ i2c-master-node {
> > >                 /* Connect XIN input to 25MHz reference */
> > >                 clocks = <&ref25m>;
> > >                 clock-names = "xin";
> > > +
> > > +               ports@1 {
> > > +                       reg = <1>;
> > > +                       mode = <CMOS>;
> > > +                       pwr_sel = <1800000>;
> > > +                       slew = <P80>;
> > > +               };
> > >         };
> > >  };
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
