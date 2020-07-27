Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79714C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5909B20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="scf1g10G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgG0ORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbgG0ORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:17:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D622C061794;
        Mon, 27 Jul 2020 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bjl5+gq9U2Z2bSaiJfRP1zE+wAOWJevhrAxgUgYzigo=; b=scf1g10GNIN9R7N3bdXIm5T3X
        V8f6RnSM/4Xa9NqtWNHxFbujD3DawFPmJEdB5C+0xf/QAPOHOsbAVsy0lJnPB1QBEd633qDI+ASX1
        U2BvCGMKw5OL+Bn8VyhCXqKOjnxsoOl9q16TV9mYn+uTAStQNaJHeOrSRu9KoC/RmVTnlrnFHl3+3
        76hmuHXIOSDej96ZKbi0/+GxDswQdm4PLsUcFMOO0imklYud/ud8/7J9zrPKGJ4Z6nuMos5KuT8Gi
        EdoJyBJA/6npMLkE57eHlhGosxv68mTqP/rgd1RON+dMfXYJeqj0K0LLyowzgJ4hJlAVwyqjXylAI
        IWXbxI4xQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44830)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k03wa-0002xY-0h; Mon, 27 Jul 2020 15:17:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k03wX-0003ir-Gd; Mon, 27 Jul 2020 15:17:29 +0100
Date:   Mon, 27 Jul 2020 15:17:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sascha Hauer <kernel@pengutronix.de>, a.zummo@towertech.it,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727141729.GJ1551@shell.armlinux.org.uk>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <CABdtJHu2BacX+EeVkCxFYWfNxJ-7Z5MP7BqVfF2KHy+XfJGN3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdtJHu2BacX+EeVkCxFYWfNxJ-7Z5MP7BqVfF2KHy+XfJGN3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:33:17PM +0200, Jon Nettleton wrote:
> On Mon, Jul 27, 2020 at 11:46 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jul 23, 2020 at 09:57:55PM +0200, Alexandre Belloni wrote:
> > > On 23/07/2020 11:49:05-0600, Rob Herring wrote:
> > > > On Mon, Jul 20, 2020 at 12:23:59PM +0100, miguelborgesdefreitas@gmail.com wrote:
> > > > > From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > > >
> > > > > This adds direct-switching mode as a configurable DT flag for
> > > > > RTC modules supporting it (e.g. nxp pcf8523).
> > > > > DSM switches the power source to the battery supply whenever the
> > > > > VDD drops below VBAT. The option is recommended for hw designs
> > > > > where VDD is always expected to be higher than VBAT.
> > > > >
> > > > > Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Added extended commit message for git history
> > > > > - Separate dt bindings documentation into a single patch
> > > > >
> > > > >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
> > > > >  Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
> > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > index 0b1080c..f715a8f 100644
> > > > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > @@ -4,10 +4,14 @@ Required properties:
> > > > >  - compatible: Should contain "nxp,pcf8523".
> > > > >  - reg: I2C address for chip.
> > > > >
> > > > > -Optional property:
> > > > > +Optional properties:
> > > > >  - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> > > > >    expressed in femto Farad (fF). Valid values are 7000 and 12500.
> > > > >    Default value (if no value is specified) is 12500fF.
> > > > > +- pm-enable-dsm: battery switch-over function is enabled in direct
> > > > > +  switching mode. The power failure condition happens when VDD < VBAT,
> > > > > +  without requiring VDD to drop below Vth(sw)bat.
> > > > > +  Default value (if not provided) is the standard mode.
> > > > >
> > > > >  Example:
> > > > >
> > > > > @@ -15,4 +19,5 @@ pcf8523: rtc@68 {
> > > > >   compatible = "nxp,pcf8523";
> > > > >   reg = <0x68>;
> > > > >   quartz-load-femtofarads = <7000>;
> > > > > + pm-enable-dsm;
> > > > >  };
> > > > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > index ee237b2..a0048f4 100644
> > > > > --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > @@ -47,4 +47,11 @@ properties:
> > > > >      description:
> > > > >        Enables wake up of host system on alarm.
> > > > >
> > > > > +  pm-enable-dsm:
> > > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > > +    description:
> > > > > +      Enables the battery switch-over function in direct switching
> > > > > +      mode. Should be set in systems where VDD is higher than VBAT
> > > > > +      at all times.
> > > >
> > > > I'm all for common properties, but is this common across vendors?
> > > >
> > >
> > > This is but this shouldn't be a DT property as it has to be changed
> > > dynamically. I'm working on an ioctl interface to change this
> > > configuration.
> >
> > Why does it need to be changed dynamically?  If the hardware components
> > are not fitted to allow the RTC to be safely used without DSM, then
> > why should userspace be able to disable DSM?
> >
> 
> My presumption would be if you had a system that ran at different
> system voltages depending if it is plugged in to mains or running on a
> battery.

Yes, but we're not talking about that case with the Cubox-i.

Should a platform like the Cubox-i allow the user to disable DSM?

There needs to be a way to block the ability to dynamically change
this mode if the hardware is not up to operating without DSM.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
