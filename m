Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B92C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF932074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgG1Q2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:28:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60222 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbgG1Q2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:28:23 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k0SSe-007J8b-6l; Tue, 28 Jul 2020 18:28:16 +0200
Date:   Tue, 28 Jul 2020 18:28:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     netdev@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v4 1/2] net: phy: add API for LEDs
 controlled by PHY HW
Message-ID: <20200728162816.GK1705504@lunn.ch>
References: <20200728150530.28827-1-marek.behun@nic.cz>
 <20200728150530.28827-2-marek.behun@nic.cz>
 <20200728171128.61c7193b@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171128.61c7193b@dellmb.labs.office.nic.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -736,6 +777,16 @@ struct phy_driver {
> >  	int (*set_loopback)(struct phy_device *dev, bool enable);
> >  	int (*get_sqi)(struct phy_device *dev);
> >  	int (*get_sqi_max)(struct phy_device *dev);
> > +
> > +	/* PHY LED support */
> > +	int (*led_init)(struct phy_device *dev, struct
> > phy_device_led *led);
> > +	int (*led_brightness_set)(struct phy_device *dev, struct
> > phy_device_led *led,
> > +				  enum led_brightness brightness);
> > +	const char *(*led_iter_hw_mode)(struct phy_device *dev,
> > struct phy_device_led *led,
> > +					void **	iter);
> > +	int (*led_set_hw_mode)(struct phy_device *dev, struct
> > phy_device_led *led,
> > +			       const char *mode);
> > +	const char *(*led_get_hw_mode)(struct phy_device *dev,
> > struct phy_device_led *led); };
> >  #define to_phy_driver(d)
> > container_of(to_mdio_common_driver(d),		\ struct
> > phy_driver, mdiodrv)
> 
> The problem here is that the same code will have to be added to DSA
> switch ops structure, which is not OK.

Not necessarily. DSA drivers do have access to the phydev structure.

I think putting these members into a structure is a good idea. That
structure can be part of phy_driver and initialised just like other
members. But on probing the phy, it can be copied over to the
phy_device structure. And we can provide an API which DSA drivers can
use to register there own structure of ops to be placed into
phy_device, which would call into the DSA driver.

      Andrew
