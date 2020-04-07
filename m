Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359AF20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aj65dFlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDGJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:49:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgDGJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586252942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HT2NIUXp8tfq0o3dL2lF3WFOJjpJvSuLcUQOzln6AYw=;
        b=aj65dFlDQSfs6T63lO2fBBNHVvSc6u8VaRlaYaBeRW/jMdKk/tcuC8dVzqe8BeydKRGLpZ
        BlYuIbhWMazkmMO5hUnapoKCmkFzNsWgRrG5rpZfcU1MtdFLSM0uHp8TdWya3biK05qQrO
        HMq0al7RUkLKn11F7wi8joTKGaJ6tPA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-KD7gUBrCMWKIAtMjnRZ9wA-1; Tue, 07 Apr 2020 05:49:00 -0400
X-MC-Unique: KD7gUBrCMWKIAtMjnRZ9wA-1
Received: by mail-wr1-f70.google.com with SMTP id q9so1451862wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HT2NIUXp8tfq0o3dL2lF3WFOJjpJvSuLcUQOzln6AYw=;
        b=ePWVworAlo8tXp7RfHEXvadK1cvoSJWsRFkNGj16bgoJgwTrvQcoJrSpDbCUNXp9rL
         wTl52oy7RfTiXROeb4brPLxdpBK1Ey1jMmSCdl7vqtJTLC0zUkEp2KmFGtLcGeFE+1Uo
         BpG0HGh8jK6YW7pRIygpGMzGZGbrsyB4e3vVss7iIgzaZWdW2h1OYsQ/XLR+2u8RK24x
         GSHlAc8vEGJG/PEnB65ud1TnbV0X5UVyDcY5ocEkisrT+vramIEIuHYVvdhAuVpZf6tU
         PtzNRd/tKNFdc3tagJW/eSzp0BrMqoECSjqBcfDR620JafOowh6xaOgpUJH4xeEWkrMu
         0VJw==
X-Gm-Message-State: AGi0Pua6LRJGlo48o3+BH/K+0ucAcsqenzD7ZN96+bej3hDKowmsWWwn
        FC58I8sM6+YKHiBlaF0r7q0HKQcCNqFwj+ZUBbmx65fFGYJHU0Ar8iK5TM4hGyV33mPst7D4+wN
        KcCUhm6gzMT/9rmz+/11CQ5I6
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr1480793wmk.138.1586252938925;
        Tue, 07 Apr 2020 02:48:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7ZYIn5E9MjpaeNsBSvGXuOWuU4hnNmQqUEdZUzUgYs6VBV0bpEZ9VwzbEmvwZBe9LzaMF5Q==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr1480780wmk.138.1586252938705;
        Tue, 07 Apr 2020 02:48:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id r5sm14040180wrt.8.2020.04.07.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:48:58 -0700 (PDT)
Date:   Tue, 7 Apr 2020 05:48:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/19] virtio: alignment issues
Message-ID: <20200407054619-mutt-send-email-mst@kernel.org>
References: <20200407010700.446571-1-mst@redhat.com>
 <146472340.20929248.1586230892042.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146472340.20929248.1586230892042.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:41:32PM -0400, Jason Wang wrote:
> ----- Original Message -----
> > 
> > This is an alternative to
> > 	vhost: force spec specified alignment on types
> > which is a bit safer as it does not change UAPI.
> > I still think it's best to change the UAPI header as well,
> > we can do that as a follow-up cleanup.
> > 
> > changes from v6:
> > 	add missing header includes all over the place
> > changes from v5:
> > 	ack for mellanox patch
> > 	fixup to remoteproc
> > changes from v4:
> > 	fixup to issues reported by kbuild
> > changes from v3:
> > 	tools/virtio fixes
> > 	a bunch more cleanups that now become possible
> > 
> > Changes from v2:
> > 	don't change struct name, instead add ifndef
> > 	so kernel does not see the legacy UAPI version.
> > 
> > Jason, can you pls ack one of the approaches?
> 
> I prefer this approach but it looks a little bit risky for 5.7. Can we
> do this in 5.8?

It's not rc1 even yet, I think it's fine.

> Instead of using Kconfig, could we simply fail the initalization of
> vhost like:
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 0395229486a9..e9f6a008ed12 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2636,6 +2636,11 @@ EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
>  
>  static int __init vhost_init(void)
>  {
> +	struct vhost_virtqueue *vq;
> +
> +	if (__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE)
> +		return -ENOTSUPP;
> +
>  	return 0;
>  }
> 
> Thanks

It's not just vhost, vringh is also broken.

It's not even rc1 yet, and I really like the resulting cleanup.
So I pushed this to next and it all seems to work pretty well,
I think I'll go with this.

> > 
> > 
> > Matej Genci (1):
> >   virtio: add VIRTIO_RING_NO_LEGACY
> > 
> > Michael S. Tsirkin (18):
> >   tools/virtio: define aligned attribute
> >   tools/virtio: make asm/barrier.h self contained
> >   tools/virtio: define __KERNEL__
> >   virtgpu: pull in uaccess.h
> >   virtio-rng: pull in slab.h
> >   remoteproc: pull in slab.h
> >   virtio_input: pull in slab.h
> >   virtio: stop using legacy struct vring in kernel
> >   vhost: force spec specified alignment on types
> >   virtio: add legacy init/size APIs
> >   virtio_ring: switch to virtio_legacy_init/size
> >   tools/virtio: switch to virtio_legacy_init/size
> >   vop: switch to virtio_legacy_init/size
> >   remoteproc: switch to virtio_legacy_init/size
> >   mellanox: switch to virtio_legacy_init/size
> >   vhost: option to fetch descriptors through an independent struct
> >   vhost: use batched version by default
> >   vhost: batching fetches
> > 
> >  drivers/block/virtio_blk.c               |   1 +
> >  drivers/char/hw_random/virtio-rng.c      |   1 +
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   1 +
> >  drivers/misc/mic/vop/vop_main.c          |   5 +-
> >  drivers/misc/mic/vop/vop_vringh.c        |   8 +-
> >  drivers/platform/mellanox/mlxbf-tmfifo.c |   6 +-
> >  drivers/remoteproc/remoteproc_core.c     |   2 +-
> >  drivers/remoteproc/remoteproc_sysfs.c    |   1 +
> >  drivers/remoteproc/remoteproc_virtio.c   |   2 +-
> >  drivers/vhost/test.c                     |   2 +-
> >  drivers/vhost/vhost.c                    | 271 +++++++++++++++--------
> >  drivers/vhost/vhost.h                    |  23 +-
> >  drivers/virtio/virtio_input.c            |   1 +
> >  drivers/virtio/virtio_pci_modern.c       |   1 +
> >  drivers/virtio/virtio_ring.c             |  15 +-
> >  include/linux/virtio.h                   |   1 -
> >  include/linux/virtio_ring.h              |  46 ++++
> >  include/linux/vringh.h                   |   1 +
> >  include/uapi/linux/virtio_ring.h         |  30 ++-
> >  tools/virtio/Makefile                    |   2 +-
> >  tools/virtio/asm/barrier.h               |   1 +
> >  tools/virtio/linux/compiler.h            |   1 +
> >  tools/virtio/ringtest/virtio_ring_0_9.c  |   6 +-
> >  tools/virtio/virtio_test.c               |   6 +-
> >  tools/virtio/vringh_test.c               |  18 +-
> >  25 files changed, 311 insertions(+), 141 deletions(-)
> > 
> > --
> > MST
> > 
> > 
> 
> > 

