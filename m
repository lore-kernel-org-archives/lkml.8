Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19DD22229
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGNPdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:33:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:19794 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgGNPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:33:02 -0400
IronPort-SDR: Fx25YqgNYcYkbhAQ2E7SBzrRBP5zmilBpMw/24mHkwG+Jc+k99BtbuiLuhfQBNZX6uXpLQ+p7Q
 LzQP6vhNuW/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128495203"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128495203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 08:33:01 -0700
IronPort-SDR: jpLl8Z91CHrJMTPg3t0J7aTW5y2Vqu6HL+js7/SNral8HdnSKvyg1gNcK1cIg8t/WVHXCucWtk
 kjh/xIzkwcnQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="317756331"
Received: from pbusser-mobl1.amr.corp.intel.com (HELO [10.252.136.7]) ([10.252.136.7])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 08:33:00 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
To:     Hans de Goede <hdegoede@redhat.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        paul@crapouillou.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200714080918.148196-1-jingxiangfeng@huawei.com>
 <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <48bdc22e-a0fc-0402-a003-1d0736107e8a@linux.intel.com>
Date:   Tue, 14 Jul 2020 10:32:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/20 8:33 AM, Hans de Goede wrote:
> Hi,
> 
> On 7/14/20 10:09 AM, Jing Xiangfeng wrote:
>> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
>> path. Add the missed function call to fix it.
>>
>> Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for 
>> inverted jack detect")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> 
> Patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Actually the existing code looks quite odd to me:

if (cnt) {
	ret = device_add_properties(codec_dev, props);
	if (ret)
		return ret;
}

devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
priv->speaker_en_gpio =
	gpiod_get_index(codec_dev, "speaker-enable", 0,
			/* see comment in byt_cht_es8316_resume */
			GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
put_device(codec_dev);

if the first branch is not taken the put_device() will not be balanced.

Shouldn't this be:

if (cnt) {
	ret = device_add_properties(codec_dev, props);
	put_device(codec_dev);
	if (ret)
		return ret;
}

devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
priv->speaker_en_gpio =
	gpiod_get_index(codec_dev, "speaker-enable", 0,
			/* see comment in byt_cht_es8316_resume */
			GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
/* removed put_device(codec_dev); */

> 
> Regards,
> 
> Hans
> 
> 
>> ---
>>   sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/boards/bytcht_es8316.c 
>> b/sound/soc/intel/boards/bytcht_es8316.c
>> index 9e5fc9430628..ecbc58e8a37f 100644
>> --- a/sound/soc/intel/boards/bytcht_es8316.c
>> +++ b/sound/soc/intel/boards/bytcht_es8316.c
>> @@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct 
>> platform_device *pdev)
>>       if (cnt) {
>>           ret = device_add_properties(codec_dev, props);
>> -        if (ret)
>> +        if (ret) {
>> +            put_device(codec_dev);
>>               return ret;
>> +        }
>>       }
>>       devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
>>
> 
