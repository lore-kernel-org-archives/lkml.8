Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7532065E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGPQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:48:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:50403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgGPQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:48:09 -0400
IronPort-SDR: IMB8suGiAK+sW7RJXXNPvABRBhvK0MPw+rsJ5TBKXcwOMC4eEdbhyNbVYrXNkwjzYLuXOgUDrw
 xS2wtxBNQlTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="146942444"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="146942444"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 09:48:09 -0700
IronPort-SDR: ZA7q2BJMG9dZklnBPNFeSbY2pb+Z2/ehqdKBomNyLVBvDQ88gZ+ViD81h0cABUL4xa+XPO7QO6
 1kvKZFaRlAlA==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="486672417"
Received: from unknown (HELO [10.254.114.13]) ([10.254.114.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 09:48:08 -0700
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
 <48bdc22e-a0fc-0402-a003-1d0736107e8a@linux.intel.com>
 <0405e05d-3f46-dba4-6558-7cf09fa3abe4@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ace068c-5ec7-7e2b-0aa5-56cb59a55f7e@linux.intel.com>
Date:   Thu, 16 Jul 2020 11:48:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0405e05d-3f46-dba4-6558-7cf09fa3abe4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
>>>> path. Add the missed function call to fix it.
>>>>
>>>> Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for 
>>>> inverted jack detect")
>>>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>>>
>>> Patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Actually the existing code looks quite odd to me:
>>
>> if (cnt) {
>>      ret = device_add_properties(codec_dev, props);
>>      if (ret)
>>          return ret;
>> }
>>
>> devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
>> priv->speaker_en_gpio =
>>      gpiod_get_index(codec_dev, "speaker-enable", 0,
>>              /* see comment in byt_cht_es8316_resume */
>>              GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>> put_device(codec_dev);
>>
>> if the first branch is not taken the put_device() will not be balanced.
> 
> The get_device() does not come from the device_add_properties, it comes
> from the earlier:
> 
> codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL, codec_name);
> 
> call.

I probably needed more coffee when I wrote this, indeed this is fine...

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

