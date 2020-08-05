Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA84EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E2207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjPjawL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHEG2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:28:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727962AbgHEG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596608913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4EoEwZG+swIVHP0lP8YoiVbx/lrSzlRaGxj/pUTBqw=;
        b=DjPjawL6ilC5vBQ08ElH3Ygl4Kkbf+EWbdMarqHBnbbWSQHIlYbQJUdl4vV/KSkKN8+n/3
        MOfNlWtgopi19fVJxQA/5bbyhLzScB4WND2hG4BAab1Zbx7ElHEAedkNT4bcidbKTLoOVL
        rVxSyYhebqkC+LaWNLbcDaAzb9pt+Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Z6h-CcQlNsSmC0oA6Dl8uQ-1; Wed, 05 Aug 2020 02:28:31 -0400
X-MC-Unique: Z6h-CcQlNsSmC0oA6Dl8uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D9F418FF662;
        Wed,  5 Aug 2020 06:28:30 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C97D8AC25;
        Wed,  5 Aug 2020 06:28:24 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
Date:   Wed, 5 Aug 2020 14:28:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-4-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/4 上午4:58, Michael S. Tsirkin wrote:
> Currently all config space fields are of the type __uXX.
> This confuses people and some drivers (notably vdpa)
> access them using CPU endian-ness - which only
> works well for legacy or LE platforms.
>
> Update virtio_cread/virtio_cwrite macros to allow __virtioXX
> and __leXX field types. Follow-up patches will convert
> config space to use these types.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 3b4eae5ac5e3..64da491936f7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -6,6 +6,7 @@
>   #include <linux/bug.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_byteorder.h>
> +#include <linux/compiler_types.h>
>   #include <uapi/linux/virtio_config.h>
>   
>   struct irq_affinity;
> @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>   	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
>   }
>   
> +/*
> + * Only the checker differentiates between __virtioXX and __uXX types. But we
> + * try to share as much code as we can with the regular GCC build.
> + */
> +#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
> +
> +/* Not a checker - we can keep things simple */
> +#define __virtio_native_typeof(x) typeof(x)
> +
> +#else
> +
> +/*
> + * We build this out of a couple of helper macros in a vain attempt to
> + * help you keep your lunch down while reading it.
> + */
> +#define __virtio_pick_value(x, type, then, otherwise)			\
> +	__builtin_choose_expr(__same_type(x, type), then, otherwise)
> +
> +#define __virtio_pick_type(x, type, then, otherwise)			\
> +	__virtio_pick_value(x, type, (then)0, otherwise)
> +
> +#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
> +	__virtio_pick_type(x, x16, __u16,					\
> +		__virtio_pick_type(x, x32, __u32,				\
> +			__virtio_pick_type(x, x64, __u64,			\
> +				otherwise)))
> +
> +#define __virtio_native_typeof(x) typeof(					\
> +	__virtio_pick_type(x, __u8, __u8,					\
> +		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> +			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> +				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> +					/* No other type allowed */		\
> +					(void)0)))))
> +
> +#endif
> +
> +#define __virtio_native_type(structname, member) \
> +	__virtio_native_typeof(((structname*)0)->member)
> +
> +#define __virtio_typecheck(structname, member, val) \
> +		/* Must match the member's type, and be integer */ \
> +		typecheck(__virtio_native_type(structname, member), (val))
> +
> +
>   /* Config space accessors. */
>   #define virtio_cread(vdev, structname, member, ptr)			\
>   	do {								\
>   		might_sleep();						\
>   		/* Must match the member's type, and be integer */	\
> -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
> +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
>   			(*ptr) = 1;					\


A silly question,  compare to using set()/get() directly, what's the 
value of the accessors macro here?

Thanks


>   									\
>   		switch (sizeof(*ptr)) {					\
> @@ -322,7 +368,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>   	do {								\
>   		might_sleep();						\
>   		/* Must match the member's type, and be integer */	\
> -		if (!typecheck(typeof((((structname*)0)->member)), *(ptr))) \
> +		if (!__virtio_typecheck(structname, member, *(ptr)))	\
>   			BUG_ON((*ptr) == 1);				\
>   									\
>   		switch (sizeof(*ptr)) {					\

