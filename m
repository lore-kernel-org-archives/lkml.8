Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214CC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E620663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WgyBe3xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD0MuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:50:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42640 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgD0MuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:50:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RCo4aZ032233;
        Mon, 27 Apr 2020 07:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587991804;
        bh=1wztSrx/1+YXEkm6LvHC/nKMdE655Ho/98MQU5EvpvU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WgyBe3xDr4Ddp2RBM5BLQVMCz1gF07yb6l0OwPQBanQZcOLmZMC04i4rbN5XPwb6Y
         Pdqg/2P97WRlpbeqYU4c5BRKlauLlUXR45he7PMXw7Xjh9yZuonxR5amexWMDReQEf
         Z5i95cj4+iFirgRlvtKwm1kwpkHZIXrZdDHc8qmA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RCo45h128747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 07:50:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 07:50:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 07:50:03 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RCo0pw101191;
        Mon, 27 Apr 2020 07:50:01 -0500
Subject: Re: [PATCH v1] phy: Add max_link_rate as a PHY attribute along with
 get/set APIs
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1587789560-16440-1-git-send-email-yamonkar@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e81446f8-9ec1-01c2-b4b4-d8ff4b63338f@ti.com>
Date:   Mon, 27 Apr 2020 18:20:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587789560-16440-1-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuti,

On 4/25/2020 10:09 AM, Yuti Amonkar wrote:
> The patch adds a pair of APIs that allow the generic PHY subsystem to
> provide information on the maximum value of link rate supported by the
> PHY. The PHY provider driver may use phy_set_max_link_rate() to set the
> maximum link rate that the PHY supports. The controller driver may then
> use phy_get_max_link_rate() to fetch the PHY link rate in order to
> properly configure the controller.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>

This patch should preferably be sent along with the patch that uses these
functions (unless you have some specific reason).

Thanks
Kishon

> ---
>  include/linux/phy/phy.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..a8b7b4a2b8de 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -119,6 +119,7 @@ struct phy_ops {
>   */
>  struct phy_attrs {
>  	u32			bus_width;
> +	u32			max_link_rate;
>  	enum phy_mode		mode;
>  };
>  
> @@ -231,6 +232,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  	phy->attrs.bus_width = bus_width;
>  }
> +
> +static inline int phy_get_max_link_rate(struct phy *phy)
> +{
> +	return phy->attrs.max_link_rate;
> +}
> +
> +static inline void phy_set_max_link_rate(struct phy *phy, int link_rate)
> +{
> +	phy->attrs.max_link_rate = link_rate;
> +}
>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *phy_optional_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> @@ -389,6 +400,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  	return;
>  }
>  
> +static inline int phy_get_max_link_rate(struct phy *phy)
> +{
> +	return -ENOSYS;
> +}
> +
> +static inline void phy_set_max_link_rate(struct phy *phy, int link_rate)
> +{
> +	return;
> +}
> +
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {
>  	return ERR_PTR(-ENOSYS);
> 
