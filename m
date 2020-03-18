Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C46C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27D620724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Haegrmno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCRR3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:29:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3844 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726680AbgCRR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:29:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IHQvxN021219;
        Wed, 18 Mar 2020 18:29:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DLuEaticBOxZPRiG0ghZvKKxllUa/anY8IH2xUyWjYk=;
 b=HaegrmnoWeCic3aQMM/PR6nzvB3fzyuh1cLxzMlNQHLjC+6qeEOsNJ+fYdkJnXR+uIwk
 kf7KF3cQMw2Vo6ZE7JHI8ixelYl/qQP0jyNNpE8B88psaQO5Bhda1jLthOr5h1joS/x4
 UMA2BmVr6I4ARkQFvs1oxwV7W8s+V96YLGRruj3kSSA0H7b2jve1ethIo6fsLm+gLctf
 bMqwEiEt+6HvLeJQdEMmKu6FJ/I3+USv58yoo+51cWuLnn8KUFh6KA6Wru3/f76vavi5
 2ZF9tqxiurbAx2by3HUV+3wEHe3pJ9MaQHRm7IWtMAslhykykE+iUV/GZsWfJIIh00u/ +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yua4wcq8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 18:29:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DBFD010002A;
        Wed, 18 Mar 2020 18:29:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8B972BC7AF;
        Wed, 18 Mar 2020 18:29:15 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 18:29:14 +0100
Subject: Re: [PATCH 1/2] remoteproc: fall back to using parent memory pool if
 no dedicated available
To:     Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-2-s-anna@ti.com>
 <ce37072d2f304214aa920e66fa3b30b1@SFHDAG3NODE1.st.com>
 <d71d6061-2bfe-e8be-857b-67b22493aeab@ti.com>
 <46d1fadd-1935-ab63-db41-89afaac79e21@ti.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <41d6734c-3fcb-499b-e1ba-09825ffc2957@st.com>
Date:   Wed, 18 Mar 2020 18:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <46d1fadd-1935-ab63-db41-89afaac79e21@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On 3/18/20 5:19 PM, Suman Anna wrote:
> Hi Arnaud,
> 
> On 3/18/20 4:37 AM, Tero Kristo wrote:
>> On 13/03/2020 18:52, Arnaud POULIQUEN wrote:
>>> Hi Suman,
>>>
>>>> -----Original Message-----
>>>> From: Suman Anna <s-anna@ti.com>
>>>> Sent: jeudi 5 mars 2020 23:41
>>>> To: Bjorn Andersson <bjorn.andersson@linaro.org>; Loic PALLARDY
>>>> <loic.pallardy@st.com>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>; Arnaud POULIQUEN
>>>> <arnaud.pouliquen@st.com>; Tero Kristo <t-kristo@ti.com>; linux-
>>>> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Suman Anna
>>>> <s-anna@ti.com>
>>>> Subject: [PATCH 1/2] remoteproc: fall back to using parent memory
>>>> pool if no
>>>> dedicated available
>>>>
>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> In some cases, like with OMAP remoteproc, we are not creating dedicated
>>>> memory pool for the virtio device. Instead, we use the same memory pool
>>>> for all shared memories. The current virtio memory pool handling
>>>> forces a
>>>> split between these two, as a separate device is created for it, causing
>>>> memory to be allocated from bad location if the dedicated pool is not
>>>> available. Fix this by falling back to using the parent device memory
>>>> pool if
>>>> dedicated is not available.
>>>>
>>>> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific
>>>> dma
>>>> memory pool")
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>>   drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_virtio.c
>>>> b/drivers/remoteproc/remoteproc_virtio.c
>>>> index 8c07cb2ca8ba..4723ebe574b8 100644
>>>> --- a/drivers/remoteproc/remoteproc_virtio.c
>>>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>>>> @@ -368,6 +368,16 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev,
>>>> int id)
>>>>                   goto out;
>>>>               }
>>>>           }
>>>> +    } else {
>>>> +        struct device_node *np = rproc->dev.parent->of_node;
>>>> +
>>>> +        /*
>>>> +         * If we don't have dedicated buffer, just attempt to
>>>> +         * re-assign the reserved memory from our parent.
>>>> +         * Failure is non-critical so don't check return value
>>>> +         * either.
>>>> +         */
>>>> +        of_reserved_mem_device_init_by_idx(dev, np, 0);
>>>>       }
>>> I aven't tested your patchset yet, but reviewing you code,  I wonder
>>> if you cannot declare your  memory pool
>>> in your platform driver using  rproc_of_resm_mem_entry_init. 
> 
> The patch actually provides a fallback option and even now this path is
> entered only when there are no dedicated pools. This restores the code
> to how the allocations were made prior to the fixed memory carveout
> changes. If the remoteproc drivers themselves do not use any DMA/CMA
> pools, then nothing changes and allocations continue to be made from the
> global pools.

If there is no dedicated pool, no need to associate a memory pool here,
The allocation by default should be done in the global pools if not pool
is associated to the vdev.
Only a global pool assigned to a rproc is not treated as you mention.    

> 
> Something
>>> like:
>>>     struct device_node *mem_node;
>>>     struct reserved_mem *rmem;
>>>
>>>     mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
>>>     rmem = of_reserved_mem_lookup(mem_node);
>>>     mem = rproc_of_resm_mem_entry_init(dev, 0,
>>>                                rmem->size,
>>>                                rmem->base,
>>>                                " vdev0buffer");
>>>
>>> A main advantage of this implementation would be that the index of the
>>> memory region would not be hard coded to 0.
> 
> The 0 is the default (equivalent to of_reserved_mem_device_init(), but
> we can't use that function here since dev and np are different).
> 
> While your suggestion does work for us, this does bring in the knowledge
> of how many vdevs a remoteproc driver is supporting. It is fine for
> remoteproc drivers that are designed exactly for a known number of vdevs
> and/or fixed pools to use the above function, but every other remoteproc
> driver would have to repeat similar code. Given that the number of vdevs
> are currently defined through the resource table and can change from
> firmware to firmware, I think this fallback option patch is the better
> scalable solution.

Yes you right this supposes that the number of vdev is limited and known, so
not enough scalable.

From MPOV what is restrictive here is the index forced to 0. 
This implementation would impose to declare first the global memory for the vdevs 
then other memory regions (e.g memory reserved for firmware code loading). 
Need at minimum to be documented this restriction...

A alternative would be to use resource table carveout to declare region, but 
this would probably break compatibility with legacy remote firmware...

A second alternative could be to define a specific name for a rproc default memory pool.
and then look for it. 

Regards,
Arnaud

> 
> Let's see if others have any opinion on this.
> 
> regards
> Suman
> 
>>
>> It seems like that would work for us also, and thus this patch can be
>> dropped. See the following patch. Suman, any comments on this? If this
>> seems acceptable, I can send this as a proper patch to the list.
>>
>> ------
>>
>> From: Tero Kristo <t-kristo@ti.com>
>> Date: Wed, 18 Mar 2020 11:22:58 +0200
>> Subject: [PATCH] remoteproc/omap: Allocate vdev0buffer memory from
>>  reserved memory pool
>>
>> Since 086d08725d34 ("remoteproc: create vdev subdevice with specific dma
>> memory pool"), remoteprocs must allocate separate vdev memory buffer. As
>> OMAP remoteproc does not do this yet, the memory gets allocated from
>> default DMA pool, and this memory is not suitable for the use. To fix
>> the issue, map the vdev0buffer to use the same device reserved memory
>> pool as the rest of the remoteproc.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>  drivers/remoteproc/omap_remoteproc.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/remoteproc/omap_remoteproc.c
>> b/drivers/remoteproc/omap_remoteproc.c
>> index 29d19a608af8..024330e31a9e 100644
>> --- a/drivers/remoteproc/omap_remoteproc.c
>> +++ b/drivers/remoteproc/omap_remoteproc.c
>> @@ -1273,6 +1273,9 @@ static int omap_rproc_probe(struct platform_device
>> *pdev)
>>      const char *firmware;
>>      int ret;
>>      struct reset_control *reset;
>> +    struct device_node *mem_node;
>> +    struct reserved_mem *rmem;
>> +    struct rproc_mem_entry *mem;
>>
>>      if (!np) {
>>          dev_err(&pdev->dev, "only DT-based devices are supported\n");
>> @@ -1335,6 +1338,19 @@ static int omap_rproc_probe(struct
>> platform_device *pdev)
>>          dev_warn(&pdev->dev, "device does not have specific CMA pool.\n");
>>          dev_warn(&pdev->dev, "Typically this should be provided,\n");
>>          dev_warn(&pdev->dev, "only omit if you know what you are
>> doing.\n");
>> +    } else {
>> +        mem_node = of_parse_phandle(pdev->dev.of_node, "memory-region",
>> +                        0);
>> +        rmem = of_reserved_mem_lookup(mem_node);
>> +        mem = rproc_of_resm_mem_entry_init(&pdev->dev, 0, rmem->size,
>> +                           rmem->base, "vdev0buffer");
>> +
>> +        if (!mem) {
>> +            ret = -ENOMEM;
>> +            goto release_mem;
>> +        }
>> +
>> +        rproc_add_carveout(rproc, mem);
>>      }
>>
>>      platform_set_drvdata(pdev, rproc);
> 
