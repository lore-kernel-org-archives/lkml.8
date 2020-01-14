Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C10C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA12A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961820;
	bh=l2r4AlqX7DIu8a1vCjrQQY2nUvcTBGVepDbO5HswZfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=laxXcMs+xfNPNI4zW6tARGCHiUJ/dIfVbdRgcSIa6CqcqHXP4uTScLwNfJt255P5Y
	 wp6tYRdjkT99DioaPVrqPLYvM92h6iDfRY98M31cjPWD5JEIzC29BPBYo0Pua6xC70
	 v1Z1FVOAW9S0fW4klm7RBhZkC0YnjyPTzzYBLVuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgANAaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:30:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37627 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgANAaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:30:19 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so10892639otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fTr7T7GJceLoLFzB5OjtrxDOobOt56IiyvMJHYGzl0w=;
        b=ugkEd3IL0pF+1nUpxO7KEYhAIB2uLDld0KuSZ4/TtTVx+P+vHOxfWTRjxNjfSuOkIG
         uWwjHyR0D7avFkxYRWoZWlZdd288a6kRiUt3THiQUvadM8rSmH9KmC3y0Mo1oB3Q3Yjk
         SzS9+JEIoAoCPJFbdVogdao21/fInopH8Rurjp9euR74rpsY1Yg9p4Ua0fjJkLEjFrOs
         F7WoMLIq7517czWj9AzbV68nWzVk80Pt6kAHOg49U8ltDtajqKXIzn1tr5y9iKd4Xjse
         DM2VogNiFCfwolyf9ESvANiuAfMWvok4pb0DVudy6wqEstMeeSFOwJ2IOQUNuMHDTN6b
         k8Eg==
X-Gm-Message-State: APjAAAXO85xoG9UnqtzMFv4ElknpTb/jSmFulfeaS+HAJZdYMi7T80xt
        AMK72gogaAiXjDAQTgAbDyFuMLDtJg==
X-Google-Smtp-Source: APXvYqwaDEwe8dwKgTEuyVExUTpL9d68u600aB7rNgMBVJbjVzYkufIiNpzTq/nqw5kx7cJ3KN00Ww==
X-Received: by 2002:a05:6830:451:: with SMTP id d17mr14322624otc.53.1578961818586;
        Mon, 13 Jan 2020 16:30:18 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm4118401oic.45.2020.01.13.16.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:30:18 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223ddc
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:24:15 -0600
Date:   Mon, 13 Jan 2020 18:24:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, lee.jones@linaro.org,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, wg@grandegger.com,
        mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 13/17] dt-bindings: atmel-usart: remove wildcard
Message-ID: <20200114002415.GA18336@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 06:18:05PM +0200, Claudiu Beznea wrote:
> Remove chip whildcard and introduce the list of compatibles instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 699fd3c9ace8..09013c49f6cc 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -1,10 +1,11 @@
>  * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>  
>  Required properties for USART:
> -- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
> -  The compatible <chip> indicated will be the first SoC to support an
> -  additional mode or an USART new feature.
> -  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> +- compatible: Should be one of the following:
> +	- "atmel,at91rm9200-usart"
> +	- "atmel,at91sam9260-usart"
> +	- "atmel,at91rm9200-dbgu"
> +	- "atmel,at91sam9260-dbgu"

Should be:

"atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
"atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"

>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
> -- 
> 2.7.4
> 
