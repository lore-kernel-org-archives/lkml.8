Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1391AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9B520760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFJG0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:26:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81500C03E96F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 23:26:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jiuBa-0001kT-Nz; Wed, 10 Jun 2020 08:26:06 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jiuBa-000441-6b; Wed, 10 Jun 2020 08:26:06 +0200
Date:   Wed, 10 Jun 2020 08:26:06 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] net: mvneta: Fix Serdes configuration for 2.5Gbps modes
Message-ID: <20200610062606.GM11869@pengutronix.de>
References: <20200609131152.22836-1-s.hauer@pengutronix.de>
 <20200609132848.GA1076317@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609132848.GA1076317@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:15:33 up 111 days, 13:46, 104 users,  load average: 0.37, 0.22,
 0.22
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

+Cc Maxime Chevallier

On Tue, Jun 09, 2020 at 03:28:48PM +0200, Andrew Lunn wrote:
> On Tue, Jun 09, 2020 at 03:11:52PM +0200, Sascha Hauer wrote:
> > The Marvell MVNETA Ethernet controller supports a 2.5Gbps SGMII mode
> > called DRSGMII. Depending on the Port MAC Control Register0 PortType
> > setting this seems to be either an overclocked SGMII mode or 2500BaseX.
> > 
> > This patch adds the necessary Serdes Configuration setting for the
> > 2.5Gbps modes. There is no phy interface mode define for overclocked
> > SGMII, so only 2500BaseX is handled for now.
> > 
> > As phy_interface_mode_is_8023z() returns true for both
> > PHY_INTERFACE_MODE_1000BASEX and PHY_INTERFACE_MODE_2500BASEX we
> > explicitly test for 1000BaseX instead of using
> > phy_interface_mode_is_8023z() to differentiate the different
> > possibilities.
> 
> Hi Sascha
> 
> This seems like it should have a Fixes: tag, and be submitted to the
> net tree. Please see the Networking FAQ.

This might be a candidate for a Fixes: tag:

| commit da58a931f248f423f917c3a0b3c94303aa30a738
| Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
| Date:   Tue Sep 25 15:59:39 2018 +0200
| 
|     net: mvneta: Add support for 2500Mbps SGMII

What do you mean by "submitted to the net tree"? I usually send network
driver related patches to netdev@vger.kernel.org and from there David
applies them. Is there anything more to it I haven't respected?

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
