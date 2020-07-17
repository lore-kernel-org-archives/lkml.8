Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F16C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAD420829
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0oRW844"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQI5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:57:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgGQI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594976270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQa1wFx5ju/viAYDB8r5LMbz53CJrK3UU1097v6vI8w=;
        b=P0oRW8447bmypg5taeu8hmwa0TeCBKZ9UzeeBPXcfT2G7qc/a/xQ0c8xwQxwV6P3hwyn7j
        FOLdSVYqy3BWh139TZJ9op0rfYaQq4nAjXoYav8hPxANqrxivz0uJHop/MTOjc/wg9Wzlv
        6hvTJLT/tcvAnbJcANv9Cwf3ww+rx8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ekLXpjRWNKaONGIx0y8cMA-1; Fri, 17 Jul 2020 04:57:47 -0400
X-MC-Unique: ekLXpjRWNKaONGIx0y8cMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2DCB800400;
        Fri, 17 Jul 2020 08:57:45 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF1C472AF1;
        Fri, 17 Jul 2020 08:57:35 +0000 (UTC)
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for supported
 mlx5 devices
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
Date:   Fri, 17 Jul 2020 16:57:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午7:54, Eli Cohen wrote:
> On Thu, Jul 16, 2020 at 05:14:32PM +0800, Jason Wang wrote:
>>> +static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
>>> +		suspend_vq(ndev, &ndev->vqs[i]);
>>
>> In teardown_virtqueues() it has a check of mvq->num_ent, any reason
>> not doing it here?
>>
> Looks like checking intialized is enough. Will fix this.
>   
>>> +
>>> +static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
>>> +	int err;
>>> +
>>> +	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
>>> +		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
>>> +		if (err) {
>>> +			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
>>> +			return;
>>> +		}
>>> +	}
>>
>> I wonder what's the reason of changing vq state on the hardware
>> here. I think we can defer it to set_status().
>>
> I can defer this to set status.
>
> I just wonder if it is possible that the core vdpa driver may call this
> function with ready equals false and after some time call it with ready
> equals true.


Good point, so I think we can keep the logic. But looks like the code 
can not work if ready equals false since it only tries to modify vq 
state to RDY.


>
>
>> (Anyhow we don't sync vq address in set_vq_address()).
>>
>>
>>> +static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +	u16 dev_features;
>>> +
>>> +	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
>>> +	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
>>> +	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
>>> +		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
>>
>> This is interesting. This suggests !VIRTIO_F_VERSION_1 &&
>> VIRTIO_F_IOMMU_PLATFORM is valid. But virito spec doesn't allow such
>> configuration.
> Will fix
>> So I think you need either:
>>
>> 1) Fail vDPA device probe when VERSION_1 is not supported
>> 2) clear IOMMU_PLATFORM if VERSION_1 is not negotiated
>>
>> For 2) I guess it can't work, according to the spec, without
>> IOMMU_PLATFORM, device need to use PA to access the memory
>>
>>
>>> +	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ANY_LAYOUT);
> I think this should be removed too


Yes, I guess for hardware vDPA which depends on IOMMU_PLATFORM which 
implies VERSION_1 that implies ANY_LAYOUT.


>
>>> +	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_IOMMU_PLATFORM);
>>> +	if (mlx5_vdpa_max_qps(ndev->mvdev.max_vqs) > 1)
>>> +		ndev->mvdev.mlx_features |= BIT(VIRTIO_NET_F_MQ);
> Also this, since multqueue requires configuration vq which is not
> supported in this version.


Yes.


>
>>> +
>>> +	print_features(mvdev, ndev->mvdev.mlx_features, false);
>>> +	return ndev->mvdev.mlx_features;
>>> +}
>>> +
>>> +static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>>> +{
>>> +	/* FIXME: qemu currently does not set all the feaures due to a bug.
>>> +	 * Add checks when this is fixed.
>>> +	 */
>>
>> I think we should add the check now then qemu can get notified. (E.g
>> IOMMU_PLATFORM)
> Will do.
>>
>>> +}
>>> +
>>> +#define MLX5_VDPA_MAX_VQ_ENTRIES 256
>>
>> Is this a hardware limitation, qemu can support up to 1K which the
>> requirement of some NFV cases.
>>
> Theoretically the device is limit is much higher. In the near future we
> will have a device capability for this. I wanted to stay on the safe side
> with this but I can change this if you think it's necessary.


I see, that's fine. Let keep this untouched.


>>> +
>>> +static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset, void *buf,
>>> +				 unsigned int len)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +
>>> +	if (offset + len < sizeof(struct virtio_net_config))
>>> +		memcpy(buf, &ndev->config + offset, len);
>>
>> Note that guest expect LE, what's the endian for ndev->config?
> This is struct virtio_net_config from include/uapi/linux/virtio_net.h.
> Looking there I see it has mixed endianess. I currently don't touch it
> but if I do, I should follow endianess guidance per the struct
> definition. So I don't think I should care about endianess when copying.


So guest would expect LE, we need be careful when modify config space 
(e.g mtu or status). Consider we don't support VIRTIO_NET_F_STATUS and 
VIRTIO_NET_F_MTU, we're probably fine.


>
>>
>>> +}
>>> +
>>> +static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>> +				 unsigned int len)
>>> +{
>>> +	/* not supported */
>>> +}
>>> +
>>> +static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +
>>> +	return mvdev->generation;
>>> +}
>>> +
>>> +static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +	bool change_map;
>>> +	int err;
>>> +
>>> +	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
>>> +	if (err) {
>>> +		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	if (change_map)
>>> +		return mlx5_vdpa_change_map(ndev, iotlb);
>>
>> Any reason for not doing this inside mlx5_handle_set_map()?
>>
> All memory registration related operations are done inside mr.c in the
> common code directory. But change map involves operations on other
> objects managed in this file.


Ok.

(Note that we can do more generalization in the future, since the only 
network specific part is the config space and control vq)


>
>>> +
>>> +void mlx5_vdpa_remove_dev(struct mlx5_vdpa_dev *mvdev)
>>> +{
>>> +	struct mlx5_vdpa_net *ndev;
>>> +
>>> +	mvdev->status = 0;
>>
>> This is probably unnecessary.
>>
> Right, will remove.


Thanks


>

