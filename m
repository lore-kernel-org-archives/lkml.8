Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB5C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7F20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="df74hTqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCRQij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:38:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48811 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727244AbgCRQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:38:38 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IGHbtb020610;
        Wed, 18 Mar 2020 17:38:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=NRNvpny+eWOCNOPinfnZBTKVTNomHJASQiqSmkj08tk=;
 b=df74hTquu0tY3/u4I6IfThldZm5Dt4eNfFMACSfDBqUjlbOuhV5WBZvID7D+eVE4SA9w
 83h4ZnKG+TgVW8d5WfRK/Jp3Cv7lLBU1YU3b+S0sP1sueXQJDTSjDvxYGsHEFc2S9XKL
 tY7sHwHzuMiw3+6zwz5PtG05lDjErui33Ed5HW9P99MuzB5o5PlnTHM61xVf8MWaM9sG
 RYXOMwXVpKHgQOPlwU+qvBH628GCUnuqmt+LN1+SWdp2+sHwehla9m915I4eflOHhnuX
 uBuC5o+gSXmLzq3V1q4KwQX9QGNUF+wIAuJnTJJg23mC/pFYWIIUvUMETXXYMPVcU0cI lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu8etcy09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 17:38:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A61D100034;
        Wed, 18 Mar 2020 17:38:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEFFD2BF9DA;
        Wed, 18 Mar 2020 17:38:30 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 17:38:30 +0100
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] remoteproc: Fix and restore the parenting hierarchy
 for vdev
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-3-s-anna@ti.com> <20200317180530.GA1801@xps15>
Message-ID: <76772d98-93d9-e559-01b8-ba7d4d1cc1eb@st.com>
Date:   Wed, 18 Mar 2020 17:38:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317180530.GA1801@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman, Mathieu,

On 3/17/20 7:05 PM, Mathieu Poirier wrote:
> Hi Suman,
> 
> On Thu, Mar 05, 2020 at 04:41:08PM -0600, Suman Anna wrote:
>> The commit 086d08725d34 ("remoteproc: create vdev subdevice with specific
>> dma memory pool") has introduced a new vdev subdevice for each vdev
>> declared in the firmware resource table and made it as the parent for the
>> created virtio rpmsg devices instead of the previous remoteproc device.
>> This changed the overall parenting hierarchy for the rpmsg devices, which
>> were children of virtio devices, and does not allow the corresponding
>> rpmsg drivers to retrieve the parent rproc device through the
>> rproc_get_by_child() API.
>>
>> Fix this by restoring the remoteproc device as the parent. The new vdev
>> subdevice can continue to inherit the DMA attributes from the remoteproc's
>> parent device (actual platform device).
>>
>> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 097f33e4f1f3..ba18f32bd0c4 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -510,7 +510,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>>  
>>  	/* Initialise vdev subdevice */
>>  	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
>> -	rvdev->dev.parent = rproc->dev.parent;
>> +	rvdev->dev.parent = &rproc->dev;
> 
> I can see how it would not be possible to retrieve the parent rproc device since
> rvdev->dev.parent was set to be platform device...

In rpmsg_virtio_bus.c [1] the vdev buffers are allocated in a memory region using a dma_alloc_coherent
So the buffers are allocated in the platform driver memory region if declared, else in the default memory region. 

According to  086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool"),
A patch has been integrated in rpmsg framework:  d999b622fcfb3 ("rpmsg: virtio: allocate buffer from parent")

-	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
+	bufs_va = dma_alloc_coherent(vdev->dev.parent,

So in term of parent-child relationchip the Loic's patches seem coherent, and don't affect parenting hierarchy
for the rpmsg bus.

So It seems to me that this patch breaks the relationship between the rpmsg bus
and the rproc platform driver, at least concerning the buffer allocation.
But on the other side this patch doesn't introduce regression for rpmsg bus on my platform... 

I probably missed something important because i can not figure out how this patch don't introduce regression.
Can the rproc->dev inherits from the rproc platform device in term of memory regions?

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/rpmsg/virtio_rpmsg_bus.c#L915
[2]: https://lkml.org/lkml/2018/11/30/180

> 
> I wonder how the original change didn't blow up sysmon_probe() and potentially
> other out-of-tree users of rproc_get_by_child().  It would be nice to have
> someone from the QCOM team test your patch.

You are right the rproc platform device is now the grand parent of a rpmsg device, while before it was the parent.
Anyway, does it makes sense to have this kind of dependency between rpmsg device and rproc device?
The fix could be done in the rpmsg device that would be rproc dependent (if out-of-tree).  
The alternative could be to declare the rpmsg device in device tree as child of the rproc platform device...

Regards,
Arnaud

> 
>>  	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
>>  	rvdev->dev.release = rproc_rvdev_release;
>>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> 
> Be mindful there might be fallouts from applying this patch since it does change
> the location of the vdev under /sys/device/platform/ .
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>> -- 
>> 2.23.0
>>
