Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0292067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R69s7Lac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgGPFmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:42:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgGPFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594878139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iOIeIlKEJcsPpbGDHdQOFqlT3P7K/L/+J8sfRdcsv8=;
        b=R69s7LactDAhvrFV18FlxBPbYq1ZwWa4ksF7JtBfp1uMW3uvZJWBeR5jSVwUYkpk68DjEq
        7Ij/R7pqznoaAjPz+yAoAYrdEY9WjTiVuiWudNMp3FjGnKwk7+4ADJFYq3Xdc23eejZ1xW
        eumZrxVYiOTlyHef+ikNhRCB5iWvotE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-rQWCdGBGPC22mc1Ieh8pbQ-1; Thu, 16 Jul 2020 01:42:17 -0400
X-MC-Unique: rQWCdGBGPC22mc1Ieh8pbQ-1
Received: by mail-wm1-f72.google.com with SMTP id o13so4010280wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7iOIeIlKEJcsPpbGDHdQOFqlT3P7K/L/+J8sfRdcsv8=;
        b=Q2nnVQUpfvX3RVEVGk6iIoRWQ8ej5Qpm+S3N3YqkYOfDEi3cTyihjuPyzHGRsiJLTQ
         FMf5VJC+Lg0Ip1pAzUqPjVLGP+sUGIlOr7/PgbzaCC3cvj/so6Tk5TR8SZ8iJOYWi9dm
         5VNc1bAfjueCqhsAq+AarnE4oYPTG/vbbXiXtWenAlcbYtue8wXU7xX0miIeRvHl4IGv
         Wn70f3cGrkwCmQ57Ax3Z49YOSSkl9mnIQXWusyJ7Kl54odqpDoEleDncPjm3sxjtjhjc
         RDp+I/ZOC2Cc7W0M0uxo6jba0esTZ4dlhbFwnil1FpQx5tEBuO07TOZBfLKBBTgpvSCq
         AZ1Q==
X-Gm-Message-State: AOAM533rEWcYjbuoaUndNrFYKf5X82qtrKIh1CzcJ/xcaNrJEbfpgHky
        6XaPxAHnQWjycPCsJ1hE3E6mdr0QBeTRVQe/W2AiOJCZZHY3swYhp6GGG6vVmHIFHimAHM+/9HO
        N8unV0nuCTORC1pAJS2D5un/Z
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr2861027wml.5.1594878135967;
        Wed, 15 Jul 2020 22:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk2KiSkJtmITnTvlIhxB0cz7evD1urhzNi5ygQuhGm8+M1oimW0b4DZK0pti7JeSPSHt1ykw==
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr2861015wml.5.1594878135700;
        Wed, 15 Jul 2020 22:42:15 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id k11sm7467756wrd.23.2020.07.15.22.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 22:42:15 -0700 (PDT)
Date:   Thu, 16 Jul 2020 01:42:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH RFC don't apply] vdpa_sim: endian-ness for config space
Message-ID: <20200716013306-mutt-send-email-mst@kernel.org>
References: <20200715135540.22832-1-mst@redhat.com>
 <8f39dcc1-0899-7ed8-8a6e-75672417b9e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f39dcc1-0899-7ed8-8a6e-75672417b9e3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:02:32PM +0800, Jason Wang wrote:
> 
> On 2020/7/15 下午9:58, Michael S. Tsirkin wrote:
> > VDPA sim stores config space as native endian, but that
> > is wrong: modern guests expect LE.
> > I coded up the following to fix it up, but it is wrong too:
> > vdpasim_create is called before guest features are known.
> > 
> > So what should we do? New ioctl to specify the interface used?
> > More ideas?
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Can we do the endian conversion in set_config/get_config()?
> 
> Thanks

That is problematic at least from static checking point of view.
It would be reasonable to do it in vdpasim_set_features, except
legacy guests might not set features at all.
So my proposal is:
- set config in vdpasim_set_features
- document that this is where devices should initialize config
- vdpa core will maintain a "features set" flag, if get/set config
  is called without set features, core will call set features
  automatically with 0 value.

Thoughts?


> 
> > 
> > 
> > ---
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c | 22 ++++++++++++++++++++--
> >   1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index a9bc5e0fb353..cc754ae0ec15 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/etherdevice.h>
> >   #include <linux/vringh.h>
> >   #include <linux/vdpa.h>
> > +#include <linux/virtio_byteorder.h>
> >   #include <linux/vhost_iotlb.h>
> >   #include <uapi/linux/virtio_config.h>
> >   #include <uapi/linux/virtio_net.h>
> > @@ -72,6 +73,23 @@ struct vdpasim {
> >   	u64 features;
> >   };
> > +/* TODO: cross-endian support */
> > +static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
> > +{
> > +	return virtio_legacy_is_little_endian() ||
> > +		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
> > +}
> > +
> > +static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
> > +{
> > +	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
> > +}
> > +
> > +static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
> > +{
> > +	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
> > +}
> > +
> >   static struct vdpasim *vdpasim_dev;
> >   static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> > @@ -332,8 +350,8 @@ static struct vdpasim *vdpasim_create(void)
> >   		goto err_iommu;
> >   	config = &vdpasim->config;
> > -	config->mtu = 1500;
> > -	config->status = VIRTIO_NET_S_LINK_UP;
> > +	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> > +	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> >   	eth_random_addr(config->mac);
> >   	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);

