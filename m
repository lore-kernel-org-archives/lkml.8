Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05820730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fNlj5grk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgDGTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:36:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45996 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:36:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 037JabDC024925;
        Tue, 7 Apr 2020 14:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586288197;
        bh=qXO+CEBbW20kZSlZvvG5fTSeziOe0x+altp1AXlXAF4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fNlj5grkvpVCV0udFKSXYeM1zzM+gVxHRk7f4J3ety+prQdbGW9VQn55VB54ThoBO
         dGHN0uHqRmWsuz/OCpg+53KaEtVOG1iyP45DtT7tYrwZBo3inetFcGW3jXySfD7PQF
         85FrJBmuXBXEVOZd0B68xuLiJNeHRnluozFwesMU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 037JabMQ083240
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Apr 2020 14:36:37 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Apr
 2020 14:36:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Apr 2020 14:36:36 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 037Jaa4C061276;
        Tue, 7 Apr 2020 14:36:36 -0500
Subject: Re: [PATCH v2 1/2] remoteproc: fall back to using parent memory pool
 if no dedicated available
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200319162321.20632-1-s-anna@ti.com>
 <20200319162321.20632-2-s-anna@ti.com> <20200325203812.GA9384@xps15>
 <207036a8-b34e-6311-5ad6-3289eb9f7a06@ti.com>
 <CANLsYkzU79LDVWO=wtoOY-=iW0a4EUf5sruwWicyj+2EAFZ4rg@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <31e64312-c80c-a1a8-a8cb-c87e54233d4f@ti.com>
Date:   Tue, 7 Apr 2020 14:36:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkzU79LDVWO=wtoOY-=iW0a4EUf5sruwWicyj+2EAFZ4rg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 3/27/20 4:09 PM, Mathieu Poirier wrote:
> On Wed, 25 Mar 2020 at 17:39, Suman Anna <s-anna@ti.com> wrote:
>>
>> Hi Mathieu,
>>
>> On 3/25/20 3:38 PM, Mathieu Poirier wrote:
>>> On Thu, Mar 19, 2020 at 11:23:20AM -0500, Suman Anna wrote:
>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>
>>>> In some cases, like with OMAP remoteproc, we are not creating dedicated
>>>> memory pool for the virtio device. Instead, we use the same memory pool
>>>> for all shared memories. The current virtio memory pool handling forces
>>>> a split between these two, as a separate device is created for it,
>>>> causing memory to be allocated from bad location if the dedicated pool
>>>> is not available. Fix this by falling back to using the parent device
>>>> memory pool if dedicated is not available.
>>>>
>>>> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>> v2:
>>>>  - Address Arnaud's concerns about hard-coded memory-region index 0
>>>>  - Update the comment around the new code addition
>>>> v1: https://patchwork.kernel.org/patch/11422721/
>>>>
>>>>  drivers/remoteproc/remoteproc_virtio.c | 15 +++++++++++++++
>>>>  include/linux/remoteproc.h             |  2 ++
>>>>  2 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
>>>> index eb817132bc5f..b687715cdf4b 100644
>>>> --- a/drivers/remoteproc/remoteproc_virtio.c
>>>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>>>> @@ -369,6 +369,21 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>>>>                              goto out;
>>>>                      }
>>>>              }
>>>> +    } else {
>>>> +            struct device_node *np = rproc->dev.parent->of_node;
>>>> +
>>>> +            /*
>>>> +             * If we don't have dedicated buffer, just attempt to re-assign
>>>> +             * the reserved memory from our parent. A default memory-region
>>>> +             * at index 0 from the parent's memory-regions is assigned for
>>>> +             * the rvdev dev to allocate from, and this can be customized
>>>> +             * by updating the vdevbuf_mem_id in platform drivers if
>>>> +             * desired. Failure is non-critical and the allocations will
>>>> +             * fall back to global pools, so don't check return value
>>>> +             * either.
>>>
>>> I'm perplex...  In the changelog it is indicated that if a memory pool is
>>> not dedicated allocation happens from a bad location but here failure of
>>> getting a hold of a dedicated memory pool is not critical.
>>
>> So, the comment here is a generic one while the bad location part in the
>> commit description is actually from OMAP remoteproc usage perspective
>> (if you remember the dev_warn messages we added to the memory-region
>> parse logic in the driver).
> 
> I can't tell... Are you referring to the comment lines after
> of_reserved_mem_device_init() in omap_rproc_probe()?

Yes indeed, the dev_warn traces after of_reserved_mem_device_init().

> 
>>
>> Before the fixed-memory carveout support, all the DMA allocations in
>> remoteproc core were made from the rproc platform device's DMA pool (
>> which can be NULL). That is lost after the fixed-memory support, and
>> they were always allocated from global DMA pools if no dedicated pools
>> are used. After this patch, that continues to be case for drivers that
>> still do not use any dedicated pools, while it does restore the usage of
>> the platform device's DMA pool if a driver uses one (OMAP remoteproc
>> falls into the latter).
>>
>>>
>>>> +             */
>>>> +            of_reserved_mem_device_init_by_idx(dev, np,
>>>> +                                               rproc->vdevbuf_mem_id);
>>>
>>> I wonder if using an index setup by platform code is really the best way
>>> forward when we already have the carveout mechanic available to us.  I see the
>>> platform code adding a carveout that would have the same name as rproc->name.
>>> From there in rproc_add_virtio_dev() we could have something like:
>>>
>>>         mem = rproc_find_carveout_by_name(rproc, "%s", rproc->name);
>>>
>>>
>>> That would be very flexible, the location of the reserved memory withing the
>>> memory-region could change without fear of breaking things and no need to add to
>>> struct rproc.
>>>
>>> Let me know what you think.
>>
>> I think that can work as well but I feel it is lot more cumbersome. It
>> does require every platform driver to add code adding/registering that
>> carveout, and parse the reserved memory region etc. End of the day, we
>> rely on DMA API and we just have to assign the region to the newly
>> created device. The DMA pool assignment for devices using
>> reserved-memory nodes has simply been the of_reserved_mem_device_init()
>> function.
> 
> Given all the things happening in the platform drivers adding and
> registering a single carveout doesn't seem that onerous to me.   I
> also expect setting rproc->vdevbuf_mem_id would involve some form of
> parsing.  

So, no additional parsing other than to know which id if you have
multiple regions. A device can only be assigned one default DMA/CMA pool
to use with the DMA API. One would need to add the assignment statement
only if region 0 is not being used as the device DMA-API pool.

Lastly if a couple of platforms end up doing the same thing
> might as well bring the code in the core, hence choosing a generic
> name such as rproc->name for the memory region.

That is actually lot more code than the current code. First you would
need to lookup and parse the reserved mem to get the address and size to
initialize the rproc mem structure, and then use the filled in values to
declare the DMA pool.

> 
> At the very least I would use of_reserved_mem_device_init_by_idx(dev,
> np, 0).  I agree it is not flexible but I'll take that over adding a
> new field to structure rproc.

Yep, I started out indeed with exactly that code in v1, and only
introduced the new field to address Arnaud's comments. Even the new
field is intrinsically initialized to 0, so the code is equivalent, and
supports the cases in case you need to use a different reserved-memory
region than at index 0.

regards
Suman


> 
> Thanks,
> Mathieu
> 
>>
>> regards
>> Suman
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>>      }
>>>>
>>>>      /* Allocate virtio device */
>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>> index ed127b2d35ca..07bd73a6d72a 100644
>>>> --- a/include/linux/remoteproc.h
>>>> +++ b/include/linux/remoteproc.h
>>>> @@ -481,6 +481,7 @@ struct rproc_dump_segment {
>>>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>>>>   * @dump_segments: list of segments in the firmware
>>>>   * @nb_vdev: number of vdev currently handled by rproc
>>>> + * @vdevbuf_mem_id: default memory-region index for allocating vdev buffers
>>>>   */
>>>>  struct rproc {
>>>>      struct list_head node;
>>>> @@ -514,6 +515,7 @@ struct rproc {
>>>>      bool auto_boot;
>>>>      struct list_head dump_segments;
>>>>      int nb_vdev;
>>>> +    u8 vdevbuf_mem_id;
>>>>      u8 elf_class;
>>>>  };
>>>>
>>>> --
>>>> 2.23.0
>>>>
>>

