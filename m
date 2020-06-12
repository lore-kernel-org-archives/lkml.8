Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54314C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251492078E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592000400;
	bh=SRLyhO58v0e/Dj7PIxpypsol0Rb9njC6wt5N2xUX9xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GzcAZfmpH4lhN39pIJ228xNcHxhkRt96a7/cTLJqrZCOzDJdpXG5RBoszj8plyqWb
	 /zDVMDNqBN9tCOPJugNCPthzVgwJb2LzU75ExuU1sf3bXmrmMZSxe41DHrmqPusy4u
	 tkm8X7octByAcU/Sj6rE4CEpFEgOIdR2rxxwv5Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLWT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:19:58 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33489 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFLWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:19:57 -0400
Received: by mail-il1-f193.google.com with SMTP id z2so10210026ilq.0;
        Fri, 12 Jun 2020 15:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJe7EvfRDhyQ3pgHBhWbEvacD+zCOM/oKm7udJScqzs=;
        b=rgmc3YX+LGTYXy0vlLXB9hd2ySZBopbKUyoRgMGQ+6oForGiSgu/e00f46Vb3/vQAO
         Sq9foSbxiKrDcTKzdePwWSv3425AxjStxRZ+A0yUfBNJVM9LACtddfWJZpsgT+EIjTa1
         1B6Yso4rDgOuPOXXSI56VsDeE5T4w/AS2rOPbb3Ol+m3anEXCViOLWiELC2u4dTwuGLm
         a33bvVe8/Q9LeNqHIS+koIzh2uZEhBczLFpjiR3M21dqanf98d6aZLzXmy5/xOUoLklH
         j39vLy7pNFZ/JNiJr8VfbQOjT/EJmFc9jpT3gSdNQrSbGuL8pGMGuxVPpQAKpnrdtwai
         eyPg==
X-Gm-Message-State: AOAM532Bd59i5dGuA5dHUiRLhdm/9rqdAPxwZCCgH8Ug78/SDai9UR8f
        BJdcY4SJpXELiPERZfDHDzRQPFg=
X-Google-Smtp-Source: ABdhPJzQFX8fpn36IQ5fDk0I8FkSJus2zTIHXov4pdQh50AFuPYG/1EgKoLVphoduV8pLdZW3Y4SzA==
X-Received: by 2002:a92:909:: with SMTP id y9mr15504125ilg.165.1592000396142;
        Fri, 12 Jun 2020 15:19:56 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l26sm3880922ild.59.2020.06.12.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 15:19:55 -0700 (PDT)
Received: (nullmailer pid 3922166 invoked by uid 1000);
        Fri, 12 Jun 2020 22:19:54 -0000
Date:   Fri, 12 Jun 2020 16:19:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: Re: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
Message-ID: <20200612221954.GA3919662@bogus>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603200319.16184-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:03:17PM +0200, Luca Ceresoli wrote:
> The "Required properties:" section is copied verbatim for each of the two
> supported chips. In preparation to add a new chip variant make it a common
> section and keep the two examples to differentiate between the two chips.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

If you want to clean this up, can you convert it to DT schema?

> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
> index 41671e0dc26b..b75ae23a1ef3 100644
> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
> @@ -1,7 +1,7 @@
>  TI LP87565 PMIC MFD driver
>  
>  Required properties:
> -  - compatible:	"ti,lp87565", "ti,lp87565-q1"
> +  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
>    - reg:		I2C slave address.
>    - gpio-controller:	Marks the device node as a GPIO Controller.
>    - #gpio-cells:	Should be two.  The first cell is the pin number and
> @@ -10,7 +10,8 @@ Required properties:
>    - xxx-in-supply:	Phandle to parent supply node of each regulator
>  			populated under regulators node. xxx should match
>  			the supply_name populated in driver.
> -Example:
> +
> +Example for the TI LP87565-Q1 PMIC (dual 2-phase output configuration):
>  
>  lp87565_pmic: pmic@60 {
>  	compatible = "ti,lp87565-q1";
> @@ -42,21 +43,7 @@ lp87565_pmic: pmic@60 {
>  	};
>  };
>  
> -TI LP87561 PMIC:
> -
> -This is a single output 4-phase regulator configuration
> -
> -Required properties:
> -  - compatible:	"ti,lp87561-q1"
> -  - reg:		I2C slave address.
> -  - gpio-controller:	Marks the device node as a GPIO Controller.
> -  - #gpio-cells:	Should be two.  The first cell is the pin number and
> -			the second cell is used to specify flags.
> -			See ../gpio/gpio.txt for more information.
> -  - xxx-in-supply:	Phandle to parent supply node of each regulator
> -			populated under regulators node. xxx should match
> -			the supply_name populated in driver.
> -Example:
> +Example for the TI LP87561 PMIC (single 4-phase output configuration):
>  
>  lp87561_pmic: pmic@62 {
>  	compatible = "ti,lp87561-q1";
> -- 
> 2.27.0
> 
