Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837C82068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgHYJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:16:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:45958 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbgHYJQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:16:27 -0400
IronPort-SDR: Tcg9Wymp2JnI650b5dnnR6FrzffqkYvu23e63JurTaGMX+Ma+MAzOQ8RhZGyznrZPMS8sLqsJ+
 1qTN32yH/cHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143735321"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="143735321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 02:16:27 -0700
IronPort-SDR: GS0E3cOxlhtrlTsQ2dLkSpVEMRWywSWViLPNUSZmA5W3Yl0Pw2C5TQe485QFLTDdNCb/enzuyp
 J/Jj/GOTt17A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="328804097"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 02:16:27 -0700
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 25BBA5805EB;
        Tue, 25 Aug 2020 02:16:24 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 1/1] extcon: ptn5150: Add usb-typec support for Intel
 LGM SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
        vijaikumar.kanagarajan@gmail.com, myungjoo.ham@samsung.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200825083147.25270-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200825084053.GA13905@kozik-lap>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <4cdc6be5-9bd7-3e90-547a-1fe8399c8852@linux.intel.com>
Date:   Tue, 25 Aug 2020 17:16:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825084053.GA13905@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Thank you for the review comments...

On 25/8/2020 4:40 pm, Krzysztof Kozlowski wrote:
> On Tue, Aug 25, 2020 at 04:31:47PM +0800, Ramuthevar,Vadivel MuruganX wrote:
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
> Hi,
> 
> I think you need the same for EXTCON_USB.
> 
> Although extcon_set_property_capability() error should not be fatal, but
> printing a warn message would be useful.
Yes , earlier we had like below settings in our patches,
+       extcon_set_property_capability(info->edev, EXTCON_USB,
+                                      EXTCON_PROP_USB_VBUS);
+       extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+                                      EXTCON_PROP_USB_VBUS);
+       extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+                                      EXTCON_PROP_USB_TYPEC_POLARITY);

sure, will add warn message as well.

Thanks!
Best Regards
Vadivel
> 
> Best regards,
> Krzysztof
> 
> 
>>   	/* Initialize PTN5150 device and print vendor id and version id */
>>   	ret = ptn5150_init_dev_type(info);
>>   	if (ret)
>> -- 
>> 2.11.0
>>
