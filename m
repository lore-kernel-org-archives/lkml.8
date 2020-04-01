Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD595C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8DE2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTdWSSIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbgDAQFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:05:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730720AbgDAQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585757146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUy3j+yrovQDgWmfFKd1F++ymnkOiTPGFKNkP/D2nvI=;
        b=NTdWSSIo9T8pno/4GfJEo7ZztV8xpyulu+WLr7mR3JmrDyl3/z80n5IJ0oWFJaLffKb18X
        obGFgSH7N9UkGE8rQq2JimC9CbmA1+p7fZdI/AyW9oXei0mxjeJj+RTf0dEpEyHGMCIS1K
        ycve0ODtRN4UGgUUdK1F1/mrIV54mM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-nRbZYoezP5SFR36ZB98lwQ-1; Wed, 01 Apr 2020 12:05:45 -0400
X-MC-Unique: nRbZYoezP5SFR36ZB98lwQ-1
Received: by mail-wm1-f69.google.com with SMTP id v8so152253wml.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUy3j+yrovQDgWmfFKd1F++ymnkOiTPGFKNkP/D2nvI=;
        b=M6yZEDSykNxJMC6gHnYY9v+pcWPn3xWeJBzp96GvQ+sNd3f89aGOR7E/uhj1LWIn6M
         oPkk07PFaQTwG4o8s9lehsxJkt5646UD/MJgIcSHdJZc07J7NiI8iL/okaU/SpzcGdeq
         NaWFQtgEAqoXPUBjnb6s2IXPHewdUdZeRaDL5nmW2x9zObV22kaCxMp3o9FPKRWPFzo6
         v/8wSq8FpeKIKonHakJNFi/68XNBOtKAfcXHw/qQNptYUOzR3gQhKi8UF8NExw089uKD
         XJmZNTugENlY29I0dMr/Cm6Il7evPimO5HsoKpClDr4eqE6Pqg+2qFedTnRTcEYUB0Z+
         sO/w==
X-Gm-Message-State: ANhLgQ1mBM2SLLqPI2kH9MZ+AnopbRb4Mg87y64rNkRanwoEU0Oo64SC
        EhVSyuwzOn9hrzu8FUwH743ATXEY97O9D/ZXYqFOCWHlRs8l7fb0r4mnHeYfHn/KYNV50tntXQM
        9UyNuq0TQMsi+LoU3SjmITlQm
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr28165162wrw.41.1585757144320;
        Wed, 01 Apr 2020 09:05:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuk07VIBkno7jCUb5wxynsgoXQ+nPbZKJ9NnXIKxpKfUHmNte/+b09H0WL7N2rcv9cUMY4tCg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr28165122wrw.41.1585757144100;
        Wed, 01 Apr 2020 09:05:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f13sm3329290wrx.56.2020.04.01.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:05:43 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:05:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        jgg@mellanox.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com,
        rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com,
        jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com,
        mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com,
        vmireyno@marvell.com, zhangweining@ruijie.com.cn
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Message-ID: <20200401120352-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <20200401092004-mutt-send-email-mst@kernel.org>
 <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
 <20200401100954-mutt-send-email-mst@kernel.org>
 <3dd3b7e7-e3d9-dba4-00fc-868081f95ab7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd3b7e7-e3d9-dba4-00fc-868081f95ab7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:29:32PM +0800, Jason Wang wrote:
> >From 9b3a5d23b8bf6b0a11e65e688335d782f8e6aa5c Mon Sep 17 00:00:00 2001
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 1 Apr 2020 22:17:27 +0800
> Subject: [PATCH] vhost: let CONFIG_VHOST to be selected by drivers
> 
> The defconfig on some archs enable vhost_net or vhost_vsock by
> default. So instead of adding CONFIG_VHOST=m to all of those files,
> simply letting CONFIG_VHOST to be selected by all of the vhost
> drivers. This fixes the build on the archs with CONFIG_VHOST_NET=m in
> their defconfig.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 2523a1d4290a..362b832f5338 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -11,19 +11,23 @@ config VHOST_RING
>  	  This option is selected by any driver which needs to access
>  	  the host side of a virtio ring.
>  
> -menuconfig VHOST
> -	tristate "Host kernel accelerator for virtio (VHOST)"
> -	depends on EVENTFD
> +config VHOST
> +	tristate
>  	select VHOST_IOTLB
>  	help
>  	  This option is selected by any driver which needs to access
>  	  the core of vhost.


OK so don't we need the dependency on EVENTFD though?
I recall there was a bug this was supposed to fix ...


> -if VHOST
> +menuconfig VHOST_MENU
> +	bool "VHOST drivers"
> +	default y
> +
> +if VHOST_MENU
>  
>  config VHOST_NET
>  	tristate "Host kernel accelerator for virtio net"
>  	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> +	select VHOST
>  	---help---
>  	  This kernel module can be loaded in host kernel to accelerate
>  	  guest networking with virtio_net. Not to be confused with virtio_net
> @@ -35,6 +39,7 @@ config VHOST_NET
>  config VHOST_SCSI
>  	tristate "VHOST_SCSI TCM fabric driver"
>  	depends on TARGET_CORE && EVENTFD
> +	select VHOST
>  	default n
>  	---help---
>  	Say M here to enable the vhost_scsi TCM fabric module
> @@ -43,6 +48,7 @@ config VHOST_SCSI
>  config VHOST_VSOCK
>  	tristate "vhost virtio-vsock driver"
>  	depends on VSOCKETS && EVENTFD
> +	select VHOST
>  	select VIRTIO_VSOCKETS_COMMON
>  	default n
>  	---help---
> @@ -56,6 +62,7 @@ config VHOST_VSOCK
>  config VHOST_VDPA
>  	tristate "Vhost driver for vDPA-based backend"
>  	depends on EVENTFD
> +	select VHOST
>  	select VDPA
>  	help
>  	  This kernel module can be loaded in host kernel to accelerate
> -- 
> 2.20.1
> 

