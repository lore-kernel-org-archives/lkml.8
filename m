Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A963C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925F02177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/jKRpVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgHDCnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:43:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34474 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729850AbgHDCnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596509001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hp9A97oTrVOTq0PRhFxZTZEQWhgsYnn8g0JTZalBa94=;
        b=D/jKRpVMIVOP+sN9yDOlJRvVzb4ZVElYDTY1H31xhFFPFjf4KyrD37wLrSDarYg0qdWUYa
        JL6RS7rBRbI14nxN1W5MV1Ku9/Iv3lhSBVpZVZvbh1654u+h80LkVYctmKyIhoh4GPqOIi
        n1m3pv3z5ky2NjKYGGJ5feA8XRz3/rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-FKQ4etofOjOF5d755bXmuw-1; Mon, 03 Aug 2020 22:43:17 -0400
X-MC-Unique: FKQ4etofOjOF5d755bXmuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 437248017FB;
        Tue,  4 Aug 2020 02:43:16 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A176E7852C;
        Tue,  4 Aug 2020 02:42:57 +0000 (UTC)
Subject: Re: [PATCH -next v3] virtio_ring: Avoid loop when vq is broken in
 virtqueue_poll
To:     Mao Wenan <wenan.mao@linux.alibaba.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200802022549-mutt-send-email-mst@kernel.org>
 <1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <12bf457d-1283-62c6-6901-29e7a14831ca@redhat.com>
Date:   Tue, 4 Aug 2020 10:42:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/2 下午3:44, Mao Wenan wrote:
> The loop may exist if vq->broken is true,
> virtqueue_get_buf_ctx_packed or virtqueue_get_buf_ctx_split
> will return NULL, so virtnet_poll will reschedule napi to
> receive packet, it will lead cpu usage(si) to 100%.
>
> call trace as below:
> virtnet_poll
> 	virtnet_receive
> 		virtqueue_get_buf_ctx
> 			virtqueue_get_buf_ctx_packed
> 			virtqueue_get_buf_ctx_split
> 	virtqueue_napi_complete
> 		virtqueue_poll           //return true
> 		virtqueue_napi_schedule //it will reschedule napi
>
> to fix this, return false if vq is broken in virtqueue_poll.
>
> Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   v2->v3: change subject, original is : "virtio_net: Avoid loop in virtnet_poll"
>   v1->v2: fix it in virtqueue_poll suggested by Michael S. Tsirkin <mst@redhat.com>
>   drivers/virtio/virtio_ring.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96ba..4f7c73e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1960,6 +1960,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
>   
> +	if (unlikely(vq->broken))
> +		return false;
> +
>   	virtio_mb(vq->weak_barriers);
>   	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
>   				 virtqueue_poll_split(_vq, last_used_idx);


Acked-by: Jason Wang <jasowang@redhat.com>


