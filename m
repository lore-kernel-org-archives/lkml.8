Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44892C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2623206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cwIfGDmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgICLfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:35:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38326 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgICLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:30:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083BUJWe124273;
        Thu, 3 Sep 2020 06:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599132619;
        bh=zWoBMHSi9LN0rO5GkwwhSejhOf97+jlwoMcbUyUwHBY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cwIfGDmJIQLAVGjQPkTMOTveLVtGnGXQV7CmnDMjhsZiyyo3m8stU8fjsQ9svVOkF
         JTLHgJtUhEOqvJczWaGFciaFpR1HNXjMXM68Ur+P/umU1ls5iW7hZwltPY0pRaTow2
         /5pk1igS9vlqKtmS1rHo8wXTXnxI3E3302/JgbK8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083BUJ0O031714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 06:30:19 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 06:30:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 06:30:19 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083BUFU5053871;
        Thu, 3 Sep 2020 06:30:15 -0500
Subject: Re: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
 <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <20200902121722.GA16811@pendragon.ideasonboard.com>
 <DM6PR07MB6154F54322C38E6D864C7797C52C0@DM6PR07MB6154.namprd07.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b7903295-6482-53a5-2f08-3da17ced0c87@ti.com>
Date:   Thu, 3 Sep 2020 17:00:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB6154F54322C38E6D864C7797C52C0@DM6PR07MB6154.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 9/3/2020 4:29 PM, Swapnil Kashinath Jakhade wrote:
> 
> 
>> -----Original Message-----
>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Sent: Wednesday, September 2, 2020 5:47 PM
>> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
>> Cc: vkoul@kernel.org; kishon@ti.com; linux-kernel@vger.kernel.org;
>> maxime@cerno.tech; Milind Parab <mparab@cadence.com>; Yuti Suresh
>> Amonkar <yamonkar@cadence.com>; nsekhar@ti.com;
>> tomi.valkeinen@ti.com; jsarha@ti.com; praneeth@ti.com
>> Subject: Re: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
>> PHY attributes
>>
>> EXTERNAL MAIL
>>
>>
>> Hi Swapnil,
>>
>> On Wed, Sep 02, 2020 at 07:09:21AM +0000, Swapnil Kashinath Jakhade
>> wrote:
>>> On Wednesday, September 2, 2020 6:00 AM Laurent Pinchart wrote:
>>>> On Mon, Aug 24, 2020 at 08:28:31PM +0200, Swapnil Jakhade wrote:
>>>>> Use generic PHY framework function phy_set_attrs() to set number
>>>>> of lanes and maximum link rate supported by PHY.
>>>>>
>>>>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>> ---
>>>>>  drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
>>>>> b/drivers/phy/cadence/phy-cadence-torrent.c
>>>>> index 7116127358ee..eca71467c4a8 100644
>>>>> --- a/drivers/phy/cadence/phy-cadence-torrent.c
>>>>> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
>>>>> @@ -1710,6 +1710,7 @@ static int cdns_torrent_phy_probe(struct
>> platform_device *pdev)
>>>>>  	struct cdns_torrent_phy *cdns_phy;
>>>>>  	struct device *dev = &pdev->dev;
>>>>>  	struct phy_provider *phy_provider;
>>>>> +	struct phy_attrs torrent_attr;
>>>>>  	const struct of_device_id *match;
>>>>>  	struct cdns_torrent_data *data;
>>>>>  	struct device_node *child;
>>>>> @@ -1852,6 +1853,12 @@ static int cdns_torrent_phy_probe(struct
>> platform_device *pdev)
>>>>>  				 cdns_phy->phys[node].num_lanes,
>>>>>  				 cdns_phy->max_bit_rate / 1000,
>>>>>  				 cdns_phy->max_bit_rate % 1000);
>>>>> +
>>>>> +			torrent_attr.bus_width = cdns_phy-
>>> phys[node].num_lanes;
>>>>> +			torrent_attr.max_link_rate = cdns_phy-
>>> max_bit_rate;
>>>>> +			torrent_attr.mode = PHY_MODE_DP;
>>>>> +
>>>>> +			phy_set_attrs(gphy, &torrent_attr);
>>>>
>>>> Why is this better than accessing the attributes manually as follows ?
>>>>
>>>> 			gphy->attrs.bus_width = cdns_phy-
>>> phys[node].num_lanes;
>>>> 			gphy->attrs.max_link_rate = cdns_phy-
>>> max_bit_rate;
>>>> 			gphy->attrs.mode = PHY_MODE_DP;
>>>>
>>>> This is called in cdns_torrent_phy_probe(), before the PHY provider
>>>> is registered, so nothing can access the PHY yet. What race
>>>> condition are you trying to protect against with usage of phy_set_attrs() ?
>>>
>>> I agree that for Cadence DP bridge driver and Torrent PHY driver use
>>> case, it would not matter even if we set the attributes in Torrent PHY
>>> driver in a way you suggested above.
>>> But as per the discussion in [1], phy_set_attrs/phy_get_attrs APIs in
>>> future could maybe used by other drivers replacing existing individual
>>> functions for attributes bus_width and mode which are
>>> phy_set_bus_width/phy_get_bus_width and
>> phy_set_mode/phy_get_mode. So
>>> this usage in Torrent PHY driver is an example implementation of the API.
>>>
>>> [1]
>>> https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/18/472__;!!EH
>>> scmS1ygiU1lA!QKTTI7BS1R35a_zoMfJsY4A4yCtEKrQNtiAXTyIZ-
>> SYIEEibYdpBMJTll
>>> Yrd-00$
>>
>> This doesn't seem a very good API to me :-S It will require callers to always
>> call phy_get_attrs() first, modify the attributes they want to set, and then call
>> phy_set_attrs(). Not only will be copy the whole phy_attrs structure
>> needlessly, it will also not be an atomic operation as someone else could
>> modify attributes between the get and set calls.
>> The lack of atomicity may not be an issue in practice if there's a single user of
>> the PHY at all times, but in that case no mutex is needed.

What if the consumer tries to set an attribute at the middle of a
phy_power_on() operation? That is still a valid operation and phy core layer
should try to prevent it no?
>>
>> I think this series tries to fix a problem that doesn't exist.
> 
> Thanks Laurent for your comments.
> 
> Hi Kishon,
> 
> Could you please suggest what would be the better approach regarding this PHY
> attributes series. Should we add individual get/set functions for new attribute
> max_link_rate just like mode and bus_width, or should we use phy_get_attrs()
> and phy_set_attrs() functions removing mutex.  Your suggestions would really help.

I think Laurent's point is not having an API at all for configuring attributes
and access them manually?

Thanks
Kishon

> 
> Thanks & regards,
> Swapnil
> 
>>
>>>>>  		} else {
>>>>>  			dev_err(dev, "Driver supports only
>> PHY_TYPE_DP\n");
>>>>>  			ret = -ENOTSUPP;
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
