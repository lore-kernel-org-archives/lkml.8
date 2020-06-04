Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29D4207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoTD3080"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFDPBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:01:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40483 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729098AbgFDPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591282879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUJSsxamSXNS7464W+wDMFH7KOGftVp/cJbzl7mlIr8=;
        b=eoTD3080T91wFoY4mFuInMEHp3NZ0XZx/lHJ5b15iuNw7mMYKziLOO6j5pRseL1hjx1N+w
        mhGvA9Giqu9e3+/BuaUNtppKbF4dAICA214wzTeOR9NJixLKi0MM274AufspRBaHyQroV9
        NekqwOctOwiBOXG5jVnYMRAU5eDQegk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-fQD-0OoMPTecJ1u66hTwCg-1; Thu, 04 Jun 2020 11:01:17 -0400
X-MC-Unique: fQD-0OoMPTecJ1u66hTwCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48045464;
        Thu,  4 Jun 2020 15:01:15 +0000 (UTC)
Received: from gondolin (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D0A061987;
        Thu,  4 Jun 2020 15:01:09 +0000 (UTC)
Date:   Thu, 4 Jun 2020 17:01:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, kevin.tian@intel.com, shaopeng.he@intel.com,
        yi.l.liu@intel.com, xin.zeng@intel.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH v4 02/10] vfio/pci: macros to generate module_init
 and module_exit for vendor modules
Message-ID: <20200604170106.561db9ad.cohuck@redhat.com>
In-Reply-To: <20200518024510.14115-1-yan.y.zhao@intel.com>
References: <20200518024202.13996-1-yan.y.zhao@intel.com>
        <20200518024510.14115-1-yan.y.zhao@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 22:45:10 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> vendor modules call macro module_vfio_pci_register_vendor_handler to
> generate module_init and module_exit.
> It is necessary to ensure that vendor modules always call
> vfio_pci_register_vendor_driver() on driver loading and
> vfio_pci_unregister_vendor_driver on driver unloading,
> because
> (1) at compiling time, there's only a dependency of vendor modules on
> vfio_pci.
> (2) at runtime,
> - vendor modules add refs of vfio_pci on a successful calling of
>   vfio_pci_register_vendor_driver() and deref of vfio_pci on a
>   successful calling of vfio_pci_unregister_vendor_driver().
> - vfio_pci only adds refs of vendor module on a successful probe of vendor
>   driver.
>   vfio_pci derefs vendor module when unbinding from a device.
> 
> So, after vfio_pci is unbound from a device, the vendor module to that
> device is free to get unloaded. However, if that vendor module does not
> call vfio_pci_unregister_vendor_driver() in its module_exit, vfio_pci may
> hold a stale pointer to vendor module.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/linux/vfio.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 3e53deb012b6..f3746608c2d9 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -223,4 +223,31 @@ struct vfio_pci_vendor_driver_ops {
>  };
>  int __vfio_pci_register_vendor_driver(struct vfio_pci_vendor_driver_ops *ops);
>  void vfio_pci_unregister_vendor_driver(struct vfio_device_ops *device_ops);
> +
> +#define vfio_pci_register_vendor_driver(__name, __probe, __remove,	\
> +					__device_ops)			\
> +static struct vfio_pci_vendor_driver_ops  __ops ## _node = {		\
> +	.owner		= THIS_MODULE,					\
> +	.name		= __name,					\
> +	.probe		= __probe,					\
> +	.remove		= __remove,					\
> +	.device_ops	= __device_ops,					\
> +};									\
> +__vfio_pci_register_vendor_driver(&__ops ## _node)
> +
> +#define module_vfio_pci_register_vendor_handler(name, probe, remove,	\
> +						device_ops)		\
> +static int __init device_ops ## _module_init(void)			\
> +{									\
> +	vfio_pci_register_vendor_driver(name, probe, remove,		\
> +					device_ops);			\

What if this function fails (e.g. with -ENOMEM)?

> +	return 0;							\
> +};									\
> +static void __exit device_ops ## _module_exit(void)			\
> +{									\
> +	vfio_pci_unregister_vendor_driver(device_ops);			\
> +};									\
> +module_init(device_ops ## _module_init);				\
> +module_exit(device_ops ## _module_exit)
> +
>  #endif /* VFIO_H */

