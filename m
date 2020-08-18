Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACC42080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgHRP4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:56:32 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59294 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgHRP40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:56:26 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k83yH-009vuo-8G; Tue, 18 Aug 2020 17:56:21 +0200
Date:   Tue, 18 Aug 2020 17:56:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Landen Chao <landen.chao@mediatek.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        davem@davemloft.net, sean.wang@mediatek.com, opensource@vdorst.com,
        frank-w@public-files.de, dqfext@gmail.com
Subject: Re: [PATCH net-next v2 3/7] net: dsa: mt7530: Extend device data
 ready for adding a new hardware
Message-ID: <20200818155621.GE2330298@lunn.ch>
References: <cover.1597729692.git.landen.chao@mediatek.com>
 <a56f3029b913d31fbd27562b98d485e981815165.1597729692.git.landen.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56f3029b913d31fbd27562b98d485e981815165.1597729692.git.landen.chao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 03:14:08PM +0800, Landen Chao wrote:
> Add a structure holding required operations for each device such as device
> initialization, PHY port read or write, a checker whether PHY interface is
> supported on a certain port, MAC port setup for either bus pad or a
> specific PHY interface.
> 
> The patch is done for ready adding a new hardware MT7531.
> 
> Signed-off-by: Landen Chao <landen.chao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/dsa/mt7530.c | 272 +++++++++++++++++++++++++++++----------
>  drivers/net/dsa/mt7530.h |  37 +++++-
>  2 files changed, 240 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 0fd50798aa42..d30b41725b4d 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -372,8 +372,9 @@ mt7530_fdb_write(struct mt7530_priv *priv, u16 vid,
>  		mt7530_write(priv, MT7530_ATA1 + (i * 4), reg[i]);
>  }
>  
> +/* Setup TX circuit incluing relevant PAD and driving */
>  static int
> -mt7530_pad_clk_setup(struct dsa_switch *ds, int mode)
> +mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
>  {
>  	struct mt7530_priv *priv = ds->priv;
>  	u32 ncpo1, ssc_delta, trgint, i, xtal;
> @@ -387,7 +388,7 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, int mode)
>  		return -EINVAL;
>  	}
>  
> -	switch (mode) {
> +	switch (interface) {
>  	case PHY_INTERFACE_MODE_RGMII:
>  		trgint = 0;
>  		/* PLL frequency: 125MHz */

Do you actually need to support all 4 RGMII modes?

...

+			goto unsupported;
> +		break;
> +	case 6: /* 1st cpu port */
> +		if (state->interface != PHY_INTERFACE_MODE_RGMII &&
> +		    state->interface != PHY_INTERFACE_MODE_TRGMII)

phy_interface_mode_is_rgmii()?

	Andrew
