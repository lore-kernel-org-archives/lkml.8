Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E9C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 00:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0AF20663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 00:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HsJzc7G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgC0AP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:15:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60680 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgC0AP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 20:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hd1YFsXLbrypTE4jWtW6CeMXVCF7Ic9nihmkXsYCCD4=; b=HsJzc7G0a9knRIHt+lZN7CgY4l
        aC+6VHmZ1DrIsd2cNn6tl+DhmNGFt+S2AWz76VmXK5u887jBzcJ0q6MVB9qLWQp1v9dgb+3gImGLw
        ODSDTS3xY3hIR3nIz7Qkzutx3d2BWDQwdbEWhgqe7IURUcbypOz19oFGfNERpenPCmI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jHceZ-0004we-2F; Fri, 27 Mar 2020 01:15:15 +0100
Date:   Fri, 27 Mar 2020 01:15:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/9] net: phy: add kr phy connection type
Message-ID: <20200327001515.GL3819@lunn.ch>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
 <1585230682-24417-4-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585230682-24417-4-git-send-email-florinel.iordache@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 03:51:16PM +0200, Florinel Iordache wrote:
> Add support for backplane kr phy connection types currently available
> (10gbase-kr, 40gbase-kr4) and the required phylink updates (cover all
> the cases for KR modes which are clause 45 compatible to correctly assign
> phy_interface and phylink#supported)
> 
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
> ---
>  drivers/net/phy/phylink.c | 15 ++++++++++++---
>  include/linux/phy.h       |  6 +++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index fed0c59..db1bb87 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -4,6 +4,7 @@
>   * technologies such as SFP cages where the PHY is hot-pluggable.
>   *
>   * Copyright (C) 2015 Russell King
> + * Copyright 2020 NXP
>   */
>  #include <linux/ethtool.h>
>  #include <linux/export.h>
> @@ -303,7 +304,6 @@ static int phylink_parse_mode(struct phylink *pl, struct fwnode_handle *fwnode)
>  			break;
>  
>  		case PHY_INTERFACE_MODE_USXGMII:
> -		case PHY_INTERFACE_MODE_10GKR:

We might have a backwards compatibility issue here. If i remember
correctly, there are some boards out in the wild using
PHY_INTERFACE_MODE_10GKR not PHY_INTERFACE_MODE_10GBASER.

See e0f909bc3a242296da9ccff78277f26d4883a79d

Russell, what do you say about this?

	 Andrew
