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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996FBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65763206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZe+axcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGMDfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:35:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39702 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgGMDfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594611303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEz69PaaqgAlR8wzuF7Cwup3jj6XAPARgQbOCVhmOI4=;
        b=MZe+axczCl+6Exkn+dUBAMVf5SDdncx+tfKl0hZdVnFEpNiHqK4IqkP+/83h02963EgiIx
        w4xBFl0tpI4g8WnVEAB7UvqaksxRyg2zUUlVioE3Q/irHaOaEXxOnGk8LWpxkhKvNLzL5E
        Mb8PJIiIEbI7LkIiQAYehWelaIj6TCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Gdj5sj8lO7iapfasuFQEow-1; Sun, 12 Jul 2020 23:35:01 -0400
X-MC-Unique: Gdj5sj8lO7iapfasuFQEow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32F8D1080;
        Mon, 13 Jul 2020 03:35:00 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3260E5C298;
        Mon, 13 Jul 2020 03:34:55 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: sparse warning fixup
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200710104900.406084-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <64117f46-6cad-afd0-7753-1636d6474731@redhat.com>
Date:   Mon, 13 Jul 2020 11:34:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710104900.406084-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/10 下午6:49, Michael S. Tsirkin wrote:
> virtio_store_mb was built with split ring in mind so it accepts
> __virtio16 arguments. Packed ring uses __le16 values, so sparse
> complains.  It's just a store with some barriers so let's convert it to
> a macro, we don't loose too much type safety by doing that.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/linux/virtio_ring.h | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 3dc70adfe5f5..b485b13fa50b 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -46,16 +46,15 @@ static inline void virtio_wmb(bool weak_barriers)
>   		dma_wmb();
>   }
>   
> -static inline void virtio_store_mb(bool weak_barriers,
> -				   __virtio16 *p, __virtio16 v)
> -{
> -	if (weak_barriers) {
> -		virt_store_mb(*p, v);
> -	} else {
> -		WRITE_ONCE(*p, v);
> -		mb();
> -	}
> -}
> +#define virtio_store_mb(weak_barriers, p, v) \
> +do { \
> +	if (weak_barriers) { \
> +		virt_store_mb(*p, v); \
> +	} else { \
> +		WRITE_ONCE(*p, v); \
> +		mb(); \
> +	} \
> +} while (0) \
>   
>   struct virtio_device;
>   struct virtqueue;


Acked-by: Jason Wang <jasowang@redhat.com>


