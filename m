Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00AC205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598341510;
	bh=wpcwA+cGlXKPbTWci3GgRf8sbZhaqgxIiZSuSQs8n0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vX5DSDNSLOcAdMQPuamvhXj1XNbhzI6O8vN+rmAwgaw018ZjhNlhKmRQy3ROMwppp
	 sP3WWyYFHH0NW1kJIg9PW0bD9VXg6AocxboMvhtZe8blr6vslGakgBnMZg9vkaMi1H
	 WJpMhYGZaAsUGvoJTEz27u43fZ7dqjpQK4Sx99Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHYHpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:45:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36971 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgHYHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:45:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id x9so1207253wmi.2;
        Tue, 25 Aug 2020 00:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxsmdDcFch7c22J7JxfwpI7tti1SyAdvo+8oYjg1+2I=;
        b=jRYVLUyrg5J8GFyxLM9vY+UymrAuJdGBi/6dsCoOZOwcgX3sNRutlOKXECX+ZHO4/r
         bV7yO5CB62IU02btiRHbAv/WAmsyED2sLIfp6nFCnQv6VgxecPZo1vebA2cbZ27lvpef
         Tqr+UWa1d6B3bbCnjaPfqr7GHuq0Pj7ZcoZD+y4HRYD9QYFZaPuBGQb9zCl5dSCQehKY
         NftbkVmIwtuUWvJ+Z/PfmVDBcwEB1c0OuuAcHeFT56iMiFXJrbnKN7h4ZOP7TLlocLMb
         fCzzgS2wMLtiqsZGW7ugKJZ3D/5mSrbHZ0kEWdXoM1kD1xln/HVaC/n8rNwzlddL5pKP
         b6bw==
X-Gm-Message-State: AOAM530lqHxxd4NVjywmXtp9TTr4wboTnysxVDaAQLDzbUFzt1kcav8v
        ixB6wqm3UQ6ga32xPjn/920=
X-Google-Smtp-Source: ABdhPJznfSTxJORBNcaOSIRYMPeV1drxg7rKMYcnYQCiCc89bTxVFyAryIoMQ5VngTiyECIcH0/2Yw==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr717799wme.43.1598341503219;
        Tue, 25 Aug 2020 00:45:03 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id h7sm4200304wmf.43.2020.08.25.00.45.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:45:02 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:45:00 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Message-ID: <20200825074500.GA19323@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
 <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
 <20200825072537.GA5914@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825072537.GA5914@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:25:37AM +0200, krzk@kernel.org wrote:
> On Tue, Aug 25, 2020 at 06:51:33AM +0000, Vaittinen, Matti wrote:
> > Hello Krzysztof,
> > 
> > Just some questions - please ignore if I misunderstood the impact of
> > the change.
> > 
> > On Mon, 2020-08-24 at 21:06 +0200, Krzysztof Kozlowski wrote:
> > > Device tree schema expects regulator names to be lowercase.  This
> > > fixes
> > > dtbs_check warnings like:
> > > 
> > >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b:
> > > regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 22 +++++++++------
> > > ----
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > index a1e5483dbbbe..299caed5d46e 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > @@ -60,7 +60,7 @@
> > >  
> > >  		regulators {
> > >  			buck1_reg: BUCK1 {
> > > -				regulator-name = "BUCK1";
> > > +				regulator-name = "buck1";
> > 
> > I am not against this change but I would expect seeing some other
> > patches too? I guess this will change the regulator name in regulator
> > core, right? So maybe I am mistaken but it looks to me this change is
> > visible in suppliers, sysfs and debugfs too? Thus changing this sounds
> > a bit like asking for a nose bleed :) Am I right that the impact of
> > this change has been thoroughly tested? Are there any other patches
> > (that I have not seen) related to this change?
> 
> Oh, crap, the names of regulators in the driver are lowercase, but they
> use of_match_ptr for upper case. Seriously, why making a binding which
> is contradictory to the driver implementation on the first day?
> 
> The driver goes with binding, right? One expects uppercase, other
> lowercase...
> 
> And tell me, what is now the ABI? The binding or the incorrect
> implementation?

Wait, my mistake. I got confused by my own change. The node name stays
the same, so of_match will be correct.

The driver internally already uses lowercase names.

Everything looks good. I will just double check whether the constraints
did not change on the board after boot.

> 
> > 
> > >  				regulator-min-microvolt = <700000>;
> > >  				regulator-max-microvolt = <1300000>;
> > >  				regulator-boot-on;
> > > @@ -69,7 +69,7 @@
> > >  			};
> > >  
> > >  			buck2_reg: BUCK2 {
> > > -				regulator-name = "BUCK2";
> > > +				regulator-name = "buck2";
> > >  				regulator-min-microvolt = <700000>;
> > >  				regulator-max-microvolt = <1300000>;
> > >  				regulator-boot-on;
> > > @@ -79,14 +79,14 @@
> > >  
> > >  			buck3_reg: BUCK3 {
> > >  				// BUCK5 in datasheet
> > > -				regulator-name = "BUCK3";
> > > +				regulator-name = "buck3";
> > >  				regulator-min-microvolt = <700000>;
> > >  				regulator-max-microvolt = <1350000>;
> > >  			};
> > >  
> > >  			buck4_reg: BUCK4 {
> > >  				// BUCK6 in datasheet
> > > -				regulator-name = "BUCK4";
> > > +				regulator-name = "buck4";
> > >  				regulator-min-microvolt = <3000000>;
> > >  				regulator-max-microvolt = <3300000>;
> > >  				regulator-boot-on;
> > > @@ -95,7 +95,7 @@
> > >  
> > >  			buck5_reg: BUCK5 {
> > >  				// BUCK7 in datasheet
> > > -				regulator-name = "BUCK5";
> > > +				regulator-name = "buck5";
> > 
> > What I see in bd718x7-regulator.c for LDO6 desc is:
> > 
> >                         /* LDO6 is supplied by buck5 */
> >                         .supply_name = "buck5",
> > 
> > So, is this change going to change the supply-chain for the board? Is
> > this intended? (Or am I mistaken on what is the impact of regulator-
> > name property?)

Good point, let me check the supplies.

> 
> The names will take regulator names from the driver. The problem is with
> matching the of_node.
> 
> 
> Dear Rob,
> 
> Maybe you have an idea how to fix this driver-binding ABI
> incompatibility? Or better just leave it?

Not valid anymore, I just got confused...

Best regards,
Krzysztof

