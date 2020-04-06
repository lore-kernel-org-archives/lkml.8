Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C62C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147E2493B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586189547;
	bh=GVYsMfinsR8g/zIfP0f+/JnCqupV0DlPI3YA/qjQXDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eD2N0U4eh0YpXpKw57+dGOg5H7yeKdRjDeL6fQtVUTCwTw8bUWNEFWWLt37kR2dbc
	 wKJEvhDZ4kcVoB+KHlbyduzmT0CwR3b22PFyNitYFOcRXpAJsdB1JzS9h6Th7c/veE
	 SGbEmq1HWJLDFVcHvCgF0xJaiWwslyK6eRCZU8dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgDFQM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgDFQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:12:24 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AA624942;
        Mon,  6 Apr 2020 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586189544;
        bh=GVYsMfinsR8g/zIfP0f+/JnCqupV0DlPI3YA/qjQXDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GR/zEuixadXHyK9EYI6p/14VWTYdRuxjwohtZp2qg156UQg20yk1N+EZ3DE5LtAVQ
         tNBGlDZBV9IfY7WcTHU1VoyjEdHtX91s1aprUJbW7ZnWDcpXI/2PxLLRDX3uRDmrq8
         6+Jb82i+rXAFL8lHmZmA4k7QBRi1LnPGe6Q6qnos=
Received: by mail-yb1-f176.google.com with SMTP id a5so127951ybo.7;
        Mon, 06 Apr 2020 09:12:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuYHGaRKLV3wNSouBwY/T6CXxknznsQeStJbO9yJ3+TtU2r6Y9cT
        vpoAk0mnNZDYlYyKVXKNM6fOsKMciA2++QtoQQ==
X-Google-Smtp-Source: APiQypIYwpnlMa5Ygcs/VtizsI4ZStmf0I0qUuQo8f6ibr2ljHP/sSlm07OxHpCgUGHI4QHbGPm2cFzN94YqXmtWAnU=
X-Received: by 2002:a25:b950:: with SMTP id s16mr35290019ybm.255.1586189543020;
 Mon, 06 Apr 2020 09:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200326213251.54457-1-aford173@gmail.com> <20200405012847.GA5234@bogus>
 <CAHCN7xLoGUSOMtMC+uHMNbA+5MGT0dzTrwbL8J0RSMjmQ7G59g@mail.gmail.com>
In-Reply-To: <CAHCN7xLoGUSOMtMC+uHMNbA+5MGT0dzTrwbL8J0RSMjmQ7G59g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Apr 2020 10:12:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2F3_QPEgG89X_nNgcUDW1Q8tSPBbqVr319T5N0bBiSw@mail.gmail.com>
Message-ID: <CAL_JsqL2F3_QPEgG89X_nNgcUDW1Q8tSPBbqVr319T5N0bBiSw@mail.gmail.com>
Subject: Re: [RFC] clk: vc5: Add bindings for output configurations
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Charles Stevens <charles.stevens@logicpd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 7:38 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Sat, Apr 4, 2020 at 8:28 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 26, 2020 at 04:32:51PM -0500, Adam Ford wrote:
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
> > >               - 5p49v5933 and
> > >               - 5p49v5935: (optional) property not present or "clkin".
> > >
> > > +For all output ports, an option child node can be used to specify:
> > > +
> > > +- mode: can be one of
> > > +               - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> > > +               - CMOS
> > > +               - HCSL
> > > +               - LVDS: Low voltage differential signal
> > > +
> > > +- voltage-level:  can be one of the following microvolts
> > > +               - 1800000
> > > +               - 2500000
> > > +               - 3300000
> > > +-  slew: Percent of normal, can be one of
> > > +               - P80
> > > +               - P85
> > > +               - P90
> > > +               - P100
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
> > > +
> > >  /* 25MHz reference crystal */
> > >  ref25: ref25m {
> > >       compatible = "fixed-clock";
> > > @@ -80,6 +101,13 @@ i2c-master-node {
> > >               /* Connect XIN input to 25MHz reference */
> > >               clocks = <&ref25m>;
> > >               clock-names = "xin";
> > > +
> > > +             ports@1 {
> >
> > 'ports' is already taken as a node name.
> Rob,
>
> The clock chip can drive multiple clocks and each output is
> independent of the rest.  The idea is that port@1 would represent
> output 1, port@2 would represent output 2, etc.
> Is there a name you'd think we should use to represent each output?

clock-output@...?

> Different variations of this chip can have different number of
> outputs.
>
> >
> > > +                     reg = <1>;
> >
> > What do the reg value signify?
>
> I am fine if we drop we drop it. I was under the assumption that reg
> =<1> had to correspond to the port@1 and that it was required since
> other devices with port sub-nodes use the reg entry.

I wasn't suggesting dropping it. Just what 0, 1, 2, etc. corresponds
to as you explained above. Just put that into the 'reg' description.

> > > +                     mode = <CMOS>;
> > > +                     pwr_sel = <1800000>;
> >
> > Not documented. Don't use '-' in property names.
>
> Do you have a preference to what name or convention you want us to use?

Errr, that was supposed to say '_'. Using hyphens is fine.

Also, needs a vendor prefix and if that's in microvolts needs a unit suffix.

Rob
