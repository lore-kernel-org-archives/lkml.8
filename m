Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC7220715
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHZDcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:32:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:64737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgHZDcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:32:14 -0400
IronPort-SDR: aa7yBwpiuTluN27FzqoB+340n16mtC5dsSOPN99inax1jat3iTfoqJBMi22GL8Gklijnbg3iyh
 EriYKB2TCM6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="136292776"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="136292776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 20:32:13 -0700
IronPort-SDR: jSEeqlTfRf9Z49X6EJiy/ciGqO+hZVw29fO+vOfiWk7i6kX7QJu7eyj+aoPQWs6Ratgh3kda2X
 V1ggnt8OTK+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="323031211"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2020 20:32:12 -0700
Received: from [10.215.173.55] (vramuthx-MOBL1.gar.corp.intel.com [10.215.173.55])
        by linux.intel.com (Postfix) with ESMTP id 3115C5806F0;
        Tue, 25 Aug 2020 20:32:09 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 1/1] extcon: ptn5150: Add usb-typec support for Intel
 LGM SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        heikki.krogerus@linux.intel.com
References: <20200825083147.25270-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CGME20200825083202epcas1p39a30661dd7ae7e5b4f8645a7cfcedd1d@epcas1p3.samsung.com>
 <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <4b1edd2e-4791-3f12-206f-9277435cdf59@samsung.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <d662a20d-bb47-4c8c-f0f3-1bc2050becc8@linux.intel.com>
Date:   Wed, 26 Aug 2020 11:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4b1edd2e-4791-3f12-206f-9277435cdf59@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   Thank you very much for the review comments...

On 25/8/2020 6:46 pm, Chanwoo Choi wrote:
> Hi,
> 
> On 8/25/20 5:31 PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add usb-typec detection support for Intel LGM SoC based
>> boards.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/extcon/extcon-ptn5150.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>> index 8ba706fad887..60355a1b5cb2 100644
>> --- a/drivers/extcon/extcon-ptn5150.c
>> +++ b/drivers/extcon/extcon-ptn5150.c
>> @@ -300,6 +300,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>   		return ret;
>>   	}
>>   
>> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> 
> extcon_set_property_capability() just sets the capability
> of EXTCON_PROP_USB_TYPEC_POLARITY property.
> 
> If you want to set the value (0 or 1) of EXTCON_PROP_USB_TYPEC_POLARITY,
> we have to call extcon_set_property() function. But, this patch doesn't
> set the any value of EXTCON_PROP_USB_TYPEC_POLARITY property.
> 
> Why do you only use extcon_set_property_capability()
> without the proper extcon_set_property()?

In extcon-ptn5150.c driver, we are not setting the capability of the 
EXTCON_PROP_USB_TYPEC_POLARITY
and EXTCON_PROP_USB_VBUS, so USB-PHY driver try to get the value of 
POLARITY capability by
calling extcon_get_property(), it returns error'ed value because we 
didn't set it.

In drivers/extcon/extcon.c, below code snippet returns errored value.
         /* Check whether the property is supported or not */
         if (!is_extcon_property_supported(id, prop))
                 return -EINVAL;

To avoid the above condition, refered and followed the same from 
drivers/extcon/extcon-usbc-cros-ec.c
        extcon_set_property_capability(info->edev, EXTCON_USB,
                                        EXTCON_PROP_USB_VBUS);
         extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
                                        EXTCON_PROP_USB_VBUS);
         extcon_set_property_capability(info->edev, EXTCON_USB,
                                        EXTCON_PROP_USB_TYPEC_POLARITY);
        .....................


after that, we follow the same to set the property capability then no 
error'ed value,
it's working properly.

Yes, you're right we can use extcon_set_property() API as well.

I can update the code like below...
	 
extcon_set_property(info->edev,EXTCON_USB_HOST,EXTCON_PROP_USB_TYPEC_POLARITY, 
flipped);

Regards
Vadivel

> 
>>   	/* Initialize PTN5150 device and print vendor id and version id */
>>   	ret = ptn5150_init_dev_type(info);
>>   	if (ret)
>>
> 
> 
