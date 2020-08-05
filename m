Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840A422CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYyYL82K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHEUJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:09:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgHEQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ULrzApT10RVIpakDAc4yxKBeNUnNTeZD7ehmAQ8Tms=;
        b=XYyYL82KozWTlZEnoE9hOkSv4h3gvP+3o59kDPpoly70br8ohs3XhJba1B8Ym4Q/p/LeQF
        pZJmSzhoo2/7eoi+CNDlwNIX2+E7RGLxwfOb4RlJRDQhUD2x7guwiO6JscV4YPeBBI0N7C
        rDdG9ZIb8gZfrkO97UioElzEMnkBBxA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-MD482BvWNSGIVOfLKES59g-1; Wed, 05 Aug 2020 08:58:08 -0400
X-MC-Unique: MD482BvWNSGIVOfLKES59g-1
Received: by mail-wr1-f72.google.com with SMTP id z1so13537647wrn.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ULrzApT10RVIpakDAc4yxKBeNUnNTeZD7ehmAQ8Tms=;
        b=gXLL4HjKnSfOop8outjvqjE1HViPmYOCX1yZz4sCKaukOPhDmQRfa8nrZ+I3FV+Np4
         C6e1eiL/oBCUIiypWL6AW+AFqXKSkCPLlkSKOxVaz1x+7MKjzmx/WN88RBC6xnP3951v
         xmuUsfpxUlRCOWf6grSEulGXASlW/bpU/uD2LWmIPPWifiqgkGd2aw68aYWYhSl2BRhF
         wI3Hp41CGdfaLvNoDfJ844TOFch96RnI9VG97Sjd2lzf5qutifAGAkJoFr5qP00y3EOM
         BD6KZoxzMOxUSub9W35bSRn0lwFiZPlKomCZkAijY2HrrySUfCcjlad/ixs5k/DnrOhO
         3gew==
X-Gm-Message-State: AOAM5309x3Kt3GHVGmSvab8Em2lg3lx3PMDnG/lFDCgcx2t5TK8ycUSv
        8NFuJ6REsi+GuI65uSJk6PQiqXBpQmAyFlqh1VY8Hw71DVKZqq84+fM6cShf8zOzuRjGTPmDhWH
        vZlG0pkCjlcQSOUpO9GaYUrZu
X-Received: by 2002:adf:a106:: with SMTP id o6mr2692913wro.1.1596632287579;
        Wed, 05 Aug 2020 05:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymsZfge35MX/5Sup1G9j697447cGxNEw/hBVXxdZ/SC5LeZkULFXxLuRBqbaI8jyXaxQHhUw==
X-Received: by 2002:adf:a106:: with SMTP id o6mr2692833wro.1.1596632286353;
        Wed, 05 Aug 2020 05:58:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id p8sm2842373wrq.9.2020.08.05.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:58:05 -0700 (PDT)
Date:   Wed, 5 Aug 2020 08:58:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
Message-ID: <20200805085635-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-5-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29:47AM +0800, Jason Wang wrote:
> This patch introduces a new ioctl for vhost-vdpa device that can
> report the iova range by the device. For device that depends on
> platform IOMMU, we fetch the iova range via DOMAIN_ATTR_GEOMETRY. For
> devices that has its own DMA translation unit, we fetch it directly
> from vDPA bus operation.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h       |  4 ++++
>  include/uapi/linux/vhost_types.h |  5 +++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 77a0c9fb6cc3..ad23e66cbf57 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -332,6 +332,30 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
>  
>  	return 0;
>  }
> +
> +static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> +{
> +	struct iommu_domain_geometry geo;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct vhost_vdpa_iova_range range;
> +	struct vdpa_iova_range vdpa_range;
> +
> +	if (!ops->set_map && !ops->dma_map) {

Why not just check if (ops->get_iova_range) directly?




> +		iommu_domain_get_attr(v->domain,
> +				      DOMAIN_ATTR_GEOMETRY, &geo);
> +		range.start = geo.aperture_start;
> +		range.end = geo.aperture_end;
> +	} else {
> +		vdpa_range = ops->get_iova_range(vdpa);
> +		range.start = vdpa_range.start;
> +		range.end = vdpa_range.end;
> +	}
> +
> +	return copy_to_user(argp, &range, sizeof(range));
> +
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -442,6 +466,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	case VHOST_VDPA_SET_CONFIG_CALL:
>  		r = vhost_vdpa_set_config_call(v, argp);
>  		break;
> +	case VHOST_VDPA_GET_IOVA_RANGE:
> +		r = vhost_vdpa_get_iova_range(v, argp);
> +		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>  		if (r == -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 0c2349612e77..850956980e27 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -144,4 +144,8 @@
>  
>  /* Set event fd for config interrupt*/
>  #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
> +
> +/* Get the valid iova range */
> +#define VHOST_VDPA_GET_IOVA_RANGE	_IOW(VHOST_VIRTIO, 0x78, \
> +					     struct vhost_vdpa_iova_range)
>  #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 669457ce5c48..4025b5a36177 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -127,6 +127,11 @@ struct vhost_vdpa_config {
>  	__u8 buf[0];
>  };
>  
> +struct vhost_vdpa_iova_range {
> +	__u64 start;
> +	__u64 end;
> +};
> +


Pls document fields. And I think first/last is a better API ...

>  /* Feature bits */
>  /* Log all write descriptors. Can be changed while device is active. */
>  #define VHOST_F_LOG_ALL 26
> -- 
> 2.20.1

