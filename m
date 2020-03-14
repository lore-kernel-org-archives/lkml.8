Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E1C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E33F206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G5szt1P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCOBya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:54:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36040 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbgCOBy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NL3MJouei4eDxbtXys1XmSE5zsmrHAunj/d9XtHq32s=; b=G5szt1P7X8/ZbWY5RtsxzdhZQQ
        FAgcpi+1hAXENYjjox6ZLVeHuUrmbkQiky5pSrHj7lZs3bFyKv0AceSFMBk833fGX1CPfVoh9mj49
        psBPAjJDhJrAgfqjaAWG1m+7bFdjDfsETwSdUxnfe4MuZWSZ6NTPOh0bHe1gK2v+in0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jDE8X-0002J5-M9; Sat, 14 Mar 2020 22:16:01 +0100
Date:   Sat, 14 Mar 2020 22:16:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Madalin Bucur <madalin.bucur@oss.nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: fsl/fman: treat all RGMII modes in
 memac_adjust_link()
Message-ID: <20200314211601.GA8622@lunn.ch>
References: <1584101065-3482-1-git-send-email-madalin.bucur@oss.nxp.com>
 <1584101065-3482-2-git-send-email-madalin.bucur@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584101065-3482-2-git-send-email-madalin.bucur@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:04:23PM +0200, Madalin Bucur wrote:
> Treat all internal delay variants the same as RGMII.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index e1901874c19f..0fc98584974a 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -782,7 +782,10 @@ int memac_adjust_link(struct fman_mac *memac, u16 speed)
>  	/* Set full duplex */
>  	tmp &= ~IF_MODE_HD;
>  
> -	if (memac->phy_if == PHY_INTERFACE_MODE_RGMII) {
> +	if (memac->phy_if == PHY_INTERFACE_MODE_RGMII ||
> +	    memac->phy_if == PHY_INTERFACE_MODE_RGMII_ID ||
> +	    memac->phy_if == PHY_INTERFACE_MODE_RGMII_RXID ||
> +	    memac->phy_if == PHY_INTERFACE_MODE_RGMII_TXID) {

Hi Madalin

You can use phy_interface_mode_is_rgmii()

    Andrew
