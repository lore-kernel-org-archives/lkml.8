Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E997C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D693E206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Q5JGK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEODCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:02:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38556 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgEODCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589511732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ02bOsTsAvIFUawcVMs6WTwU2Gy+CcgbmbjJ63LKRA=;
        b=A5Q5JGK9jkaxA9qMAzhXhYlX1iskGEiLNvdsuc49mAQrDjjpswm8S+ApReXDl7YYhtsTUK
        5kgGqaF1Kb9ApM28IKdT+jtPMtHrlXiU4j7PyacN/qmmJ61P/icDVomTKmrbJy/vavXjkk
        jsrR1HWVTcbLO6MF783cxUDo10zWKR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-hIHUJaHiN5WsAxTGh3F8Zw-1; Thu, 14 May 2020 23:02:08 -0400
X-MC-Unique: hIHUJaHiN5WsAxTGh3F8Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BC5380058A;
        Fri, 15 May 2020 03:02:07 +0000 (UTC)
Received: from [10.72.13.11] (ovpn-13-11.pek2.redhat.com [10.72.13.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 027181C92D;
        Fri, 15 May 2020 03:02:01 +0000 (UTC)
Subject: Re: [PATCH] vdpa_sim: do not reset IOTLB during device reset
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200514072549.29694-1-jasowang@redhat.com>
 <20200514053233-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c0353f0c-e60e-3fcd-6452-38eefca18a03@redhat.com>
Date:   Fri, 15 May 2020 11:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514053233-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/14 下午5:35, Michael S. Tsirkin wrote:
> On Thu, May 14, 2020 at 03:25:49PM +0800, Jason Wang wrote:
>> We reset IOTLB during device reset this breaks the assumption that the
>> mapping needs to be controlled via vDPA DMA ops explicitly in a
>> incremental way. So the networking will be broken after e.g a guest
>> reset.
>>
>> Fix this by not resetting the IOTLB during device reset.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> That's a bit weird, and can be a security risk if state
> leaks between security domains through this.


I'm not sure I get this. Note that:

1) For devices that depend on platform IOMMU, the mappings are valid 
across device reset
2) vhost_vdpa will reset IOTLB during release, so I think there's no 
security leak in this case

If we reset IOTLB during device reset, there will be an inconsistency 
between on-chip IOMMU devices and platform IOMMU devices. We can fix 
this inconsistency in another way, e.g unmap during vhost_vdpa_reset. 
This means userspace need to replay the mapping before DRIVER_OK, which 
seems a burden to userspace.


> And there's 0 chance any hardware implementation can
> keep the translations around across resets - there
> is simply nowhere to keep them.


It depends on the hardware implementation, e.g the IOMMU does not belong 
to VF but PF.

Thanks


>
> IMHO we need a different way to make this work, simulator
> needs to look like a hardware device as much as possible.
>
>
>> ---
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 7957d2d41fc4..cc5525743a25 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -119,8 +119,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>>   	for (i = 0; i < VDPASIM_VQ_NUM; i++)
>>   		vdpasim_vq_reset(&vdpasim->vqs[i]);
>>   
>> -	vhost_iotlb_reset(vdpasim->iommu);
>> -
>>   	vdpasim->features = 0;
>>   	vdpasim->status = 0;
>>   	++vdpasim->generation;
>> -- 
>> 2.20.1

