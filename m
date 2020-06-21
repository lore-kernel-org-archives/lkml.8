Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75BA251F6
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgFUPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 11:38:47 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57011 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgFUPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 11:38:47 -0400
Received: from webmail.gandi.net (webmail21.sd4.0x35.net [10.200.201.21])
        (Authenticated sender: foss@0leil.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPA id 50CEEC0005;
        Sun, 21 Jun 2020 15:38:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 21 Jun 2020 17:38:42 +0200
From:   Quentin Schulz <foss@0leil.net>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next v3 4/8] net: phy: mscc: take into account the
 1588 block in MACsec init
In-Reply-To: <20200619122300.2510533-5-antoine.tenart@bootlin.com>
References: <20200619122300.2510533-1-antoine.tenart@bootlin.com>
 <20200619122300.2510533-5-antoine.tenart@bootlin.com>
Message-ID: <964739eb70dcd58153d8548f7b57719b@0leil.net>
X-Sender: foss@0leil.net
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,

On 2020-06-19 14:22, Antoine Tenart wrote:
> This patch takes in account the use of the 1588 block in the MACsec
> initialization, as a conditional configuration has to be done (when the
> 1588 block is used).
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/phy/mscc/mscc_macsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc_macsec.c
> b/drivers/net/phy/mscc/mscc_macsec.c
> index c0eeb62cb940..713c62b1d1f0 100644
> --- a/drivers/net/phy/mscc/mscc_macsec.c
> +++ b/drivers/net/phy/mscc/mscc_macsec.c
> @@ -285,7 +285,9 @@ static void vsc8584_macsec_mac_init(struct
> phy_device *phydev,
>  				 MSCC_MAC_CFG_PKTINF_CFG_STRIP_PREAMBLE_ENA |
>  				 MSCC_MAC_CFG_PKTINF_CFG_INSERT_PREAMBLE_ENA |
>  				 (bank == HOST_MAC ?
> -				  MSCC_MAC_CFG_PKTINF_CFG_ENABLE_TX_PADDING : 0));
> +				  MSCC_MAC_CFG_PKTINF_CFG_ENABLE_TX_PADDING : 0) |
> +				 (IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING) ?
> +				  MSCC_MAC_CFG_PKTINF_CFG_MACSEC_BYPASS_NUM_PTP_STALL_CLKS(0x8) : 
> 0));

Do we have more info on this 0x8? Where does it come from? What does it 
mean?

Also this starts to get a little bit hard to read. Would it make sense 
to have
two temp variables? e.g.:

	padding = bank == HOST_MAC ? MSCC_MAC_CFG_PKTINF_CFG_ENABLE_TX_PADDING 
: 0;
	ptp_stall_clks = IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING) ?
		MSCC_MAC_CFG_PKTINF_CFG_MACSEC_BYPASS_NUM_PTP_STALL_CLKS(0x8) : 0;

	vsc8584_macsec_phy_write(phydev, bank, MSCC_MAC_CFG_PKTINF_CFG,
				 MSCC_MAC_CFG_PKTINF_CFG_STRIP_FCS_ENA |
				 MSCC_MAC_CFG_PKTINF_CFG_INSERT_FCS_ENA |
				 MSCC_MAC_CFG_PKTINF_CFG_LPI_RELAY_ENA |
				 MSCC_MAC_CFG_PKTINF_CFG_STRIP_PREAMBLE_ENA |
				 MSCC_MAC_CFG_PKTINF_CFG_INSERT_PREAMBLE_ENA |
				 padding |
				 ptp_stall_clks);

Thanks,
Quentin
