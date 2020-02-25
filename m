Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0330C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91576222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="En+pd2BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgBYFjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:39:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgBYFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582609194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvyMr31DEcUC3wl6gi1vnkH+1S5pTodyIZXAYjl8UxA=;
        b=En+pd2BZMstAE8xSKWiy+S6eiUQAoegB05+F4N6iBYik9YQtdEklJWrr9yMpsYqVZsB1Oj
        yK9tBVUI4jhnxpnlfXRGOaEyZPQDTxHtr/+Lfdsj9g/50XZ8FP4IvF0vVPIGxTzM7pBdIu
        OYo9ewnDOnN0CCQYa0OjMTyeBU8sOEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-ZxyOww8YMguspF5qMtIFnQ-1; Tue, 25 Feb 2020 00:39:50 -0500
X-MC-Unique: ZxyOww8YMguspF5qMtIFnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0BD18AB2C2;
        Tue, 25 Feb 2020 05:39:49 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 001D1393;
        Tue, 25 Feb 2020 05:39:43 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
To:     Suman Anna <s-anna@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20200224212643.30672-1-s-anna@ti.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
Date:   Tue, 25 Feb 2020 13:39:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224212643.30672-1-s-anna@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/25 =E4=B8=8A=E5=8D=885:26, Suman Anna wrote:
> The functions vring_new_virtqueue() and __vring_new_virtqueue() are use=
d
> with split rings, and any allocations within these functions are manage=
d
> outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ring=
:
> allocate desc state for split ring separately") allocates the desc stat=
e
> within the __vring_new_virtqueue() but frees it only when the .we_own_r=
ing
> flag is set. This leads to a memory leak when freeing such allocated
> virtqueues with the vring_del_virtqueue() function.
>
> Fix this by moving the desc_state free code outside the flag and only
> for split rings. Issue was discovered during testing with remoteproc
> and virtio_rpmsg.
>
> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring s=
eparately")
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   drivers/virtio/virtio_ring.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> index 867c7ebd3f10..58b96baa8d48 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>   					 vq->split.queue_size_in_bytes,
>   					 vq->split.vring.desc,
>   					 vq->split.queue_dma_addr);
> -
> -			kfree(vq->split.desc_state);
>   		}
>   	}
> +	if (!vq->packed_ring)
> +		kfree(vq->split.desc_state);


Nitpick, it looks to me it would be more clear if we just free=20
desc_state unconditionally here (and remove the kfree for packed above).

Anyway desc_state will be allocated by use even if !we_own_ring.

Thanks


>   	list_del(&_vq->list);
>   	kfree(vq);
>   }

