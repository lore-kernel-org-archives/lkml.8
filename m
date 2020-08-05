Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36995C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF0822CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLiWvD9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHEUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:13:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbgHEQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st8bBehsTAufbhHFpNAjUz+GFm9Sypep/hQM+t1/5CA=;
        b=OLiWvD9ULsohS61oaTeFplCN+DkUM9HeIVyk6n6cNe6FVwoKywvshZmrs1SPjjht9MqauR
        d+WkS2zparbT3wccflLUiJre7E/uMCSNy+3bcmxQJTrMToaVLyok2c9Z1HyhpzsldgusNM
        0TIQ3iBjUYy+WwvBMHwQQafiHYzB+Kk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cRgaUL_oMUOSM6Ik95spaA-1; Wed, 05 Aug 2020 07:44:26 -0400
X-MC-Unique: cRgaUL_oMUOSM6Ik95spaA-1
Received: by mail-wr1-f69.google.com with SMTP id e14so10016557wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=st8bBehsTAufbhHFpNAjUz+GFm9Sypep/hQM+t1/5CA=;
        b=MGy5IRm0mVzUXa2+ntALKn0nOjg1gB0wzNk2ml+GM94t4X83zgtvxb5RwpFJuOHGxN
         Dcqp6szyoiT4AqhCUms6yF4r4Ippm2snVK6MCzwAw48ENIWSvyInDI+NvTjJlo0Wwqw7
         K1zKvs2EWKHF9L3ydpiNCahT4eXGcI3MJ+m2Z5f3dXNcT3zGjqwXSZM0zvocSC64D99G
         Q8EDHAaDhsO9b3VpVgDfS4JKo1WDP9CUSsVUzZWQGcVEULhDOf6GdlxiTneVmMFfBhCN
         Kcg124uGJncmeGEYvNGR+BbOmxXtUob7zFFxKnNJXmZ2ONwll99NCKHY7+GLhMceCl2z
         1NOA==
X-Gm-Message-State: AOAM533BozCdNIwkY/yeQnR7NJVI+gajXx1dwOXJ0qVz/173H15feriu
        0fF7XA0O9SxxqMGPZfIdDfA3aO832nJrvzfkR9lVYXMI/u0UkOLyGhgUdRTSL617aVGUE9a+rEH
        q9h/u8lcId8+16c1fFV+DD79W
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr3135805wml.106.1596627857904;
        Wed, 05 Aug 2020 04:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOkFykdUhPDpT8zbjlSuYH0hAbQAOKS37RNUEgvX/NjN6jmiXOGVeJFe+LNfzuJxKvZFKtEw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr3135788wml.106.1596627857703;
        Wed, 05 Aug 2020 04:44:17 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id m8sm2491089wro.75.2020.08.05.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:44:16 -0700 (PDT)
Date:   Wed, 5 Aug 2020 07:44:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
Message-ID: <20200805074105-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-23-mst@redhat.com>
 <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:21:07PM +0800, Jason Wang wrote:
> 
> On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
> > VDPA sim accesses config space as native endian - this is
> > wrong since it's a modern device and actually uses LE.
> > 
> > It only supports modern guests so we could punt and
> > just force LE, but let's use the full virtio APIs since people
> > tend to copy/paste code, and this is not data path anyway.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c | 31 ++++++++++++++++++++++++++-----
> >   1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index a9bc5e0fb353..fa05e065ff69 100644
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
> > @@ -306,7 +324,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops;
> >   static struct vdpasim *vdpasim_create(void)
> >   {
> > -	struct virtio_net_config *config;
> >   	struct vdpasim *vdpasim;
> >   	struct device *dev;
> >   	int ret = -ENOMEM;
> > @@ -331,10 +348,7 @@ static struct vdpasim *vdpasim_create(void)
> >   	if (!vdpasim->buffer)
> >   		goto err_iommu;
> > -	config = &vdpasim->config;
> > -	config->mtu = 1500;
> > -	config->status = VIRTIO_NET_S_LINK_UP;
> > -	eth_random_addr(config->mac);
> > +	eth_random_addr(vdpasim->config.mac);
> >   	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
> >   	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
> > @@ -448,6 +462,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
> >   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> >   {
> >   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +	struct virtio_net_config *config = &vdpasim->config;
> >   	/* DMA mapping must be done by driver */
> >   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> > @@ -455,6 +470,12 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> >   	vdpasim->features = features & vdpasim_features;
> > +	/* We only know whether guest is using the legacy interface here, so
> > +	 * that's the earliest we can set config fields.
> > +	 */
> 
> 
> We check whether or not ACCESS_PLATFORM is set before which is probably a
> hint that only modern device is supported. So I wonder just force LE and
> fail if VERSION_1 is not set is better?
> 
> Thanks
> 

Hmm good point. As usual legacy does not have a clean way to fail though,
are we sure we don't ever want to support legacy guests?


> > +
> > +	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> > +	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> >   	return 0;
> >   }

