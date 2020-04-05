Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082FC2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874D8206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHRT0D7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDEBi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:38:28 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45936 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgDEBi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:38:28 -0400
Received: by mail-il1-f195.google.com with SMTP id x16so11314515ilp.12;
        Sat, 04 Apr 2020 18:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh9zpylJzlWDVxe0NhErymJEwgRkNRnBRUgqFg4D0kw=;
        b=bHRT0D7xl4KLso6fT3W9GM+6sM/WVJvc+7au4NYzjD7ZT4i5eaRDaOK07So7BQ1ChB
         a0Igrh/z6iqj+q0my9BsOa8KF5FYDhJS/xOdLG6/cKS0JEhSNrCFsBt7nQidqrFgQr+Y
         CViuy2eshZ9VJWxyeiWd47fcxVaNwB0UiNj8dAz4MGktN7zxSZDRnB7wzVc1sECTSxGm
         9D+8E2bpEyMcIv6ZGC/teZWJeCsGbM+PJgAEcrtOvvrtj9gcSrCWmE3tteBcKB/wfeCN
         yr294/EaDV5YqSmLrq0W4rdSRQ+qbErwIyuNyuQhyUTx1LtI3PgvRv56pXV8xs6f9TTA
         Mb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh9zpylJzlWDVxe0NhErymJEwgRkNRnBRUgqFg4D0kw=;
        b=EwSBDmA8UpSQw8uPdrHryI1VkTstU2qRXJtk7QcdAbCjTYL8xVXwzULC6sYmLeCWYp
         jQ3gi40yTXaQARGCSBxMjtlK2TpGKcDp3dosHNVFpGsToSE1zsNILsSIu8TIuHZcBQHs
         dLxHqXZzcrS9oRO6mQTGKDc1l0IPeJ7al0y4u+yH9ro+86hSJd9FxYI23Vhl3f85XIea
         I73FnRJ/NwQ0Dp+oe46ZoK5E2IL2xBLKSD1Ko4yk8MctGzeqWVH1mC3q787vAgKX8o3a
         y3pMXr8zIw//Sb0pQ5e5TFpPpufy69pyaA0MFUk21QnEg01b8yGXavAkzAyfJjWOb7fd
         zhkQ==
X-Gm-Message-State: AGi0PubOwSRz77w+IHzfc/1XzHosrKyVn6Cx3SwRXcyCzS+1HVaoWDqL
        5YEkykF+H+3sdPTlynpUfjOj+KpPKGz5f4Oikpg=
X-Google-Smtp-Source: APiQypKP8pJNWAA8Ga4oZcUxieGSF1zYC+6BeM++CKdq038kwvsC2fC+xSMzJ87j0rz4ZUfBM0ORex1cQ2ziHZec9Oc=
X-Received: by 2002:a92:5dc7:: with SMTP id e68mr15684229ilg.205.1586050706698;
 Sat, 04 Apr 2020 18:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200326213251.54457-1-aford173@gmail.com> <20200405012847.GA5234@bogus>
In-Reply-To: <20200405012847.GA5234@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 4 Apr 2020 20:38:15 -0500
Message-ID: <CAHCN7xLoGUSOMtMC+uHMNbA+5MGT0dzTrwbL8J0RSMjmQ7G59g@mail.gmail.com>
Subject: Re: [RFC] clk: vc5: Add bindings for output configurations
To:     Rob Herring <robh@kernel.org>
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

On Sat, Apr 4, 2020 at 8:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 26, 2020 at 04:32:51PM -0500, Adam Ford wrote:
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
> >               - 5p49v5933 and
> >               - 5p49v5935: (optional) property not present or "clkin".
> >
> > +For all output ports, an option child node can be used to specify:
> > +
> > +- mode: can be one of
> > +               - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> > +               - CMOS
> > +               - HCSL
> > +               - LVDS: Low voltage differential signal
> > +
> > +- voltage-level:  can be one of the following microvolts
> > +               - 1800000
> > +               - 2500000
> > +               - 3300000
> > +-  slew: Percent of normal, can be one of
> > +               - P80
> > +               - P85
> > +               - P90
> > +               - P100
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
> > +
> >  /* 25MHz reference crystal */
> >  ref25: ref25m {
> >       compatible = "fixed-clock";
> > @@ -80,6 +101,13 @@ i2c-master-node {
> >               /* Connect XIN input to 25MHz reference */
> >               clocks = <&ref25m>;
> >               clock-names = "xin";
> > +
> > +             ports@1 {
>
> 'ports' is already taken as a node name.
Rob,

The clock chip can drive multiple clocks and each output is
independent of the rest.  The idea is that port@1 would represent
output 1, port@2 would represent output 2, etc.
Is there a name you'd think we should use to represent each output?
Different variations of this chip can have different number of
outputs.

>
> > +                     reg = <1>;
>
> What do the reg value signify?

I am fine if we drop we drop it. I was under the assumption that reg
=<1> had to correspond to the port@1 and that it was required since
other devices with port sub-nodes use the reg entry.

>
> > +                     mode = <CMOS>;
> > +                     pwr_sel = <1800000>;
>
> Not documented. Don't use '-' in property names.

Do you have a preference to what name or convention you want us to use?
>

Thanks for the review.


adam

> > +                     slew = <P80>;
> > +             };
> >       };
> >  };
> >
> > --
> > 2.25.1
> >
