Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA396C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DCA20936
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="S0pde+3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:08:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:42212 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCNIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593781721; bh=CYRY9AOPIP7htR7BCw4/gS8rxf6F0JzXOnAZZ9MMcRY=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=S0pde+3BRUgDE8vcKlpnV7Ut/H9JL6ZM8QM8bnr9Ge0k3kKbg4uKFIGIyNZbBxAsR
         Dzbjz0dOtgx5iGG3qofJT6NCG3Bz/KXq/rsoWqKvBKpdiy6o6ZE/3f8TpVLhZh3jpg
         ldpXigLPX9xPU7Bvuo+ln+6dna5w6q56hfh8CMlk=
Date:   Fri, 3 Jul 2020 15:08:41 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 2/2] arm64: dts: sun50i-a64-pinephone: Add touchscreen
 support
Message-ID: <20200703130841.3zqa5y4uazzl477z@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20200702081432.1727696-1-megous@megous.com>
 <20200702081432.1727696-3-megous@megous.com>
 <20200703121706.gf2yxfe7crleatlm@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703121706.gf2yxfe7crleatlm@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:17:06PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jul 02, 2020 at 10:14:32AM +0200, Ondrej Jirman wrote:
> > Pinephone has a Goodix GT917S capacitive touchscreen controller on
> > I2C0 bus. Add support for it.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index a89425ad3727..5c7386566053 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -121,6 +121,25 @@ &ehci1 {
> >  	status = "okay";
> >  };
> >  
> > +&i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins>;
> > +	status = "okay";
> 
> I didn't spot this earlier, but the pinctrl properties are already set
> in the DTSI. I've removed them while applying the patch.

Ah, right. Thank you very much. :)

regards,
	o.

> Thanks!
> Maxime


