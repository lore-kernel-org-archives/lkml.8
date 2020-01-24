Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC04C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6342072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579888757;
	bh=50y0NaTE3axGGy6OKBVato6obQgydRCsHHRyTVeVAJI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vrFpsO8o9o/sRGq3HUdWwvWUkcL2ZKbuqiRy0u5Md95imCwDvRW8uJP7QD8zeA9Pt
	 RQY3y6lCl12m0/Nsq/QG1xf68EYY3vHdrak/Iq/QD9VHgx/2+5D2qgBqbi4KszKwrw
	 Jf7xi92xfvLYUXcowhfV39Xj6f3zvaBcLhIjDBws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390967AbgAXR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:59:16 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39249 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390902AbgAXR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:59:15 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so2856649ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ex0Isa11/flUHUOcxw59BzxTs8GRZOlZkq93u4RA4cc=;
        b=HGuapn5TKXdsGZVP/fd3t4XZ3KECr31sSy71HHNkBR1yREz/nnbselm1Io6SqGJDC3
         7AqBXqewKQctdURvHPlNLYCxvPWb4dXm28iYOVKQuPav8B4ggEIJHQ00jfGsjTJqXJSo
         kTuoVPu3MSMoaAeyexzQ73reTt3mIIChM1v5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ex0Isa11/flUHUOcxw59BzxTs8GRZOlZkq93u4RA4cc=;
        b=cqCaOF1wLeSPxuIXkmvuPqUiGxkTW5kDvCUqvN7A4WWHbud5fofH0PqUgFg7HLHt+f
         5a7IURp7wvMxEj5tafdkCzJ6AJg41AE7MKXc8X5xoKd5RNwgCtkRywB7rHdnaVTfd6Ub
         2sFW0fphtjjwhBYwiTFp3zSoHF7r4HQtsxhqUR58zyxOLBrDICmfNZth0YJlbPGYzwlQ
         XPxDSUxEP6BlfWXIYPo7hMwUfcCou4MptwA4f+d7BJnAZzAINKMlUetNELhK8DE5nejq
         Y19mzo6TF//ZTlmtBBoXz+fYYWWQlPsxO5goBwSlPEXLjzHJKrDqqxI5EP2dplBmhH+n
         JlAQ==
X-Gm-Message-State: APjAAAWa5Eq61/VBgmqMdatKiHCVu5sXBbBSN33r3tRwdQebbz7DKrqG
        IZV6jk91/mqHFPgFW0ksoN7paCQ6XGY=
X-Google-Smtp-Source: APXvYqzbojxj7MjKCh5WcRlf+iKihR3vmOwHSm53h/ObLAA0Fw3I7khmHWixbodbBkGe+QaiCAqfLg==
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr3255546ioj.83.1579888754401;
        Fri, 24 Jan 2020 09:59:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i11sm1338641ion.1.2020.01.24.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:59:13 -0800 (PST)
Subject: Re: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during
 init
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Grimm, Jon" <jon.grimm@amd.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20200123223214.2566-1-skhan@linuxfoundation.org>
 <096ee758-a372-4caa-c082-e1e8cff3f033@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11e832e3-67ca-cc8a-7e5c-c60b9fc54da1@linuxfoundation.org>
Date:   Fri, 24 Jan 2020 10:59:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <096ee758-a372-4caa-c082-e1e8cff3f033@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 11:43 PM, Suravee Suthikulpanit wrote:
> 
> 
> On 1/24/20 5:32 AM, Shuah Khan wrote:
>> init_iommu_perf_ctr() clobbers the register when it checks write access
>> to IOMMU perf counters and fails to restore when they are writable.
>>
>> Add save and restore to fix it.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v1:
>> -- Fix bug in sucessful return path. Add a return instead of
>>     fall through to pc_false error case
>>
>>   drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/amd_iommu_init.c 
>> b/drivers/iommu/amd_iommu_init.c
>> index 568c52317757..483f7bc379fa 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -1655,27 +1655,39 @@ static int iommu_pc_get_set_reg(struct 
>> amd_iommu *iommu, u8 bank, u8 cntr,
>>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>>   {
>>       struct pci_dev *pdev = iommu->dev;
>> -    u64 val = 0xabcd, val2 = 0;
>> +    u64 val = 0xabcd, val2 = 0, save_reg = 0;
>>       if (!iommu_feature(iommu, FEATURE_PC))
>>           return;
>>       amd_iommu_pc_present = true;
>> +    /* save the value to restore, if writable */
>> +    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
>> +        goto pc_false;
>> +
>>       /* Check if the performance counters can be written to */
>>       if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>>           (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
>> -        (val != val2)) {
>> -        pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
>> -        amd_iommu_pc_present = false;
>> -        return;
>> -    }
>> +        (val != val2))
>> +        goto pc_false;
>> +
>> +    /* restore */
>> +    if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
>> +        goto pc_false;
>>       pci_info(pdev, "IOMMU performance counters supported\n");
>>       val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
>>       iommu->max_banks = (u8) ((val >> 12) & 0x3f);
>>       iommu->max_counters = (u8) ((val >> 7) & 0xf);
>> +
>> +    return;
>> +
> 
> Good catch. Sorry, I missed this part as well :(
> 
>> +pc_false:
>> +    pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
>> +    amd_iommu_pc_present = false;
>> +    return;
>>   }
>>   static ssize_t amd_iommu_show_cap(struct device *dev,
>>
> 
> As for your question in v1:
> 
>  > I see 2 banks and 4 counters on my system. Is it sufficient to check
>  > the first bank and first counter? In other words, if the first one
>  > isn't writable, are all counters non-writable?
> 
> We currently assume all counters have the same write-ability. So, it 
> should be sufficient
> to just check the first one.
> 
>  > Should we read the config first and then, try to see if any of the
>  > counters are writable? I have a patch that does that, I can send it
>  > out for review.
> 
> Which config are you referring to? Not sure what you mean.

I mean reading MMIO_CNTR_CONF_OFFSET to get max banks and counters.
Also what is the reason to check writable?

I tried a couplf og things on my

AMD Ryzen 5 PRO 2400GE w/ Radeon Vega Graphics

I changed the logic to read config to get max banks and counters
before checking if counters are writable and tried writing to all.
The result is the same and all of them aren't writable. However,
when disable the writable check and assume they are, I can run

perf stat -e 'amd_iommu_0 on all events and get data.

perf stat -e 'amd_iommu_0/cmd_processed/' sleep 10

  Performance counter stats for 'system wide':

                 56      amd_iommu_0/cmd_processed/ 


       10.001525171 seconds time elapsed


perf stat -a -e amd_iommu/mem_trans_total/ sleep 10

  Performance counter stats for 'system wide':

              2,696      amd_iommu/mem_trans_total/ 


       10.001465115 seconds time elapsed

I tried all possible events listed under amd_iommu_0 and I can get
data on all of them. No problems in dmesg.

Is this inline with what you expect? I am curious what this write
tell us and can we enable read only mode on these counters?

> 
> By the way, here is the output from booting the system with this patch 
> (+ debug messages).
> 
> [   14.408834] pci 0000:60:00.2: AMD-Vi: IOMMU performance counters 
> supported
> [   14.416526] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
> [   14.429602] pci 0000:40:00.2: AMD-Vi: IOMMU performance counters 
> supported
> [   14.437275] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
> [   14.450320] pci 0000:20:00.2: AMD-Vi: IOMMU performance counters 
> supported
> [   14.457991] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
> [   14.471049] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
> supported
> [   14.478722] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
> 
> Also, here is the perf amd_iommu testing.
> 
> # perf stat -e 'amd_iommu_0/cmd_processed/,\
>          amd_iommu_1/cmd_processed/,\
>          amd_iommu_2/cmd_processed/,\
>          amd_iommu_3/cmd_processed/'
> 
>   Performance counter stats for 'system wide':
> 
>                 204      amd_iommu_0/cmd_processed/
>                   0      amd_iommu_1/cmd_processed/
>                 472      amd_iommu_2/cmd_processed/
>                   2      amd_iommu_3/cmd_processed/
> 
>        10.198257728 seconds time elapsed
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 

Thanks for testing it.

-- Shuah
