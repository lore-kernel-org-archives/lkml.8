Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54085C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F220421919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xRFxHL9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgIIRGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:06:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIIPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:40:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089FdoE7086333;
        Wed, 9 Sep 2020 10:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599665990;
        bh=PKpzgV2pHlGLyVf0qMwwItFiGxw4/quKFW+Xh2YeSG0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xRFxHL9/w7zkT7aaPLp/M1+RW59j3iiaB9ENw29hbFZzb/OiWd6JXatoXnNkm2dRn
         yfWwA3+wnOxaENRjTWWNizCao/nX+SZ3F2UOdGTXAOAuG3NoTS74sHWgncefUcH1bs
         bQNyQXzevSqeFWfpQ5G76s0gL45NNMRPs5iSfYDo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 089Fdo8U087352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 10:39:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 10:39:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 10:39:50 -0500
Received: from [10.250.222.86] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089FdlZ4108164;
        Wed, 9 Sep 2020 10:39:48 -0500
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
To:     Crystal Guo <crystal.guo@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-4-crystal.guo@mediatek.com>
 <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
 <1599620279.14806.18.camel@mhfsdcap03>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
Date:   Wed, 9 Sep 2020 10:39:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599620279.14806.18.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:57 PM, Crystal Guo wrote:
> On Thu, 2020-09-03 at 07:40 +0800, Suman Anna wrote:
>> Hi Crystal,
>>
>> On 8/16/20 10:03 PM, Crystal Guo wrote:
>>> Introduce ti_syscon_reset() to integrate assert and deassert together.
>>> If some modules need do serialized assert and deassert operations
>>> to reset itself, reset_control_reset can be called for convenience.
>>
>> There are multiple changes in this same patch. I think you should split this
>> functionality away from the change for the regmap_update_bits() to
>> regmap_write_bits(), similar to what you have done in your v2 Patch 4.
>>
> 
> Thanks for your suggestion.
> I will split this patch in the next version.
> 
>>>
>>> Such as reset-qcom-aoss.c, it integrates assert and deassert together
>>> by 'reset' method. MTK Socs also need this method to perform reset.
>>>
>>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
>>> ---
>>>  drivers/reset/reset-ti-syscon.c | 26 ++++++++++++++++++++++++--
>>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
>>> index a2635c21db7f..08289342f9af 100644
>>> --- a/drivers/reset/reset-ti-syscon.c
>>> +++ b/drivers/reset/reset-ti-syscon.c
>>> @@ -15,6 +15,7 @@
>>>   * GNU General Public License for more details.
>>>   */
>>>  
>>> +#include <linux/delay.h>
>>>  #include <linux/mfd/syscon.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>> @@ -56,6 +57,7 @@ struct ti_syscon_reset_data {
>>>  	struct regmap *regmap;
>>>  	struct ti_syscon_reset_control *controls;
>>>  	unsigned int nr_controls;
>>> +	unsigned int reset_duration_us;
>>>  };
>>>  
>>>  #define to_ti_syscon_reset_data(rcdev)	\
>>> @@ -89,7 +91,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
>>>  	mask = BIT(control->assert_bit);
>>>  	value = (control->flags & ASSERT_SET) ? mask : 0x0;
>>>  
>>> -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
>>> +	return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
>>>  }
>>>  
>>>  /**
>>> @@ -120,7 +122,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
>>>  	mask = BIT(control->deassert_bit);
>>>  	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
>>>  
>>> -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
>>> +	return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
>>>  }
>>>  
>>>  /**
>>> @@ -158,9 +160,26 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
>>>  		!(control->flags & STATUS_SET);
>>>  }
>>>  
>>> +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
>>> +				  unsigned long id)
>>> +{
>>> +	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
>>> +	int ret;
>>> +
>>> +	ret = ti_syscon_reset_assert(rcdev, id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (data->reset_duration_us)
>>> +		usleep_range(data->reset_duration_us, data->reset_duration_us * 2);
>>> +
>>> +	return ti_syscon_reset_deassert(rcdev, id);
>>
>> I echo Philipp's comments [1] from your original v1 series about this. We don't
>> need a property to distinguish this, but you could add a flag using match data
>> and Mediatek compatible, and use that within this function, or optionally set
>> this ops based on compatible (whatever is preferred by Philipp).
>>
>> regards
>> Suman
>>
>> [1] https://patchwork.kernel.org/comment/23519193/
>>
> Hi Suman, Philipp
> 
> Which method would you recommend more?
> 1. like v2 patch, but assign the flag "data->assert_deassert_together"
> directly (maybe rename "assert_deassert_together" to
> "reset_op_available")
> 
> 2. use Mediatek compatible to decide the reset handler available or not.

I would go with this option. Anyway, I think you might have to add the reset SoC
data as well, based on Rob's comment on the binding.

regards
Suman

> 
> Thanks
> Crystal
> 
>>> +}
>>> +
>>>  static const struct reset_control_ops ti_syscon_reset_ops = {
>>>  	.assert		= ti_syscon_reset_assert,
>>>  	.deassert	= ti_syscon_reset_deassert,
>>> +	.reset		= ti_syscon_reset,
>>>  	.status		= ti_syscon_reset_status,
>>>  };
>>>  
>>> @@ -204,6 +223,9 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>>>  		controls[i].flags = be32_to_cpup(list++);
>>>  	}
>>>  
>>> +	of_property_read_u32(pdev->dev.of_node,	"reset-duration-us",
>>> +				&data->reset_duration_us);
>>> +
>>>  	data->rcdev.ops = &ti_syscon_reset_ops;
>>>  	data->rcdev.owner = THIS_MODULE;
>>>  	data->rcdev.of_node = np;
>>>
>>
> 

