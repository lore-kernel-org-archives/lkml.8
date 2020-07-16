Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B817C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D297C206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dle/UjR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgGPHnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:43:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgGPHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594885381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/M1LdeciBf3NeuOyb67GFpMFVConif4B3xfVjnjlr4=;
        b=Dle/UjR1VL1UrvKRlfFgJ7+b2IEkr3FJDRk9q/d98m5RampJzfS4Jg73MU4YD0RXeX132o
        q6GZx0ZI8As8qleZHVyJgIlzyHfN+OKuV9wQmylIDWJkx6eVTMZgFbo1kt76Hn265LGTnP
        gPALURloq+QSpfjEMgzZLyasniL1ziA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Rjqs5vsRO-SAkXazgbMtiQ-1; Thu, 16 Jul 2020 03:42:59 -0400
X-MC-Unique: Rjqs5vsRO-SAkXazgbMtiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D56941800D42;
        Thu, 16 Jul 2020 07:42:58 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B7CB2B6D6;
        Thu, 16 Jul 2020 07:42:54 +0000 (UTC)
Subject: Re: [PATCH RFC don't apply] vdpa_sim: endian-ness for config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200715135540.22832-1-mst@redhat.com>
 <8f39dcc1-0899-7ed8-8a6e-75672417b9e3@redhat.com>
 <20200716013306-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b3872628-5cf2-911b-4e3b-748824243366@redhat.com>
Date:   Thu, 16 Jul 2020 15:42:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716013306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午1:42, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2020 at 10:02:32PM +0800, Jason Wang wrote:
>> On 2020/7/15 下午9:58, Michael S. Tsirkin wrote:
>>> VDPA sim stores config space as native endian, but that
>>> is wrong: modern guests expect LE.
>>> I coded up the following to fix it up, but it is wrong too:
>>> vdpasim_create is called before guest features are known.
>>>
>>> So what should we do? New ioctl to specify the interface used?
>>> More ideas?
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Can we do the endian conversion in set_config/get_config()?
>>
>> Thanks
> That is problematic at least from static checking point of view.


I don't get here. I thought it's just leXX_to_cpu() conversion in 
set_config()/get_config() as what is done in MMIO's vm_set/vm_get.


> It would be reasonable to do it in vdpasim_set_features, except
> legacy guests might not set features at all.
> So my proposal is:
> - set config in vdpasim_set_features


Just to make sure I understand here. What's the meaning of "set config" 
do you mean setup the config space? If yes, and if there's a device 
config space, we still need to do the endian conversion?


> - document that this is where devices should initialize config
> - vdpa core will maintain a "features set" flag, if get/set config
>    is called without set features, core will call set features
>    automatically with 0 value.


Ok, I think you meant checking FEATURE_OK via get_status in vDPA core?

Thanks



>
> Thoughts?
>
>
>>>
>>> ---
>>>    drivers/vdpa/vdpa_sim/vdpa_sim.c | 22 ++++++++++++++++++++--
>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index a9bc5e0fb353..cc754ae0ec15 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -24,6 +24,7 @@
>>>    #include <linux/etherdevice.h>
>>>    #include <linux/vringh.h>
>>>    #include <linux/vdpa.h>
>>> +#include <linux/virtio_byteorder.h>
>>>    #include <linux/vhost_iotlb.h>
>>>    #include <uapi/linux/virtio_config.h>
>>>    #include <uapi/linux/virtio_net.h>
>>> @@ -72,6 +73,23 @@ struct vdpasim {
>>>    	u64 features;
>>>    };
>>> +/* TODO: cross-endian support */
>>> +static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
>>> +{
>>> +	return virtio_legacy_is_little_endian() ||
>>> +		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
>>> +}
>>> +
>>> +static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
>>> +{
>>> +	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
>>> +}
>>> +
>>> +static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
>>> +{
>>> +	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
>>> +}
>>> +
>>>    static struct vdpasim *vdpasim_dev;
>>>    static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>> @@ -332,8 +350,8 @@ static struct vdpasim *vdpasim_create(void)
>>>    		goto err_iommu;
>>>    	config = &vdpasim->config;
>>> -	config->mtu = 1500;
>>> -	config->status = VIRTIO_NET_S_LINK_UP;
>>> +	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>> +	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>>    	eth_random_addr(config->mac);
>>>    	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);

