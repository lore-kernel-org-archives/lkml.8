Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5527BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254AB206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591742304;
	bh=DMC0QDaxKZmuxVdK3JhVcDPvCC8PTWbCHX+dRyemGvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rL/1D0bkNAMHZ7aJS6lRV17CJCqV7fGnUTIVwH+wy19dNmpEesQChNmRicz+b4NBV
	 GIug6NuRIMPkSSh9aY5uWCu6qSYmOYWmPViCJ8DweySnvf5S/vRWpoOITRxYGEK2wI
	 qaxYdWEYikof7ij7jY1nVYpGYKAkQOuF5pPmC5NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFIWiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:38:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36471 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:38:21 -0400
Received: by mail-il1-f196.google.com with SMTP id a13so73834ilh.3;
        Tue, 09 Jun 2020 15:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=we/QVLPljh+VvvW0TyDCBs0GVOvUPbhlxjdGb+22AwU=;
        b=lPH3skqnbNzXbkmD0AtcbGO2iDzFQs4Ff+GH8qs8I5wNCF+8HsM8W7yX96g6ZURTYx
         cyenjuVJ8XbA9cnrJZFqmmOvzZBVfXrnItE7kreBd7sgZDZxaXpO3UYyqUGJrJjfDSeY
         njsc9SoGnAh05FOY3LB3JBS/iXprSZ16k7XfiHmYGnX/3YYdniudpmuBkTmOQlvZ6uxY
         VZLQdGD0+WWLHOICo6BCYbCJsU9Vo9rzgg1eDnQSkVUwZ2NhePMnwtvP4Si8iNcUydXO
         D+OMdeH94J3/NGXI8WJ0s8WFHFqMNVjAfUoYsVwX+ADg1sQ+7yF7OH241nfk0uq1F9Bu
         PV7w==
X-Gm-Message-State: AOAM532ItB/SqxTDB+gje9GxYWl7Z1fJ9n5ZVxtrkNjS6JAgBzl+RdnI
        YRgyVZMt4jdgl9xRbHoHMA==
X-Google-Smtp-Source: ABdhPJz4GX4BnpQD1QFEzALE9UZw4o3rV4NJACs3ZOZEhF5IUEXncgLcDuIDjhxVyYTfB+mgSFz/LA==
X-Received: by 2002:a92:c5c5:: with SMTP id s5mr242862ilt.85.1591742300408;
        Tue, 09 Jun 2020 15:38:20 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t9sm9864098ilg.74.2020.06.09.15.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:38:19 -0700 (PDT)
Received: (nullmailer pid 1629822 invoked by uid 1000);
        Tue, 09 Jun 2020 22:38:18 -0000
Date:   Tue, 9 Jun 2020 16:38:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <parthiban@linumiz.com>
Cc:     m.felsch@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add MYiR Tech boards
Message-ID: <20200609223818.GA1626212@bogus>
References: <20200601145857.5658-1-parthiban@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601145857.5658-1-parthiban@linumiz.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:58:56PM +0200, Parthiban Nallathambi wrote:
> Add entries for MYiR Tech imx6ULL eval boards.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index cd3fbe7e3948..592d73187da4 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -264,6 +264,8 @@ properties:
>                - armadeus,imx6ull-opos6uldev # OPOS6UL (i.MX6ULL) SoM on OPOS6ULDev board
>                - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
>                - kontron,imx6ull-n6411-som # Kontron N6411 SOM
> +              - myir,imx6ull-mys-6ulx # MYiR Tech iMX6ULL Evaluation Board
> +              - myir,imx6ull-mys-6ulx-nand # MYiR Tech iMX6ULL Evaluation Board with NAND

Can't you tell there is nand by the presence of a nand nodes?

>                - toradex,colibri-imx6ull-eval            # Colibri iMX6ULL Module on Colibri Evaluation Board
>                - toradex,colibri-imx6ull-wifi-eval       # Colibri iMX6ULL Wi-Fi / Bluetooth Module on Colibri Evaluation Board
>            - const: fsl,imx6ull
> -- 
> 2.26.2
> 
