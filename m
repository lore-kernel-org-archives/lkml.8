Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B47C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F8F2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGWVfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:35:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52272 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgGWVfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:35:48 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jyisF-006aCj-2o; Thu, 23 Jul 2020 23:35:31 +0200
Date:   Thu, 23 Jul 2020 23:35:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v2 1/1] net: phy: marvell: add
 support for PHY LEDs via LED class
Message-ID: <20200723213531.GK1553578@lunn.ch>
References: <20200723181319.15988-1-marek.behun@nic.cz>
 <20200723181319.15988-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723181319.15988-2-marek.behun@nic.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:13:19PM +0200, Marek Behún wrote:
> This patch adds support for controlling the LEDs connected to several
> families of Marvell PHYs via Linux' LED API. These families are:
> 88E1112, 88E1121R, 88E1240, 88E1340S, 88E1510 and 88E1545. More can be
> added.
> 
> The code reads LEDs definitions from the device-tree node of the PHY.
> 
> Since the LEDs can be controlled by hardware, we add one LED-private LED
> trigger named "hw-control". This trigger is private and displayed only
> for Marvell PHY LEDs.
> 
> When this driver is activated, another sysfs file is created in that
> LEDs sysfs directory, names "hw_control". This file contains space
> separated list of possible HW controlled modes for this LED. The one
> which is selected is enclosed by square brackets. To change HW control
> mode the user has to write the name of desired mode to this "hw_control"
> file.
> 
> This patch does not yet add support for compound LED modes. This could
> be achieved via the LED multicolor framework (which is not yet in
> upstream).
> 
> Settings such as HW blink rate or pulse stretch duration are not yet
> supported, nor are LED polarity settings.

Hi Marek

I expect some of this should be moved into the phylib core. We don't
want each PHY inventing its own way to do this. The core should
provide a framework and the PHY driver fills in the gaps.

Take a look at for example mscc_main.c and its LED information. It has
pretty similar hardware to the Marvell. And microchip.c also has LED
handling, etc.

> +static int _marvell_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness,
> +				       bool check_trigger)

Please avoid _ functions. 

> +{
> +	struct phy_device *phydev = to_phy_device(cdev->dev->parent);
> +	struct marvell_phy_led *led = to_marvell_phy_led(cdev);
> +	u8 val;
> +
> +	/* don't do anything if HW control is enabled */
> +	if (check_trigger && cdev->trigger == &marvell_hw_led_trigger)
> +		return 0;

I thought the brightness file disappeared when a trigger takes
over. So is this possible?

      Andrew
