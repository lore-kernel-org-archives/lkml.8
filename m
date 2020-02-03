Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CAFC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC0C20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dknKMzx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgBCSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:41:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38032 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBCSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ul0HVKuO8ElH72GqJH89jBPZVUgcn0UM0cFS4x7qJd4=; b=dknKMzx1V+kHeGsvSUL/m770r
        lwectpAJQAwF7Tj+QWt/N8hIReL8BqKs32eYMh61EuTtICDXvJn31GhlVeI6EOtMk6AtRVDnRuhnq
        aMjtoE1nOHJJTAv1j3D8blgH6lA2DG0lWI8N4W0Rexlol+nfYWtCH2cAz/icD3bx6wp1N14Gjb2ge
        k+bP1mj5bfz0m2T8Yy9PrNDUWTFgxrncOxR4492HBIcbbm9QGnjTtyvDNo67o6Ihx/xPhLG2Qhlq7
        826bEnPpwbEEM/1+bJercd94r+yu0n5tSWB+0Gl6jAMQi6mTsAAUkKnINvOmq8LQkUkOLC4SDE+HZ
        8cDI86H/Q==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43022)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iygf0-0005Eo-16; Mon, 03 Feb 2020 18:41:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iygev-00007u-B6; Mon, 03 Feb 2020 18:41:21 +0000
Date:   Mon, 3 Feb 2020 18:41:21 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Calvin Johnson <calvin.johnson@nxp.com>
Cc:     linux.cj@gmail.com, Jon Nettleton <jon@solid-run.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        cristian.sovaiala@nxp.com, laurentiu.tudor@nxp.com,
        ioana.ciornei@nxp.com, V.Sethi@nxp.com, pankaj.bansal@nxp.com,
        "Rajesh V . Bikkina" <rajesh.bikkina@nxp.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 6/7] net: phylink: Introduce
 phylink_fwnode_phy_connect()
Message-ID: <20200203184121.GR25745@shell.armlinux.org.uk>
References: <20200131153440.20870-1-calvin.johnson@nxp.com>
 <20200131153440.20870-7-calvin.johnson@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131153440.20870-7-calvin.johnson@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:04:39PM +0530, Calvin Johnson wrote:
> From: Calvin Johnson <calvin.johnson@oss.nxp.com>
> 
> Introduce phylink_fwnode_phy_connect API to connect the PHY using
> fwnode.
> 
> Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> ---
> 
>  drivers/net/phy/phylink.c | 64 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  2 ++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index ee7a718662c6..f211f62283b5 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -18,6 +18,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/workqueue.h>
> +#include <linux/acpi.h>
>  
>  #include "sfp.h"
>  #include "swphy.h"
> @@ -817,6 +818,69 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
>  }
>  EXPORT_SYMBOL_GPL(phylink_connect_phy);
>  
> +/**
> + * phylink_fwnode_phy_connect() - connect the PHY specified in the fwnode.
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @dn: a pointer to a &struct device_node.
> + * @flags: PHY-specific flags to communicate to the PHY device driver
> + *
> + * Connect the phy specified in the device node @dn to the phylink instance
> + * specified by @pl. Actions specified in phylink_connect_phy() will be
> + * performed.
> + *
> + * Returns 0 on success or a negative errno.
> + */
> +int phylink_fwnode_phy_connect(struct phylink *pl,
> +			       struct fwnode_handle *fwnode,
> +			       u32 flags)
> +{
> +	struct fwnode_handle *phy_node;
> +	struct phy_device *phy_dev;
> +	int ret;
> +	int status;
> +	struct fwnode_reference_args args;
> +
> +	/* Fixed links and 802.3z are handled without needing a PHY */
> +	if (pl->link_an_mode == MLO_AN_FIXED ||
> +	    (pl->link_an_mode == MLO_AN_INBAND &&
> +	     phy_interface_mode_is_8023z(pl->link_interface)))
> +		return 0;
> +
> +	status = acpi_node_get_property_reference(fwnode, "phy-handle", 0,
> +						  &args);
> +	if (ACPI_FAILURE(status) || !is_acpi_device_node(args.fwnode))
> +		status = acpi_node_get_property_reference(fwnode, "phy", 0,
> +							  &args);
> +	if (ACPI_FAILURE(status) || !is_acpi_device_node(args.fwnode))
> +		status = acpi_node_get_property_reference(fwnode,
> +							  "phy-device", 0,
> +							  &args);

This is a copy-and-paste of phylink_of_phy_connect() without much
thought.

There is no need to duplicate the legacy DT functionality of
phy/phy-device/phy-handle in ACPI - there is no legacy to support,
so it's pointless trying to find one of three properties here.

I'd prefer both the DT and ACPI variants to be more integrated, so
we don't have two almost identical functions except for the firmware
specific detail.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
