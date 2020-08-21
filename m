Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9738C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C637B20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pprz9GB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHUL7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:59:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727793AbgHUL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598011159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXhX/N8GWSH0WBma7AaYD7/6Ls1zDroEUp4iK0a472s=;
        b=Pprz9GB18yLo7N34MsnjMH33xtquWqXOEpcs8SwzZegs2ys9NLQ9DizkDiZ6dFnHUctdNi
        HAx/fSrv3YxY07F7/GavoDyflMF6d2RKHlOI3xj/8J0ocHv993TjTJCDZYB9+3Wf+qyYQ6
        TXQGdbOhkRovEPH76PIvewl/AFLNUBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-k3hyZhTvOxCnLe9Nsh08xw-1; Fri, 21 Aug 2020 07:59:17 -0400
X-MC-Unique: k3hyZhTvOxCnLe9Nsh08xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C82864080;
        Fri, 21 Aug 2020 11:59:15 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEAE27AECB;
        Fri, 21 Aug 2020 11:59:08 +0000 (UTC)
Date:   Fri, 21 Aug 2020 13:59:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v9 1/2] virtio: let arch advertise guest's memory access
 restrictions
Message-ID: <20200821135906.1c6bede3.cohuck@redhat.com>
In-Reply-To: <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
        <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 18:23:17 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may restrict host access to guest memory.

"e.g. IBM s390 Secure Execution or AMD SEV"

Just to make clearer what you are referring to?

> 
> Provide a new Kconfig entry the architecture can select,
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
> the arch_has_restricted_virtio_memory_access callback to advertise

s/advertise/advertise to/

> VIRTIO common code when the architecture restricts memory access
> from the host.

"The common code can then fail the probe for any device where
VIRTIO_F_IOMMU_PLATFORM is required, but not set."

?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       | 15 +++++++++++++++
>  include/linux/virtio_config.h |  9 +++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..509f3b4d8ba1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected by any architecture enforcing
> +	  VIRTIO_F_IOMMU_PLATFORM

"This option is selected if the architecture may need to enforce
VIRTIO_F_IOMMU_PLATFORM."

?

> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

