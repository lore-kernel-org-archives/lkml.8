Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC59820780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WslN3y8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgF3Bzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34015 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgF3Bzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593482151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEQQaNPX5G3qAOWZhGlH8NtJDgMROrPMCFF25IlDv5U=;
        b=WslN3y8aGkQVR7H1h4cDrKTzM2fTbvDeOKfgI/2XX5AooEXnnYSZu73WRnHr8NWkqKJLLz
        /Si22t/SGJ1DEJOncaCem+oBGyBufaKENw883cwDw0aqxZcrjhslXnARU5yb4HEIh27Vs1
        mcJUjPqq/PvNfVYHBQ4M9M6FfkaPpaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-ZjWjyPAkOiml5GfSgpvgJw-1; Mon, 29 Jun 2020 21:55:37 -0400
X-MC-Unique: ZjWjyPAkOiml5GfSgpvgJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA34A80058A;
        Tue, 30 Jun 2020 01:55:35 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F22C7BEA1;
        Tue, 30 Jun 2020 01:55:24 +0000 (UTC)
Subject: Re: [PATCH RFC 4/5] vhost-vdpa: support IOTLB batching hints
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200618055626.25660-1-jasowang@redhat.com>
 <20200618055626.25660-5-jasowang@redhat.com>
 <20200628054940-mutt-send-email-mst@kernel.org>
 <a2216693-cdba-ff53-46f9-abaf47789f5a@redhat.com>
 <20200629114607-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <45bea43a-7404-c0f4-49d8-10a849588c0a@redhat.com>
Date:   Tue, 30 Jun 2020 09:55:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629114607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/29 下午11:49, Michael S. Tsirkin wrote:
> On Mon, Jun 29, 2020 at 05:26:03PM +0800, Jason Wang wrote:
>> On 2020/6/28 下午5:58, Michael S. Tsirkin wrote:
>>> On Thu, Jun 18, 2020 at 01:56:25PM +0800, Jason Wang wrote:
>>>> This patches extend the vhost IOTLB API to accept batch updating hints
>>>> form userspace. When userspace wants update the device IOTLB in a
>>>> batch, it may do:
>>>>
>>>> 1) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_BEGIN flag
>>>> 2) Perform a batch of IOTLB updating via VHOST_IOTLB_UPDATE/INVALIDATE
>>>> 3) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_END flag
>>> As long as we are extending the interface,
>>> is there some way we could cut down the number of system calls needed
>>> here?
>>
>> I'm not sure it's worth to do that since usually we only have less than 10
>> regions.
>
> Well with a guest iommu I'm guessing it can go up significantly, right?


The batching flag is not mandatory, so userspace can still choose to 
update a single IOTLB mapping through a single system call without batch 
flag.


>
>> A possible method is to carry multiple vhost_iotlb_message in one system
>> call.
> That's an option.
> Also, can kernel handle a batch that is too large by applying
> parts of it iteratively?


I think so, we can iterate a vhost iotlb message one by one through iov 
iterator.


> Or must all changes take place atomically after BATCH_END?


For changes:

- if you mean the changes in vhost IOTLB, it's not atomically
- if you mean the mapping seen by vDPA device driver, it could be 
atomically for the device driver that implements set_map() method, since 
we pass a interval tree to the device.


> If atomically, we might need to limit batch size to make
> sure kernel can keep a copy in memory.


It's the responsibility of guest driver to make sure there won't be a 
race condition between DMA and map updating. So it looks to me we don't 
need to care about that.


>
>
>>>
>>>> Vhost-vdpa may decide to batch the IOMMU/IOTLB updating in step 3 when
>>>> vDPA device support set_map() ops. This is useful for the vDPA device
>>>> that want to know all the mappings to tweak their own DMA translation
>>>> logic.
>>>>
>>>> For vDPA device that doesn't require set_map(), no behavior changes.
>>>>
>>>> This capability is advertised via VHOST_BACKEND_F_IOTLB_BATCH capability.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    drivers/vhost/vdpa.c             | 30 +++++++++++++++++++++++-------
>>>>    include/uapi/linux/vhost.h       |  2 ++
>>>>    include/uapi/linux/vhost_types.h |  7 +++++++
>>>>    3 files changed, 32 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index 453057421f80..8f624bbafee7 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -56,7 +56,9 @@ enum {
>>>>    };
>>>>    enum {
>>>> -	VHOST_VDPA_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>>> +	VHOST_VDPA_BACKEND_FEATURES =
>>>> +	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
>>>> +	(1ULL << VHOST_BACKEND_F_IOTLB_BATCH),
>>>>    };
>>>>    /* Currently, only network backend w/o multiqueue is supported. */
>>>> @@ -77,6 +79,7 @@ struct vhost_vdpa {
>>>>    	int virtio_id;
>>>>    	int minor;
>>>>    	struct eventfd_ctx *config_ctx;
>>>> +	int in_batch;
>>>>    };
>>>>    static DEFINE_IDA(vhost_vdpa_ida);
>>>> @@ -125,6 +128,7 @@ static void vhost_vdpa_reset(struct vhost_vdpa *v)
>>>>    	const struct vdpa_config_ops *ops = vdpa->config;
>>>>    	ops->set_status(vdpa, 0);
>>>> +	v->in_batch = 0;
>>>>    }
>>>>    static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>>>> @@ -540,9 +544,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>>>    	if (ops->dma_map)
>>>>    		r = ops->dma_map(vdpa, iova, size, pa, perm);
>>>> -	else if (ops->set_map)
>>>> -		r = ops->set_map(vdpa, dev->iotlb);
>>>> -	else
>>>> +	else if (ops->set_map) {
>>>> +		if (!v->in_batch)
>>>> +			r = ops->set_map(vdpa, dev->iotlb);
>>>> +	} else
>>>>    		r = iommu_map(v->domain, iova, pa, size,
>>>>    			      perm_to_iommu_flags(perm));
>>>> @@ -559,9 +564,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
>>>>    	if (ops->dma_map)
>>>>    		ops->dma_unmap(vdpa, iova, size);
>>>> -	else if (ops->set_map)
>>>> -		ops->set_map(vdpa, dev->iotlb);
>>>> -	else
>>>> +	else if (ops->set_map) {
>>>> +		if (!v->in_batch)
>>>> +			ops->set_map(vdpa, dev->iotlb);
>>>> +	} else
>>>>    		iommu_unmap(v->domain, iova, size);
>>>>    }
>>>> @@ -655,6 +661,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>>>>    					struct vhost_iotlb_msg *msg)
>>>>    {
>>>>    	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
>>>> +	struct vdpa_device *vdpa = v->vdpa;
>>>> +	const struct vdpa_config_ops *ops = vdpa->config;
>>>>    	int r = 0;
>>>>    	r = vhost_dev_check_owner(dev);
>>>> @@ -668,6 +676,14 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>>>>    	case VHOST_IOTLB_INVALIDATE:
>>>>    		vhost_vdpa_unmap(v, msg->iova, msg->size);
>>>>    		break;
>>>> +	case VHOST_IOTLB_BATCH_BEGIN:
>>>> +		v->in_batch = true;
>>>> +		break;
>>>> +	case VHOST_IOTLB_BATCH_END:
>>>> +		if (v->in_batch && ops->set_map)
>>>> +			ops->set_map(vdpa, dev->iotlb);
>>>> +		v->in_batch = false;
>>>> +		break;
>>>>    	default:
>>>>    		r = -EINVAL;
>>>>    		break;
>>>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>>>> index 0c2349612e77..565da96f55d5 100644
>>>> --- a/include/uapi/linux/vhost.h
>>>> +++ b/include/uapi/linux/vhost.h
>>>> @@ -91,6 +91,8 @@
>>>>    /* Use message type V2 */
>>>>    #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
>>>> +/* IOTLB can accpet batching hints */
>>> typo
>>
>> Will fix.
>>
>>
>>>> +#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
>>>>    #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>>>>    #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>>> index 669457ce5c48..5c12faffdde9 100644
>>>> --- a/include/uapi/linux/vhost_types.h
>>>> +++ b/include/uapi/linux/vhost_types.h
>>>> @@ -60,6 +60,13 @@ struct vhost_iotlb_msg {
>>>>    #define VHOST_IOTLB_UPDATE         2
>>>>    #define VHOST_IOTLB_INVALIDATE     3
>>>>    #define VHOST_IOTLB_ACCESS_FAIL    4
>>>> +/* VHOST_IOTLB_BATCH_BEGIN is a hint that userspace will update
>>>> + * several mappings afterwards. VHOST_IOTLB_BATCH_END is a hint that
>>>> + * userspace had finished the mapping updating.
>>> Well not just hints - in fact updates do not take place
>>> until _END.
>>>
>>> How about:
>>>
>>> /* VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>>>    * multiple mappings in one go: beginning with
>>>    * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
>>>      VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>>>    */
>>
>> That's better.
>
> Is there a guarantee that these changes take place atomically?
> Let's document that.


There's no guarantee. Will document this.

Thanks


>
>>>
>>>> When those two flags
>>>> + * were set, kernel will ignore the rest fileds of the IOTLB message.
>>> how about:
>>>
>>> when one of these two values is used as the message type, the
>>> rest of the fields in the message are ignored.
>>
>> Yes.
>>
>> Will fix.
>>
>> Thanks
>>
>>
>>>> + */
>>>> +#define VHOST_IOTLB_BATCH_BEGIN    5
>>>> +#define VHOST_IOTLB_BATCH_END      6
>>>>    	__u8 type;
>>>>    };
>>>> -- 
>>>> 2.20.1

