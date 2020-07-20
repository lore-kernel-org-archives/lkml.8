Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A929520709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZX1q3PQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgGTEMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:12:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30214 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725287AbgGTEMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595218363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNmYyatHBjazXta2G+8f7FUFOpNtqCLp5w3UofyHTXI=;
        b=fZX1q3PQ70EQT9bQdOCgmg3nvfoe2cHXLt7AK5QmKq7ZXm7LB4alrfh2Q9YZI1twS+erUM
        lOTpyNsc+sB9ROMAWEglzGbYgZF4Pm0DdlVnc6oz+hmH0d5IRwxfrrLCCsX+9DU9QED3Em
        WfV9auKOocoVGgoMw8JY1KH4myuSq64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-vz456LNhO_qCuug1rjUAMQ-1; Mon, 20 Jul 2020 00:12:39 -0400
X-MC-Unique: vz456LNhO_qCuug1rjUAMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D803318A1DE1;
        Mon, 20 Jul 2020 04:12:37 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69EAA72E52;
        Mon, 20 Jul 2020 04:12:32 +0000 (UTC)
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for supported
 mlx5 devices
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
 <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
 <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ed10cb66-174f-ec5c-8043-4e18de65fb99@redhat.com>
Date:   Mon, 20 Jul 2020 12:12:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/19 上午3:49, Eli Cohen wrote:
> On Fri, Jul 17, 2020 at 04:57:29PM +0800, Jason Wang wrote:
>>> Looks like checking intialized is enough. Will fix this.
>>>>> +
>>>>> +static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
>>>>> +{
>>>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>> +	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
>>>>> +	int err;
>>>>> +
>>>>> +	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
>>>>> +		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
>>>>> +		if (err) {
>>>>> +			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
>>>>> +			return;
>>>>> +		}
>>>>> +	}
>>>> I wonder what's the reason of changing vq state on the hardware
>>>> here. I think we can defer it to set_status().
>>>>
>>> I can defer this to set status.
>>>
>>> I just wonder if it is possible that the core vdpa driver may call this
>>> function with ready equals false and after some time call it with ready
>>> equals true.
>>
>> Good point, so I think we can keep the logic. But looks like the
>> code can not work if ready equals false since it only tries to
>> modify vq state to RDY.
>>
> The point is that you cannot modify the virtqueue to "not ready".


Is this a hardware limitation of software one?

I'm asking since we need support live migration. But a questions is how 
to stop the device but not reset, since we need get e.g last_avail_idx 
from the device.

It could be either:

1) set_status(0)
2) get_vq_state()

or

1) set_queue_ready(0)
2) get_vq_state()

Set_status(0) means reset the virtio device but last_avail_idx is 
something out of virtio spec. I guess using set_queue_ready() is better.

What's you opinion?

Thanks


>   The
> only option is to destroy it and create a new one. This means that if I
> get ready equals false after the virtqueue has been created I need to
> teardown the driver and set it up again.
>
> Given that, I think your original suggestion to defer this logic is
> reasonable.
>

