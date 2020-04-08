Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25FF20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HpNs0wdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgDHKzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:55:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54912 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDHKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w6dHPYMv2i9dm01SaFUvBAnpyuM/9O8Vy7ZNYT4fAcY=; b=HpNs0wdn7sIB4LHpoFt4EPV2v
        ugIr1QFTho4/bn6ATMEWn/ThHaK3CzQqQX1yYflUUX7BTC4wiB+EmHxzWF0CJrly9cZK1uLca/RZs
        /SbuAkNVXidImBiJRAWZ40Cf39MVWTyEkXLmYLqCza7ufVHCV3KO+QMqzNe4piJv7pYKWWv3St+BV
        ir7kkXkdJkNpBkP0ycIJ/q+pejyz/D3ndwa02/VkX/z9OwGn5jb5IxUb95LK9+XEQ/5JHOmMZNmS+
        /OizKNwKIM0oBYRYpDTTc0uohJEIOKRoXtBzSdxRCnW/JL30g5ZwWIT3PQv27Pj4tddYvUlHjjEud
        IMX7H5geg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43136)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jM8Mn-0005RT-IU; Wed, 08 Apr 2020 11:55:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jM8Mk-0001mF-Ry; Wed, 08 Apr 2020 11:55:30 +0100
Date:   Wed, 8 Apr 2020 11:55:30 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1] gpio: mpc8xxx: Add shutdown function.
Message-ID: <20200408105530.GR25745@shell.armlinux.org.uk>
References: <20200408102118.17572-1-hui.song_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408102118.17572-1-hui.song_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 06:21:17PM +0800, Hui Song wrote:
> From: Song Hui <hui.song_1@nxp.com>
> 
> The shutdown function needed to make interrupt handler to be NULL
> when kexec execute.
> 
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Please improve the commit message.  You describe what change the patch
is making (which we can see from reading the patch), but you don't
explain why it is necessary, or really what problem the patch is
solving.  I'm not aware of other implementations needing this for
kexec to work.

Thanks.

> ---
>  drivers/gpio/gpio-mpc8xxx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 604dfec..a24e6c5 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -446,9 +446,21 @@ static int mpc8xxx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int mpc8xxx_shutdown(struct platform_device *pdev)
> +{
> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = platform_get_drvdata(pdev);
> +
> +	if (mpc8xxx_gc->irq) {
> +		irq_set_chained_handler_and_data(mpc8xxx_gc->irqn, NULL, NULL);
> +		irq_domain_remove(mpc8xxx_gc->irq);
> +	}
> +
> +	return 0;
> +}
>  static struct platform_driver mpc8xxx_plat_driver = {
>  	.probe		= mpc8xxx_probe,
>  	.remove		= mpc8xxx_remove,
> +	.shutdown	= mpc8xxx_shutdown,
>  	.driver		= {
>  		.name = "gpio-mpc8xxx",
>  		.of_match_table	= mpc8xxx_gpio_ids,
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
