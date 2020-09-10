Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D34C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F422145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgIJOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:48:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55232 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbgIJOrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:47:10 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kGNqf-00E57e-Cn; Thu, 10 Sep 2020 16:46:53 +0200
Date:   Thu, 10 Sep 2020 16:46:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next + leds v2 6/7] net: phy: marvell: add support
 for LEDs controlled by Marvell PHYs
Message-ID: <20200910144653.GA3354160@lunn.ch>
References: <20200909162552.11032-1-marek.behun@nic.cz>
 <20200909162552.11032-7-marek.behun@nic.cz>
 <20200910122341.GC7907@duo.ucw.cz>
 <20200910131541.GD3316362@lunn.ch>
 <20200910161522.3cf3ad63@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910161522.3cf3ad63@dellmb.labs.office.nic.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Moreover I propose (and am willing to do) this:
>   Rewrite phy_led_trigger so that it registers one trigger, `phydev`.
>   The identifier of the PHY which should be source of the trigger can be
>   set via a separate sysfs file, `device_name`, like in netdev trigger.
>   The linked speed on which the trigger should light the LED will be
>   selected via sysfs file `mode` (or do you propose another name?
>   `trigger_on` or something?)
> 
>   Example:
>     # cd /sys/class/leds/<LED>
>     # echo phydev >trigger
>     # echo XYZ >device_name
>     # cat mode
>     1Gbps 100Mbps 10Mbps
>     # echo 1Gbps >mode
>     # cat mode
>     [1Gbps] 100Mbps 10Mbps
> 
>   Also the code should be moved from driver/net/phy to
>   drivers/leds/trigger.
> 
>   The old API can be declared deprecated or removed, but outright
>   removal may cause some people to complain.

This is ABI, so you cannot remove it, or change it. You can however
add to it, in a backwards compatible way.

    Andrew
