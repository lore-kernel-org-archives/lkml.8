Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C872073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KbmLfbIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCELCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:02:15 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37070 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCELCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:02:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025B2CHG070950;
        Thu, 5 Mar 2020 05:02:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583406132;
        bh=Xf1sRmkJiwnY8rrWe4eV5yH+UcPKjlexHlXHcZvFUcA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KbmLfbIYtekCXup3DzahcPLAG6PjYGXDRJQqtLSPGx3/XRkROU6Vyw6xXsVWxs4lp
         IHDLzIQvPsIKqkDhP5tMJNuNqoWVZg0+uoG3CYrSEvDml6Ns8yDx3SUEv7L4xE8mou
         qymDTlEym8/Y9U/t/gFQG0EN4iWTAm4JlZDbXN2I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025B2C90041167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 05:02:12 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 05:02:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 05:02:11 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025B28qQ080091;
        Thu, 5 Mar 2020 05:02:09 -0600
Subject: Re: [for-next PATCH v2 1/5] phy: ti: gmii-sel: simplify config
 dependencies between net drivers and gmii phy
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     Sekhar Nori <nsekhar@ti.com>, Rob Herring <robh+dt@kernel.org>,
        netdev <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200303160029.345-1-grygorii.strashko@ti.com>
 <20200303160029.345-2-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a6dc55bb-090f-d1de-90c7-247197d3748e@ti.com>
Date:   Thu, 5 Mar 2020 16:36:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303160029.345-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 03/03/20 9:30 pm, Grygorii Strashko wrote:
> The phy-gmii-sel can be only auto selected in Kconfig and now the pretty
> complex Kconfig dependencies are defined for phy-gmii-sel driver, which
> also need to be updated every time phy-gmii-sel is re-used for any new
> networking driver.
> 
> Simplify Kconfig definition for phy-gmii-sel PHY driver - drop all
> dependencies and from networking drivers and rely on using 'imply
> PHY_TI_GMII_SEL' in Kconfig definitions for networking drivers instead.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig | 1 +

I can pick this in my tree. Can you give your Acked-by since there is a
small change in drivers/net?

Thanks
Kishon
>  drivers/phy/ti/Kconfig          | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index bf98e0fa7d8b..8a6ca16eee3b 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -53,6 +53,7 @@ config TI_CPSW
>  	select MFD_SYSCON
>  	select PAGE_POOL
>  	select REGMAP
> +	imply PHY_TI_GMII_SEL
>  	---help---
>  	  This driver supports TI's CPSW Ethernet Switch.
>  
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index 6dbe9d0b9ff3..15a3bcf32308 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -106,11 +106,8 @@ config TWL4030_USB
>  
>  config PHY_TI_GMII_SEL
>  	tristate
> -	default y if TI_CPSW=y || TI_CPSW_SWITCHDEV=y
> -	depends on TI_CPSW || TI_CPSW_SWITCHDEV || COMPILE_TEST
>  	select GENERIC_PHY
>  	select REGMAP
> -	default m
>  	help
>  	  This driver supports configuring of the TI CPSW Port mode depending on
>  	  the Ethernet PHY connected to the CPSW Port.
> 
