Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC9DC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3559D207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3x2n47K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgEMCdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:33:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43488 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgEMCdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:33:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D2X6cD020439;
        Tue, 12 May 2020 21:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589337186;
        bh=yTteBEh6Xwn4I3BnvI6/DQ8ygYomYcOGArsSXBO0R/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a3x2n47K9GBaLLhitS5heuPagTcYKacY4q19cXTJ5s9Ud49C9v30kOX1chVBQwCkd
         d35wSH+IYw4EPw4LFQM8mJNbFUYmFAFrkSSwty/t/I6IhgGWjazhGWWFWijX1EhNKp
         SdmmHj+oyMjKs9gddleUaZW+I/JQyl24uNN1+1Es=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D2X6pQ012778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 21:33:06 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 21:33:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 21:33:05 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D2X3tF053605;
        Tue, 12 May 2020 21:33:04 -0500
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: phy: Drop reset-gpios from
 marvell,mmp3-hsic-phy
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200509081754.474787-1-lkundrak@v3.sk>
 <20200509081754.474787-2-lkundrak@v3.sk>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3fbe923d-6b38-bec5-c623-7640c6affbae@ti.com>
Date:   Wed, 13 May 2020 08:03:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509081754.474787-2-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

On 5/9/2020 1:47 PM, Lubomir Rintel wrote:
> This has been added in error -- the PHY block doesn't have a reset pin.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml     | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
> index 00609ace677c..30e290c57930 100644
> --- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
> @@ -18,27 +18,20 @@ properties:
>      maxItems: 1
>      description: base address of the device
>  
> -  reset-gpios:
> -    maxItems: 1
> -    description: GPIO connected to reset
> -
>    "#phy-cells":
>      const: 0
>  
>  required:
>    - compatible
>    - reg
> -  - reset-gpios
>    - "#phy-cells"
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/gpio/gpio.h>
>      hsic-phy@f0001800 {
>              compatible = "marvell,mmp3-hsic-phy";
>              reg = <0xf0001800 0x40>;
> -            reset-gpios = <&gpio 63 GPIO_ACTIVE_HIGH>;
>              #phy-cells = <0>;
>      };
> 
