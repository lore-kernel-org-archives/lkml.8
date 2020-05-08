Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC6BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA48320643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT3BliqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHG5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:57:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbgEHG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588921057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5ntPciZTCWKN64isoisXBbo/H8iuO4xx8/GM0cAie0=;
        b=BT3BliqKMrZMjkYTigblMgMgKttQCLU8VrbZ1ZM58iP6adePUFi82EZLDPcZ/AlD/UfjWf
        Gwyg4tqXW3jKS9VYDgQu70am9YwerDpJ8di8qfR+lNL6xZ+HK/JUJZnC0NOUDACm35aldg
        Q2BUkYaFAue3CRd/pqRMN1oUzWRx32Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-hxsoD0k8MXyIsvWBEEnnQg-1; Fri, 08 May 2020 02:57:35 -0400
X-MC-Unique: hxsoD0k8MXyIsvWBEEnnQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2BA180183C;
        Fri,  8 May 2020 06:57:33 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C426B5D9CC;
        Fri,  8 May 2020 06:57:29 +0000 (UTC)
Subject: Re: [PATCH -next] vdpasim: remove unused variable 'ret'
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200410115422.42308-1-yuehaibing@huawei.com>
 <20200505203544-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f832450b-03f8-b5b6-76ae-c5c0fe5f2fdb@redhat.com>
Date:   Fri, 8 May 2020 14:57:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505203544-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/6 上午8:35, Michael S. Tsirkin wrote:
> On Fri, Apr 10, 2020 at 07:54:22PM +0800, YueHaibing wrote:
>> drivers/vdpa/vdpa_sim/vdpa_sim.c:92:6: warning:
>>   variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> Either this, or BUG_ON.  Jason?


BUG_ON seems too aggressive. So I prefer this patch.

Acked-by: Jason Wang <jasowang@redhat.com>


>
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 7957d2d41fc4..01c456f7c1f7 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -89,15 +89,14 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>>   static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>   {
>>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> -	int ret;
>>   
>> -	ret = vringh_init_iotlb(&vq->vring, vdpasim_features,
>> -				VDPASIM_QUEUE_MAX, false,
>> -				(struct vring_desc *)(uintptr_t)vq->desc_addr,
>> -				(struct vring_avail *)
>> -				(uintptr_t)vq->driver_addr,
>> -				(struct vring_used *)
>> -				(uintptr_t)vq->device_addr);
>> +	vringh_init_iotlb(&vq->vring, vdpasim_features,
>> +			  VDPASIM_QUEUE_MAX, false,
>> +			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> +			  (struct vring_avail *)
>> +			  (uintptr_t)vq->driver_addr,
>> +			  (struct vring_used *)
>> +			  (uintptr_t)vq->device_addr);
>>   }
>>   
>>   static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
>> -- 
>> 2.17.1
>>

