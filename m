Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C6C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63E9206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yh34QAZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgDUSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:25:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51182 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:25:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03LIPiBP078591;
        Tue, 21 Apr 2020 13:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587493544;
        bh=0rKeFaXuJ6nfYmaZnZdiSCGcrH9DLFU2XypMpmdekMc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Yh34QAZiP+GaMiBKGFj5Q7JtO368ZGShL8xTe7wswUn90B/5IcK3V4t38El6uQadG
         tFMZKl6An0I1UeXv9zQOTOROyPM7RorN+wGyKL+geevg9+e7A5j9Hly6CicqI8HbSD
         AizsWQNWuSKQWpIMFO1ooLeMA67j3Ii3c5pIRPdY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03LIPio8000987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Apr 2020 13:25:44 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Apr 2020 13:25:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Apr 2020 13:25:43 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03LIPhpa068658;
        Tue, 21 Apr 2020 13:25:43 -0500
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
 <07eb5b9f-60cd-6555-1904-7b348bdc43f2@ti.com>
 <DB6PR0402MB2760A0F6D7BC0F5AC7207E1188D50@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <aff9b0dc-12e0-18a3-ed67-e3bed0424662@ti.com>
Date:   Tue, 21 Apr 2020 13:25:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB2760A0F6D7BC0F5AC7207E1188D50@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 2:42 AM, Peng Fan wrote:
>> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
>> segments
>>
>> On 4/13/20 4:05 AM, Peng Fan wrote:
>>>
>>>> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
>>>> segments
>>>>
>>>> On Thu 09 Apr 18:29 PDT 2020, Peng Fan wrote:
>>>>
>>>>> Hi Bjorn,
>>>>>
>>>>>> Subject: Re: [PATCH 1/2] remoteproc: drop memset when loading elf
>>>>>> segments
>>>>>>
>>>>>> On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
>>>>>>
>>>>>>> To arm64, "dc      zva, dst" is used in memset.
>>>>>>> Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,
>>>>>>>
>>>>>>> "If the memory region being zeroed is any type of Device memory,
>>>>>>> this instruction can give an alignment fault which is prioritized
>>>>>>> in the same way as other alignment faults that are determined by
>>>>>>> the memory type."
>>>>>>>
>>>>>>> On i.MX platforms, when elf is loaded to onchip TCM area, the
>>>>>>> region is ioremapped, so "dc zva, dst" will trigger abort.
>>>>>>>
>>>>>>> Since memset is not strictly required, let's drop it.
>>>>>>>
>>>>>>
>>>>>> This would imply that we trust that the firmware doesn't expect
>>>>>> remoteproc to zero out the memory, which we've always done. So I
>>>>>> don't think we can say that it's not required.
>>>>>
>>>>> Saying an image runs on a remote core needs Linux to help zero out
>>>>> BSS section, this not make sense to me.
>>>>
>>>> Maybe not, but it has always done it, so if there's firmware out
>>>> there that depends on it such change would break them..
>>>
>>> Got it.
>>>
>>>>
>>>>> My case is as following, I need to load section 7 data.
>>>>> I no need to let remoteproc to memset section 8/9/10/11/12, the
>>>>> firmware itself could handle that. Just because the memsz is larger
>>>>> than filesz, remoreproc must memset?
>>>>
>>>> By having a PT_LOAD segment covering these I think it's reasonable to
>>>> assume that the ELF loader should be able to touch the associated
>> memory.
>>>>
>>>>> Section Headers:
>>>>>     [Nr] Name              Type            Addr     Off
>> Size
>>>> ES Flg Lk Inf Al
>>>>>     [ 0]                   NULL            00000000 000000
>>>> 000000 00      0   0  0
>>>>>     [ 1] .interrupts       PROGBITS        1ffe0000 010000 000240
>> 00
>>>> A  0   0  4
>>>>>     [ 2] .resource_table   PROGBITS        1ffe0240 010240 000058
>> 00
>>>> A  0   0  1
>>>>>     [ 3] .text             PROGBITS        1ffe02a0 0102a0
>> 009ccc 00
>>>> AX  0   0 16
>>>>>     [ 4] .ARM              ARM_EXIDX       1ffe9f6c 019f6c
>> 000008
>>>> 00  AL  3   0  4
>>>>>     [ 5] .init_array       INIT_ARRAY      1ffe9f74 019f74 000004
>> 04
>>>> WA  0   0  4
>>>>>     [ 6] .fini_array       FINI_ARRAY      1ffe9f78 019f78 000004
>> 04
>>>> WA  0   0  4
>>>>>     [ 7] .data             PROGBITS        1fff9240 029240
>> 000084
>>>> 00  WA  0   0  4
>>>>>     [ 8] .ncache.init      PROGBITS        1fff92c4 0292c4 000000
>> 00
>>>> W  0   0  1
>>>>>     [ 9] .ncache           NOBITS          1fff92c4 0292c4
>> 000a80
>>>> 00  WA  0   0  4
>>>>>     [10] .bss              NOBITS          1fff9d44 0292c4
>> 01f5c0
>>>> 00  WA  0   0  4
>>>>>     [11] .heap             NOBITS          20019304 0292c4
>> 000404
>>>> 00  WA  0   0  1
>>>>>     [12] .stack            NOBITS          20019708 0292c4
>> 000400
>>>> 00  WA  0   0  1
>>>>>
>>>>>>
>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>>> ---
>>>>>>>    drivers/remoteproc/remoteproc_elf_loader.c | 7 ++-----
>>>>>>>    1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
>>>>>>> b/drivers/remoteproc/remoteproc_elf_loader.c
>>>>>>> index 16e2c496fd45..cc50fe70d50c 100644
>>>>>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>>>>>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>>>>>>> @@ -238,14 +238,11 @@ int rproc_elf_load_segments(struct rproc
>>>>>>> *rproc,
>>>>>> const struct firmware *fw)
>>>>>>>    			memcpy(ptr, elf_data + offset, filesz);
>>>>>>>
>>>>>>>    		/*
>>>>>>> -		 * Zero out remaining memory for this segment.
>>>>>>> +		 * No need zero out remaining memory for this segment.
>>>>>>>    		 *
>>>>>>>    		 * This isn't strictly required since dma_alloc_coherent
>> already
>>>>>>> -		 * did this for us. albeit harmless, we may consider removing
>>>>>>> -		 * this.
>>>>>>> +		 * did this for us.
>>>>>>
>>>>>> In the case of recovery this comment is wrong, we do not
>>>>>> dma_alloc_coherent() the carveout during a recovery.
>>>>>
>>>>> Isn't the it the firmware's job to memset the region?
>>>>>
>>>>
>>>> I'm not aware of this being a documented requirement, we've always
>>>> done it here for them, so removing this call would be a change in behavior.
>>>>
>>>>>>
>>>>>> And in your case you ioremapped existing TCM, so it's never true.
>>>>>>
>>>>>>>    		 */
>>>>>>> -		if (memsz > filesz)
>>>>>>> -			memset(ptr + filesz, 0, memsz - filesz);
>>>>>>
>>>>>> So I think you do want to zero out this region. Question is how we do it...
>>>>>
>>>>> I have contacted our M4 owners, we no need clear it from Linux side.
>>>>
>>>> And I think _most_ firmware out there, like yours, does clear BSS etc
>>>> during initialization.
>>>>
>>>>> We also support booting m4 before booting Linux, at that case, Linux
>>>>> has noting to do with memset. It is just I try loading m4 image with
>>>>> Linux, and met the issue that memset trigger abort.
>>>>>
>>>>
>>>> Please see the proposal for attaching to already running remoteproc's
>>>> from Mathieu. I don't expect that you want to load your PROGBITS
>>>> either in this case?
>>>
>>> No need to load for early boot case. It is just userspace load trigger
>>> kernel panic, because memset arm64 could not work for ioremapped
>> memory.
>>>
>>> How about adding ops hooks for memset and memcpy to let driver have
>>> their own implementation?
>>
>> Hi Peng,
>>
>> The trick is to use the ioremap_wc() variant instead of ioremap() in your
>> platform driver while mapping the TCMs. I know multiple folks have run into
>> this issue. This is what most of the remoteproc drivers use, and mmio-sram
>> driver also uses the same.
> 
> TCM is different from OCRAM in i.MX chips.
> ioremap_wc not work for TCM memory, I just tried that.

What ARM core is this? Is it a standard ARM TCM memory? The TCM 
interfaces from standard ARM cores in general are treated as normal 
memory, so write combine should be ok on them. When you say it doesn't 
work, whats not working - the memcpy/memset or the remoteproc doesn't boot?

> I am thinking we change memset/memcpy to use
> memset_io/memcpy_fromio/memcpy_toio for remoteproc common code,

This has other implications. Not everything is IO memory to make this 
change in the common core.

If this is a custom memory interface requiring specific handling, then 
one option is to provide and use your own ops->load function within the 
driver. This is what I do for one of our remoteprocs that requires a 
specific memcpy handling semantics.

regards
Suman
