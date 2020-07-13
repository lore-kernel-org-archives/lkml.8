Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEC32072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hl/sBJ1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGML63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:58:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43700 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGML62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:58:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DBwNnC069123;
        Mon, 13 Jul 2020 06:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594641503;
        bh=TbkC6KrmeWz60ZVMmtFFcx7ipPpCkLMjQ4Vkst7dBQE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hl/sBJ1b2oA8hanDtMnFUPuBQib7yU0yz3fFBnOzYuyQ33k5dtWsiccDOyVgUM5ws
         L+1WuiSye5tQgfNsVwDXY7EF+m842w0WKItwKaWj27mLRzVP/KjkfDYJA7feuYVbpT
         G4dqiEbVP0UWwCHycF88bsiK6z1QDthT0XhrM2jI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DBwNYA077416;
        Mon, 13 Jul 2020 06:58:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 06:58:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 06:58:23 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DBwJWb082607;
        Mon, 13 Jul 2020 06:58:20 -0500
Subject: Re: [PATCH v3 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
To:     Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <mparab@cadence.com>, <yamonkar@cadence.com>, <nsekhar@ti.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
 <1594633112-4155-2-git-send-email-sjakhade@cadence.com>
 <20200713111120.GI34333@vkoul-mobl>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <67fcecf5-7be3-518f-ce3e-095dcddd5bc9@ti.com>
Date:   Mon, 13 Jul 2020 17:28:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713111120.GI34333@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2020 4:41 PM, Vinod Koul wrote:
> On 13-07-20, 11:38, Swapnil Jakhade wrote:
>> Add new PHY attribute max_link_rate to struct phy_attrs.
>> Add a pair of PHY APIs to get/set all the PHY attributes.
>> Use phy_set_attrs() to set attribute values in the PHY provider driver.
>> Use phy_get_attrs() to get attribute values in the controller driver.
>>
>> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>> ---
>>  include/linux/phy/phy.h | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index bcee8eba62b3..7fb59359ab7b 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -115,10 +115,12 @@ struct phy_ops {
>>  /**
>>   * struct phy_attrs - represents phy attributes
>>   * @bus_width: Data path width implemented by PHY
>> + * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
>>   * @mode: PHY mode
>>   */
>>  struct phy_attrs {
>>  	u32			bus_width;
>> +	u32			max_link_rate;
>>  	enum phy_mode		mode;
>>  };
>>  
>> @@ -231,6 +233,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>>  {
>>  	phy->attrs.bus_width = bus_width;
>>  }
>> +
>> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
>> +{
>> +	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
>> +}
>> +
>> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
>> +{
>> +	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
>> +}
> 
> we already have APIs for mode and bus_width so why not add one for
> link_rate and call them?
> 
> Also I see you are using phy_set_attrs() in second patch, why add
> phy_get_attrs() when we have no user?

One of the factors to consider is who will set the attributes; it could either
be phy provider (like 2/2 of this series) or phy consumer (factors like PCIe
speed, lane are usually negotiated with the phy consumer).

Now if phy provider is setting/getting the attributes, then
phy_set_attrs/phy_get_attrs should be protected by mutex. We don't want to be
updating attributes when phy consumer is doing some phy ops.

If phy_consumer is updating attributes, it could directly access the phy
attributes if it's updating within one of those phy ops. Don't really see a
need for using an API to update the attributes then.

However if it's updating outside the phy_ops, then it would still make sense to
use the APIs to update attributes with all those mutex protection.

Regards
Kishon
> 
>>  struct phy *phy_get(struct device *dev, const char *string);
>>  struct phy *phy_optional_get(struct device *dev, const char *string);
>>  struct phy *devm_phy_get(struct device *dev, const char *string);
>> @@ -389,6 +401,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>>  	return;
>>  }
>>  
>> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
>> +{
>> +	return;
>> +}
>> +
>> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
>> +{
>> +	return;
>> +}
>> +
>>  static inline struct phy *phy_get(struct device *dev, const char *string)
>>  {
>>  	return ERR_PTR(-ENOSYS);
>> -- 
>> 2.26.1
> 
