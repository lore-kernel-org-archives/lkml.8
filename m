Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF0BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB322078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCPEChtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgDAOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:15:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732826AbgDAOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585750515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1f7HGkvLeJwtZr/nhHBwLAndJ8z678Q44dIY0gzIYM=;
        b=fCPEChtC8vZnXFt2Ps1pK7eB+Bt9HnkUDJYikk+7+l+xLgu0PLnNUzpcSEtNQiMWmL1BJX
        OvsCIdf64LOeRxDHlFr7d8WXMqppzoTHfJrHY8Zd7fYs0uX1yRo2XyumH0CF6wb9gquAMR
        0G+zaghyNfqmxX1BDTQPnUT7bE3kwSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-tL46n0ADOsSqsDfON6DnNw-1; Wed, 01 Apr 2020 10:13:22 -0400
X-MC-Unique: tL46n0ADOsSqsDfON6DnNw-1
Received: by mail-wm1-f71.google.com with SMTP id l13so21762wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i1f7HGkvLeJwtZr/nhHBwLAndJ8z678Q44dIY0gzIYM=;
        b=G4yfkjN5wZx/ui9Qg64/cCL3SgXjQ0t9f78cukn3dupA3efGEbsQD2n7D3nJ8xGsXl
         19hI9TfNv9LjOoLnDVqYVwjSu5v8ffv9cn0eYXXs9mlCGnsZ559xRW7OcCrwwn0uD04m
         7JjSBtYYBx95KEpuspB9dhz7cp18BbMBXzUt4EcET1dH1NIWGezoEMDm95ZSn31BgtZP
         CKmfUpBwAi15+71RqIYFAOnFsozNDG336OQIF/AmR8njmEBVu2MwbNfXcqPQuPUtjD2L
         IfqCzGxnimJ725/jiUYKmTAPQshbVefpzuELDd8gNSn/2KkU7PhLI4dYIxboJkL5bAe8
         DljA==
X-Gm-Message-State: AGi0PuboIXQfKJlsGfrC7gFHyWrS6arm16BS6QT4fZugmO0G1RyDf9wI
        dx5HygNMTYCO5QdojBF7RYzjopDU8Eqm+gXUTFLvsD8GyuQ/fChfcqUoqRnven0wdvMaB9WkN5S
        obNAPpxlxuRtUNsICQ4qDwxdk
X-Received: by 2002:a1c:9658:: with SMTP id y85mr4492423wmd.63.1585750399944;
        Wed, 01 Apr 2020 07:13:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJs5EbWmst7DVw5ihLG2s2hFAxQ8npMW8uVZXgFKCJBe3IpzUUywXMdNRtaqWDIUaHL2OcOmg==
X-Received: by 2002:a1c:9658:: with SMTP id y85mr4492386wmd.63.1585750399582;
        Wed, 01 Apr 2020 07:13:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id c85sm2806878wmd.48.2020.04.01.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:13:18 -0700 (PDT)
Date:   Wed, 1 Apr 2020 10:13:14 -0400
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
Message-ID: <20200401100954-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <20200401092004-mutt-send-email-mst@kernel.org>
 <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:08:59PM +0800, Jason Wang wrote:
> 
> On 2020/4/1 下午9:22, Michael S. Tsirkin wrote:
> > On Thu, Mar 26, 2020 at 10:01:17PM +0800, Jason Wang wrote:
> > > Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
> > > not necessarily for VM since it's a generic userspace and kernel
> > > communication protocol. Such dependency may prevent archs without
> > > virtualization support from using vhost.
> > > 
> > > To solve this, a dedicated vhost menu is created under drivers so
> > > CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> > > 
> > > While at it, also squash Kconfig.vringh into vhost Kconfig file. This
> > > avoids the trick of conditional inclusion from VOP or CAIF. Then it
> > > will be easier to introduce new vringh users and common dependency for
> > > both vringh and vhost.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Is this just so we can drop the dependency on CONFIG_VIRTUALIZATION?
> > If yes what happens if we drop this patch?
> 
> 
> The problem is that then VHOST_RING must depend on CONFIG_VIRTUALIZATION
> (which enable VHOST_IOTLB) to work.
> 
> But it looks to me CAIF and VOP doesn't requires CONFIG_VIRTUALIZATION.

How about stubs for IOTLB so VHOST_RING does not depend on VHOST_IOTLB?
I'm pretty sure neither user of vringh can actually use IOTLB, it's a
software only thing.

> 
> > Given the impact it had I'd like to defer it till next release if
> > possible.
> > 
> > 
> > > ---
> > >   arch/arm/kvm/Kconfig         |  2 --
> > >   arch/arm64/kvm/Kconfig       |  2 --
> > >   arch/mips/kvm/Kconfig        |  2 --
> > >   arch/powerpc/kvm/Kconfig     |  2 --
> > >   arch/s390/kvm/Kconfig        |  4 ----
> > >   arch/x86/kvm/Kconfig         |  4 ----
> > >   drivers/Kconfig              |  2 ++
> > >   drivers/misc/mic/Kconfig     |  4 ----
> > >   drivers/net/caif/Kconfig     |  4 ----
> > >   drivers/vhost/Kconfig        | 23 ++++++++++++++---------
> > >   drivers/vhost/Kconfig.vringh |  6 ------
> > >   11 files changed, 16 insertions(+), 39 deletions(-)
> > >   delete mode 100644 drivers/vhost/Kconfig.vringh
> > > 
> > > diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> > > index f591026347a5..be97393761bf 100644
> > > --- a/arch/arm/kvm/Kconfig
> > > +++ b/arch/arm/kvm/Kconfig
> > > @@ -54,6 +54,4 @@ config KVM_ARM_HOST
> > >   	---help---
> > >   	  Provides host support for ARM processors.
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > > index a475c68cbfec..449386d76441 100644
> > > --- a/arch/arm64/kvm/Kconfig
> > > +++ b/arch/arm64/kvm/Kconfig
> > > @@ -64,6 +64,4 @@ config KVM_ARM_PMU
> > >   config KVM_INDIRECT_VECTORS
> > >          def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> > > index eac25aef21e0..b91d145aa2d5 100644
> > > --- a/arch/mips/kvm/Kconfig
> > > +++ b/arch/mips/kvm/Kconfig
> > > @@ -72,6 +72,4 @@ config KVM_MIPS_DEBUG_COP0_COUNTERS
> > >   	  If unsure, say N.
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> > > index 711fca9bc6f0..12885eda324e 100644
> > > --- a/arch/powerpc/kvm/Kconfig
> > > +++ b/arch/powerpc/kvm/Kconfig
> > > @@ -204,6 +204,4 @@ config KVM_XIVE
> > >   	default y
> > >   	depends on KVM_XICS && PPC_XIVE_NATIVE && KVM_BOOK3S_HV_POSSIBLE
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> > > index d3db3d7ed077..def3b60f1fe8 100644
> > > --- a/arch/s390/kvm/Kconfig
> > > +++ b/arch/s390/kvm/Kconfig
> > > @@ -55,8 +55,4 @@ config KVM_S390_UCONTROL
> > >   	  If unsure, say N.
> > > -# OK, it's a little counter-intuitive to do this, but it puts it neatly under
> > > -# the virtualization menu.
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > > index 991019d5eee1..0dfe70e17af9 100644
> > > --- a/arch/x86/kvm/Kconfig
> > > +++ b/arch/x86/kvm/Kconfig
> > > @@ -94,8 +94,4 @@ config KVM_MMU_AUDIT
> > >   	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
> > >   	 auditing of KVM MMU events at runtime.
> > > -# OK, it's a little counter-intuitive to do this, but it puts it neatly under
> > > -# the virtualization menu.
> > > -source "drivers/vhost/Kconfig"
> > > -
> > >   endif # VIRTUALIZATION
> > > diff --git a/drivers/Kconfig b/drivers/Kconfig
> > > index 8befa53f43be..7a6d8b2b68b4 100644
> > > --- a/drivers/Kconfig
> > > +++ b/drivers/Kconfig
> > > @@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
> > >   source "drivers/virtio/Kconfig"
> > > +source "drivers/vhost/Kconfig"
> > > +
> > >   source "drivers/hv/Kconfig"
> > >   source "drivers/xen/Kconfig"
> > > diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> > > index b6841ba6d922..8f201d019f5a 100644
> > > --- a/drivers/misc/mic/Kconfig
> > > +++ b/drivers/misc/mic/Kconfig
> > > @@ -133,8 +133,4 @@ config VOP
> > >   	  OS and tools for MIC to use with this driver are available from
> > >   	  <http://software.intel.com/en-us/mic-developer>.
> > > -if VOP
> > > -source "drivers/vhost/Kconfig.vringh"
> > > -endif
> > > -
> > >   endmenu
> > > diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
> > > index e74e2bb61236..9db0570c5beb 100644
> > > --- a/drivers/net/caif/Kconfig
> > > +++ b/drivers/net/caif/Kconfig
> > > @@ -58,8 +58,4 @@ config CAIF_VIRTIO
> > >   	---help---
> > >   	  The CAIF driver for CAIF over Virtio.
> > > -if CAIF_VIRTIO
> > > -source "drivers/vhost/Kconfig.vringh"
> > > -endif
> > > -
> > >   endif # CAIF_DRIVERS
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index 3d03ccbd1adc..4aef10a54cd1 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -1,8 +1,20 @@
> > >   # SPDX-License-Identifier: GPL-2.0-only
> > > +config VHOST_RING
> > > +	tristate
> > > +	help
> > > +	  This option is selected by any driver which needs to access
> > > +	  the host side of a virtio ring.
> > > +
> > > +menuconfig VHOST
> > > +	tristate "Host kernel accelerator for virtio (VHOST)"
> > > +	help
> > > +	  This option is selected by any driver which needs to access
> > > +	  the core of vhost.
> > > +if VHOST
> > > +
> > The description here is wrong, isn't it?
> > VHOST and VHOST_RING are no longer selected, right?
> 
> 
> For VHOST not currently.

Can we just bring it back and select it?

> For VHOST_RING, it was selected by CAIF, VOP and VDPASIM.
> 
> Thanks
> 
> 
> > 
> > 
> > >   config VHOST_NET
> > >   	tristate "Host kernel accelerator for virtio net"
> > >   	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> > > -	select VHOST
> > >   	---help---
> > >   	  This kernel module can be loaded in host kernel to accelerate
> > >   	  guest networking with virtio_net. Not to be confused with virtio_net
> > > @@ -14,7 +26,6 @@ config VHOST_NET
> > >   config VHOST_SCSI
> > >   	tristate "VHOST_SCSI TCM fabric driver"
> > >   	depends on TARGET_CORE && EVENTFD
> > > -	select VHOST
> > >   	default n
> > >   	---help---
> > >   	Say M here to enable the vhost_scsi TCM fabric module
> > > @@ -24,7 +35,6 @@ config VHOST_VSOCK
> > >   	tristate "vhost virtio-vsock driver"
> > >   	depends on VSOCKETS && EVENTFD
> > >   	select VIRTIO_VSOCKETS_COMMON
> > > -	select VHOST
> > >   	default n
> > >   	---help---
> > >   	This kernel module can be loaded in the host kernel to provide AF_VSOCK
> > > @@ -34,12 +44,6 @@ config VHOST_VSOCK
> > >   	To compile this driver as a module, choose M here: the module will be called
> > >   	vhost_vsock.
> > > -config VHOST
> > > -	tristate
> > > -	---help---
> > > -	  This option is selected by any driver which needs to access
> > > -	  the core of vhost.
> > > -
> > >   config VHOST_CROSS_ENDIAN_LEGACY
> > >   	bool "Cross-endian support for vhost"
> > >   	default n
> > > @@ -54,3 +58,4 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >   	  adds some overhead, it is disabled by default.
> > >   	  If unsure, say "N".
> > > +endif
> > > diff --git a/drivers/vhost/Kconfig.vringh b/drivers/vhost/Kconfig.vringh
> > > deleted file mode 100644
> > > index c1fe36a9b8d4..000000000000
> > > --- a/drivers/vhost/Kconfig.vringh
> > > +++ /dev/null
> > > @@ -1,6 +0,0 @@
> > > -# SPDX-License-Identifier: GPL-2.0-only
> > > -config VHOST_RING
> > > -	tristate
> > > -	---help---
> > > -	  This option is selected by any driver which needs to access
> > > -	  the host side of a virtio ring.
> > > -- 
> > > 2.20.1

