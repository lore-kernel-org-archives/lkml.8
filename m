Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532632177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geGxxXXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgHERYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:24:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34098 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728485AbgHERQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lad+l1QsVGACWdbh/Js4EqT43VIKUvJSAKVohar8Uec=;
        b=geGxxXXI5N6UvtmH5+Th8NT6nsUOKyjiAAzwNPda72ts1kdnSMpY4OAaceZXsPaJWsot+k
        UdyiofWAjjmk/Rb96oQL0gcmiM4NPQwdhNw2nOqvd+U5i7YHKrPEcYvulCnnt/G9XaFx9W
        u81nnO08lRFDRAiSyUU4BI2Efh1N2a0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-WY5JIb6JMEOlT1wXyPPUUA-1; Wed, 05 Aug 2020 07:40:20 -0400
X-MC-Unique: WY5JIb6JMEOlT1wXyPPUUA-1
Received: by mail-wr1-f72.google.com with SMTP id e12so13538114wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lad+l1QsVGACWdbh/Js4EqT43VIKUvJSAKVohar8Uec=;
        b=s3YAd+wlXGjLRp1AwSxn5Q7Sy/sbmPNBuC6TO5J06m8b6UcCt1bCH7d+OiRY9z1hyf
         tUzXcqfKqm5Qx/9kTzSg0RrJkCE/Hiv46/EllQg6Qzb+e9Ubh+nMM5XeWfNPTgWW74E4
         0mUbT6PccIs21ExPqJvr8+Tvjw2vgy5QRoFO5VVUPqGKX9YndGY0F07C+OlxqMdqULXj
         7CCOae02VD5iE1/Z4a/uRAbTU/LU6KObuzeR3FzVqXjeUPjHjto7RhMndHIWHtxKYb8J
         XE/pw6BytMBf+ZaBTMqO2VOwDeefafVqUGetNorawbNmeqHao+Tef/luoXogQ3Bd8MaB
         O74g==
X-Gm-Message-State: AOAM531cNFS1Ig7IjcznhuuGmm8KLYl8q5YvzoaAzK8OBcFVQwbOe1J7
        Yg7/IgSDlMXSh2kCzMNdLlu//9VsOi5Bgv1xm1+SAak25Ycq7fZe5oPlCpy440dB6OHqa3QmP6V
        6c8zASI89Q00wSeolcsMlVRTM
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr2905540wml.186.1596627619070;
        Wed, 05 Aug 2020 04:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzLUhNKsFdDJV97Qke7oWTu+zTzIxWpF7w4wMB3AJ3toR2KxppLas4gqRP9GzEle7rmm20eQ==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr2905517wml.186.1596627618867;
        Wed, 05 Aug 2020 04:40:18 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id d14sm2409261wre.44.2020.08.05.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:40:17 -0700 (PDT)
Date:   Wed, 5 Aug 2020 07:40:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
Message-ID: <20200805073929-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:14:07PM +0800, Jason Wang wrote:
> 
> On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
> > Some legacy guests just assume features are 0 after reset.
> > We detect that config space is accessed before features are
> > set and set features to 0 automatically.
> > Note: some legacy guests might not even access config space, if this is
> > reported in the field we might need to catch a kick to handle these.
> 
> 
> I wonder whether it's easier to just support modern device?
> 
> Thanks


Well hardware vendors are I think interested in supporting legacy
guests. Limiting vdpa to modern only would make it uncompetitive.



> 
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vdpa/vdpa.c  |  1 +
> >   include/linux/vdpa.h | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index de211ef3738c..7105265e4793 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -96,6 +96,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> >   	vdev->dev.release = vdpa_release_dev;
> >   	vdev->index = err;
> >   	vdev->config = config;
> > +	vdev->features_valid = false;
> >   	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
> >   	if (err)
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 239db794357c..29b8296f1414 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -33,12 +33,14 @@ struct vdpa_notification_area {
> >    * @dma_dev: the actual device that is performing DMA
> >    * @config: the configuration ops for this device.
> >    * @index: device index
> > + * @features_valid: were features initialized? for legacy guests
> >    */
> >   struct vdpa_device {
> >   	struct device dev;
> >   	struct device *dma_dev;
> >   	const struct vdpa_config_ops *config;
> >   	unsigned int index;
> > +	bool features_valid;
> >   };
> >   /**
> > @@ -266,4 +268,36 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> >   {
> >   	return vdev->dma_dev;
> >   }
> > +
> > +static inline void vdpa_reset(struct vdpa_device *vdev)
> > +{
> > +        const struct vdpa_config_ops *ops = vdev->config;
> > +
> > +	vdev->features_valid = false;
> > +        ops->set_status(vdev, 0);
> > +}
> > +
> > +static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > +{
> > +        const struct vdpa_config_ops *ops = vdev->config;
> > +
> > +	vdev->features_valid = true;
> > +        return ops->set_features(vdev, features);
> > +}
> > +
> > +
> > +static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
> > +				   void *buf, unsigned int len)
> > +{
> > +        const struct vdpa_config_ops *ops = vdev->config;
> > +
> > +	/*
> > +	 * Config accesses aren't supposed to trigger before features are set.
> > +	 * If it does happen we assume a legacy guest.
> > +	 */
> > +	if (!vdev->features_valid)
> > +		vdpa_set_features(vdev, 0);
> > +	ops->get_config(vdev, offset, buf, len);
> > +}
> > +
> >   #endif /* _LINUX_VDPA_H */

