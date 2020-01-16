Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6920EC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4AC2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgAPQrS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:47:18 -0500
Received: from mailoutvs28.siol.net ([185.57.226.219]:60633 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729878AbgAPQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3256D522C71;
        Thu, 16 Jan 2020 17:47:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yW5AjuuxMjwE; Thu, 16 Jan 2020 17:47:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C28C9523561;
        Thu, 16 Jan 2020 17:47:12 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 66D88522C71;
        Thu, 16 Jan 2020 17:47:12 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Use internal oscillator
Date:   Thu, 16 Jan 2020 17:47:12 +0100
Message-ID: <20509747.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20200116080652.mp5z7dtrtj3nyhpq@gilmour.lan>
References: <20200113180720.77461-1-jernej.skrabec@siol.net> <20200116080652.mp5z7dtrtj3nyhpq@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 16. januar 2020 ob 09:06:52 CET je Maxime Ripard napisal(a):
> Hi Jernej,
> 
> On Mon, Jan 13, 2020 at 07:07:20PM +0100, Jernej Skrabec wrote:
> > Tanix TX6 doesn't have external 32 kHz oscillator, so switch RTC clock
> > to internal one.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> > While this patch gives one possible solution, I mainly want to start
> > discussion why Allwinner SoC dtsi reference external 32 kHz crystal
> > although some boards don't have it. My proposal would be to make clock
> > property optional, based on the fact if external crystal is present or
> > not. However, I'm not sure if that is possible at this point or not.
> 
> It's probably a bit of a dumb question but.. are you sure the crystal
> is missing?

Although I don't have schematic, I'm pretty sure. Without this patch or one at 
[1], RTC gives a lot of errors in dmesg. I think that unpopulated XC2 pads 
near SoC (see [2]) are probably reserved for crystal.

With patch in [1], which enables automatic switching in case of error, I saw 
that on this box RTC always switched to internal RC.

> 
> The H6 datasheet mentions that the 32kHz crystal needs to be there,
> and it's part of the power sequence, so I'd expect all boards to have
> it.

Can you be more specific where it is stated that crystal is mandatory? 

Note that schematic of some boards, like OrangePi PC2 (H5) or OrangePi Zero 
(H3) don't even have 32K crystal in them.

> 
> > Driver also considers missing clock property as deprecated (old DT) [1],
> > so this might complicate things even further.
> > 
> > What do you think?
> 
> I'm pretty sure (but that would need to be checked) that we never got
> a node without the clocks property on the H6. If that's the case, then
> we can add a check on the compatible.

Yes, that would be nice solution. I can work something out if you agree that 
this is the way.

> 
> > Best regards,
> > Jernej
> > 
> > [1]
> > https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-sun6i.c#L2
> > 63> 
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts index
> > 83e6cb0e59ce..af3aebda47bb 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > @@ -91,6 +91,12 @@ &r_ir {
> > 
> >  	status = "okay";
> >  
> >  };
> > 
> > +/* This board doesn't have external 32 kHz crystal. */
> > +&rtc {
> > +	assigned-clocks = <&rtc 0>;
> > +	assigned-clock-parents = <&rtc 2>;
> > +};
> > +
> 
> This should be dealt with in the driver however.

Sure, it is something to start discussion, I don't like tackling clocks in DT 
either.

Best regards,
Jernej

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Allwinner/
devices/H6/patches/linux/15-RTC-workaround.patch
[2] http://linux-sunxi.org/images/2/2e/Tanix_tx6_pcb_top.png




