Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72CAC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C7C20708
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599643256;
	bh=DlA9S72+RxODfy/0PBwFbJslFddkMuCm1adp0wImsaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J6dtKXJYdwF5KB5281/0XvuYHMduo5NbvsbKEPguAVrBTLcVvizooBcI3vtTH9w7T
	 jzu0+OR6RajQQ1uTkgWwfiFr7se9LKJon8DoUYfpukFQLbZhbKnmo2JtQfuAguERia
	 tRJsRh6OhVdOrFmSaGKnyitTYG/Dt6rlpEfggtDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIIJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:20:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43396 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:20:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id n13so1886316edo.10;
        Wed, 09 Sep 2020 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNmAfjU4H8Zs5sT50QV1b9clmpM+rEqrxgMSd1310HY=;
        b=DLA3Vrq01UT2vsRpkdsbBH1ScpPCezhLJy8R0iucwWzvHO232sc4JrgI17NyaiILZW
         SlE9yesYUJwJmUGb9jzqjWQxkrVbPRy5FPy8cesarw+lFXqPXj5112jPohaAoUkbWdqp
         bzhZUMuimnjbBfD3zfwaKxQImKwVCEElsvQZoeiwdFOSSAt/2r//LbGKq28vZZLLDryB
         iHiCJacpKKdIB8B1oHM0ndwdKJDrXjQo36XTTnZhAT+Zw68YeIsMCOdISp6lPNmic8pV
         vlywY9GzgAWKxyhYAyc+RKkio+CT6MdSuLdWFM3hy6NvMr/7t/AHV/tJk1f128KaN1jl
         n0Vg==
X-Gm-Message-State: AOAM5325QuZpnTNH4h9koyPuGiwhfSZJj3foRZHBSPn0eKREf7VaoEnW
        k4/c41kaluMPsgtyZs/95aw=
X-Google-Smtp-Source: ABdhPJyvE1fotHFbZZdQmEQ+CwuYf7b6JGPrd//NJAWkJjBm7V86ddJ0cwro1l4DBy1w1oj1V485DQ==
X-Received: by 2002:a50:e70e:: with SMTP id a14mr3019138edn.93.1599643250032;
        Wed, 09 Sep 2020 02:20:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id r15sm1435034edv.94.2020.09.09.02.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 02:20:49 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:20:47 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "rjones@gateworks.com" <rjones@gateworks.com>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Message-ID: <20200909092047.GA4184@kozik-lap>
References: <20200908145900.4423-1-krzk@kernel.org>
 <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
 <20200909081716.GA11775@kozik-lap>
 <745c815f716fa8245f17cb2e189529e382df63da.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <745c815f716fa8245f17cb2e189529e382df63da.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:57:36AM +0000, Vaittinen, Matti wrote:
> Hello Krzysztof,
> 
> On Wed, 2020-09-09 at 10:17 +0200, krzk@kernel.org wrote:
> > On Wed, Sep 09, 2020 at 06:30:44AM +0000, Vaittinen, Matti wrote:
> > > On Tue, 2020-09-08 at 16:59 +0200, Krzysztof Kozlowski wrote:
> > > > GPIO_ACTIVE_x flags are not correct in the context of interrupt
> > > > flags.
> > > > These are simple defines so they could be used in DTS but they
> > > > will
> > > > not
> > > > have the same meaning:
> > > > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > > > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> > > > 
> > > > Correct the interrupt flags, assuming the author of the code
> > > > wanted
> > > > some
> > > > logical behavior behind the name "ACTIVE_xxx", this is:
> > > >   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > 
> > > For BD70528:
> > > Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > 
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/act8945a.txt          | 2
> > > > +-
> > > >  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3
> > > > ++-
> > > >  Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2
> > > > +-
> > > >  3 files changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-
> > > > pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-
> > > > pmic.txt
> > > > index c3c02ce73cde..386eec06cf08 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > > @@ -39,7 +39,7 @@ pmic: pmic@4b {
> > > >  	compatible = "rohm,bd70528";
> > > >  	reg = <0x4b>;
> > > >  	interrupt-parent = <&gpio1>;
> > > > -	interrupts = <29 GPIO_ACTIVE_LOW>;
> > > > +	interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> > > 
> > > This is how it should have been from the beginning :) Thanks!
> > 
> > I start to wonder now. It seems some boards do not configure a pull
> > up
> > there, so IRQ_TYPE_LEVEL_LOW is wrong - causes the line to stay in
> > low
> > state.  But actually this maybe is a problem of missing pull up, not
> > the
> > IRQ flag?
> 
> The BD70528 is designed so that it will use level active interrupts -
> and line is pulled down when IRQ is active. Thus the example should
> have IRQ_TYPE_LEVEL_LOW - and your fix is correct.
> 
> After that being said - I can't comment on actual board using BD70528
> (or other ROHM ICs) - even less I can comment boards using other ICs.
> 
> After that being said - it's not a rare mistake to configure level
> active IRQs to be triggered at edge - it actually works most of the
> time - untill they deadlock at the race of generating new IRQ between
> reading the status and acking the line... I've debugged way too many
> such cases...
> 
> Anyways, for BD70528 DTS example your fix looks correct. Thanks.

Thanks. I found this error in multiple DTS files - most probably a copy
paste from example or from evalkit (e.g. imx8mm-evk.dts). The trouble is
that I don't have the schematics for them and at least in one hardware
(Variscite VAR-SOM-MX8M which I am using) it looks like logic got
reversed...

Best regards,
Krzysztof

