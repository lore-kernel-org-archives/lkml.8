Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E8C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55A820715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FC3VcDC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGNcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:32:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38238 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k+RNLZTniJRRRyBN0pswuLEqgka8vHJHmd3fETb5+CE=; b=FC3VcDC2xE+tTcLzIAskQ5uK7W
        Bszji7B8P8H00Q+qIQ4ACOkdf+7nkLwXVn23El9UAGFGANB/26ufuu/jNvFZXKXQJhxCRLkSUnF6M
        EVhal8AgmqGp1ZMZEzapk0WMSyhtYKu0OTA2fKES4OJlsRpwqma1Tjj1E3IUZfq2SMkQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j03jy-0003pJ-D1; Fri, 07 Feb 2020 14:32:14 +0100
Date:   Fri, 7 Feb 2020 14:32:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: [PATCH v2] net: dsa: microchip: enable module autoprobe
Message-ID: <20200207133214.GB14393@lunn.ch>
References: <20200207104643.1049-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207104643.1049-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 12:46:43PM +0200, Codrin Ciubotariu wrote:
> From: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> 
> This matches /sys/devices/.../spi1.0/modalias content.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>  - added alias for all the variants of this driver
> 
>  drivers/net/dsa/microchip/ksz9477_spi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477_spi.c b/drivers/net/dsa/microchip/ksz9477_spi.c
> index c5f64959a184..1142768969c2 100644
> --- a/drivers/net/dsa/microchip/ksz9477_spi.c
> +++ b/drivers/net/dsa/microchip/ksz9477_spi.c
> @@ -101,6 +101,12 @@ static struct spi_driver ksz9477_spi_driver = {
>  
>  module_spi_driver(ksz9477_spi_driver);
>  
> +MODULE_ALIAS("spi:ksz9477");
> +MODULE_ALIAS("spi:ksz9897");
> +MODULE_ALIAS("spi:ksz9893");
> +MODULE_ALIAS("spi:ksz9563");
> +MODULE_ALIAS("spi:ksz8563");
> +MODULE_ALIAS("spi:ksz9567");
>  MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
>  MODULE_DESCRIPTION("Microchip KSZ9477 Series Switch SPI access Driver");
>  MODULE_LICENSE("GPL");

Hi Codrin

You might want to consider adding a Fixes tag?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
