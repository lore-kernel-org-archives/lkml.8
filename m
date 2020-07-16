Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2604C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6286A2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="oUJVxjzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgGPRau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:30:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:47818 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGPRat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594920646; bh=iYn8jfeBSAzwnJBKIEFCuqwW/wbz6/V7dqN/0Nu0G/s=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=oUJVxjzJH49f84omY00AR4pWkrwXTkWSauU2gxPhOyctei7hiQK1+jpn5hkLX5IzJ
         Emr1OPUlDE4jLdDJnedyHVcpy5JqlamZuVK6Wxb1phQVxmFdgJ1r61hDUrvDwrwMUC
         TrPU4fsdEnfGDu3iebz2PJqbMT7809X2egHRTFas=
Date:   Thu, 16 Jul 2020 19:30:46 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next 0/3] Add support for LEDs on Marvell
 PHYs
Message-ID: <20200716173046.aea5rsfe47vnamvh@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
References: <20200716171730.13227-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716171730.13227-1-marek.behun@nic.cz>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 16, 2020 at 07:17:27PM +0200, Marek Behún wrote:
> Hello,
> 
> this RFC series should apply on both net-next/master and Pavel's
> linux-leds/for-master tree.
> 
> This adds support for LED's connected to some Marvell PHYs.
> 
> LEDs are specified via device-tree. Example:
> 
> ethernet-phy@1 {
> 	reg = <1>;
> 
> 	leds {
> 		led@0 {
> 			reg = <0>;
> 			color = <LED_COLOR_ID_GREEN>;
> 			function = LED_FUNCTION_LINK;
> 			linux,default-trigger = "hw:1000/100/10/nolink";
> 		};
> 
> 		led@1 {
> 			reg = <1>;
> 			color = <LED_COLOR_ID_YELLOW>;
> 			function = LED_FUNCTION_ACTIVITY;
> 			linux,default-trigger = "hw:act/noact";
> 		};
> 	};
> };
> 
> Since Marvell PHYs can control the LEDs themselves in various modes,
> we need to be able to switch between them or disable them.
> 
> This is achieved by extending the LED trigger API with LED-private triggers.
> The proposal for this is based on work by Ondrej and Pavel, but after writing
> this support for Marvell PHYs I am not very happy how this turned out:
> - this LED-private triggers API works by registering triggers with specific
>   private trigger type. If this trigger type is defined for a trigger, only
>   those LEDs will be able to set this trigger which also have this trigger type.
>   (Both structs led_classdev and led_trigger have member trigger_type)
> - on Marvell PHYs each LED can have up to 8 different triggers
> - currently the driver supports up to 6 LEDs, since at least 88E1340 support
>   6 LEDs
> - almost every LED supports some mode which is not supported by at least one
>   other LED
> - this leads to the following dillema:
>   1. either we support one trigger type across the driver, but then the
>      /sys/class/leds/<LED>/trigger file will also list HW triggers not
>      supported by this specific LED,
>   2. or we add 6 trigger types, each different one LED, and register up to
>      8 HW triggers for each trigger type, which results in up to 48 triggers
>      per this driver.
>   In this proposal alternative 1 is taken and when unsupported HW trigger
>   is requested by writing to /sys/class/leds/<LED>/trigger file, the write
>   system call returns -EOPNOTSUPP.
> - therefore I think that this is not the correct way how to implement
>   LED-private triggers, and instead an approach as desribed in [1].
>   What do you people think?

This seems easily solvable by using sysfs attributes for specific hw mode
configuration.

This would result in having one private trigger registered with all the special
casing being done in your sysfs *_store/show functions that could be made per LED,
because sysfs functions get a reference to led_classdev.

You can then apply any kind of constraints fairly easily in sysfs interface
for your hw trigger.

See my driver: https://megous.com/git/linux/commit/?h=tbs-a711-5.8&id=a4da688b5d48011777d1e870a7d2b42edc9d144f

I guess unless you really want to have all possible configureations exposed
as differently named triggers via the led/trigger sysfs interface. But as you
see it makes things complicated.

regards,
	o.


> Marek
> 
> Marek Behún (3):
>   leds: trigger: add support for LED-private device triggers
>   leds: trigger: return error value if .activate() failed
>   net: phy: marvell: add support for PHY LEDs via LED class
> 
>  drivers/leds/led-triggers.c |  32 ++--
>  drivers/net/phy/Kconfig     |   7 +
>  drivers/net/phy/marvell.c   | 307 +++++++++++++++++++++++++++++++++++-
>  include/linux/leds.h        |  10 ++
>  4 files changed, 346 insertions(+), 10 deletions(-)
> 
> -- 
> 2.26.2
> 
