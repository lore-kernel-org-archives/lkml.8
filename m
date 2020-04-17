Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4820C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB762078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8TsQw5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDQQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:44:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgDQQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:44:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HGi2TM068609;
        Fri, 17 Apr 2020 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587141842;
        bh=C5ZM4aWfGtnuHTTZhSX2+Ie3wR/ZWNt+wWMfl4WFyjA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I8TsQw5wscZJzhL59S3kv1u03/ko87NgrRv5Nv0IkzxyPIEVBvm+dB+rnjKVEbNFE
         +eP8KgVWp1D6VHHrOP1/9a5ewGPTtcKCcU7giky1I3zj9fm4R8acYYpLMA6ahxJure
         Da/JyVm797QdnsH0EhCwRLaf9hFZotdo8HveW7IM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HGi1SA056616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 11:44:02 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 11:44:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 11:44:01 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HGi14L095536;
        Fri, 17 Apr 2020 11:44:01 -0500
Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf segments
To:     Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <20200410012034.GU20625@builder.lan>
 <AM0PR04MB44816C59A9BE84465AC8F2C388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200411015104.GJ576963@builder.lan>
 <AM0PR04MB4481CF4ACD86C69B329D5F2188DD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <07eb5b9f-60cd-6555-1904-7b348bdc43f2@ti.com>
Date:   Fri, 17 Apr 2020 11:43:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481CF4ACD86C69B329D5F2188DD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 4:05 AM, Peng Fan wrote:
> 
>> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
>> segments
>>
>> On Thu 09 Apr 18:29 PDT 2020, Peng Fan wrote:
>>
>>> Hi Bjorn,
>>>
>>>> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
>>>> segments
>>>>
>>>> On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
>>>>
>>>>> To arm64, "dc      zva, dst" is used in memset.
>>>>> Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
>>>>>
>>>>> "If the memory region being zeroed is any type of Device memory,
>>>>> this instruction can give an alignment fault which is prioritized
>>>>> in the same way as other alignment faults that are determined by
>>>>> the memory type."
>>>>>
>>>>> On i.MX platforms, when elf is loaded to onchip TCM area, the
>>>>> region is ioremapped, so "dc zva, dst" will trigger abort.
>>>>>
>>>>> Since memset is not strictly required, let's drop it.
>>>>>
>>>>
>>>> This would imply that we trust that the firmware doesn't expect
>>>> remoteproc to zero out the memory, which we've always done. So I
>>>> don't think we can say that it's not required.
>>>
>>> Saying an image runs on a remote core needs Linux to help zero out BSS
>>> section, this not make sense to me.
>>
>> Maybe not, but it has always done it, so if there's firmware out there that
>> depends on it such change would break them..
> 
> Got it.
> 
>>
>>> My case is as following, I need to load section 7 data.
>>> I no need to let remoteproc to memset section 8/9/10/11/12, the
>>> firmware itself could handle that. Just because the memsz is larger
>>> than filesz, remoreproc must memset?
>>
>> By having a PT_LOAD segment covering these I think it's reasonable to
>> assume that the ELF loader should be able to touch the associated memory.
>>
>>> Section Headers:
>>>    [Nr] Name              Type            Addr     Off    Size
>> ES Flg Lk Inf Al
>>>    [ 0]                   NULL            00000000 000000
>> 000000 00      0   0  0
>>>    [ 1] .interrupts       PROGBITS        1ffe0000 010000 000240 00
>> A  0   0  4
>>>    [ 2] .resource_table   PROGBITS        1ffe0240 010240 000058 00
>> A  0   0  1
>>>    [ 3] .text             PROGBITS        1ffe02a0 0102a0 009ccc 00
>> AX  0   0 16
>>>    [ 4] .ARM              ARM_EXIDX       1ffe9f6c 019f6c 000008
>> 00  AL  3   0  4
>>>    [ 5] .init_array       INIT_ARRAY      1ffe9f74 019f74 000004 04
>> WA  0   0  4
>>>    [ 6] .fini_array       FINI_ARRAY      1ffe9f78 019f78 000004 04
>> WA  0   0  4
>>>    [ 7] .data             PROGBITS        1fff9240 029240 000084
>> 00  WA  0   0  4
>>>    [ 8] .ncache.init      PROGBITS        1fff92c4 0292c4 000000 00
>> W  0   0  1
>>>    [ 9] .ncache           NOBITS          1fff92c4 0292c4 000a80
>> 00  WA  0   0  4
>>>    [10] .bss              NOBITS          1fff9d44 0292c4 01f5c0
>> 00  WA  0   0  4
>>>    [11] .heap             NOBITS          20019304 0292c4 000404
>> 00  WA  0   0  1
>>>    [12] .stack            NOBITS          20019708 0292c4 000400
>> 00  WA  0   0  1
>>>
>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>   drivers/remoteproc/remoteproc_elf_loader.c | 7 ++-----
>>>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
>>>>> b/drivers/remoteproc/remoteproc_elf_loader.c
>>>>> index 16e2c496fd45..cc50fe70d50c 100644
>>>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>>>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>>>>> @@ -238,14 +238,11 @@ int rproc_elf_load_segments(struct rproc
>>>>> *rproc,
>>>> const struct firmware *fw)
>>>>>   			memcpy(ptr, elf_data + offset, filesz);
>>>>>
>>>>>   		/*
>>>>> -		 * Zero out remaining memory for this segment.
>>>>> +		 * No need zero out remaining memory for this segment.
>>>>>   		 *
>>>>>   		 * This isn't strictly required since dma_alloc_coherent already
>>>>> -		 * did this for us. albeit harmless, we may consider removing
>>>>> -		 * this.
>>>>> +		 * did this for us.
>>>>
>>>> In the case of recovery this comment is wrong, we do not
>>>> dma_alloc_coherent() the carveout during a recovery.
>>>
>>> Isn't the it the firmware's job to memset the region?
>>>
>>
>> I'm not aware of this being a documented requirement, we've always done it
>> here for them, so removing this call would be a change in behavior.
>>
>>>>
>>>> And in your case you ioremapped existing TCM, so it's never true.
>>>>
>>>>>   		 */
>>>>> -		if (memsz > filesz)
>>>>> -			memset(ptr + filesz, 0, memsz - filesz);
>>>>
>>>> So I think you do want to zero out this region. Question is how we do it...
>>>
>>> I have contacted our M4 owners, we no need clear it from Linux side.
>>
>> And I think _most_ firmware out there, like yours, does clear BSS etc during
>> initialization.
>>
>>> We also support booting m4 before booting Linux, at that case, Linux
>>> has noting to do with memset. It is just I try loading m4 image with
>>> Linux, and met the issue that memset trigger abort.
>>>
>>
>> Please see the proposal for attaching to already running remoteproc's from
>> Mathieu. I don't expect that you want to load your PROGBITS either in this
>> case?
> 
> No need to load for early boot case. It is just userspace load trigger
> kernel panic, because memset arm64 could not work for ioremapped memory.
> 
> How about adding ops hooks for memset and memcpy to let driver
> have their own implementation?

Hi Peng,

The trick is to use the ioremap_wc() variant instead of ioremap() in 
your platform driver while mapping the TCMs. I know multiple folks have 
run into this issue. This is what most of the remoteproc drivers use, 
and mmio-sram driver also uses the same.

regards
Suman
