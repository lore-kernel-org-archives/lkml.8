Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A84C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C97C207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGWT6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:58:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51549 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:58:01 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EE163E0005;
        Thu, 23 Jul 2020 19:57:55 +0000 (UTC)
Date:   Thu, 23 Jul 2020 21:57:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     miguelborgesdefreitas@gmail.com, a.zummo@towertech.it,
        baruch@tkos.co.il, linux@armlinux.org.uk, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200723195755.GV3428@piout.net>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723174905.GA596242@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2020 11:49:05-0600, Rob Herring wrote:
> On Mon, Jul 20, 2020 at 12:23:59PM +0100, miguelborgesdefreitas@gmail.com wrote:
> > From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > 
> > This adds direct-switching mode as a configurable DT flag for
> > RTC modules supporting it (e.g. nxp pcf8523).
> > DSM switches the power source to the battery supply whenever the
> > VDD drops below VBAT. The option is recommended for hw designs
> > where VDD is always expected to be higher than VBAT.
> > 
> > Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > ---
> > Changes in v2:
> > - Added extended commit message for git history
> > - Separate dt bindings documentation into a single patch
> > 
> >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
> >  Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > index 0b1080c..f715a8f 100644
> > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > @@ -4,10 +4,14 @@ Required properties:
> >  - compatible: Should contain "nxp,pcf8523".
> >  - reg: I2C address for chip.
> >  
> > -Optional property:
> > +Optional properties:
> >  - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> >    expressed in femto Farad (fF). Valid values are 7000 and 12500.
> >    Default value (if no value is specified) is 12500fF.
> > +- pm-enable-dsm: battery switch-over function is enabled in direct
> > +  switching mode. The power failure condition happens when VDD < VBAT,
> > +  without requiring VDD to drop below Vth(sw)bat.
> > +  Default value (if not provided) is the standard mode.
> >  
> >  Example:
> >  
> > @@ -15,4 +19,5 @@ pcf8523: rtc@68 {
> >  	compatible = "nxp,pcf8523";
> >  	reg = <0x68>;
> >  	quartz-load-femtofarads = <7000>;
> > +	pm-enable-dsm;
> >  };
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > index ee237b2..a0048f4 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > @@ -47,4 +47,11 @@ properties:
> >      description:
> >        Enables wake up of host system on alarm.
> >  
> > +  pm-enable-dsm:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Enables the battery switch-over function in direct switching
> > +      mode. Should be set in systems where VDD is higher than VBAT
> > +      at all times.
> 
> I'm all for common properties, but is this common across vendors?
> 

This is but this shouldn't be a DT property as it has to be changed
dynamically. I'm working on an ioctl interface to change this
configuration.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
