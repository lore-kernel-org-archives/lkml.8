Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43512C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16531206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598341849;
	bh=FYA3iXqGm68dq2/AIC2yAdRz4HmUkj2uRSXATXo7/rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=shOutMuUDd8zcIcXMHIymWUo3Pvyy5+yNVWkvvoF5fKu2KMAyEU8plTrZQRmqglJd
	 zr2hOrFJ7/Oz7OCvovM8yA7gle3a1iN2RGEEb+JCgCc0s06EmKvTWnQ2Pi3l3Wra8r
	 2wC0YCOFGfkxFlzsw1WiakEe8Dp3LT5SffWhgNCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgHYHur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:50:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:50:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so10902903wru.2;
        Tue, 25 Aug 2020 00:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDClTj1s5N+7to7OhV01SAjKraKRfpn6FyxoNR9IkEU=;
        b=bN5XDiUE4nUX3oPmRJkcEPxQdXjIOD0VRzGvRvbaqpjAmg4MCPDIvxLlf00nSEwsmm
         OpTWCpyaJVrxFt7Uphlub9Hn97Vp+WIi5wdFHX38mHW6tkzAba6Wa1Zp/b2JTqOhFw59
         +2KUxEwiAPsGj1EaUOSr9zEJhsUTnZwONavX4qxsRx8A+OG81t8WWou6ZMPinGUhD6Mu
         5biDDiHlm8ngOUfmYHqskIZopbgh/4nsbXGywSw3ylOlFxEVdDrYW12bOf+aCztZDlEV
         xyuAXnjKcXSY3K2zSAp0wn7NBmIJX5v6D5hBo1CpSyAP2SEBCoib05tVKyyF8S5ufjH0
         Ztig==
X-Gm-Message-State: AOAM531tFbMXON9O85VWXl4dgKbCWn3HDP2Zp1+rjMtLOutr9KlTr4oV
        vBHFUTs80Kk9yXh1/Qculn8=
X-Google-Smtp-Source: ABdhPJz4Djn1xXgFIG+eLnd2hHpypc7Vf0VfaQwoafVN0wzGR0eJoRGVKcMj9sJTv9d70FoXI70fpA==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr9269809wrv.127.1598341841452;
        Tue, 25 Aug 2020 00:50:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id v9sm17639149wru.37.2020.08.25.00.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:50:40 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:50:38 +0200
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
Message-ID: <20200825075038.GA10148@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
 <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
 <20200825072537.GA5914@kozik-lap>
 <20200825074500.GA19323@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825074500.GA19323@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:45:00AM +0200, krzk@kernel.org wrote:
> On Tue, Aug 25, 2020 at 09:25:37AM +0200, krzk@kernel.org wrote:
> > On Tue, Aug 25, 2020 at 06:51:33AM +0000, Vaittinen, Matti wrote:
> > > Hello Krzysztof,
> > > 
> > > Just some questions - please ignore if I misunderstood the impact of
> > > the change.
> > > 
> > > On Mon, 2020-08-24 at 21:06 +0200, Krzysztof Kozlowski wrote:
> > > > Device tree schema expects regulator names to be lowercase.  This
> > > > fixes
> > > > dtbs_check warnings like:
> > > > 
> > > >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b:
> > > > regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 22 +++++++++------
> > > > ----
> > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > index a1e5483dbbbe..299caed5d46e 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > @@ -60,7 +60,7 @@
> > > >  
> > > >  		regulators {
> > > >  			buck1_reg: BUCK1 {
> > > > -				regulator-name = "BUCK1";
> > > > +				regulator-name = "buck1";
> > > 
> > > I am not against this change but I would expect seeing some other
> > > patches too? I guess this will change the regulator name in regulator
> > > core, right? So maybe I am mistaken but it looks to me this change is
> > > visible in suppliers, sysfs and debugfs too? Thus changing this sounds
> > > a bit like asking for a nose bleed :) Am I right that the impact of
> > > this change has been thoroughly tested? Are there any other patches
> > > (that I have not seen) related to this change?
> > 
> > Oh, crap, the names of regulators in the driver are lowercase, but they
> > use of_match_ptr for upper case. Seriously, why making a binding which
> > is contradictory to the driver implementation on the first day?
> > 
> > The driver goes with binding, right? One expects uppercase, other
> > lowercase...
> > 
> > And tell me, what is now the ABI? The binding or the incorrect
> > implementation?
> 
> Wait, my mistake. I got confused by my own change. The node name stays
> the same, so of_match will be correct.
> 
> The driver internally already uses lowercase names.
> 
> Everything looks good. I will just double check whether the constraints
> did not change on the board after boot.

Constraints look good.

> 
> > 
> > > 
> > > >  				regulator-min-microvolt = <700000>;
> > > >  				regulator-max-microvolt = <1300000>;
> > > >  				regulator-boot-on;
> > > > @@ -69,7 +69,7 @@
> > > >  			};
> > > >  
> > > >  			buck2_reg: BUCK2 {
> > > > -				regulator-name = "BUCK2";
> > > > +				regulator-name = "buck2";
> > > >  				regulator-min-microvolt = <700000>;
> > > >  				regulator-max-microvolt = <1300000>;
> > > >  				regulator-boot-on;
> > > > @@ -79,14 +79,14 @@
> > > >  
> > > >  			buck3_reg: BUCK3 {
> > > >  				// BUCK5 in datasheet
> > > > -				regulator-name = "BUCK3";
> > > > +				regulator-name = "buck3";
> > > >  				regulator-min-microvolt = <700000>;
> > > >  				regulator-max-microvolt = <1350000>;
> > > >  			};
> > > >  
> > > >  			buck4_reg: BUCK4 {
> > > >  				// BUCK6 in datasheet
> > > > -				regulator-name = "BUCK4";
> > > > +				regulator-name = "buck4";
> > > >  				regulator-min-microvolt = <3000000>;
> > > >  				regulator-max-microvolt = <3300000>;
> > > >  				regulator-boot-on;
> > > > @@ -95,7 +95,7 @@
> > > >  
> > > >  			buck5_reg: BUCK5 {
> > > >  				// BUCK7 in datasheet
> > > > -				regulator-name = "BUCK5";
> > > > +				regulator-name = "buck5";
> > > 
> > > What I see in bd718x7-regulator.c for LDO6 desc is:
> > > 
> > >                         /* LDO6 is supplied by buck5 */
> > >                         .supply_name = "buck5",
> > > 
> > > So, is this change going to change the supply-chain for the board? Is
> > > this intended? (Or am I mistaken on what is the impact of regulator-
> > > name property?)
> 
> Good point, let me check the supplies.

This patch actually fixes the supplies which before were not working
because of case mismatch.

Before:

 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  4    5      0 unknown     0mV     0mA     0mV     0mV
    LDO6                          1    0      0 unknown  1200mV     0mA   900mV  1800mV
 BUCK1                            1    0      0 unknown   850mV     0mA   700mV  1300mV
 BUCK2                            2    1      0 unknown  1000mV     0mA   700mV  1300mV
    cpu0-cpu                      1                                 0mA  1000mV  1000mV
 BUCK3                            1    0      0 unknown   975mV     0mA   700mV  1350mV
 BUCK4                            1    0      0 unknown  3300mV     0mA  3000mV  3300mV
 BUCK5                            1    0      0 unknown  1800mV     0mA  1605mV  1995mV
 BUCK6                            1    0      0 unknown  1200mV     0mA   800mV  1400mV
 LDO1                             1    0      0 unknown  1800mV     0mA  1600mV  1900mV
 LDO2                             1    0      0 unknown   800mV     0mA   800mV   900mV
 LDO3                             1    0      0 unknown  1800mV     0mA  1800mV  3300mV
 LDO4                             1    0      0 unknown   900mV     0mA   900mV  1800mV
 ldo5                             1    4      0 unknown  1800mV     0mA  1800mV  1800mV



After:
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
buck1                            1    0      0 unknown   850mV     0mA   700mV  1300mV
 buck2                            2    1      0 unknown   850mV     0mA   700mV  1300mV
    cpu0-cpu                      1                                 0mA   850mV   850mV
 buck3                            1    0      0 unknown   975mV     0mA   700mV  1350mV
 buck4                            1    0      0 unknown  3300mV     0mA  3000mV  3300mV
 buck5                            2    1      0 unknown  1800mV     0mA  1605mV  1995mV
    ldo6                          1    0      0 unknown  1200mV     0mA   900mV  1800mV
 buck6                            1    0      0 unknown  1200mV     0mA   800mV  1400mV
 ldo1                             1    0      0 unknown  1800mV     0mA  1600mV  1900mV
 ldo2                             1    0      0 unknown   800mV     0mA   800mV   900mV
 ldo3                             1    0      0 unknown  1800mV     0mA  1800mV  3300mV
 ldo4                             1    0      0 unknown   900mV     0mA   900mV  1800mV
 ldo5                             0    0      0 unknown  3300mV     0mA     0mV     0mV

Best regards,
Krzysztof
