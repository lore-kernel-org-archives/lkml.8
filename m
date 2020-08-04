Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6803DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49545208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT9HPjSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgHDOYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:24:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728880AbgHDOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iy5rOiKvzn/ihf1AsNDgRAp385wBg2mwZBntnUSOdjY=;
        b=hT9HPjSFt8YBB/MEENy1OTOaGfNleaf5V1zHXy3LdXT/alj70aF9CyQGLSD8iBaDTgXaej
        EcB5SazeQ1HSrXDXJbtbVCKuJ6E9DcBIyLKI2ab7nV97yrAwEiIholWrYLjPj4tVs74mm0
        lYxvNL6C565snCCDQ4oQNPATIQ2YLQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-jw4ds942OKiTFM2bmKBI3A-1; Tue, 04 Aug 2020 10:23:47 -0400
X-MC-Unique: jw4ds942OKiTFM2bmKBI3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228AE800461;
        Tue,  4 Aug 2020 14:23:46 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E13B7B90F;
        Tue,  4 Aug 2020 14:23:42 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:23:40 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config
 space
Message-ID: <20200804162340.046b719b.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-4-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-4-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:58:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

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
>  include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

(...)

> @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
>  }
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

It might help with the lunch, but it still gives a slight queasiness.
No ideas for a better version, though.

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

Acked-by: Cornelia Huck <cohuck@redhat.com>

