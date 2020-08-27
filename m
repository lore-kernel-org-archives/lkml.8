Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CA420786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH0HyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:13056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0HyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:02 -0400
IronPort-SDR: vz4bzoQ2rOVep7gF8OnzVv2aaOcIS+Q9r3sY/Js14XZW9M1UBFwXOFDpCIQGWnAm9Y3E8/9QRd
 VxnZps+SMYiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="217988356"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="217988356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 00:54:01 -0700
IronPort-SDR: /BlwljAFZPlXT5EC9L5SRl7mceno88GYplxunrJ7L2uL1bUWgMSzIEaQL0RSsrVtsYVIhpPo00
 ai3Jx3cDTxYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="295638978"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2020 00:54:01 -0700
Received: from [10.249.76.175] (vramuthx-MOBL1.gar.corp.intel.com [10.249.76.175])
        by linux.intel.com (Postfix) with ESMTP id D6A1A5806C6;
        Thu, 27 Aug 2020 00:53:57 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v3 1/1] extcon: ptn5150: Set the VBUS and POLARITY
 property capability
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CGME20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb@epcas1p3.samsung.com>
 <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <e0ac8482-d607-6095-0d9b-2918f0e7a0f2@samsung.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <47fef2ec-012c-03c7-13ef-0882b4f7146b@linux.intel.com>
Date:   Thu, 27 Aug 2020 15:53:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e0ac8482-d607-6095-0d9b-2918f0e7a0f2@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/8/2020 3:56 pm, Chanwoo Choi wrote:
> On 8/27/20 3:51 PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Set the capability value of property for VBUS and POLARITY.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/extcon/extcon-ptn5150.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>> index 841c9fe211f1..20d49a54c36e 100644
>> --- a/drivers/extcon/extcon-ptn5150.c
>> +++ b/drivers/extcon/extcon-ptn5150.c
>> @@ -275,6 +275,13 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>   		return ret;
>>   	}
>>   
>> +	extcon_set_property_capability(info->edev, EXTCON_USB,
>> +				       EXTCON_PROP_USB_VBUS);
>> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_VBUS);
>> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> 
> Above codes used the space for the indentation to keep the vertical line.
> I think that we better to use tab for the indentation.
> 
> If there are no objection, I'll fix and then apply it.
Thank you!, no objection , please fix it.

Regards
Vadivel
> 
>> +
>>   	/* Initialize PTN5150 device and print vendor id and version id */
>>   	ret = ptn5150_init_dev_type(info);
>>   	if (ret)
>>
> 
> 
