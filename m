Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D700C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E41620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="aX50kRH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgG1PLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:11:31 -0400
Received: from mail.nic.cz ([217.31.204.67]:46602 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbgG1PLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:11:30 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 7261313FCD6;
        Tue, 28 Jul 2020 17:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1595949088; bh=7uovp5tiRjX0Q63trdBfxs/RHAlmPAqgR0xCiyLf3Cc=;
        h=Date:From:To;
        b=aX50kRH0WUaobGgSRxE97ikqg3Uj/nhtXx/hA2vDiK97ShqjTmkjcIGtC6L+hXe5o
         e3CXHVDS2R3QCYRBnnwOWy0juraKeg/k7aEw2wsprXz0pQepIN5pPdj1rUHiQ/R39K
         1tXQWpeoWvXe1nmXWD8TsdBaW5cB9Ihs4evn2Vdo=
Date:   Tue, 28 Jul 2020 17:11:28 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     netdev@vger.kernel.org
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?Q?Ond?= =?UTF-8?Q?=C5=99ej?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v4 1/2] net: phy: add API for LEDs
 controlled by PHY HW
Message-ID: <20200728171128.61c7193b@dellmb.labs.office.nic.cz>
In-Reply-To: <20200728150530.28827-2-marek.behun@nic.cz>
References: <20200728150530.28827-1-marek.behun@nic.cz>
        <20200728150530.28827-2-marek.behun@nic.cz>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 17:05:29 +0200
Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> @@ -736,6 +777,16 @@ struct phy_driver {
>  	int (*set_loopback)(struct phy_device *dev, bool enable);
>  	int (*get_sqi)(struct phy_device *dev);
>  	int (*get_sqi_max)(struct phy_device *dev);
> +
> +	/* PHY LED support */
> +	int (*led_init)(struct phy_device *dev, struct
> phy_device_led *led);
> +	int (*led_brightness_set)(struct phy_device *dev, struct
> phy_device_led *led,
> +				  enum led_brightness brightness);
> +	const char *(*led_iter_hw_mode)(struct phy_device *dev,
> struct phy_device_led *led,
> +					void **	iter);
> +	int (*led_set_hw_mode)(struct phy_device *dev, struct
> phy_device_led *led,
> +			       const char *mode);
> +	const char *(*led_get_hw_mode)(struct phy_device *dev,
> struct phy_device_led *led); };
>  #define to_phy_driver(d)
> container_of(to_mdio_common_driver(d),		\ struct
> phy_driver, mdiodrv)

The problem here is that the same code will have to be added to DSA
switch ops structure, which is not OK.

I wanted to put this into struct mdio_driver_common, so that all mdio
drivers would be able to have HW LEDs connected. But then I remembered
that not all DSA drivers are connected via MDIO, some are via SPI.

So maybe this could instead become part of LED API, instead of phydev
API. Structure
  struct hw_controlled_led
and
  struct hw_controlled_led_ops
could be offered by the LED API, which would also register the needed
trigger.

struct phydev, struct dsa_switch and other could then just contain
pointer to struct hw_controlled_led_ops...

Marek
