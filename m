Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F68C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E03206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849162;
	bh=2fMIFdJWMxMZMLxUPhbRA/eCK4AngiF2WrHPJI3R26U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vq/rAWLnhYa9xB5z6VtcJYuddGSEFWW6X2LcQz5Lh6WD31WRIGfmdmQRFtFygjOeN
	 CsSPxBdAOXWt5SVDxM06dc8JdgCyNdlXOMfCJGf6WCx6NodIwaZqCbb6wXr1DTVOLy
	 onuoWdWtX0ozoe1SryUkHMHsP5r2bdRAAD+vd6FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGOVjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:39:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39130 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:39:19 -0400
Received: by mail-il1-f195.google.com with SMTP id k6so3312890ili.6;
        Wed, 15 Jul 2020 14:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrkUh7wwexXk5hb+g44Ui8rq5L2tuZFeK1IjsvUGjNk=;
        b=SfDrFOZ0Affo3xmvd7bBCIeM3Ag0vr1FKzP16pfpqM7sjip4E6wsOVneypBySHU+GK
         LbiLmzBfPI3UImW58IL1d2qWVC3faiC6Tpt9hyq4OUAmoG6Fb6mKcEcq2sTTHi7PULo3
         Im2Q4kP+Gn3gm3kP046TMEQqkO6ObfBRPeV2QSdvYprqW6LttSV/PeSrK67qUaK/MPsl
         WvRQuUQ1Q0N9iFdWrdbdfSkCLCFzuEk7UItLRbjsUK5eAdwX0pehKZ2zU+Ty/1cAsMW2
         BJ6Edd5SxdzmQoHVtr+wJ0EBlJvNXgDs/wJP1clllDtQw83I7zLfXb6wbueRvn1O66gP
         pDZw==
X-Gm-Message-State: AOAM530ewB24Fe/uy9kgLWLYMBLSK0YCSq6UgLGTaWKE7KdSpfZBM8gd
        zDUzchqB1Eb7ucpNpVxlXke/6G6SJg==
X-Google-Smtp-Source: ABdhPJwEDw0qx3Zkz0lSKaCfP+LFe1k0hgRoQ3IJ01pLg5UrHij2iLaerPQHDAmLW5Gj/Aj12Sc1fw==
X-Received: by 2002:a92:cf42:: with SMTP id c2mr1593003ilr.13.1594849158597;
        Wed, 15 Jul 2020 14:39:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w4sm1737856ioc.23.2020.07.15.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:39:17 -0700 (PDT)
Received: (nullmailer pid 862187 invoked by uid 1000);
        Wed, 15 Jul 2020 21:39:17 -0000
Date:   Wed, 15 Jul 2020 15:39:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Daniel M. Weeks" <dan@danweeks.net>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
Message-ID: <20200715213917.GA818608@bogus>
References: <20200703153748.GA16156@dev.danweeks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703153748.GA16156@dev.danweeks.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:37:48AM -0400, Daniel M. Weeks wrote:
> Signed-off-by: Daniel M. Weeks <dan@danweeks.net>

Commit message? Isn't this going to break any users? Or we rely on i2c 
stripping the vendor?

> ---
>  Documentation/devicetree/bindings/hwmon/lm75.txt | 2 +-
>  drivers/hwmon/lm75.c                             | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> index 273616702c51..e5bb554cd2c3 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.txt
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> @@ -14,10 +14,10 @@ Required properties:
>  		"maxim,max6626",
>  		"maxim,max31725",
>  		"maxim,max31726",
> -		"maxim,mcp980x",
>  		"nxp,pct2075",
>  		"st,stds75",
>  		"st,stlm75",
> +		"microchip,mcp980x",
>  		"microchip,tcn75",
>  		"ti,tmp100",
>  		"ti,tmp101",
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..a8cfc7e4a685 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -690,10 +690,6 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "maxim,max31726",
>  		.data = (void *)max31725
>  	},
> -	{
> -		.compatible = "maxim,mcp980x",
> -		.data = (void *)mcp980x
> -	},
>  	{
>  		.compatible = "nxp,pct2075",
>  		.data = (void *)pct2075
> @@ -706,6 +702,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "st,stlm75",
>  		.data = (void *)stlm75
>  	},
> +	{
> +		.compatible = "microchip,mcp980x",
> +		.data = (void *)mcp980x
> +	},
>  	{
>  		.compatible = "microchip,tcn75",
>  		.data = (void *)tcn75
> -- 
> Daniel M. Weeks
