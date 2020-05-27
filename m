Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EED2207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GG3L+diV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgE0Ad0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:33:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50814 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgE0AdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8XQiPl3J4Z+p4woOPKcPHigRSA+YLSXLLEdL58R3tic=; b=GG3L+diVvZhRkr5tFVxVy5Rjv+
        yF3z/M9pnQzAXSgseibShXFvWc4rlA9YMc25DJmBt8sNuKbLSHeWZAwHFBU0/x8UpJ0zM4OQRBknL
        jaSNCRSo6D/elxX6SZ5pxP7otqifDPO5s7kv+qXFt18zC3WdnW37bbHt35p0KNu3PiNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jdk0W-003L8I-Hv; Wed, 27 May 2020 02:33:20 +0200
Date:   Wed, 27 May 2020 02:33:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next v2 1/2] net: enetc: Initialize SerDes for SGMII
 and SXGMII protocols
Message-ID: <20200527003320.GC782807@lunn.ch>
References: <20200526225050.5997-1-michael@walle.cc>
 <20200526225050.5997-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225050.5997-2-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:50:49AM +0200, Michael Walle wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> ENETC has ethernet MACs capable of SGMII and SXGMII but in order to use
> these protocols some serdes configurations need to be performed. The
> SerDes is configurable via an internal MDIO bus connected to an internal
> PCS device, all reads/writes are performed at address 0.
> 
> This patch basically removes the dependency on bootloader regarding
> SerDes initialization.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 17 ++++
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 98 +++++++++++++++++++
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
>  3 files changed, 116 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 6314051bc6c1..ee5851486388 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -224,6 +224,23 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_PM0_MAXFRM	0x8014
>  #define ENETC_SET_TX_MTU(val)	((val) << 16)
>  #define ENETC_SET_MAXFRM(val)	((val) & 0xffff)
> +
> +#define ENETC_PM_IMDIO_BASE	0x8030
> +/* PCS registers */
> +#define ENETC_PCS_CR			0x0
> +#define ENETC_PCS_CR_RESET_AN		0x1200
> +#define ENETC_PCS_CR_DEF_VAL		0x0140
> +#define ENETC_PCS_CR_LANE_RESET		0x8000

Hi Michael

This looks like a standard BMCR. I know Russell King has pushed for
just using MII_BMCR, BMCR_ANENABLE | BMCR_ANRESTART, BMCR_FULLDPLX |
BMCR_SPEED1000, etc, since people understand what they mean.

> +#define ENETC_PCS_DEV_ABILITY		0x04
> +#define ENETC_PCS_DEV_ABILITY_SGMII	0x4001
> +#define ENETC_PCS_DEV_ABILITY_SXGMII	0x5001
> +#define ENETC_PCS_LINK_TIMER1		0x12
> +#define ENETC_PCS_LINK_TIMER1_VAL	0x06a0
> +#define ENETC_PCS_LINK_TIMER2		0x13
> +#define ENETC_PCS_LINK_TIMER2_VAL	0x0003
> +#define ENETC_PCS_IF_MODE		0x14
> +#define ENETC_PCS_IF_MODE_SGMII_AN	0x0003

It would be nice to document what these individual bits mean.

   Andrew
