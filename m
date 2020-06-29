Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D25206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WATI1aeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgF2TOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29731 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731769AbgF2TO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKk9x1ZzFjGFJjDTJMw2AVFBxkCLtkiGAK1b50FnpyI=;
        b=WATI1aeZOHz9BODvfqaTcBY2W/1jGBnLt5xW4kA4HhoiSHA9WDX/MQIcOHN1lq5hFBx9Qm
        RcPnzk06yxIDvIqZo4e/FEn6/I9hZvcCNt87YdWz6ZXESnzDa0roqJ+U0wt+J2CamvYbNl
        ixyG+Wh+wf4uW0iQytHYf/8Q5g5+Bvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-FXOnTUHOM4eXhKCA6AhhAA-1; Mon, 29 Jun 2020 12:09:07 -0400
X-MC-Unique: FXOnTUHOM4eXhKCA6AhhAA-1
Received: by mail-wr1-f69.google.com with SMTP id g14so16716041wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKk9x1ZzFjGFJjDTJMw2AVFBxkCLtkiGAK1b50FnpyI=;
        b=LLv0CmCT/fbX/QGAk4mdytBE+LPKlQvmI+WL8zP1+PFo+pHi+6NBVxWB5aNDoEDGPG
         eMhAmXRFrLN4pv7ZDtdVlzmHAKrt0z27SqM2cXYYpQcfEi3tXBKquQW9XndtAQjmD8su
         3d3JoN24GVS5wLoINXP5gKHWxgNaBKkbfld9INB7KeZrV9qRPNv6g08LPqg7KchZuRtP
         a+snnqDxFqOqUz5R/cplLJIakbQjsQZ9ULCxp3/aL26wyr3uqZS/r47pSQA2C0ohpLVU
         CJwepUFqMTkMduqXqm2iKD+8dKDZ4ux5I5o/9/FDCEg8II39B1CzIm4PBPrIP/j+sBXd
         YOqg==
X-Gm-Message-State: AOAM533QtBaxVfXvLmTrhxu5EDsmiUPBlNxGLqVd4uDKNz744hHP8sFh
        eGCiSO/bU4/zAw4tosL6Rjh9yJaUdgFsGixr0CVvAc4DwOVFdmLo5FoK6EOTjPjeR+um8LHEoT5
        tso7uL2e+/sh3cdvN6aj+63l5
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr17963500wre.260.1593446946505;
        Mon, 29 Jun 2020 09:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDXOCSXxSQZMNZVOBwszvdjERPP6yUs2xp6RZO8HYxWfEU+82mznJ8Ra2CRJJQ8FwgVwFeLw==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr17963478wre.260.1593446946277;
        Mon, 29 Jun 2020 09:09:06 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id j6sm274496wma.25.2020.06.29.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:09:05 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:09:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200629115952-mutt-send-email-mst@kernel.org>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
> An architecture protecting the guest memory against unauthorized host
> access may want to enforce VIRTIO I/O device protection through the
> use of VIRTIO_F_IOMMU_PLATFORM.
> Let's give a chance to the architecture to accept or not devices
> without VIRTIO_F_IOMMU_PLATFORM.

I agree it's a bit misleading. Protection is enforced by memory
encryption, you can't trust the hypervisor to report the bit correctly
so using that as a securoty measure would be pointless.
The real gain here is that broken configs are easier to
debug.

Here's an attempt at a better description:

	On some architectures, guest knows that VIRTIO_F_IOMMU_PLATFORM is
	required for virtio to function: e.g. this is the case on s390 protected
	virt guests, since otherwise guest passes encrypted guest memory to devices,
	which the device can't read. Without VIRTIO_F_IOMMU_PLATFORM the
	result is that affected memory (or even a whole page containing
	it is corrupted). Detect and fail probe instead - that is easier
	to debug.

however, now that we have described what it is (hypervisor
misconfiguration) I ask a question: can we be sure this will never
ever work? E.g. what if some future hypervisor gains ability to
access the protected guest memory in some abstractly secure manner?
We are blocking this here, and it's hard to predict the future,
and a broken hypervisor can always find ways to crash the guest ...

IMHO it would be safer to just print a warning.
What do you think?



> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/init.c     |  6 ++++++
>  drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
>  include/linux/virtio.h  |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 6dc7c3b60ef6..215070c03226 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -45,6 +45,7 @@
>  #include <asm/kasan.h>
>  #include <asm/dma-mapping.h>
>  #include <asm/uv.h>
> +#include <linux/virtio.h>
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  
> @@ -161,6 +162,11 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>  
> +int arch_needs_virtio_iommu_platform(struct virtio_device *dev)
> +{
> +	return is_prot_virt_guest();
> +}
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..aa8e01104f86 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
>  
> +/*
> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing
> + *				      features for VIRTIO device dev
> + * @dev: the VIRTIO device being added
> + *
> + * Permits the platform to provide architecture specific functionality when
> + * devices features are finalized. This is the default implementation.
> + * Architecture implementations can override this.
> + */
> +
> +int __weak arch_needs_virtio_iommu_platform(struct virtio_device *dev)
> +{
> +	return 0;
> +}
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> +	if (arch_needs_virtio_iommu_platform(dev) &&
> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> +		return -ENODEV;
> +	}
> +
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>  	status = dev->config->get_status(dev);
>  	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a493eac08393..e8526ae3463e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -195,4 +195,6 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
> +
> +int arch_needs_virtio_iommu_platform(struct virtio_device *dev);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.25.1

