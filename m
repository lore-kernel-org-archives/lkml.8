Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48E42072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgAJOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:20:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgAJOUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:20:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3CC4328;
        Fri, 10 Jan 2020 06:20:41 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 953CE3F534;
        Fri, 10 Jan 2020 06:20:40 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:20:38 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH 07/14] net: axienet: Fix SGMII support
Message-ID: <20200110142038.2ed094ba@donnerap.cambridge.arm.com>
In-Reply-To: <20200110140415.GE19739@lunn.ch>
References: <20200110115415.75683-1-andre.przywara@arm.com>
        <20200110115415.75683-8-andre.przywara@arm.com>
        <20200110140415.GE19739@lunn.ch>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 15:04:15 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

Hi Andrew,

> On Fri, Jan 10, 2020 at 11:54:08AM +0000, Andre Przywara wrote:
> > With SGMII, the MAC and the PHY can negotiate the link speed between
> > themselves, without the host needing to mediate between them.
> > Linux recognises this, and will call phylink's mac_config with the speed
> > member set to SPEED_UNKNOWN (-1).
> > Currently the axienet driver will bail out and complain about an
> > unsupported link speed.
> > 
> > Teach axienet's mac_config callback to leave the MAC's speed setting
> > alone if the requested speed is SPEED_UNKNOWN.  
> 
> Hi Andre
> 
> Is there an interrupt when SGMII signals a change in link state? If
> so, you should call phylink_mac_change().

Good point. The doc describes a "Auto-Negotiation Complete" interrupt status bit, which signal that " ... auto-negotiation of the SGMII or 1000BASE-X interface has completed."
But I have no clue whether that would trigger on a link status *change*. Is there a way to test this without pulling the cable? My board sits in a data centre, so is not easily accessible to me.

Cheers,
Andre.
