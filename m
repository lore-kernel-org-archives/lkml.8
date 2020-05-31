Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E295C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B782076B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 15:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEaPgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 11:36:16 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:46746 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaPgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 11:36:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 45D7FFB03;
        Sun, 31 May 2020 17:36:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BPwWvG9Wfq8s; Sun, 31 May 2020 17:36:11 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 52F2944BF8; Sun, 31 May 2020 17:36:10 +0200 (CEST)
Date:   Sun, 31 May 2020 17:36:10 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        kernel@puri.sm, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, angus@akkea.ca,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: Add a device tree for the Librem5 phone
Message-ID: <20200531153610.GA9581@bogon.m.sigxcpu.org>
References: <20200514155737.12160-1-martin.kepplinger@puri.sm>
 <20200529162850.GC3709@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529162850.GC3709@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, May 29, 2020 at 06:28:50PM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> > 
> > Add a devicetree description for the Librem 5 phone. The early batches
> > that have been sold are supported as well as the mass-produced device
> > available later this year, see https://puri.sm/products/librem-5/
> > 
> > This boots to a working console with working WWAN modem, wifi usdhc,
> > IMU sensor device, proximity sensor, haptic motor, gpio keys, GNSS and LEDs.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> 
> > +		blue {
> > +			label = "phone:blue:front";
> > +			label = "phone:green:front";
> > +			label = "phone:red:front";
> 
> Droid 4 uses "status-led:{red,green,blue}". Could this use same
> naming?

Looking at leds-class.rst we don't have a useful devicename so
should that just be omitted and s.th. like

		label = "blue:status";
		label = "green:status";
		label = "red:status";

be used instead. If we want to map to current usage

		label = "blue:status";
		label = "green:boot";
		label = "red:charging";

would be even closer but since that is bound to change just going with
"status" would make sense.
Cheers,
 -- Guido


> 
> > +			label = "lm3560:flash";
> > +			label = "lm3560:torch";
> 
> This is one LED, right? I'm pretty sure we don't want lm3560 in the
> name... "main-camera:flash" would be better. Even better would be
> something that's already in use.
> 
> > +			label = "white:backlight_cluster";
> 
> Make this ":backlight", please. Again, we want something that's
> already used.
> 
> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


