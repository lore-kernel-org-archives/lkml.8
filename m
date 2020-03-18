Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064720719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pQvVOy0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCRQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:19:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41814 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgCRQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:19:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02IGJHdo120797;
        Wed, 18 Mar 2020 11:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584548357;
        bh=JoRXXGAZSEJHCSyleL2XBkBbbnRu/mpxxfYt8wd+af4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pQvVOy0i7LiO4yxpx8r7T+WaNd+DUoZud17nesU4d8Q9h9q2eDJxh84801rkKS/Zx
         /WULUB6i5qP7Oj1+duPTq7SF0TrKAxP7UkT4YyTe7ins89txnmGgM+1f2H5TfowcvS
         DpKo0x8K0DWjafKYQpBeO/37+5Q+LcpT7qXNWC6s=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02IGJHuA014013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 11:19:17 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 11:19:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 11:19:17 -0500
Received: from [10.250.35.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02IGJHWh124741;
        Wed, 18 Mar 2020 11:19:17 -0500
Subject: Re: [PATCH 1/2] remoteproc: fall back to using parent memory pool if
 no dedicated available
To:     Tero Kristo <t-kristo@ti.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-2-s-anna@ti.com>
 <ce37072d2f304214aa920e66fa3b30b1@SFHDAG3NODE1.st.com>
 <d71d6061-2bfe-e8be-857b-67b22493aeab@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <46d1fadd-1935-ab63-db41-89afaac79e21@ti.com>
Date:   Wed, 18 Mar 2020 11:19:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d71d6061-2bfe-e8be-857b-67b22493aeab@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On 3/18/20 4:37 AM, Tero Kristo wrote:
> On 13/03/2020 18:52, Arnaud POULIQUEN wrote:
>> Hi Suman,
>>
>>> -----Original Message-----
>>> From: Suman Anna <s-anna@ti.com>
>>> Sent: jeudi 5 mars 2020 23:41
>>> To: Bjorn Andersson <bjorn.andersson@linaro.org>; Loic PALLARDY
>>> <loic.pallardy@st.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>; Arnaud POULIQUEN
>>> <arnaud.pouliquen@st.com>; Tero Kristo <t-kristo@ti.com>; linux-
>>> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Suman Anna
>>> <s-anna@ti.com>
>>> Subject: [PATCH 1/2] remoteproc: fall back to using parent memory
>>> pool if no
>>> dedicated available
>>>
>>> From: Tero Kristo <t-kristo@ti.com>
>>>
>>> In some cases, like with OMAP remoteproc, we are not creating dedicated
>>> memory pool for the virtio device. Instead, we use the same memory pool
>>> for all shared memories. The current virtio memory pool handling
>>> forces a
>>> split between these two, as a separate device is created for it, causing
>>> memory to be allocated from bad location if the dedicated pool is not
>>> available. Fix this by falling back to using the parent device memory
>>> pool if
>>> dedicated is not available.
>>>
>>> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific
>>> dma
>>> memory pool")
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>>   drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_virtio.c
>>> b/drivers/remoteproc/remoteproc_virtio.c
>>> index 8c07cb2ca8ba..4723ebe574b8 100644
>>> --- a/drivers/remoteproc/remoteproc_virtio.c
>>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>>> @@ -368,6 +368,16 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev,
>>> int id)
>>>                   goto out;
>>>               }
>>>           }
>>> +    } else {
>>> +        struct device_node *np = rproc->dev.parent->of_node;
>>> +
>>> +        /*
>>> +         * If we don't have dedicated buffer, just attempt to
>>> +         * re-assign the reserved memory from our parent.
>>> +         * Failure is non-critical so don't check return value
>>> +         * either.
>>> +         */
>>> +        of_reserved_mem_device_init_by_idx(dev, np, 0);
>>>       }
>> I aven't tested your patchset yet, but reviewing you code,  I wonder
>> if you cannot declare your  memory pool
>> in your platform driver using  rproc_of_resm_mem_entry_init. 

The patch actually provides a fallback option and even now this path is
entered only when there are no dedicated pools. This restores the code
to how the allocations were made prior to the fixed memory carveout
changes. If the remoteproc drivers themselves do not use any DMA/CMA
pools, then nothing changes and allocations continue to be made from the
global pools.

Something
>> like:
>>     struct device_node *mem_node;
>>     struct reserved_mem *rmem;
>>
>>     mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
>>     rmem = of_reserved_mem_lookup(mem_node);
>>     mem = rproc_of_resm_mem_entry_init(dev, 0,
>>                                rmem->size,
>>                                rmem->base,
>>                                " vdev0buffer");
>>
>> A main advantage of this implementation would be that the index of the
>> memory region would not be hard coded to 0.

The 0 is the default (equivalent to of_reserved_mem_device_init(), but
we can't use that function here since dev and np are different).

While your suggestion does work for us, this does bring in the knowledge
of how many vdevs a remoteproc driver is supporting. It is fine for
remoteproc drivers that are designed exactly for a known number of vdevs
and/or fixed pools to use the above function, but every other remoteproc
driver would have to repeat similar code. Given that the number of vdevs
are currently defined through the resource table and can change from
firmware to firmware, I think this fallback option patch is the better
scalable solution.

Let's see if others have any opinion on this.

regards
Suman

> 
> It seems like that would work for us also, and thus this patch can be
> dropped. See the following patch. Suman, any comments on this? If this
> seems acceptable, I can send this as a proper patch to the list.
> 
> ------
> 
> From: Tero Kristo <t-kristo@ti.com>
> Date: Wed, 18 Mar 2020 11:22:58 +0200
> Subject: [PATCH] remoteproc/omap: Allocate vdev0buffer memory from
>  reserved memory pool
> 
> Since 086d08725d34 ("remoteproc: create vdev subdevice with specific dma
> memory pool"), remoteprocs must allocate separate vdev memory buffer. As
> OMAP remoteproc does not do this yet, the memory gets allocated from
> default DMA pool, and this memory is not suitable for the use. To fix
> the issue, map the vdev0buffer to use the same device reserved memory
> pool as the rest of the remoteproc.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c
> b/drivers/remoteproc/omap_remoteproc.c
> index 29d19a608af8..024330e31a9e 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -1273,6 +1273,9 @@ static int omap_rproc_probe(struct platform_device
> *pdev)
>      const char *firmware;
>      int ret;
>      struct reset_control *reset;
> +    struct device_node *mem_node;
> +    struct reserved_mem *rmem;
> +    struct rproc_mem_entry *mem;
> 
>      if (!np) {
>          dev_err(&pdev->dev, "only DT-based devices are supported\n");
> @@ -1335,6 +1338,19 @@ static int omap_rproc_probe(struct
> platform_device *pdev)
>          dev_warn(&pdev->dev, "device does not have specific CMA pool.\n");
>          dev_warn(&pdev->dev, "Typically this should be provided,\n");
>          dev_warn(&pdev->dev, "only omit if you know what you are
> doing.\n");
> +    } else {
> +        mem_node = of_parse_phandle(pdev->dev.of_node, "memory-region",
> +                        0);
> +        rmem = of_reserved_mem_lookup(mem_node);
> +        mem = rproc_of_resm_mem_entry_init(&pdev->dev, 0, rmem->size,
> +                           rmem->base, "vdev0buffer");
> +
> +        if (!mem) {
> +            ret = -ENOMEM;
> +            goto release_mem;
> +        }
> +
> +        rproc_add_carveout(rproc, mem);
>      }
> 
>      platform_set_drvdata(pdev, rproc);

