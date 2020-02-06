Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C574AC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8221D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pQOyULch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBFPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:34:53 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37378 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBFPew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cKeWrxfeVixH6vK7WVivOd6AqrxVMB3a/G5TvXBlN5A=; b=pQOyULchj/k0Xw9JGpHughvM89
        +cCDcfsd8PeG+Iwcz1PIfl1YucTjO6vD7nGk28vE05skcbCe0/4h5A6iYM8zHk79We5xTf8EtmArJ
        uvmkEZ+Y3dnGSI/sOEfCxwvrvphPsAjKqk7q5I8+vB6LFbrjN8lXYtmozYlYYhNjWLM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1izjB2-0008JF-RY; Thu, 06 Feb 2020 16:34:48 +0100
Date:   Thu, 6 Feb 2020 16:34:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: [PATCH] net: dsa: microchip: enable module autoprobe
Message-ID: <20200206153448.GA30090@lunn.ch>
References: <20200206150837.12009-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206150837.12009-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 05:08:37PM +0200, Codrin Ciubotariu wrote:
> From: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> 
> This matches /sys/devices/.../spi1.0/modalias content.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz9477_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477_spi.c b/drivers/net/dsa/microchip/ksz9477_spi.c
> index c5f64959a184..248b69c74b45 100644
> --- a/drivers/net/dsa/microchip/ksz9477_spi.c
> +++ b/drivers/net/dsa/microchip/ksz9477_spi.c
> @@ -101,6 +101,7 @@ static struct spi_driver ksz9477_spi_driver = {
>  
>  module_spi_driver(ksz9477_spi_driver);
>  
> +MODULE_ALIAS("spi:ksz8563");

Is this sufficient for all the different variants this driver
supports?

	Andrew
