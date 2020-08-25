Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348EC20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598338542;
	bh=O8xVWhecf0GTNNOQhzrq9+gFIK5wLyvxcyy2rCvFaVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OujEUHY9xdhCm8g/2t4bNYQkft8n9Q/wrDcLYLJfQ1hQ+Qc0nYWo2IGPiveXNlOp+
	 6w+KnNOwzWYOQ7d9254NXzB2vkg2qBu/JX5K1Q6RtAEIVz99si+/14pIeg3SiwXsui
	 PvnytvZFeJ3qanvybvZm+w87Quj9E8CbpHvWkPVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgHYGzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:55:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39147 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgHYGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:55:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id g75so1073879wme.4;
        Mon, 24 Aug 2020 23:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/BMEK5hdF0iweITjCzRL7tnq3hV766kEY/n/gaXN14=;
        b=WHzldN0LodFs4WwI1EiYmhb8ySSaSJGDjLsyILIAUtbX6NZUpj9poLC3tfs2etTU1Q
         0hsnnl3yyVRnIF7PTLAhkCU1IPDknPPnqS0xI1CVzTW6f3L7fuuP4SjAgRuJ8ys+utLz
         LQ/jZkZzIdcasBBm+uEB81qzz8wyYNj//OpKVLx1xj1jYq8H+PLusLAFFZnT97HrmFPb
         zuZn4EGWjX3IBiwgTS98GuMBBdWHsg1DGp3wh52fI/6X7etyyMVoRHYzjdgqLKiBxXFm
         rotwOddo+254em0OlKRjNYjVPgrrPqP8nAPVGD8OEM/pPjEfK9c0YAclcdoXOdr4UOZV
         z+HQ==
X-Gm-Message-State: AOAM530jjo0WCxiUtnSAhAoIJ3xEzC9FVl/q1kjrsaTR4JDZ8CizO7XU
        OOOtqtxyuybtlJPcUScePvY=
X-Google-Smtp-Source: ABdhPJzVthOSQHuBCkTElEnSeTuy6N11zAwWgCV1RLWESAC/VoowTAPU7THZp0e1uMR0gy8Ohekb8Q==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr547797wmd.67.1598338538029;
        Mon, 24 Aug 2020 23:55:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id z1sm11576477wru.6.2020.08.24.23.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 23:55:37 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:55:34 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
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
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 01/16] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock
 properties requirements
Message-ID: <20200825065534.GB3458@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <b75867fd1c662a83d933ae8f0c4373ba017eb808.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b75867fd1c662a83d933ae8f0c4373ba017eb808.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 06:23:36AM +0000, Vaittinen, Matti wrote:
> 
> Hello Krzysztof,
> 
> On Mon, 2020-08-24 at 21:06 +0200, Krzysztof Kozlowski wrote:
> > The input clock and number of clock provider cells are not required
> > for
> > the PMIC to operate.  They are needed only for the optional bd718x7
> > clock driver.
> 
> I have always found the DT bindings hard to do. I quite often end up
> having a different view with Rob so I probably could just shut-up and
> watch how this evolves :)
> 
> But as keeping my mouth is so difficult...
> 
> ...All of the drivers are optional. The PMIC can power-on without any
> drivers. Drivers are mostly used just for disabling the voltage from
> graphics accelerator block when it is not needed (optional). Or some
> DVS (optional). But yes, maybe the clk driver is "more optional" than
> the rest. XD So, I am not against this.

Each regulator node is optional, it can be skipped. And device will
work and regulator driver will bind. The difference here is that without
clocks the clock driver won't even bind... but if we keep clocks as
required, then multiple DTSes do not pass the bindings check.

I don't have strong feelings about dropping requirement for clocks, just
this looks easier to implement and logical to me (this is a PMIC so
clock is a secondary feature).

> 
> > Add also clock-output-names as driver takes use of it.
> > 
> > This fixes dtbs_check warnings like:
> > 
> >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b:
> > 'clocks' is a required property
> >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b:
> > '#clock-cells' is a required property
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml       | 9
> > +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-
> > pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-
> > pmic.yaml
> > index 77bcca2d414f..5d531051a153 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> > @@ -38,6 +38,9 @@ properties:
> >    "#clock-cells":
> >      const: 0
> >  
> > +  clock-output-names:
> > +    maxItems: 1
> 
> I had this in original binding (text) document patch series. For some
> reason it was later dropped. Unfortunately I didn't easily find a
> reason as to why. Adding it back now is absolutely fine for me though.
> 
> > +
> >  # The BD71847 abd BD71850 support two different HW states as reset
> > target
> >  # states. States are called as SNVS and READY. At READY state all
> > the PMIC
> >  # power outputs go down and OTP is reload. At the SNVS state all
> > other logic
> > @@ -116,12 +119,14 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > -  - clocks
> > -  - "#clock-cells"
> >    - regulators
> >  
> >  additionalProperties: false
> >  
> > +dependencies:
> > +  '#clock-cells': [clocks]
> > +  clocks: ['#clock-cells']
> 
> This is new to me. Please educate me - does this simply mean that if
> '#clock-cells' is given, then also the 'clocks' must be given - and the
> other way around?

Yes, because the clocks do not have sense without clock-cells and vice versa.

> 
> If so, then:
> Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 

Thanks.

Best regards,
Krzysztof
