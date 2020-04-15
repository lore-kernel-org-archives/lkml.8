Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7B20767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370710AbgDONhz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636175AbgDONhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:37:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:37:39 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOiEN-0002og-3x; Wed, 15 Apr 2020 15:37:31 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jOiEK-0006aW-Fd; Wed, 15 Apr 2020 15:37:28 +0200
Date:   Wed, 15 Apr 2020 15:37:28 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de
Subject: Re: [PATCH v1] ethtool: provide UAPI for PHY master/slave
 configuration.
Message-ID: <20200415133728.urvsdolwhaa4eknm@pengutronix.de>
References: <20200415121209.12197-1-o.rempel@pengutronix.de>
 <20200415131104.GA657811@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200415131104.GA657811@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:23:06 up 152 days,  4:41, 170 users,  load average: 0.02, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 03:11:04PM +0200, Andrew Lunn wrote:
> On Wed, Apr 15, 2020 at 02:12:09PM +0200, Oleksij Rempel wrote:
> > This UAPI is needed for BroadR-Reach 100BASE-T1 devices. Due to lack of
> > auto-negotiation support, we needed to be able to configure the
> > MASTER-SLAVE role of the port manually or from an application in user
> > space.
> 
> Hi Oleksij
> 
> This is a nice way to do this.
> 
> > +/* Port mode */
> > +#define PORT_MODE_MASTER	0x00
> > +#define PORT_MODE_SLAVE		0x01
> > +#define PORT_MODE_MASTER_FORCE	0x02
> > +#define PORT_MODE_SLAVE_FORCE	0x03
> > +#define PORT_MODE_UNKNOWN	0xff
> 
> It is not clear to me what PORT_MODE_MASTER and PORT_MODE_SLAVE. Do
> these mean to negotiate master/slave? Maybe some comments, or clearer
> names?

In the IEEE 802.3 it is described as:
---------------------------------------------------------------------------
Port type: Bit 9.10 is to be used to indicate the preference to operate
as MASTER (multiport device) or as SLAVE (single-port device) if the
MASTER-SLAVE Manual Configuration Enable bit, 9.12, is not set.  Usage
of this bit is described in 40.5.2.
1 = Multiport device
0 = single-port device
---------------------------------------------------------------------------

Setting PORT_MODE_MASTER/PORT_MODE_SLAVE will increase the chance to get
MASTER or SLAVE mode, but not force it.

If we will follow strictly to the IEEE 802.3 spec, it should be named:

#define PORT_MODE_UNKNOWN	0x00
/* this two options will not force some specific mode, only influence
 * the chance to get it */
#define PORT_TYPE_MULTI_PORT	0x01
#define PORT_TYPE_SINGLE_PORT	0x02
/* this two options will force master or slave mode */
#define PORT_MODE_MASTER	0x03
#define PORT_MODE_SLAVE		0x04

Please tell, if you have better ideas.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
