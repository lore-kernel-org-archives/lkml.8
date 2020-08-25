Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80752067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598344066;
	bh=zH6zAmWNDQeYfmc7483mMPTMv/VHesfHdcXgdnmbnQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lK/AsitUd5IJtAbVN7+hbNkq59kC6bvFQVDYzbbFoLjPEF8PtljRPpR5luyOxx3yy
	 rocaPwcefWz5EkMgskC1YaMoy6Z1kOo9s1S2IwzZn+B4zclh+4/PklN9X5g6J5cSLB
	 OMyqLty1OLo8YSruDiRajwKbOkL2FJMaUa8XHdQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgHYI1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:27:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44846 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:27:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so11767492wrs.11;
        Tue, 25 Aug 2020 01:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzk/j/h+CHtoBs7WU3yHntrC0qxaCXjR1fH0V9/5Wm0=;
        b=DZL+KcvpoM/+Y/WnqDYa85m4bcSBwBr6b9nWg+yn6fBIorMq4AuSFxEG4/pimIR/Fi
         8Drfv0QM0Cmf9t1CSYbRc1n23cBdNQzf6OcOY8cE1THk5ybbaqxeT8PD5Nkm6sUW8ZEW
         eutldPLMypg+5bhPOjIQddBzahUvqqhDuSIJ9I7/kULZHiNEje/Ryt+A+Udbw5wFH/n6
         FqyO/B/JpLF03E25RocRZl+Mc/CTzbr4O72TXvghAHBMe/1pG7G8QyIv6eg8I2V08dBP
         6xeHnHEVhiVB4ADp274hxArcNquOQtjPYQ2vciJu+yqkYfBAKOX3P8lizpUmdbrQG/FO
         liOg==
X-Gm-Message-State: AOAM530+JLXkIzrrkYvTi0UvPDX6PyON6KDR7CkxF6+AD6ruqnQSGBqH
        ayG4/Dr0SttXekCVWF6DO1w=
X-Google-Smtp-Source: ABdhPJxoCLkqGyzs6q1pxiVhqlA//hTKc1KXeM8kVomdEA7+mejtIoNtD/2dCQpKDs0/FIJo591YTA==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr4003367wrn.60.1598344060504;
        Tue, 25 Aug 2020 01:27:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id a85sm4713802wmd.26.2020.08.25.01.27.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 01:27:39 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:27:37 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Message-ID: <20200825082737.GA12902@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
 <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
 <20200825072537.GA5914@kozik-lap>
 <20200825074500.GA19323@kozik-lap>
 <20200825075038.GA10148@kozik-lap>
 <3018d638b5753e629ebdb6a25973aeff7e446720.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3018d638b5753e629ebdb6a25973aeff7e446720.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:22:18AM +0000, Vaittinen, Matti wrote:
> Hello Krzysztof,
> 
> On Tue, 2020-08-25 at 09:50 +0200, krzk@kernel.org wrote:
> > On Tue, Aug 25, 2020 at 09:45:00AM +0200, krzk@kernel.org wrote:
> > > On Tue, Aug 25, 2020 at 09:25:37AM +0200, krzk@kernel.org wrote:
> > > > On Tue, Aug 25, 2020 at 06:51:33AM +0000, Vaittinen, Matti wrote:
> > > > > Hello Krzysztof,
> > > > > 
> > > > > Just some questions - please ignore if I misunderstood the
> > > > > impact of
> > > > > the change.
> > > > > 
> > > > > On Mon, 2020-08-24 at 21:06 +0200, Krzysztof Kozlowski wrote:
> > > > > > Device tree schema expects regulator names to be
> > > > > > lowercase.  This
> > > > > > fixes
> > > > > > dtbs_check warnings like:
> > > > > > 
> > > > > >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: 
> > > > > > pmic@4b:
> > > > > > regulators:LDO1:regulator-name:0: 'LDO1' does not match
> > > > > > '^ldo[1-6]$'
> > > > > > 
> > > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > > ---
> > > > > >  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 22
> > > > > > +++++++++------
> > > > > > ----
> > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-
> > > > > > evk.dts
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > > > index a1e5483dbbbe..299caed5d46e 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > > > > > @@ -60,7 +60,7 @@
> > > > > >  
> > > > > >  		regulators {
> > > > > >  			buck1_reg: BUCK1 {
> > > > > > -				regulator-name = "BUCK1";
> > > > > > +				regulator-name = "buck1";
> > > > > 
> > > > > I am not against this change but I would expect seeing some
> > > > > other
> > > > > patches too? I guess this will change the regulator name in
> > > > > regulator
> > > > > core, right? So maybe I am mistaken but it looks to me this
> > > > > change is
> > > > > visible in suppliers, sysfs and debugfs too? Thus changing this
> > > > > sounds
> > > > > a bit like asking for a nose bleed :) Am I right that the
> > > > > impact of
> > > > > this change has been thoroughly tested? Are there any other
> > > > > patches
> > > > > (that I have not seen) related to this change?
> > > > 
> > > > Oh, crap, the names of regulators in the driver are lowercase,
> > > > but they
> > > > use of_match_ptr for upper case. Seriously, why making a binding
> > > > which
> > > > is contradictory to the driver implementation on the first day?
> > > > 
> > > > The driver goes with binding, right? One expects uppercase, other
> > > > lowercase...
> > > > 
> > > > And tell me, what is now the ABI? The binding or the incorrect
> > > > implementation?
> > > 
> > > Wait, my mistake. I got confused by my own change. The node name
> > > stays
> > > the same, so of_match will be correct.
> 
> Yes. I think so too. Match will still work as earler.
> 
> > > 
> > > The driver internally already uses lowercase names.
> 
> Yep. I was simply thinking that if anyone has been specifying the
> regulators as suppliers by name - then this change will change things
> (as is seen for LDO5). Additionally, if any user-space SW has been
> reading the regulator states from sysfs - then these names will also
> change the sysfs. Debugfs change is hopefully not such a big deal.

About user-space, I think the embedded DT is not part of kernel ABI, so
there is no such requirement about keeping it stable. I agree though it
might be annoying surprise.

> 
> Whether this really breaks anything is beyond my knowledge as I don't
> even have this board. Anyways, I think that by minimum the commit
> message should point out that this change will be visible outside DTS
> and the BD718x7 driver - up to the user-space.

Good point, I will extend the commit msg about possible impact and
fixing supplies.

> 
> > > 
> > > Everything looks good. I will just double check whether the
> > > constraints
> > > did not change on the board after boot.
> > 
> > Constraints look good.
> > 
> > > > > >  				regulator-min-microvolt =
> > > > > > <700000>;
> > > > > >  				regulator-max-microvolt =
> > > > > > <1300000>;
> > > > > >  				regulator-boot-on;
> > > > > > @@ -69,7 +69,7 @@
> > > > > >  			};
> > > > > >  
> > > > > >  			buck2_reg: BUCK2 {
> > > > > > -				regulator-name = "BUCK2";
> > > > > > +				regulator-name = "buck2";
> > > > > >  				regulator-min-microvolt =
> > > > > > <700000>;
> > > > > >  				regulator-max-microvolt =
> > > > > > <1300000>;
> > > > > >  				regulator-boot-on;
> > > > > > @@ -79,14 +79,14 @@
> > > > > >  
> > > > > >  			buck3_reg: BUCK3 {
> > > > > >  				// BUCK5 in datasheet
> > > > > > -				regulator-name = "BUCK3";
> > > > > > +				regulator-name = "buck3";
> > > > > >  				regulator-min-microvolt =
> > > > > > <700000>;
> > > > > >  				regulator-max-microvolt =
> > > > > > <1350000>;
> > > > > >  			};
> > > > > >  
> > > > > >  			buck4_reg: BUCK4 {
> > > > > >  				// BUCK6 in datasheet
> > > > > > -				regulator-name = "BUCK4";
> > > > > > +				regulator-name = "buck4";
> > > > > >  				regulator-min-microvolt =
> > > > > > <3000000>;
> > > > > >  				regulator-max-microvolt =
> > > > > > <3300000>;
> > > > > >  				regulator-boot-on;
> > > > > > @@ -95,7 +95,7 @@
> > > > > >  
> > > > > >  			buck5_reg: BUCK5 {
> > > > > >  				// BUCK7 in datasheet
> > > > > > -				regulator-name = "BUCK5";
> > > > > > +				regulator-name = "buck5";
> > > > > 
> > > > > What I see in bd718x7-regulator.c for LDO6 desc is:
> > > > > 
> > > > >                         /* LDO6 is supplied by buck5 */
> > > > >                         .supply_name = "buck5",
> > > > > 
> > > > > So, is this change going to change the supply-chain for the
> > > > > board? Is
> > > > > this intended? (Or am I mistaken on what is the impact of
> > > > > regulator-
> > > > > name property?)
> > > 
> > > Good point, let me check the supplies.
> > 
> > This patch actually fixes the supplies which before were not working
> > because of case mismatch.
> > Before:
> > 
> >  regulator                      use open bypass  opmode voltage
> > current     min     max
> > -------------------------------------------------------------------
> > --------------------
> >  regulator-dummy                  4    5      0
> > unknown     0mV     0mA     0mV     0mV
> >     LDO6                          1    0      0
> > unknown  1200mV     0mA   900mV  1800mV
> >  BUCK1                            1    0      0
> > unknown   850mV     0mA   700mV  1300mV
> >  BUCK2                            2    1      0
> > unknown  1000mV     0mA   700mV  1300mV
> >     cpu0-
> > cpu                      1                                 0mA  1000m
> > V  1000mV
> >  BUCK3                            1    0      0
> > unknown   975mV     0mA   700mV  1350mV
> >  BUCK4                            1    0      0
> > unknown  3300mV     0mA  3000mV  3300mV
> >  BUCK5                            1    0      0
> > unknown  1800mV     0mA  1605mV  1995mV
> >  BUCK6                            1    0      0
> > unknown  1200mV     0mA   800mV  1400mV
> >  LDO1                             1    0      0
> > unknown  1800mV     0mA  1600mV  1900mV
> >  LDO2                             1    0      0
> > unknown   800mV     0mA   800mV   900mV
> >  LDO3                             1    0      0
> > unknown  1800mV     0mA  1800mV  3300mV
> >  LDO4                             1    0      0
> > unknown   900mV     0mA   900mV  1800mV
> >  ldo5                             1    4      0
> > unknown  1800mV     0mA  1800mV  1800mV
> > 
> > 
> > 
> > After:
> >  regulator                      use open bypass  opmode voltage
> > current     min     max
> > -------------------------------------------------------------------
> > --------------------
> > buck1                            1    0      0
> > unknown   850mV     0mA   700mV  1300mV
> >  buck2                            2    1      0
> > unknown   850mV     0mA   700mV  1300mV
> >     cpu0-
> > cpu                      1                                 0mA   850m
> > V   850mV
> >  buck3                            1    0      0
> > unknown   975mV     0mA   700mV  1350mV
> >  buck4                            1    0      0
> > unknown  3300mV     0mA  3000mV  3300mV
> >  buck5                            2    1      0
> > unknown  1800mV     0mA  1605mV  1995mV
> >     ldo6                          1    0      0 
> 
> That was my point :) Before this commit the system has acted
> differently - either by accident or by purpose. In any case, the DTS
> change will change supply logic and this should probably be mentioned
> in commit log to help bisecting possible issues :)
> 
> But as I said, I am not opposed to this change - I am merely somewhat
> cautious with changes like this.

Thanks for the hints.

Best regards,
Krzysztof

