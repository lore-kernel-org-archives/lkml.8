Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF2EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6D1207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:34:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:39982 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHZHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:34:02 -0400
IronPort-SDR: 0GafeSFbd2fPtfcu0y/EvUpmiwBOQchHPdbaWgNbaFwMHm/RSs9aiMrdRm9SDqqiM65Ox2xiXj
 p3EXs9Quf7WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153671790"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="153671790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 00:34:00 -0700
IronPort-SDR: KsKT0zQOlKI9ZRXe9nwwNG+Znb7WuamKHzseJep0AJhFaxdyjy1ipUOn6FK/RGr1LeijjSvGn1
 wWBgT+MsGYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="323089632"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 00:34:00 -0700
Received: from [10.215.173.55] (vramuthx-MOBL1.gar.corp.intel.com [10.215.173.55])
        by linux.intel.com (Postfix) with ESMTP id D75A6580821;
        Wed, 26 Aug 2020 00:33:56 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 2/9] extcon: extcon-ptn5150: Switch to GENMASK() for
 VBUS detection macro
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200826065920.GB12271@pi3>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <f6552123-a01f-7d42-cc58-0a1da157e134@linux.intel.com>
Date:   Wed, 26 Aug 2020 15:33:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826065920.GB12271@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
> On Tue, Aug 18, 2020 at 02:57:20PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Switch to GENMASK() for VBUS detection macro.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/extcon/extcon-ptn5150.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> This is too simple change, should be squashed with 1, 3, 4 and 5.
> 
> There is no point to split each change a define to use BIT or GENMASK.
Thank you for the review comments and suggestions.
Sure, I will squash it as mentioned patches mentioned above.

Best Regards
Vadivel
> 
> Best regards,
> Krzysztof
> 
>>
>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>> index 5d9a8767646b..c816a6c1e05c 100644
>> --- a/drivers/extcon/extcon-ptn5150.c
>> +++ b/drivers/extcon/extcon-ptn5150.c
>> @@ -42,9 +42,7 @@ enum ptn5150_reg {
>>   #define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
>>   	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
>>   
>> -#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
>> -#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
>> -	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
>> +#define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
>>   
>>   #define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
>>   #define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
>> @@ -130,9 +128,8 @@ static void ptn5150_irq_work(struct work_struct *work)
>>   			case PTN5150_UFP_ATTACHED:
>>   				extcon_set_state_sync(info->edev, EXTCON_USB,
>>   						false);
>> -				vbus = ((reg_data &
>> -					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
>> -					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
>> +				vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION,
>> +						 reg_data);
>>   				if (vbus)
>>   					gpiod_set_value(info->vbus_gpiod, 0);
>>   				else
>> -- 
>> 2.11.0
>>
