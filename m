Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5BBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBC220658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqWt+fSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgHRRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:21:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgHRRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597771165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j64k1BjS19VEZuprA/Uv6wjZ0j6DF7go4E2SGuD+yBw=;
        b=UqWt+fSWx6byMZR95G6sKVBuK9u4TFF3pAdFqNOpiWIzC0n3gXySNCfsJE2qDxD9sOQQ1a
        q1rjC5FPgQkC3oia+GQDu6Rk4GUGW7++ufjIJ5u+0c/U8jlOWv6HSsbboSCMafQy95dTKT
        5+A/FBk6nQMhu3Ialk/3LGnV8a7mftQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-Jg3p_x-KOfG-Bfm2-U4Y1w-1; Tue, 18 Aug 2020 13:19:21 -0400
X-MC-Unique: Jg3p_x-KOfG-Bfm2-U4Y1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AF2100CEC4;
        Tue, 18 Aug 2020 17:19:19 +0000 (UTC)
Received: from gondolin (ovpn-112-221.ams2.redhat.com [10.36.112.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3242160C07;
        Tue, 18 Aug 2020 17:19:13 +0000 (UTC)
Date:   Tue, 18 Aug 2020 19:19:10 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/2] virtio: let arch validate VIRTIO features
Message-ID: <20200818191910.1fc300f2.cohuck@redhat.com>
In-Reply-To: <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
        <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 16:58:30 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may need to validate the VIRTIO devices features
> based on architecture specifics.
> 
> Provide a new Kconfig entry, CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS,
> the architecture can select when it provides a callback named
> arch_has_restricted_memory_access to validate the virtio device
> features.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/Kconfig        | 6 ++++++
>  drivers/virtio/virtio.c       | 4 ++++
>  include/linux/virtio_config.h | 9 +++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..eef09e3c92f9 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected by any architecture enforcing
> +	  VIRTIO_F_IOMMU_PLATFORM

This option is only for a very specific case of "restricted memory
access", namely the kind that requires IOMMU_PLATFORM for virtio
devices. ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS? Or is this intended
to cover cases outside of virtio as well?

> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..1471db7d6510 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -176,6 +176,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = arch_has_restricted_memory_access(dev);
> +	if (ret)
> +		return ret;

Hm, I'd rather have expected something like

if (arch_has_restricted_memory_access(dev)) {
	// enforce VERSION_1 and IOMMU_PLATFORM
}

Otherwise, you're duplicating the checks in the individual architecture
callbacks again.

[Not sure whether the device argument would be needed here; are there
architectures where we'd only require IOMMU_PLATFORM for a subset of
virtio devices?]

> +
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index bb4cc4910750..f6b82541c497 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -459,4 +459,13 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  		_r;							\
>  	})
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS
> +int arch_has_restricted_memory_access(struct virtio_device *dev);
> +#else
> +static inline int arch_has_restricted_memory_access(struct virtio_device *dev)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS */
> +
>  #endif /* _LINUX_VIRTIO_CONFIG_H */

