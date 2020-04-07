Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43629C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D6620672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYVw3aY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDGDlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:41:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgDGDlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586230908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8prdO6Acwn6arLFerg39u4iXNWZQDVNoQ19OuejLBc=;
        b=iYVw3aY4qpB7dyW8+IwGE5LZs3AbZiPCPIuyzbyh6NLoyU32N10xAKVyE5Bw1Ypc7palBz
        BBlUzqrRKRSCBKNvmYH7bp9hCopMh/nNJdeWla4KeB6wrJtK5sDJObvk87OJNX3qujl286
        xl//FHHpSyjkOs9syZp7Yejmv4Rp/SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-NHO9UX6FOdegEl60zoN-9g-1; Mon, 06 Apr 2020 23:41:46 -0400
X-MC-Unique: NHO9UX6FOdegEl60zoN-9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 852BB107ACCA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 03:41:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B46F1001DF2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 03:41:45 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6DFCF38A1;
        Tue,  7 Apr 2020 03:41:45 +0000 (UTC)
Date:   Mon, 6 Apr 2020 23:41:32 -0400 (EDT)
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <146472340.20929248.1586230892042.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
Subject: Re: [PATCH v7 00/19] virtio: alignment issues
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.20, 10.4.195.22]
Thread-Topic: virtio: alignment issues
Thread-Index: BPzE9+ZqcMmiKGOAqBpu7P8gySkjgQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> 
> This is an alternative to
> 	vhost: force spec specified alignment on types
> which is a bit safer as it does not change UAPI.
> I still think it's best to change the UAPI header as well,
> we can do that as a follow-up cleanup.
> 
> changes from v6:
> 	add missing header includes all over the place
> changes from v5:
> 	ack for mellanox patch
> 	fixup to remoteproc
> changes from v4:
> 	fixup to issues reported by kbuild
> changes from v3:
> 	tools/virtio fixes
> 	a bunch more cleanups that now become possible
> 
> Changes from v2:
> 	don't change struct name, instead add ifndef
> 	so kernel does not see the legacy UAPI version.
> 
> Jason, can you pls ack one of the approaches?

I prefer this approach but it looks a little bit risky for 5.7. Can we
do this in 5.8?

Instead of using Kconfig, could we simply fail the initalization of
vhost like:

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0395229486a9..e9f6a008ed12 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2636,6 +2636,11 @@ EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
 static int __init vhost_init(void)
 {
+	struct vhost_virtqueue *vq;
+
+	if (__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE)
+		return -ENOTSUPP;
+
 	return 0;
 }

Thanks

> 
> 
> Matej Genci (1):
>   virtio: add VIRTIO_RING_NO_LEGACY
> 
> Michael S. Tsirkin (18):
>   tools/virtio: define aligned attribute
>   tools/virtio: make asm/barrier.h self contained
>   tools/virtio: define __KERNEL__
>   virtgpu: pull in uaccess.h
>   virtio-rng: pull in slab.h
>   remoteproc: pull in slab.h
>   virtio_input: pull in slab.h
>   virtio: stop using legacy struct vring in kernel
>   vhost: force spec specified alignment on types
>   virtio: add legacy init/size APIs
>   virtio_ring: switch to virtio_legacy_init/size
>   tools/virtio: switch to virtio_legacy_init/size
>   vop: switch to virtio_legacy_init/size
>   remoteproc: switch to virtio_legacy_init/size
>   mellanox: switch to virtio_legacy_init/size
>   vhost: option to fetch descriptors through an independent struct
>   vhost: use batched version by default
>   vhost: batching fetches
> 
>  drivers/block/virtio_blk.c               |   1 +
>  drivers/char/hw_random/virtio-rng.c      |   1 +
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   1 +
>  drivers/misc/mic/vop/vop_main.c          |   5 +-
>  drivers/misc/mic/vop/vop_vringh.c        |   8 +-
>  drivers/platform/mellanox/mlxbf-tmfifo.c |   6 +-
>  drivers/remoteproc/remoteproc_core.c     |   2 +-
>  drivers/remoteproc/remoteproc_sysfs.c    |   1 +
>  drivers/remoteproc/remoteproc_virtio.c   |   2 +-
>  drivers/vhost/test.c                     |   2 +-
>  drivers/vhost/vhost.c                    | 271 +++++++++++++++--------
>  drivers/vhost/vhost.h                    |  23 +-
>  drivers/virtio/virtio_input.c            |   1 +
>  drivers/virtio/virtio_pci_modern.c       |   1 +
>  drivers/virtio/virtio_ring.c             |  15 +-
>  include/linux/virtio.h                   |   1 -
>  include/linux/virtio_ring.h              |  46 ++++
>  include/linux/vringh.h                   |   1 +
>  include/uapi/linux/virtio_ring.h         |  30 ++-
>  tools/virtio/Makefile                    |   2 +-
>  tools/virtio/asm/barrier.h               |   1 +
>  tools/virtio/linux/compiler.h            |   1 +
>  tools/virtio/ringtest/virtio_ring_0_9.c  |   6 +-
>  tools/virtio/virtio_test.c               |   6 +-
>  tools/virtio/vringh_test.c               |  18 +-
>  25 files changed, 311 insertions(+), 141 deletions(-)
> 
> --
> MST
> 
> 

> 

