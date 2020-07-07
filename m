Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08A420702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxkEsHGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:15:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30986 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726745AbgGGLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594120500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SkfEvXWOe57lsdbNZpY7pfaCzkWkPb715oD3Syj+e4=;
        b=VxkEsHGKTerksz5+5AG5XGp6j6VCjPGXo1cXO/WoQLDoTcF2m2zNHqsDT4aYWLQ6zn2SB9
        UHpRtuuWiY9H17J89zUPsF5UkSxlkw781qRW5VDqjE4NzKptsTThLNuIzrHomCkvCgtfzj
        Fufrbn+Xv0UHQEG45h77y9QKqrtOKww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Mdy9FweHOBCXQAfGxBdXrw-1; Tue, 07 Jul 2020 07:14:57 -0400
X-MC-Unique: Mdy9FweHOBCXQAfGxBdXrw-1
Received: by mail-wr1-f70.google.com with SMTP id e11so48418196wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2SkfEvXWOe57lsdbNZpY7pfaCzkWkPb715oD3Syj+e4=;
        b=BxWqL3TiATuLI+FQpOnVstGmllQkVmX4TrFHxK4pw0RhJs86kVwPMRy3w86dxfO+XR
         vnZNsCpzgIbxKwXyMwoZ45X8Amx3vIB1yshMJo4ujkw6r4Uj02z9k+qmIKvKISBxFnwm
         ppciTod+DBvEQMV3stVeSPksv6TuxOr3BF/5xFb+XQ4o2vXpAsNLZhsImG3/y7IIhcgy
         d+2d4cnsjUs4OvfTU8V1It4uhaMf4svG/pt57byG5ZFV5EPSCAe3KycPqOjOOtnl9AtI
         3RJPWNLLVyEH4o4rCDcIJzqgA0JvTv+GRDuaeZ50nce8GLxAiJWgW5cjISoE5rk3tih7
         bYrg==
X-Gm-Message-State: AOAM531PDMEzXsg+YllhNiImx1QjiCG2WE1aV0xHjWn00xg1O1Q7m73n
        T0PMcrfgNgFKwkTyMEmlWv588G9vxYMPlAFsp2j5rm/vTdUardWoaNHghG7TChhddK6d7JvIItb
        U2Za/2shxyhX3d6cX9CvkH2OI
X-Received: by 2002:adf:de01:: with SMTP id b1mr52165616wrm.305.1594120495907;
        Tue, 07 Jul 2020 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfrgQVHW0xPEz2qK4WxsyK5VqMd4mfiVNX7Uo+QjneR39/UAS7kA8HbpUGWt9XZF4TGRAOtA==
X-Received: by 2002:adf:de01:: with SMTP id b1mr52165596wrm.305.1594120495667;
        Tue, 07 Jul 2020 04:14:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-109-139.red.bezeqint.net. [79.182.109.139])
        by smtp.gmail.com with ESMTPSA id 92sm597206wrr.96.2020.07.07.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:14:54 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:14:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200707060838-mutt-send-email-mst@kernel.org>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
 <20200707114633.68122a00.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114633.68122a00.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 11:46:33AM +0200, Cornelia Huck wrote:
> On Tue,  7 Jul 2020 10:44:37 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > S390, protecting the guest memory against unauthorized host access
> > needs to enforce VIRTIO I/O device protection through the use of
> > VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.
> 
> Hm... what about:
> 
> "If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated. Use the new arch_validate_virtio_features() interface to
> enforce this."

s/enforce this/fail probe if that's not the case, preventing a host error on access attempt/



> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index c296e5c8dbf9..106330f6eda1 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/swap.h>
> > +#include <linux/virtio_config.h>
> >  #include <asm/facility.h>
> >  #include <asm/sections.h>
> >  #include <asm/uv.h>
> > @@ -413,3 +414,27 @@ static int __init uv_info_init(void)
> >  }
> >  device_initcall(uv_info_init);
> >  #endif
> > +
> > +/*
> > + * arch_validate_virtio_iommu_platform
> 
> s/arch_validate_virtio_iommu_platform/arch_validate_virtio_features/
> 
> > + * @dev: the VIRTIO device being added
> > + *
> > + * Return value: returns -ENODEV if any features of the
> > + *               device breaks the protected virtualization
> > + *               0 otherwise.
> 
> I don't think you need to specify the contract here: that belongs to
> the definition in the virtio core. What about simply adding a sentence
> "Return an error if required features are missing on a guest running
> with protected virtualization." ?
> 
> > + */
> > +int arch_validate_virtio_features(struct virtio_device *dev)
> > +{
> 
> Maybe jump out immediately if the guest is not protected?
> 
> > +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> > +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> > +
> > +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +		dev_warn(&dev->dev,
> > +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> 
> if (!is_prot_virt_guest())
> 	return 0;
> 
> if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> 	dev_warn(&dev->dev,
>                  "legacy virtio is incompatible with protected guests");
> 	return -ENODEV;
> }
> 
> if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> 	dev_warn(&dev->dev,
> 		 "device does not work with limited memory access in protected guests");
> 	return -ENODEV;
> }
> 
> > +
> > +	return 0;
> > +}

