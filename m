Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591220838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgAJRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:32:54 -0500
Received: from foss.arm.com ([217.140.110.172]:49104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgAJRcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:32:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2653E30E;
        Fri, 10 Jan 2020 09:32:53 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE693F6C4;
        Fri, 10 Jan 2020 09:32:51 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:32:49 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] net: axienet: Fix SGMII support
Message-ID: <20200110173249.0b086a76@donnerap.cambridge.arm.com>
In-Reply-To: <20200110145849.GC25745@shell.armlinux.org.uk>
References: <20200110115415.75683-1-andre.przywara@arm.com>
        <20200110115415.75683-8-andre.przywara@arm.com>
        <20200110145849.GC25745@shell.armlinux.org.uk>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 14:58:49 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Fri, Jan 10, 2020 at 11:54:08AM +0000, Andre Przywara wrote:
> > With SGMII, the MAC and the PHY can negotiate the link speed between
> > themselves, without the host needing to mediate between them.
> > Linux recognises this, and will call phylink's mac_config with the speed
> > member set to SPEED_UNKNOWN (-1).  
> 
> I wonder whether you have read the documentation for the phylink
> mac_config() method (if not, please read it, it contains some very
> important information about what mac_config() should do.)  When
> operating in SGMII in-band mode, state->speed and state->duplex are
> not actually valid.
> 
> You'll probably want to submit a better patch after reading the
> documentation.

Sure, I am admittedly quite clueless about phylink in particular, and found the available information quite daunting.
So I tried my best in looking at what other drivers do. From what I got there is that you speed=-1 should be ignored, but the other fields still handled.
Also I was somewhat puzzled, as I was expecting "mode" being MLO_AN_INBAND. But in fact it's called twice with MLO_AN_PHY, and mac_pcs_get_state() never gets called:

[  166.516583] xilinx_axienet 7fe00000.ethernet eth0: PHY [axienet-7fe00000:01] driver [Generic PHY]
[  166.547309] xilinx_axienet 7fe00000.ethernet eth0: configuring for phy/sgmii link mode
[  166.572343] axienet_mac_config(mode=0, speed=-1, duplex=255, pause=16, link=0, an_en=1)
udhcpc: sending discover
[  168.652152] axienet_mac_config(mode=0, speed=-1, duplex=255, pause=0, link=1, an_en=0)
[  168.683538] xilinx_axienet 7fe00000.ethernet eth0: Link is Up - Unknown/Unknown - flow control off
[  168.712560] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
udhcpc: sending discover
udhcpc: sending select for 10.1.x.y
udhcpc: lease of 10.1.x.y obtained, lease time 691200

I was just wondering if the DT description is giving Linux a wrong impression, but I have phy-mode set to sgmii, also just tried phy-connection-type on top of that. The DT snippet is the same as the example in patch 14. The PHY is a Marvell 88E1111, connected via SGMII.
 
I would be grateful for any advice!

Cheers,
Andre.
