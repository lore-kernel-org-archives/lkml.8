Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BCCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F94720771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHVT/WIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgGWEvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:51:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:51:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06N4pYMq078623;
        Wed, 22 Jul 2020 23:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595479894;
        bh=BKw6gnQsbDABlJ346u046OyEAM1YzpkEDLApL6zgFmg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IHVT/WIto/+qorf8QpJd64GTFLnxOAh5L0E/PFBCIllQt69q8fTux5i9MFUpJ3+8P
         t3ADMchfZ23k3KmLDNc2kV/9HGZDs0hdRbBEs1PKFUGFZ0OznoW9qkQoVwsm5U9pup
         C2YaCuwyG/DDgLBamQ70TI4R63U6pDwji34ZCYY4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06N4pYYV019607
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 23:51:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 23:51:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 23:51:33 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N4pUup011676;
        Wed, 22 Jul 2020 23:51:31 -0500
Subject: Re: [PATCH v4 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>, <nsekhar@ti.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
 <1594968633-12535-2-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b6fa3c63-1662-b191-200f-218630c950f9@ti.com>
Date:   Thu, 23 Jul 2020 10:21:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594968633-12535-2-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 12:20 PM, Swapnil Jakhade wrote:
> Add new PHY attribute max_link_rate to struct phy_attrs.
> Add a pair of PHY APIs to get/set all the PHY attributes.
> Use phy_get_attrs() to get attribute values and phy_set_attrs()
> to set attribute values.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> ---
>  include/linux/phy/phy.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..5d8ebb056c1d 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -115,10 +115,12 @@ struct phy_ops {
>  /**
>   * struct phy_attrs - represents phy attributes
>   * @bus_width: Data path width implemented by PHY
> + * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
>   * @mode: PHY mode
>   */
>  struct phy_attrs {
>  	u32			bus_width;
> +	u32			max_link_rate;
>  	enum phy_mode		mode;
>  };
>  
> @@ -231,6 +233,20 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  	phy->attrs.bus_width = bus_width;
>  }
> +
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);
> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);
> +}
>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *phy_optional_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> @@ -389,6 +405,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  	return;
>  }
>  
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	return;
> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
> +{
> +	return;
> +}
> +
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {
>  	return ERR_PTR(-ENOSYS);
> 
