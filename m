Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760EC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE93A206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B5zjVL/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgA0LQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:16:17 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34504 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA0LQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UCgrtPNzJO46r3b/mUyJxh1OmaEkXSe8oNF3O0byYUc=; b=B5zjVL/wnoqw6vZqWGnCca6Ix
        3Mq/MYyf+fXGYsEl5W1q5lu7Xb3teExMbEiD3mvjH6wKDtYDJhxKHnfLY3y1BeoyeVEVoag+SHWDR
        t2SUAmY7dM1JZ2s1kpCFNN4GOCWaFpxNl80ASB1APiT9LYVt0FOYA19T1i8SzXhUS3kEbmsE448du
        xhzhk5vlCS3J4s5lGJftXgiArNRJgcLyoiC3RK8EmaIxOleCbc98AuZJLZbFbMi8h+jXIMFjW6up6
        twiSvEWfyZWT7i3AsS+z4OKAQzYpp3dAlUakHFCr1Z4efCqVdLSlYPjAQSvFpBIIASWVZX3StzWY1
        0Nd0AlQqw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39806)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iw2NC-0000rn-8i; Mon, 27 Jan 2020 11:16:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iw2N7-0001Lr-Sg; Mon, 27 Jan 2020 11:16:01 +0000
Date:   Mon, 27 Jan 2020 11:16:01 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 2/8] net: phylink: Add phylink_and and
 phylink_andnot Helpers
Message-ID: <20200127111601.GS25745@shell.armlinux.org.uk>
References: <cover.1580122909.git.Jose.Abreu@synopsys.com>
 <9509e5d75810da4ef49c674f0fd5cacb81d1a536.1580122909.git.Jose.Abreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9509e5d75810da4ef49c674f0fd5cacb81d1a536.1580122909.git.Jose.Abreu@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:09:07PM +0100, Jose Abreu wrote:
> Add two new helpers for bitmap handling.

Please use linkmode_andnot() and linkmode_and() instead.

> 
> Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
> 
> ---
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/phylink.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 523209e70947..70a2f7a4450b 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -272,6 +272,10 @@ int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
>  
>  #define phylink_zero(bm) \
>  	bitmap_zero(bm, __ETHTOOL_LINK_MODE_MASK_NBITS)
> +#define phylink_and(bm, obm) \
> +	bitmap_and(bm, bm, obm, __ETHTOOL_LINK_MODE_MASK_NBITS)
> +#define phylink_andnot(bm, obm) \
> +	bitmap_andnot(bm, bm, obm, __ETHTOOL_LINK_MODE_MASK_NBITS)
>  #define __phylink_do_bit(op, bm, mode) \
>  	op(ETHTOOL_LINK_MODE_ ## mode ## _BIT, bm)
>  
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
