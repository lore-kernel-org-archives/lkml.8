Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D47C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF432070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VbSKhkxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCSLl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:41:56 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38005 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgCSLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:41:56 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JBcB1X023788;
        Thu, 19 Mar 2020 12:41:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=kDMXz0MhKopx7KXlXCqnguWCVFPXUtL3vDpbb9CupGQ=;
 b=VbSKhkxrdvx9xMS/Z6/ehATeCpW224opQHWXn4vzH1n319kyhUSz3usrcQbFwssWrQz0
 LOD6ZopRbfXoQF46C+7agRLrUp8QrJG6S6GdCsZN+RZGIsdjoqC/HajPXbP4ODxXlA7m
 JGJWX6aA6Xv1AvhtBUWA6WsRegEZvODylQjRQnIos/w6XfZIDiV0J85P3/RS0f1O+tlH
 VEjK8HD2j3cH1Tq3XC3a2KWvGjGn6NcxUT/SYxn7HSQTYEJ2akyasAip87ovbmWsiicc
 haiFkA7isoKbC5cK+//PCF2xz9KQwCdzHRslmCPMI4OPy9afxsKxNJoF9p5BSVxSHlwc 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu8ethj97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 12:41:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7367B10002A;
        Thu, 19 Mar 2020 12:41:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6329D2A9704;
        Thu, 19 Mar 2020 12:41:50 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 12:41:49 +0100
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] remoteproc: Fix and restore the parenting hierarchy
 for vdev
To:     Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-3-s-anna@ti.com> <20200317180530.GA1801@xps15>
 <76772d98-93d9-e559-01b8-ba7d4d1cc1eb@st.com>
 <f08b15c2-639c-2919-e321-a5a5296e8112@ti.com>
Message-ID: <884c84e3-6eb7-165f-cbdf-ba513558ed28@st.com>
Date:   Thu, 19 Mar 2020 12:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f08b15c2-639c-2919-e321-a5a5296e8112@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_03:2020-03-19,2020-03-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Suman,

On 3/18/20 8:23 PM, Suman Anna wrote:
> Hi Arnaud,
> 
> On 3/18/20 11:38 AM, Arnaud POULIQUEN wrote:
>> Hi Suman, Mathieu,
>>
>> On 3/17/20 7:05 PM, Mathieu Poirier wrote:
>>> Hi Suman,
>>>
>>> On Thu, Mar 05, 2020 at 04:41:08PM -0600, Suman Anna wrote:
>>>> The commit 086d08725d34 ("remoteproc: create vdev subdevice with specific
>>>> dma memory pool") has introduced a new vdev subdevice for each vdev
>>>> declared in the firmware resource table and made it as the parent for the
>>>> created virtio rpmsg devices instead of the previous remoteproc device.
>>>> This changed the overall parenting hierarchy for the rpmsg devices, which
>>>> were children of virtio devices, and does not allow the corresponding
>>>> rpmsg drivers to retrieve the parent rproc device through the
>>>> rproc_get_by_child() API.
>>>>
>>>> Fix this by restoring the remoteproc device as the parent. The new vdev
>>>> subdevice can continue to inherit the DMA attributes from the remoteproc's
>>>> parent device (actual platform device).
>>>>
>>>> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>>  drivers/remoteproc/remoteproc_core.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>> index 097f33e4f1f3..ba18f32bd0c4 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -510,7 +510,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>>>>  
>>>>  	/* Initialise vdev subdevice */
>>>>  	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
>>>> -	rvdev->dev.parent = rproc->dev.parent;
>>>> +	rvdev->dev.parent = &rproc->dev;
>>>
>>> I can see how it would not be possible to retrieve the parent rproc device since
>>> rvdev->dev.parent was set to be platform device...
>>
>> In rpmsg_virtio_bus.c [1] the vdev buffers are allocated in a memory region using a dma_alloc_coherent
>> So the buffers are allocated in the platform driver memory region if declared, else in the default memory region. 
>>
>> According to  086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool"),
>> A patch has been integrated in rpmsg framework:  d999b622fcfb3 ("rpmsg: virtio: allocate buffer from parent")
>>
>> -	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
>> +	bufs_va = dma_alloc_coherent(vdev->dev.parent,
>>
>> So in term of parent-child relationchip the Loic's patches seem coherent, and don't affect parenting hierarchy
>> for the rpmsg bus.
> 
> So, there are two things w.r.t rpmsg device hierarchy - buffer
> allocations and the overall hierarchy to allow a child rpmsg device to
> be able to retrieve the corresponding rproc. This is done using
> rproc_get_by_child() which walks up the dev parent hierarchy and
> matching the parent device type to rproc_type.
> 
> Commit 086d08725d34 adds a new vdevbuffer device with parent as the
> rproc platform device and makes this the parent of the virtio device, so
> the buffer allocations were unchanged just with that commit, but the
> rproc lookup will always fail. The later commit d999b622fcfb3 switches
> the buffer allocation over to the vdevbuffer device, and with rproc
> drivers that added dedicated vdevbuf pools allocates from those pools
> (these were mostly coming from a specific rproc platform device memory
> region index anyway). For those that did not define, this actually
> became the global pool even if the rproc device was using a single
> DMA/CMA pool (patch 1).
> 
> Please see my cover-letter for an example of the dev hierarchy.
You are right allocation is not affected by your patch.
It is still done in the memory pool attached to rvdev.
This is the main point i missed. I reviewed the whole parent hierarchy to better understand why your patch
does not affect the memory allocation.
Now it clear to me, sorry for my misunderstanding of your point.

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

> 
>>
>> So It seems to me that this patch breaks the relationship between the rpmsg bus
>> and the rproc platform driver, at least concerning the buffer allocation.
> 
> I am not sure if you were interpreting this patch with or without
> d999b622fcfb3 ("rpmsg: virtio: allocate buffer from parent"). Both of
> the above commits are in 5.1, so I consider this patch to be fixing only
> on 5.1+ kernels and it does use d999b622fcfb3. Buffer allocations after
> this patch without d999b622fcfb3 would try to allocate from rproc device
> which is a pseudo-device and doesn't have any pools defined with it, so
> will allocate from the global pool.
> 
>> But on the other side this patch doesn't introduce regression for rpmsg bus on my platform... 
>>
>> I probably missed something important because i can not figure out how this patch don't introduce regression.
>> Can the rproc->dev inherits from the rproc platform device in term of memory regions?
>>
>> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/rpmsg/virtio_rpmsg_bus.c#L915
>> [2]: https://lkml.org/lkml/2018/11/30/180
>>
>>>
>>> I wonder how the original change didn't blow up sysmon_probe() and potentially
>>> other out-of-tree users of rproc_get_by_child().  It would be nice to have
>>> someone from the QCOM team test your patch.
>>
>> You are right the rproc platform device is now the grand parent of a rpmsg device, while before it was the parent.
>> Anyway, does it makes sense to have this kind of dependency between rpmsg device and rproc device?
>> The fix could be done in the rpmsg device that would be rproc dependent (if out-of-tree).
> 
> Not sure what you are proposing here, since you cannot retrieve a rproc
> handle. We use this to perform address translations in rpmsg drivers
> since all the addresses are with the rproc device.
>
>> The alternative could be to declare the rpmsg device in device tree as child of the rproc platform device...
> 
> And that is completely orthogonal and doesn't solve the current scenario
> where rpmsg devices are created through the virtio-rpmsg bus nameservice
> announcement.
Yes it another discussion. The only thing i would like to highlight here (for future discussion) is the relation chip
you create between rpmsg and remoteproc using rproc_get_by_child. 
Would be nice to have an abstraction layer for memory allocation and translation for generic RPMsg devices decorrelated
from remoteproc.
No more the topic here...

Thanks,
Arnaud

> 
> regards
> Suman
> 
> 
>>
>> Regards,
>> Arnaud
>>
>>>
>>>>  	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
>>>>  	rvdev->dev.release = rproc_rvdev_release;
>>>>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
>>>
>>> Be mindful there might be fallouts from applying this patch since it does change
>>> the location of the vdev under /sys/device/platform/ .
>>>
>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>
>>>> -- 
>>>> 2.23.0
>>>>
> 
