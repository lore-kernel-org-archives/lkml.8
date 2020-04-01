Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E50C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB842073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHN6a7zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgDANXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:23:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732684AbgDANXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585747399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hi0o+VWe9/l5oID1pIBS8BAdOnRzvBXeS2Ff7vUWBLM=;
        b=NHN6a7zg19oCVhQZQLLGpk2c4U8sPvLA43gGm0MK270RR3ufCkFAEsrcWIFVQM5e+VPVzu
        6nfAHOkxrxeLxiqKhAUWi/KHRvzVYr0AhtBqcQSSd+5nsp9Rt8HC9/1e13Xc8Zi5pgTsRl
        W/nYJsSrgusm1HMsprS+WudBDyWLgQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-64obzA8_MlG_mS1aE_1wmg-1; Wed, 01 Apr 2020 09:23:05 -0400
X-MC-Unique: 64obzA8_MlG_mS1aE_1wmg-1
Received: by mail-wr1-f72.google.com with SMTP id k11so1580573wrm.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hi0o+VWe9/l5oID1pIBS8BAdOnRzvBXeS2Ff7vUWBLM=;
        b=DEZHY0q+4WAS7ACGvVBHJyWqe7LIVGLAsc4oVp/rBQjyoYisIezh0BV0qWzF1W+xlz
         mqteY9JOlPHI7j31sALl5pMWJFQvh78SWs0a6KV45WjeNAhuWKoRsyUiPeKiw91hZ2y+
         8HWuAdngk6RyFnSzSqxHpA1dqIchWvR/rKhUoMBpV33aNxDJ7iJF2bwl3y2WAYam8El5
         SKFTlgytKAT5DpZGb1ihIOq4OmsLG9z9H0lDB2N/yDCRcjkjUqpQRVOBFw1zcFRYEzwi
         r1VdKz6Kz53YAYsrcsq33M2HAt9bQeeiJc2l54jXnvJIjpVcMAGmyQrV5e0J1PLEMPAg
         q6Gg==
X-Gm-Message-State: AGi0PubCN9rqZHfdBpq1qylHyu7r/MB5xPj/N7gw+e9+4+yRzoOS5/53
        3NaFRKqxoako6NAnrt2aX0A5bG1yDr+PUbjouRW7MaVV3R5pUVHNsvdf+GiF0B8NvVq2bmSiqhP
        FBmHyYy8AMtQxR5yhljX1mE1k
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr4325108wmm.106.1585747382388;
        Wed, 01 Apr 2020 06:23:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhB75sCXbwWEjkpMwVSQLEx4YoDlWEazTbH9fpWHve3UfYWpZM6zzG2sMK7lf6Dc3p4IaHJg==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr4325075wmm.106.1585747382089;
        Wed, 01 Apr 2020 06:23:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id c85sm2625867wmd.48.2020.04.01.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:22:58 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:22:52 -0400
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
Message-ID: <20200401092004-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326140125.19794-2-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:01:17PM +0800, Jason Wang wrote:
> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
> not necessarily for VM since it's a generic userspace and kernel
> communication protocol. Such dependency may prevent archs without
> virtualization support from using vhost.
> 
> To solve this, a dedicated vhost menu is created under drivers so
> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> 
> While at it, also squash Kconfig.vringh into vhost Kconfig file. This
> avoids the trick of conditional inclusion from VOP or CAIF. Then it
> will be easier to introduce new vringh users and common dependency for
> both vringh and vhost.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Is this just so we can drop the dependency on CONFIG_VIRTUALIZATION?
If yes what happens if we drop this patch?
Given the impact it had I'd like to defer it till next release if
possible.


> ---
>  arch/arm/kvm/Kconfig         |  2 --
>  arch/arm64/kvm/Kconfig       |  2 --
>  arch/mips/kvm/Kconfig        |  2 --
>  arch/powerpc/kvm/Kconfig     |  2 --
>  arch/s390/kvm/Kconfig        |  4 ----
>  arch/x86/kvm/Kconfig         |  4 ----
>  drivers/Kconfig              |  2 ++
>  drivers/misc/mic/Kconfig     |  4 ----
>  drivers/net/caif/Kconfig     |  4 ----
>  drivers/vhost/Kconfig        | 23 ++++++++++++++---------
>  drivers/vhost/Kconfig.vringh |  6 ------
>  11 files changed, 16 insertions(+), 39 deletions(-)
>  delete mode 100644 drivers/vhost/Kconfig.vringh
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index f591026347a5..be97393761bf 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -54,6 +54,4 @@ config KVM_ARM_HOST
>  	---help---
>  	  Provides host support for ARM processors.
>  
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index a475c68cbfec..449386d76441 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -64,6 +64,4 @@ config KVM_ARM_PMU
>  config KVM_INDIRECT_VECTORS
>         def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
>  
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> index eac25aef21e0..b91d145aa2d5 100644
> --- a/arch/mips/kvm/Kconfig
> +++ b/arch/mips/kvm/Kconfig
> @@ -72,6 +72,4 @@ config KVM_MIPS_DEBUG_COP0_COUNTERS
>  
>  	  If unsure, say N.
>  
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 711fca9bc6f0..12885eda324e 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -204,6 +204,4 @@ config KVM_XIVE
>  	default y
>  	depends on KVM_XICS && PPC_XIVE_NATIVE && KVM_BOOK3S_HV_POSSIBLE
>  
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index d3db3d7ed077..def3b60f1fe8 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -55,8 +55,4 @@ config KVM_S390_UCONTROL
>  
>  	  If unsure, say N.
>  
> -# OK, it's a little counter-intuitive to do this, but it puts it neatly under
> -# the virtualization menu.
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 991019d5eee1..0dfe70e17af9 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -94,8 +94,4 @@ config KVM_MMU_AUDIT
>  	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
>  	 auditing of KVM MMU events at runtime.
>  
> -# OK, it's a little counter-intuitive to do this, but it puts it neatly under
> -# the virtualization menu.
> -source "drivers/vhost/Kconfig"
> -
>  endif # VIRTUALIZATION
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 8befa53f43be..7a6d8b2b68b4 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
>  
>  source "drivers/virtio/Kconfig"
>  
> +source "drivers/vhost/Kconfig"
> +
>  source "drivers/hv/Kconfig"
>  
>  source "drivers/xen/Kconfig"
> diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> index b6841ba6d922..8f201d019f5a 100644
> --- a/drivers/misc/mic/Kconfig
> +++ b/drivers/misc/mic/Kconfig
> @@ -133,8 +133,4 @@ config VOP
>  	  OS and tools for MIC to use with this driver are available from
>  	  <http://software.intel.com/en-us/mic-developer>.
>  
> -if VOP
> -source "drivers/vhost/Kconfig.vringh"
> -endif
> -
>  endmenu
> diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
> index e74e2bb61236..9db0570c5beb 100644
> --- a/drivers/net/caif/Kconfig
> +++ b/drivers/net/caif/Kconfig
> @@ -58,8 +58,4 @@ config CAIF_VIRTIO
>  	---help---
>  	  The CAIF driver for CAIF over Virtio.
>  
> -if CAIF_VIRTIO
> -source "drivers/vhost/Kconfig.vringh"
> -endif
> -
>  endif # CAIF_DRIVERS
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 3d03ccbd1adc..4aef10a54cd1 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,8 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config VHOST_RING
> +	tristate
> +	help
> +	  This option is selected by any driver which needs to access
> +	  the host side of a virtio ring.
> +
> +menuconfig VHOST
> +	tristate "Host kernel accelerator for virtio (VHOST)"
> +	help
> +	  This option is selected by any driver which needs to access
> +	  the core of vhost.
> +if VHOST
> +

The description here is wrong, isn't it?
VHOST and VHOST_RING are no longer selected, right?


>  config VHOST_NET
>  	tristate "Host kernel accelerator for virtio net"
>  	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> -	select VHOST
>  	---help---
>  	  This kernel module can be loaded in host kernel to accelerate
>  	  guest networking with virtio_net. Not to be confused with virtio_net
> @@ -14,7 +26,6 @@ config VHOST_NET
>  config VHOST_SCSI
>  	tristate "VHOST_SCSI TCM fabric driver"
>  	depends on TARGET_CORE && EVENTFD
> -	select VHOST
>  	default n
>  	---help---
>  	Say M here to enable the vhost_scsi TCM fabric module
> @@ -24,7 +35,6 @@ config VHOST_VSOCK
>  	tristate "vhost virtio-vsock driver"
>  	depends on VSOCKETS && EVENTFD
>  	select VIRTIO_VSOCKETS_COMMON
> -	select VHOST
>  	default n
>  	---help---
>  	This kernel module can be loaded in the host kernel to provide AF_VSOCK
> @@ -34,12 +44,6 @@ config VHOST_VSOCK
>  	To compile this driver as a module, choose M here: the module will be called
>  	vhost_vsock.
>  
> -config VHOST
> -	tristate
> -	---help---
> -	  This option is selected by any driver which needs to access
> -	  the core of vhost.
> -
>  config VHOST_CROSS_ENDIAN_LEGACY
>  	bool "Cross-endian support for vhost"
>  	default n
> @@ -54,3 +58,4 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  adds some overhead, it is disabled by default.
>  
>  	  If unsure, say "N".
> +endif
> diff --git a/drivers/vhost/Kconfig.vringh b/drivers/vhost/Kconfig.vringh
> deleted file mode 100644
> index c1fe36a9b8d4..000000000000
> --- a/drivers/vhost/Kconfig.vringh
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -config VHOST_RING
> -	tristate
> -	---help---
> -	  This option is selected by any driver which needs to access
> -	  the host side of a virtio ring.
> -- 
> 2.20.1

