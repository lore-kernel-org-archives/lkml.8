Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D21C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091282071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxJjXejh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbgDAQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:08:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbgDAQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585757290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOVDtyF1AE9D3PmM9Cg9VpMJ2l3FcGqxQ8lNxLr5dIs=;
        b=SxJjXejhlEBLDSX9/KQ3PoWI4jiY7Qbtic8xN92A6yQDW/5QL9EbKZ5Gl2tYKqi8n0wjyV
        vqeTU65B+cIV9dchRlxJ7gQBOqFHNAtRX6H2mWarhu5AnDDdsLaSbtaatG524sgXrD/8KR
        UaNftzzwDuVW5BvgZRyQeqqw6aZsvRc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-xz0ZNqUcNlijAMosrMh-lA-1; Wed, 01 Apr 2020 12:08:08 -0400
X-MC-Unique: xz0ZNqUcNlijAMosrMh-lA-1
Received: by mail-wr1-f72.google.com with SMTP id t25so50496wrb.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hOVDtyF1AE9D3PmM9Cg9VpMJ2l3FcGqxQ8lNxLr5dIs=;
        b=PCI0neRAcW+69kHgj8tASIujxUiK31zVdsxWci+co3ljdZanKT/4fKh44oDkHMRTsz
         ZXtmNZUB6lMfCwVttuMPmqooc+JawYsZCUUHrO1Npqn13/MYhaK3MYZTiAV237+oIBfi
         5T8ke0AzNwK8et2BPhjML+6KqMg0juMVrW1Mpk3lTXEmnvikQn5YIudBPOw92zdyD0gL
         QzKBlLwbSsM3/2tmnLolXhzWgk309DTgqTfWTY0Lbx7uPmuux0QtgTsGIYjUI2vYpiES
         QhRcHpbGgITj30MkELImwkRBKUNmL95VXqG06etM0vTRy27r9knT0hKmh5xKNZSaiyad
         3DjQ==
X-Gm-Message-State: ANhLgQ2ql9HWfd3AwBh2HiT909OnF069wSuxSOcRsnfWotfIH18iiNEy
        rGa0gprMhG6FUst0NuWP5nuaKyOQu8TDL5/qfDMaN9ABhqRLLrxrPIk+GJduis+3F4VzFFfWzuo
        8OfGYV7veL68yAU3sL0Fg9Ovl
X-Received: by 2002:a5d:5704:: with SMTP id a4mr27652991wrv.95.1585757287405;
        Wed, 01 Apr 2020 09:08:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu/0IpuTVbC9txesB4+4J8VJA6MAuurHQYjHbAmRAHqQl2A8Juskzx4t/Kit00vNhGBgfiZ4Q==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr27652949wrv.95.1585757287093;
        Wed, 01 Apr 2020 09:08:07 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n6sm3579451wrp.30.2020.04.01.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:08:06 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:08:01 -0400
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
Message-ID: <20200401120643-mutt-send-email-mst@kernel.org>
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
>  
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

OK so I squashed this into the original buggy patch.
Could you please play with vhost branch of my tree on various
arches? If it looks ok to you let me know I'll push
this to next.


-- 
MST

