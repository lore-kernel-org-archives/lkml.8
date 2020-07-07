Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8912065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVEslWn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGJqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:46:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728066AbgGGJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594115206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paElSljDoi/kRmElIyCEk5zdeibZul3cFtMLCVBiU6A=;
        b=BVEslWn7sf5c89KoPkivL5w65yIWXBhlWHh+0Lvyp2e09vhqMtHKHnsPxlstXYXv5q4usf
        qxSuzlVeJPO8r+iJGxpS//BbBX74ayr0lSbm6GKDFVfZakelVIsNMkcdjoL05urrR4plAt
        XWW2dS8g3NzF6YCpswPUQSyqH4+C0Ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-vebczNtdNi-q_vVha5qWyw-1; Tue, 07 Jul 2020 05:46:44 -0400
X-MC-Unique: vebczNtdNi-q_vVha5qWyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4893461;
        Tue,  7 Jul 2020 09:46:42 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943B160CC0;
        Tue,  7 Jul 2020 09:46:36 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:46:33 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200707114633.68122a00.cohuck@redhat.com>
In-Reply-To: <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
        <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jul 2020 10:44:37 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> S390, protecting the guest memory against unauthorized host access
> needs to enforce VIRTIO I/O device protection through the use of
> VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.

Hm... what about:

"If protected virtualization is active on s390, the virtio queues are
not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
negotiated. Use the new arch_validate_virtio_features() interface to
enforce this."

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index c296e5c8dbf9..106330f6eda1 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -14,6 +14,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/virtio_config.h>
>  #include <asm/facility.h>
>  #include <asm/sections.h>
>  #include <asm/uv.h>
> @@ -413,3 +414,27 @@ static int __init uv_info_init(void)
>  }
>  device_initcall(uv_info_init);
>  #endif
> +
> +/*
> + * arch_validate_virtio_iommu_platform

s/arch_validate_virtio_iommu_platform/arch_validate_virtio_features/

> + * @dev: the VIRTIO device being added
> + *
> + * Return value: returns -ENODEV if any features of the
> + *               device breaks the protected virtualization
> + *               0 otherwise.

I don't think you need to specify the contract here: that belongs to
the definition in the virtio core. What about simply adding a sentence
"Return an error if required features are missing on a guest running
with protected virtualization." ?

> + */
> +int arch_validate_virtio_features(struct virtio_device *dev)
> +{

Maybe jump out immediately if the guest is not protected?

> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> +		return is_prot_virt_guest() ? -ENODEV : 0;
> +	}
> +
> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> +		return is_prot_virt_guest() ? -ENODEV : 0;
> +	}

if (!is_prot_virt_guest())
	return 0;

if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
	dev_warn(&dev->dev,
                 "legacy virtio is incompatible with protected guests");
	return -ENODEV;
}

if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
	dev_warn(&dev->dev,
		 "device does not work with limited memory access in protected guests");
	return -ENODEV;
}

> +
> +	return 0;
> +}

