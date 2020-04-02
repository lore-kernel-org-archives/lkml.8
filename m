Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C66C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A4720784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnfgyI9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbgDBMyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:54:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388332AbgDBMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585832046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+rpGY/lQzxU62GHHMv3q/FRvIYAGToP29ghNExNLYc=;
        b=RnfgyI9+oyMc3AuIbdtm6rrOc3vRp8y16aj+7KDdObR1zzjbELDemQJmQ9nBAXDh0CqtV7
        YshEO7NY2ybY+RRJA+t7j8A5HewgLXpKDX1h6aH+CcXS7hVnEpPdSw4jB21r8h0vX4Qdif
        AFFzVnrGAy8DXyTnyC1hpHpujER3UUw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-2kbaBs38MwWBGrezlkjw7g-1; Thu, 02 Apr 2020 08:54:05 -0400
X-MC-Unique: 2kbaBs38MwWBGrezlkjw7g-1
Received: by mail-qt1-f199.google.com with SMTP id z5so3051871qtd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e+rpGY/lQzxU62GHHMv3q/FRvIYAGToP29ghNExNLYc=;
        b=Q1Vj6aH1TAtB0LiZowQ+Pk/PbiUvhYNM4c3AWFtDLXZNomUyvfe0zeCN9ujh5dTWMd
         iFOicMwVhnkRmZIRD6EUJGSm8OUcMKssAGYhQBs6qwaDVdF+q29PcP3sAvLcMVZNMNHy
         Qxeup9CEGx/HudxmRRbz/yRqMr/NS7ELCRItrJaZ4F4PR7YW9qEprsZFT6Mt6LuARMFu
         mD1ZtQwLtSQWLAzh3yIau+m5oakO13RRZKmvqy4m+2w4GtOwadVelzNT7oVYpGLSM1cc
         D38/pt8pVuYxmsGtw9nH9H2sbBrLsZDILg6W5zr28ODIZDQMBLptjOn7dHFEWJ11bvu0
         UdlQ==
X-Gm-Message-State: AGi0PubgHu/mxRiwWCFBwLgBNIp4nTX54AFjB+dGCZrP49jW32QiMsUU
        bufBKhCx+iqvbwgzfjD50MbgXAItYr5WiohPB9GBSTnUljd4SGRkjlPFVmM68yzCXtFy+RUoXMR
        zYGlhfwd74G8CyXRY0hvn9Fab
X-Received: by 2002:a37:b17:: with SMTP id 23mr3444709qkl.326.1585832044800;
        Thu, 02 Apr 2020 05:54:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWAXrSE3QY71rFZEVKPyM9P23H/+nJyT2FOKqzUpxwU6y4/YNd29YMt69nqsRb7v9SGkCigg==
X-Received: by 2002:a37:b17:: with SMTP id 23mr3444679qkl.326.1585832044434;
        Thu, 02 Apr 2020 05:54:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id m27sm3713948qtf.80.2020.04.02.05.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:54:03 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:53:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] virtio/test: fix up after IOTLB changes
Message-ID: <20200402084021-mutt-send-email-mst@kernel.org>
References: <20200401165100.276039-1-mst@redhat.com>
 <921fe999-e183-058d-722a-1a6a6ab066e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <921fe999-e183-058d-722a-1a6a6ab066e0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:01:56PM +0800, Jason Wang wrote:
> 
> On 2020/4/2 上午12:51, Michael S. Tsirkin wrote:
> > Allow building vringh without IOTLB (that's the case for userspace
> > builds, will be useful for CAIF/VOD down the road too).
> > Update for API tweaks.
> > Don't include vringh with kernel builds.
> 
> 
> I'm not quite sure we need this.
> 
> E.g the userspace accessor is not used by CAIF/VOP.

Well any exported symbols are always compiled in, right?
So we can save some kernel memory by not building unused stuff ...


> > 
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Eugenio Pérez <eperezma@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vhost/test.c   | 4 ++--
> >   drivers/vhost/vringh.c | 5 +++++
> >   include/linux/vringh.h | 2 ++
> >   tools/virtio/Makefile  | 3 ++-
> >   4 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 394e2e5c772d..9a3a09005e03 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -120,7 +120,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> >   	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> >   	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> >   	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > -		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT);
> > +		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> >   	f->private_data = n;
> > @@ -225,7 +225,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
> >   {
> >   	void *priv = NULL;
> >   	long err;
> > -	struct vhost_umem *umem;
> > +	struct vhost_iotlb *umem;
> >   	mutex_lock(&n->dev.mutex);
> >   	err = vhost_dev_check_owner(&n->dev);
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index ee0491f579ac..878e565dfffe 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -13,9 +13,11 @@
> >   #include <linux/uaccess.h>
> >   #include <linux/slab.h>
> >   #include <linux/export.h>
> > +#ifdef VHOST_IOTLB
> 
> 
> Kbuild bot reports build issues with this.
> 
> It looks to me we should use #if IS_ENABLED(CONFIG_VHOST_IOTLB) here and
> following checks.
> 
> Thanks
> 

In fact IS_REACHEABLE is probably the right thing to do.


> 
> >   #include <linux/bvec.h>
> >   #include <linux/highmem.h>
> >   #include <linux/vhost_iotlb.h>
> > +#endif
> >   #include <uapi/linux/virtio_config.h>
> >   static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
> > @@ -1059,6 +1061,8 @@ int vringh_need_notify_kern(struct vringh *vrh)
> >   }
> >   EXPORT_SYMBOL(vringh_need_notify_kern);
> > +#ifdef VHOST_IOTLB
> > +
> >   static int iotlb_translate(const struct vringh *vrh,
> >   			   u64 addr, u64 len, struct bio_vec iov[],
> >   			   int iov_size, u32 perm)
> > @@ -1416,5 +1420,6 @@ int vringh_need_notify_iotlb(struct vringh *vrh)
> >   }
> >   EXPORT_SYMBOL(vringh_need_notify_iotlb);
> > +#endif
> >   MODULE_LICENSE("GPL");
> > diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> > index bd0503ca6f8f..ebff121c0b02 100644
> > --- a/include/linux/vringh.h
> > +++ b/include/linux/vringh.h
> > @@ -14,8 +14,10 @@
> >   #include <linux/virtio_byteorder.h>
> >   #include <linux/uio.h>
> >   #include <linux/slab.h>
> > +#ifdef VHOST_IOTLB
> >   #include <linux/dma-direction.h>
> >   #include <linux/vhost_iotlb.h>
> > +#endif
> >   #include <asm/barrier.h>
> >   /* virtio_ring with information needed for host access. */
> > diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> > index f33f32f1d208..d3f152f4660b 100644
> > --- a/tools/virtio/Makefile
> > +++ b/tools/virtio/Makefile
> > @@ -22,7 +22,8 @@ OOT_CONFIGS=\
> >   	CONFIG_VHOST=m \
> >   	CONFIG_VHOST_NET=n \
> >   	CONFIG_VHOST_SCSI=n \
> > -	CONFIG_VHOST_VSOCK=n
> > +	CONFIG_VHOST_VSOCK=n \
> > +	CONFIG_VHOST_RING=n
> >   OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
> >   oot-build:
> >   	echo "UNSUPPORTED! Don't use the resulting modules in production!"

