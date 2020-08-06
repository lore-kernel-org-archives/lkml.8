Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C5020792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaWaIBK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgHFD3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:29:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730784AbgHFD3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqqusaMY5nwkPoft2J2o8MkWdw785dqs4rwmV+X8bIM=;
        b=DaWaIBK0tzvHWThdfVm7QeobMmvyqephQ0+4hQWZO1B0f79YMi76oDQG3iJOo4NxjTuVTt
        r59GHVGToVhAV7OfUdH9O34omCL74/aQGTG6tMUB/7uljN5Y9McvNiYFwu/jgvw1fck8G6
        yiqB6tpRczhTZY3VcIyKs5Aaa7QwodA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Tki8dWVcPCurLaGHCQ6RVA-1; Wed, 05 Aug 2020 23:29:28 -0400
X-MC-Unique: Tki8dWVcPCurLaGHCQ6RVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D514258;
        Thu,  6 Aug 2020 03:29:26 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A097B19C71;
        Thu,  6 Aug 2020 03:29:18 +0000 (UTC)
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
 <20200805085635-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
Date:   Thu, 6 Aug 2020 11:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085635-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午8:58, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:29:47AM +0800, Jason Wang wrote:
>> This patch introduces a new ioctl for vhost-vdpa device that can
>> report the iova range by the device. For device that depends on
>> platform IOMMU, we fetch the iova range via DOMAIN_ATTR_GEOMETRY. For
>> devices that has its own DMA translation unit, we fetch it directly
>> from vDPA bus operation.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>>   include/uapi/linux/vhost.h       |  4 ++++
>>   include/uapi/linux/vhost_types.h |  5 +++++
>>   3 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 77a0c9fb6cc3..ad23e66cbf57 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -332,6 +332,30 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>>   
>>   	return 0;
>>   }
>> +
>> +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
>> +{
>> +	struct iommu_domain_geometry geo;
>> +	struct vdpa_device *vdpa = v->vdpa;
>> +	const struct vdpa_config_ops *ops = vdpa->config;
>> +	struct vhost_vdpa_iova_range range;
>> +	struct vdpa_iova_range vdpa_range;
>> +
>> +	if (!ops->set_map && !ops->dma_map) {
> Why not just check if (ops->get_iova_range) directly?


Because set_map || dma_ops is a hint that the device has its own DMA 
translation logic.

Device without get_iova_range does not necessarily meant it use IOMMU 
driver.

Thanks


>
>
>
>
>> +		iommu_domain_get_attr(v->domain,
>> +				      DOMAIN_ATTR_GEOMETRY, &geo);
>> +		range.start = geo.aperture_start;
>> +		range.end = geo.aperture_end;
>> +	} else {
>> +		vdpa_range = ops->get_iova_range(vdpa);
>> +		range.start = vdpa_range.start;
>> +		range.end = vdpa_range.end;
>> +	}
>> +
>> +	return copy_to_user(argp, &range, sizeof(range));
>> +
>> +}
>> +
>>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>   				   void __user *argp)
>>   {
>> @@ -442,6 +466,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>   	case VHOST_VDPA_SET_CONFIG_CALL:
>>   		r = vhost_vdpa_set_config_call(v, argp);
>>   		break;
>> +	case VHOST_VDPA_GET_IOVA_RANGE:
>> +		r = vhost_vdpa_get_iova_range(v, argp);
>> +		break;
>>   	default:
>>   		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>>   		if (r == -ENOIOCTLCMD)
>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> index 0c2349612e77..850956980e27 100644
>> --- a/include/uapi/linux/vhost.h
>> +++ b/include/uapi/linux/vhost.h
>> @@ -144,4 +144,8 @@
>>   
>>   /* Set event fd for config interrupt*/
>>   #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
>> +
>> +/* Get the valid iova range */
>> +#define VHOST_VDPA_GET_IOVA_RANGE	_IOW(VHOST_VIRTIO, 0x78, \
>> +					     struct vhost_vdpa_iova_range)
>>   #endif
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index 669457ce5c48..4025b5a36177 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -127,6 +127,11 @@ struct vhost_vdpa_config {
>>   	__u8 buf[0];
>>   };
>>   
>> +struct vhost_vdpa_iova_range {
>> +	__u64 start;
>> +	__u64 end;
>> +};
>> +
>
> Pls document fields. And I think first/last is a better API ...
>
>>   /* Feature bits */
>>   /* Log all write descriptors. Can be changed while device is active. */
>>   #define VHOST_F_LOG_ALL 26
>> -- 
>> 2.20.1

