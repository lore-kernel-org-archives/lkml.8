Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F6C54FCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D92073C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4MMliW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCYCGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:06:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgCYCGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:06:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so865289wme.1;
        Tue, 24 Mar 2020 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vhj/cUOt8InHEY3y0xTMZDd+AyewRSpJhJ657Y+NLRk=;
        b=U4MMliW+TM5OMwqCr+1bcBsUNcIaeC4S0l3xOh7/7w0+jPIAJT7NhY9J7DVatUZxKS
         BAkc9krwUcEFSbhy4iSyCpkoqmx4s4GeNBSpzd4ifUO50iiQEA+Cef4GGFPs7MRTniUs
         aP0y8KCZvYJC2FNrEGZGgqSAaTJFzny7qXDA1zr/lVvr+Bpb8gCq7ITab4XLutSw5EeZ
         YL+zsZAS9K1GwQAr8UMsQ+pmU6tIGBaJCa4GYpdWwOPqALmFOEoc2BiJMguENx2Fhgrx
         W39IRZFl1R84rjBFpUykl8+dxcZCglQrDNNUYng1Wo5JoQjTO5g3xtrNMeumn9Ybk+7z
         3Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhj/cUOt8InHEY3y0xTMZDd+AyewRSpJhJ657Y+NLRk=;
        b=B1cu6VJapl8S7BV1ReiUr4IDhVJ8XwMtwgqXT33e2mchEHIUNaRehuGVw9r2WJ0jx/
         px2UYxWz1jlrc0jHpgga+VKgq6pLjhNz8ZXQFJcUWAiTo8/dhV44zvkKnCdVFeh1O+aT
         EZ0LCleugowl5h7hCw3Gc8NnoT/iL6CyVG/TPJK6chh0o5PweN6nDOuJy+83us/ohwhH
         s/Ei1+poI04QGiTdRIjaNUebyH69NM1ll8RiE1YxyGAoyWxK1qxPYdYzVibcOucJg1nr
         OZ9hE8ppXY7ea8NJtBU1V9SdCCTmOXWYdgGjtR3GR+GEmjyDK/LTGyfZhi20z3CPk7wR
         Zogg==
X-Gm-Message-State: ANhLgQ1Lw8pKcS/L5LVShrjMy4eCGIc6KACdRy7yPuGclmgKkk4oEe3b
        R9BO0iJthmpsON/TV+soevHbk3O2S6twoM0UdRc=
X-Google-Smtp-Source: ADFU+vuz+b9doeUll4/EOrh0cZv2Ww8hqQ6hUTWpfXwbj4Hl0/OAezNmgwgCu9VMn+yWVU4oKGKRu/k2E08UBdxDZ3M=
X-Received: by 2002:a1c:f615:: with SMTP id w21mr953078wmc.152.1585101969314;
 Tue, 24 Mar 2020 19:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072730.9193-1-zhang.lyra@gmail.com> <20200304072730.9193-4-zhang.lyra@gmail.com>
 <158475317083.125146.1467485980949213245@swboyd.mtv.corp.google.com>
 <CAAfSe-sQnZLn8J7Ct5OES=2PmT-nGT-_0zXxRaO=mcHVtgTcnQ@mail.gmail.com> <158510180797.125146.1966913179385526344@swboyd.mtv.corp.google.com>
In-Reply-To: <158510180797.125146.1966913179385526344@swboyd.mtv.corp.google.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 25 Mar 2020 10:05:33 +0800
Message-ID: <CAAfSe-s0gcehu0ZDj=FTe5S7CzAHC5mahXBH2fJm7mXS7Xys1Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 at 10:03, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2020-03-22 04:00:39)
> > Hi Stephen,
> >
> > On Sat, 21 Mar 2020 at 09:12, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Chunyan Zhang (2020-03-03 23:27:26)
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > add a new bindings to describe sc9863a clock compatible string.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > [...]
> > > > +examples:
> > > > +  - |
> > > > +    ap_clk: clock-controller@21500000 {
> > > > +      compatible = "sprd,sc9863a-ap-clk";
> > > > +      reg = <0 0x21500000 0 0x1000>;
> > > > +      clocks = <&ext_26m>, <&ext_32k>;
> > > > +      clock-names = "ext-26m", "ext-32k";
> > > > +      #clock-cells = <1>;
> > > > +    };
> > > > +
> > > > +  - |
> > > > +    soc {
> > > > +      #address-cells = <2>;
> > > > +      #size-cells = <2>;
> > > > +
> > > > +      ap_ahb_regs: syscon@20e00000 {
> > > > +        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> > > > +        reg = <0 0x20e00000 0 0x4000>;
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +        ranges = <0 0 0x20e00000 0x4000>;
> > > > +
> > > > +        apahb_gate: apahb-gate@0 {
> > >
> > > Why do we need a node per "clk type" in the simple-mfd syscon? Can't we
> > > register clks from the driver that matches the parent node and have that
> > > driver know what sorts of clks are where? Sorry I haven't read the rest
> > > of the patch series and I'm not aware if this came up before. If so,
> > > please put details about this in the commit text.
> >
> > Please see the change logs after v2 in cover-letter.
> >
> > Rob suggested us to put some clocks under syscon nodes, since these
> > clocks have the same
> > physical address base with the syscon;
>
> Ok. I'll apply the series to clk-next then.

Thank you.

Chunyan
