Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB2BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53609221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFTPkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:40:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50150 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgFTPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:40:11 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jmfbE-001PRD-2h; Sat, 20 Jun 2020 17:40:08 +0200
Date:   Sat, 20 Jun 2020 17:40:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        richardcochran@gmail.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com, foss@0leil.net
Subject: Re: [PATCH net-next v3 6/8] net: phy: mscc: timestamping and PHC
 support
Message-ID: <20200620154008.GO304147@lunn.ch>
References: <20200619122300.2510533-1-antoine.tenart@bootlin.com>
 <20200619122300.2510533-7-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619122300.2510533-7-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 02:22:58PM +0200, Antoine Tenart wrote:
> To get and set the PHC time, a GPIO has to be used and changes are only
> retrieved or committed when on a rising edge. The same GPIO is shared by
> all PHYs, so the granularity of the lock protecting it has to be
> different from the ones protecting the 1588 registers (the VSC8584 PHY
> has 2 1588 blocks, and a single load/save pin).

I guess you thought about this GPIO quite a bit.

It appears you have the mutex in the shared structure, but each PHY
has its own gpio_desc, even though it should be for the same GPIO? The
binding requires each PHY has the GPIO, even though it is the same
GPIO. And there does not appear to be any checking that each PHY
really does have the same GPIO.

Ideally there would be a section in DT for the package, and this GPIO
would be there. But i don't see an good way to do this.

This does not feel right to me, but i've no good idea how it can be
made better :-(

     Andrew
 
