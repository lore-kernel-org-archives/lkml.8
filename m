Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F84C20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MvL35sHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCRPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:00:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgCRPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:00:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02IF0oXs100065;
        Wed, 18 Mar 2020 10:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584543650;
        bh=4hsSjsqTg006Xi7d9l/z1juDZrjWW/WtTHhxxRdkAAU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MvL35sHeun/xhaqUjJ2DzelnFWg7GMdahFHl1WVuqKKepeePmmB8i93XE/6ThICpL
         HElEzJNx/4WgUFCta5c3ocCpSI4Qib0z8CBx7bpVBwvCcbAgkBTjuKPcjwV3deTE8C
         84Tjij5GfTPtkqhAsLoO0Jl822hG6/OIk+qf5xg8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02IF0oGj026548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 10:00:50 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 10:00:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 10:00:50 -0500
Received: from [10.250.35.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02IF0os8119880;
        Wed, 18 Mar 2020 10:00:50 -0500
Subject: Re: [PATCH 2/2] remoteproc: Fix and restore the parenting hierarchy
 for vdev
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-3-s-anna@ti.com> <20200317180530.GA1801@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <17204b55-2d58-d8cf-e504-6b6969afa987@ti.com>
Date:   Wed, 18 Mar 2020 10:00:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200317180530.GA1801@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 3/17/20 1:05 PM, Mathieu Poirier wrote:
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
> 
> I wonder how the original change didn't blow up sysmon_probe() and potentially
> other out-of-tree users of rproc_get_by_child().  

QCOM code uses SMD transport, and not virtio_rpmsg transport, and the
parent-child relationship is direct rproc subdevices which are added in
their platform drivers directly. This affects only virtio-rpmsg clients.
Please see qcom_add_smd_subdev().

It would be nice to have
> someone from the QCOM team test your patch.
> 
>>  	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
>>  	rvdev->dev.release = rproc_rvdev_release;
>>  	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> 
> Be mindful there might be fallouts from applying this patch since it does change
> the location of the vdev under /sys/device/platform/ .
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks for the review.

regards
Suman
