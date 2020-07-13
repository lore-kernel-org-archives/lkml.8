Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1AAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B95C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEeOUmDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGMD3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:29:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgGMD3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594610952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sqmIa3FOThqJ2P5OGh1edrqCIvFDayENPyYWhN4VO0=;
        b=EEeOUmDzDxG/uNx89SYC7UDU5Ub5PWd07Pg6cLxbj24QTN1IpVkGFn0zlWSwtryDOMNiii
        QsyhFjsajeRWQJeeDI9F2ZeEky9qEpMZu6IE6IsikzZ6DMerFfAXxdMsSD1EdO3f2qkOpU
        6x1h3NexXki+eIxzhJikDOzsRfll6nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-cgnKb0z2Mb-co7CYRgTzmw-1; Sun, 12 Jul 2020 23:29:11 -0400
X-MC-Unique: cgnKb0z2Mb-co7CYRgTzmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1441086;
        Mon, 13 Jul 2020 03:29:10 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F2FE74F75;
        Mon, 13 Jul 2020 03:29:02 +0000 (UTC)
Subject: Re: [PATCH] virtio_balloon: fix sparse warning
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20200710104837.405966-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2c3b61df-c5c8-536a-01d4-c468e958f6d7@redhat.com>
Date:   Mon, 13 Jul 2020 11:29:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710104837.405966-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/10 下午6:48, Michael S. Tsirkin wrote:
> balloon uses virtio32_to_cpu instead of cpu_to_virtio32
> to convert a native endian number to virtio.
> No practical difference but makes sparse warn.
> Fix it up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fc7301406540..5d4b891bf84f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -596,7 +596,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
>   	while (virtqueue_get_buf(vq, &unused))
>   		;
>   
> -	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
> +	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
>   					virtio_balloon_cmd_id_received(vb));
>   	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
>   	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);


Acked-by: Jason Wang <jasowang@redhat.com>


