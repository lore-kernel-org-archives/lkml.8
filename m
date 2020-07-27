Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B48A206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgG0PlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:41:11 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34315 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgG0PlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:41:08 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CA78DFF81B;
        Mon, 27 Jul 2020 15:41:04 +0000 (UTC)
Date:   Mon, 27 Jul 2020 17:41:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Rob Herring <robh@kernel.org>, miguelborgesdefreitas@gmail.com,
        a.zummo@towertech.it, baruch@tkos.co.il, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727154104.GE239143@piout.net>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727152439.GK1551@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2020 16:24:39+0100, Russell King - ARM Linux admin wrote:
> On Mon, Jul 27, 2020 at 04:49:38PM +0200, Alexandre Belloni wrote:
> > On 27/07/2020 10:45:53+0100, Russell King - ARM Linux admin wrote:
> > > > This is but this shouldn't be a DT property as it has to be changed
> > > > dynamically. I'm working on an ioctl interface to change this
> > > > configuration.
> > > 
> > > Why does it need to be changed dynamically?  If the hardware components
> > > are not fitted to allow the RTC to be safely used without DSM, then
> > > why should userspace be able to disable DSM?
> > 
> > For RTCs with a standby mode, you want to be able to return to standby
> > mode.
> > 
> > That would happen for example after factory flashing in that common use
> > case:
> >  - the board is manufactured
> >  - Vbackup is installed, the RTC switches to standby mode
> >  - the board is then booted to flash a system, Vprimary is now present,
> >    the RTC switches to DSM.
> > 
> > At this point, if the board is simply shut down, the RTC will start
> > draining Vbackup before leaving the factory. Instead, we want to be able
> > to return to standby mode until the final user switches the product on
> > for the first time.
> 
> I don't think you're understanding what's going on with this proposed
> patch.  The cubox-i does work today, and the RTC does survive most
> power-downs. There are situations where it doesn't.
> 
> So, let's take your process above.
> 
> - the board is manufactured
> - Vbackup is installed, the RTC switches to standby mode
> - the board is then booted to flash a system, Vprimary is now present
> - the board is powered down.  the RTC _might_ switch over to battery
>   if it notices the power failure in time, or it might not.  A random
>   sample of units leaving the factory have the RTC in standby mode.
>   Others are draining the battery.
> 
> I'm not saying what you propose isn't a good idea.  I'm questioning
> why we should expose this in the generic kernel on platforms where
> it's likely to end up with the RTC being corrupted.
> 

Note that I didn't say we should expose settings that are not working
but it is a different discussion. I was explaining why we need to be
able to change it dynamically.

> Now, I question your idea that units should leave the factory without
> the RTC being programmed.  We know that lovely systemd goes utterly
> bonkers if the system time is beyond INT_MAX.  If the RTC leaves
> standby mode containing a date which we translate beyond INT_MAX,
> systemd will refuse to boot the system, and the user will have no
> way to set the correct time.  The user returns the device to the
> supplier as faulty...

This is doesn't happen since v4.17.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
