Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EFC433EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFC222D6E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B042Axnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHFFz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbgHFFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596693353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vv95cTkdzqIZ8eUeXOL4xgSOD8IhzvwipbFF4KLUn3o=;
        b=B042AxnumN3Aaupv53ldh3dpth2vvHopyZbLQ8ArflF7SJH89bD0zEv7drHs7FOpW3IsB/
        fGoRO6nJ4wBcFW3xVsm8u8tjEcDaM2YixlrrqOjtKzcAUscpy/VXvfHdz3Uqcm6cGD/i1R
        66ZHlZuWHYS+CFbkblMe/XSs681+hmk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-iXLA2xhoNJeFbpsCMsF4RQ-1; Thu, 06 Aug 2020 01:55:51 -0400
X-MC-Unique: iXLA2xhoNJeFbpsCMsF4RQ-1
Received: by mail-wm1-f70.google.com with SMTP id f74so3676617wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vv95cTkdzqIZ8eUeXOL4xgSOD8IhzvwipbFF4KLUn3o=;
        b=JbnDV958xEAd+aV3XnGXVFkLPDfew2bwhSNKmZ1v2aab9OfWQe7axZf46Cs2GzQFSL
         0YCZ91rVsHWctP0/n5LtMwooQo2oyDrPH90tqa8zGxMCnRlqiZt/RdH6eL1P4QrGqW5v
         iLT08MkucN2wt+zQpRwWd3HAFJT6l2RtQG6HdGkbgHMFT4M9cbAmehUZxwW1fEhkHUMG
         xqp/VdBGYINZf96Wy5aJ5K8x5DOBTtm6l9qRhujG1IQbfVO1GX4cyEOPtIsRE/hRbf2c
         HPIn0Ey/sOIneDVLuSCxNKrIlmLAS4qtDJ/7kPt4+9f1031lrRW3glNR0PYzfybqwYUn
         f95Q==
X-Gm-Message-State: AOAM5307XLmxlPG1CCs9t2ZhzgXK9nV/iW8fu8l0NeC4CHHPD/1i9E5n
        rNsQ5GLOeEd2hy+KbpYsPmIlPLQ6XruiwodIVurC5oMGyHU6mEoT9R1s3r+ezlgKLYOGsWxjfIh
        RPJ/ArgJ4qc8iOi7lRkPWFvKf
X-Received: by 2002:a1c:2646:: with SMTP id m67mr6675520wmm.137.1596693350421;
        Wed, 05 Aug 2020 22:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx08gE4aA+Do8IVciL8GUnVeLcSzewgPqTloEUDa1j+r/zSmJ0raKbrtSORsged7mQQ8WpiLw==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr6675504wmm.137.1596693350147;
        Wed, 05 Aug 2020 22:55:50 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id k184sm5157635wme.1.2020.08.05.22.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:55:49 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:55:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
Message-ID: <20200806015513-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
 <20200805085635-mutt-send-email-mst@kernel.org>
 <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:29:16AM +0800, Jason Wang wrote:
> 
> On 2020/8/5 下午8:58, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:29:47AM +0800, Jason Wang wrote:
> > > This patch introduces a new ioctl for vhost-vdpa device that can
> > > report the iova range by the device. For device that depends on
> > > platform IOMMU, we fetch the iova range via DOMAIN_ATTR_GEOMETRY. For
> > > devices that has its own DMA translation unit, we fetch it directly
> > > from vDPA bus operation.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
> > >   include/uapi/linux/vhost.h       |  4 ++++
> > >   include/uapi/linux/vhost_types.h |  5 +++++
> > >   3 files changed, 36 insertions(+)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 77a0c9fb6cc3..ad23e66cbf57 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -332,6 +332,30 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
> > >   	return 0;
> > >   }
> > > +
> > > +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> > > +{
> > > +	struct iommu_domain_geometry geo;
> > > +	struct vdpa_device *vdpa = v->vdpa;
> > > +	const struct vdpa_config_ops *ops = vdpa->config;
> > > +	struct vhost_vdpa_iova_range range;
> > > +	struct vdpa_iova_range vdpa_range;
> > > +
> > > +	if (!ops->set_map && !ops->dma_map) {
> > Why not just check if (ops->get_iova_range) directly?
> 
> 
> Because set_map || dma_ops is a hint that the device has its own DMA
> translation logic.
> 
> Device without get_iova_range does not necessarily meant it use IOMMU
> driver.
> 
> Thanks

OK let's add some code comments please, and check get_iova_range
is actually there before calling.

> 
> > 
> > 
> > 
> > 
> > > +		iommu_domain_get_attr(v->domain,
> > > +				      DOMAIN_ATTR_GEOMETRY, &geo);
> > > +		range.start = geo.aperture_start;
> > > +		range.end = geo.aperture_end;
> > > +	} else {
> > > +		vdpa_range = ops->get_iova_range(vdpa);
> > > +		range.start = vdpa_range.start;
> > > +		range.end = vdpa_range.end;
> > > +	}
> > > +
> > > +	return copy_to_user(argp, &range, sizeof(range));
> > > +
> > > +}
> > > +
> > >   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > >   				   void __user *argp)
> > >   {
> > > @@ -442,6 +466,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > >   	case VHOST_VDPA_SET_CONFIG_CALL:
> > >   		r = vhost_vdpa_set_config_call(v, argp);
> > >   		break;
> > > +	case VHOST_VDPA_GET_IOVA_RANGE:
> > > +		r = vhost_vdpa_get_iova_range(v, argp);
> > > +		break;
> > >   	default:
> > >   		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> > >   		if (r == -ENOIOCTLCMD)
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index 0c2349612e77..850956980e27 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -144,4 +144,8 @@
> > >   /* Set event fd for config interrupt*/
> > >   #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
> > > +
> > > +/* Get the valid iova range */
> > > +#define VHOST_VDPA_GET_IOVA_RANGE	_IOW(VHOST_VIRTIO, 0x78, \
> > > +					     struct vhost_vdpa_iova_range)
> > >   #endif
> > > diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> > > index 669457ce5c48..4025b5a36177 100644
> > > --- a/include/uapi/linux/vhost_types.h
> > > +++ b/include/uapi/linux/vhost_types.h
> > > @@ -127,6 +127,11 @@ struct vhost_vdpa_config {
> > >   	__u8 buf[0];
> > >   };
> > > +struct vhost_vdpa_iova_range {
> > > +	__u64 start;
> > > +	__u64 end;
> > > +};
> > > +
> > 
> > Pls document fields. And I think first/last is a better API ...
> > 
> > >   /* Feature bits */
> > >   /* Log all write descriptors. Can be changed while device is active. */
> > >   #define VHOST_F_LOG_ALL 26
> > > -- 
> > > 2.20.1

