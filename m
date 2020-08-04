Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF41B207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xx6uBbNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHDOu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:50:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49736 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHDOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596552651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YxLRfbCPvEp7fds9gJqZErapKvRhVFigGRNQsWtgis=;
        b=Xx6uBbNh0iJDgOpH48suyP+DkGDzF5B2iPqMLg2jNJe9xc2ix0T1zQi0R4IQMlUysxhYf+
        WOsmwQfcRrw9ei7yFq1Iz/ZokP889w2luZ/TJgutQyFpKAs32qmg+rDG3aRh8LbLsD4kl0
        MSEfoWI8IbbmUGUx41GnNOk6LwMumT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-OMCkbzNkO12miiPFRDkg0A-1; Tue, 04 Aug 2020 10:50:48 -0400
X-MC-Unique: OMCkbzNkO12miiPFRDkg0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E08580BCB2;
        Tue,  4 Aug 2020 14:50:46 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A960069317;
        Tue,  4 Aug 2020 14:50:41 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:50:39 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 17/24] virtio_config: disallow native type fields
Message-ID: <20200804165039.58dcb29e.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-18-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-18-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:57 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Transitional devices should all use __virtioXX types.

I think they should use __leXX for those fields that are not present
with legacy devices?

> Modern ones should use __leXX.
> _uXX type would be a bug.
> Let's prevent that.

That sounds right, though.

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 64da491936f7..c68f58f3bf34 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  	__virtio_pick_type(x, __u8, __u8,					\
>  		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
>  			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> -				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> -					/* No other type allowed */		\
> -					(void)0)))))
> +				/* No other type allowed */			\
> +				(void)0))))
>  
>  #endif
>  

