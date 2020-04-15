Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86674C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664D02076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aT9ZDP6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636218AbgDONpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:45:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39628 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636203AbgDONpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mFdulGoyzXjkcnbudHCs8v43UlFuR/6b6qFTHBhgztQ=; b=aT9ZDP6NUhJkvzVM5Rv4I0IaCH
        2xBYHrQu7THMIFbFvSLSgbwRerLp0iMoF10yXHaGU8vYiNICcFX86T7lihyx6Ez+By+pVnGnvofi9
        0KKSBL3xm4o2mzc4RJ83veghAOHV7plgcKDdCy5GdpK/S0YpoDNJmAidq6nW5MLEEGAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jOiLn-002t3u-FB; Wed, 15 Apr 2020 15:45:11 +0200
Date:   Wed, 15 Apr 2020 15:45:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <20200415134511.GB657811@lunn.ch>
References: <20200415121209.12197-1-o.rempel@pengutronix.de>
 <20200415131104.GA657811@lunn.ch>
 <20200415133728.urvsdolwhaa4eknm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415133728.urvsdolwhaa4eknm@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the IEEE 802.3 it is described as:
> ---------------------------------------------------------------------------
> Port type: Bit 9.10 is to be used to indicate the preference to operate
> as MASTER (multiport device) or as SLAVE (single-port device) if the
> MASTER-SLAVE Manual Configuration Enable bit, 9.12, is not set.  Usage
> of this bit is described in 40.5.2.
> 1 = Multiport device
> 0 = single-port device

I really should go read the standard, but...

> ---------------------------------------------------------------------------
> 
> Setting PORT_MODE_MASTER/PORT_MODE_SLAVE will increase the chance to get
> MASTER or SLAVE mode, but not force it.
> 
> If we will follow strictly to the IEEE 802.3 spec, it should be named:
> 
> #define PORT_MODE_UNKNOWN	0x00
> /* this two options will not force some specific mode, only influence
>  * the chance to get it */
> #define PORT_TYPE_MULTI_PORT	0x01
> #define PORT_TYPE_SINGLE_PORT	0x02
> /* this two options will force master or slave mode */
> #define PORT_MODE_MASTER	0x03
> #define PORT_MODE_SLAVE		0x04

I prefer having FORCE in the name.

But let me read the standard and get up to speed.

    Andrew
