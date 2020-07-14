Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9626CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F336227C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQTpIGD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgGNT3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:29:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbgGNT3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594754978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se13lQ+CRIfb3wczYYNcPpZ+CJSV+AV7XeFB0nsW9Bg=;
        b=FQTpIGD071r5j3xorxjVsbud3A+e0n5WpdjiXvKO/dQvGHDIRz17UzUa4SNyinIvhxcNLE
        WLepfpwU7/eEqdkmbFZy5HNPTPBLi+wRiDcSTHtEbTLWUV0SFFKfSB0hOIl6sid3Z/wjlO
        xi9zINbMxzEh6KUZhPz4LsLBaAs5Cyw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102--5Vc4xfjPDeJjQeJveQMbg-1; Tue, 14 Jul 2020 15:29:36 -0400
X-MC-Unique: -5Vc4xfjPDeJjQeJveQMbg-1
Received: by mail-wr1-f70.google.com with SMTP id y18so23099645wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Se13lQ+CRIfb3wczYYNcPpZ+CJSV+AV7XeFB0nsW9Bg=;
        b=TlcEltL1PVWUZ8qI3n0amIlexga/NLdFN8JUugSv7Cd6u2Rm8y4H5d7Ixo4HW9bPfb
         ri+h28qeYc2t/g8L9UyFvwlBkzCULq7WmH0Bk/8FpA7lPhVT6a9i3F3HL9soqBQAqAXN
         fDususYJMGeiGX6JzsyEMZv1qrxrRxkA2DTAIfogLduD9eiWuBFDdSfngzyRAKYHIc5w
         LOcPsrVlIUY26dgf+z4Fe0C9lCDNKDLLCSGNVYbL+SazVviyGp8TeLoIf2aYROdLhHv1
         QWLlXu1LC8v+oSB9kFVOHiSKeOqC+yzr+vquDESXvHznzrfpLWp3dB3a2+vIokEmVyKs
         kjPg==
X-Gm-Message-State: AOAM5329aVGNMEkcNuECSHFDsx2jCR0PWE9YdpgcCzakx1JrYwQwxFYe
        nGNf6sCFaT+1BKmt9ijd1soDGZoxblRcwMHgWTFgS0ISIgf6R+/KVGmCgl3CQgXPSKFi4pw6Hcs
        KYAKcDf4tGqjJVt8bnxIwxYX9
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr7465833wru.8.1594754975064;
        Tue, 14 Jul 2020 12:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSeJkI7z8WDbBOeYyVmOlkEvrIzXZey3Q5E1/PnSLt1NtmuSs61S7NuXpLadP67n6hFVhkpA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr7465807wru.8.1594754974798;
        Tue, 14 Jul 2020 12:29:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u65sm6219443wmg.5.2020.07.14.12.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:29:34 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        paul@crapouillou.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200714080918.148196-1-jingxiangfeng@huawei.com>
 <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
 <48bdc22e-a0fc-0402-a003-1d0736107e8a@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0405e05d-3f46-dba4-6558-7cf09fa3abe4@redhat.com>
Date:   Tue, 14 Jul 2020 21:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <48bdc22e-a0fc-0402-a003-1d0736107e8a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/14/20 5:32 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 7/14/20 8:33 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 7/14/20 10:09 AM, Jing Xiangfeng wrote:
>>> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
>>> path. Add the missed function call to fix it.
>>>
>>> Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect")
>>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>>
>> Patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Actually the existing code looks quite odd to me:
> 
> if (cnt) {
>      ret = device_add_properties(codec_dev, props);
>      if (ret)
>          return ret;
> }
> 
> devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
> priv->speaker_en_gpio =
>      gpiod_get_index(codec_dev, "speaker-enable", 0,
>              /* see comment in byt_cht_es8316_resume */
>              GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> put_device(codec_dev);
> 
> if the first branch is not taken the put_device() will not be balanced.

The get_device() does not come from the device_add_properties, it comes
from the earlier:

codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL, codec_name);

call.

Regards,

Hans



> 
> Shouldn't this be:
> 
> if (cnt) {
>      ret = device_add_properties(codec_dev, props);
>      put_device(codec_dev);
>      if (ret)
>          return ret;
> }
> 
> devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
> priv->speaker_en_gpio =
>      gpiod_get_index(codec_dev, "speaker-enable", 0,
>              /* see comment in byt_cht_es8316_resume */
>              GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> /* removed put_device(codec_dev); */
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>> ---
>>>   sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
>>> index 9e5fc9430628..ecbc58e8a37f 100644
>>> --- a/sound/soc/intel/boards/bytcht_es8316.c
>>> +++ b/sound/soc/intel/boards/bytcht_es8316.c
>>> @@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>>>       if (cnt) {
>>>           ret = device_add_properties(codec_dev, props);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            put_device(codec_dev);
>>>               return ret;
>>> +        }
>>>       }
>>>       devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
>>>
>>
> 

