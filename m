Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B1AC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2757320752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FKq32PO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEDNkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:40:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40068 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgEDNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AS2kv0gpUVX7q+EU8jc6o6kLyYe4vA6m3YP11lOv2W4=; b=FKq32PO49K7052ag4nwLaAeRJi
        SCB9TH1e0Kq8y1nBOTyOs87CbK1XO03zV5+FTyBE09XdTEltwfV898Yq6HgYH/EFd9F3jUxAmgJdo
        CDEzrhTn364OKsaf6WbCE86VaEECqGwjKKYwu56w9pAEw/R2HOJpSU6j/MjzsjWUF9nc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jVbKi-000nw6-Ve; Mon, 04 May 2020 15:40:32 +0200
Date:   Mon, 4 May 2020 15:40:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: net: nxp,tja11xx: add compatible support
Message-ID: <20200504134032.GB190789@lunn.ch>
References: <20200504082617.11326-1-o.rempel@pengutronix.de>
 <20200504084412.juhnxip7lg2d3ct5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504084412.juhnxip7lg2d3ct5@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:44:12AM +0200, Oleksij Rempel wrote:
> Hi all,
> 
> here is first attempt to rework this binding. So far I have following
> questions and/or issues:
> - currently this PHY is identified by ID, not by compatible. Should it
>   be probed by compatible?
>   Theoretically I can use:
>   	compatible = "nxp,tja1102", "ethernet-phy-ieee802.3-c22";

Hi Oleksij

This will not work, in the current framework. PHYs probe via the ID
registers, or ethernet-phy-id0141.0e90 like compatible strings. MDIO
devices, which means devices like Ethernet switches, probe via
compatible strings. There are a few old DT blobs which do have a
compatible for the PHY, but they are white listed and ignored. See
of_mdio.c, whitelist_phys and of_mdiobus_child_is_phy().

If the DT validation code is wrongly forcing you to have a compatible,
i think your best bet is to use the ethernet-phy-id with the correct
ID values.

   Andrew
