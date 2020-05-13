Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B4C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F0E2124A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vaW0tWNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgEMNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:12:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57772 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgEMNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eB5FjLH7T6LhaFmYc7bOJ9LyuU3m4PmCrJlFeQNyDeA=; b=vaW0tWNYAWeERIsAFaRBT+vCbp
        OYPNdm8F5mu8ZorEnYvHUlsajv4DP/hvwjHpJinMAKOx4yTeNdFjALpgHM1zTc+lfQ8U6f5xIXy7Z
        pGbgboEFdxEV0PZcsWVUZY7T9v+upqrr0holqtzXHlM6L21fKbcZSAl7Fj/5+OrHf81s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jYrBS-002A4R-3u; Wed, 13 May 2020 15:12:26 +0200
Date:   Wed, 13 May 2020 15:12:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com, kuba@kernel.org,
        Yufeng Mo <moyufeng@huawei.com>,
        Jian Shen <shenjian15@huawei.com>
Subject: Re: [PATCH net-next] net: phy: realtek: add loopback support for
 RTL8211F
Message-ID: <20200513131226.GA499265@lunn.ch>
References: <1589358344-14009-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589358344-14009-1-git-send-email-tanhuazhong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:25:44PM +0800, Huazhong Tan wrote:
> From: Yufeng Mo <moyufeng@huawei.com>
> 
> PHY loopback is already supported by genphy driver. This patch
> adds the set_loopback interface to RTL8211F PHY driver, so the PHY
> selftest can run properly on it.
> 
> Signed-off-by: Yufeng Mo <moyufeng@huawei.com>
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

It took three people to write a 1 line patch?

> ---
>  drivers/net/phy/realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index c7229d0..6c5918c 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -615,6 +615,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.resume		= genphy_resume,
>  		.read_page	= rtl821x_read_page,
>  		.write_page	= rtl821x_write_page,
> +		.set_loopback   = genphy_loopback,
>  	}, {
>  		.name		= "Generic FE-GE Realtek PHY",
>  		.match_phy_device = rtlgen_match_phy_device,

Do you have access to the data sheets? Can you check if the other PHYs
supported by this driver also support loopback in the standard way?
They probably do.

	  Andrew
