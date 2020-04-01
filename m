Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DAFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA620BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBRcBUpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbgDAP52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:57:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50591 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733164AbgDAP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585756645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJvti0HQwxkGVr50UmLlXHEkmoOLavfcErw++olR+Jo=;
        b=CBRcBUptPGzJgM8ONDMF1CcAKgsQK+zb0NzJn8gyfabDOELw6+tghnJfJEIZs2QWHgnj1g
        wlNo/bmWkdsq5MRXXLJqhV2x4ltdvYiQWEN+w+czhzQxPtD54/f5r81e9n8VEG7coPDis9
        RzT2ytmQebccjm9q9tpQntOsiyaYQbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--tdhvSYpO6yjqwCsmGO7SQ-1; Wed, 01 Apr 2020 11:57:20 -0400
X-MC-Unique: -tdhvSYpO6yjqwCsmGO7SQ-1
Received: by mail-wr1-f72.google.com with SMTP id t25so35927wrb.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MJvti0HQwxkGVr50UmLlXHEkmoOLavfcErw++olR+Jo=;
        b=dPU/fSyGPNR2mym37gRMr09tM7iAl1N2UqdlD3IwjOLZDDoPxAxyoe82qzqcwHoFvx
         WzAZdv/wnTRwJlMVCGf3V8levR4yyrqrnpAevpgq5sBLKjVpO/2XqNX6rgUmyCBI88ky
         dsZCkUpirUbaRgiJi2qB5sQ5bnRKbEp0mlYryIHTeLrseGIvJUHc4vHTHPSKAP8SoXXZ
         76qR+YbbLtgJKXTET937LWHqzjrCWarjNeS2tkyVbHpgnowYednoTuk0pGyl4nbp0mN4
         JA4Tu9PpF1/7VTKWBwaPU+TD2JGSlyYwPEsVO3vRkBYMMV0xBSTcbXd47dVw6Dy0lXUK
         rU5w==
X-Gm-Message-State: AGi0PuYGMNTpwWJF2ORdE6cxUAYWaNl7K1FtwKEgVh7hLffX5N6WqjPM
        rZ0GCYFQiXr4zPEyUK49yRj5bE6H57+Z/8OZ6OfdvXCI1H0tvfoTW93K2pEQI9cDfNakkU5zKi+
        PsZEPOkN9AfXFhZuyU2/VS6aM
X-Received: by 2002:a1c:1942:: with SMTP id 63mr5209043wmz.133.1585756639449;
        Wed, 01 Apr 2020 08:57:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA2aA36/p1yS+4iSBINIMZYbsrQcGfbJmIXDjaLpAeYKGxwb5JBIS+CYjNIECD0H1M4kXpUQ==
X-Received: by 2002:a1c:1942:: with SMTP id 63mr5209012wmz.133.1585756639201;
        Wed, 01 Apr 2020 08:57:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id a8sm2954348wmb.39.2020.04.01.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:57:18 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:57:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Message-ID: <20200401115650-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
 <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
 <c423c5b1-7817-7417-d7af-e07bef6368e7@redhat.com>
 <20200401102631-mutt-send-email-mst@kernel.org>
 <5e409bb4-2b06-5193-20c3-a9ddaafacf5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e409bb4-2b06-5193-20c3-a9ddaafacf5a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:50:50PM +0800, Jason Wang wrote:
> 
> On 2020/4/1 下午10:27, Michael S. Tsirkin wrote:
> > On Wed, Apr 01, 2020 at 10:13:29PM +0800, Jason Wang wrote:
> > > On 2020/4/1 下午9:02, Christian Borntraeger wrote:
> > > > On 01.04.20 14:56, Christian Borntraeger wrote:
> > > > > On 01.04.20 14:50, Jason Wang wrote:
> > > > > > On 2020/4/1 下午7:21, Christian Borntraeger wrote:
> > > > > > > On 26.03.20 15:01, Jason Wang wrote:
> > > > > > > > Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
> > > > > > > > not necessarily for VM since it's a generic userspace and kernel
> > > > > > > > communication protocol. Such dependency may prevent archs without
> > > > > > > > virtualization support from using vhost.
> > > > > > > > 
> > > > > > > > To solve this, a dedicated vhost menu is created under drivers so
> > > > > > > > CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> > > > > > > FWIW, this now results in vhost not being build with defconfig kernels (in todays
> > > > > > > linux-next).
> > > > > > > 
> > > > > > Hi Christian:
> > > > > > 
> > > > > > Did you meet it even with this commit https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a4be40cbcedba9b5b714f3c95182e8a45176e42d?
> > > > > I simply used linux-next. The defconfig does NOT contain CONFIG_VHOST and therefore CONFIG_VHOST_NET and friends
> > > > > can not be selected.
> > > > > 
> > > > > $ git checkout next-20200401
> > > > > $ make defconfig
> > > > >     HOSTCC  scripts/basic/fixdep
> > > > >     HOSTCC  scripts/kconfig/conf.o
> > > > >     HOSTCC  scripts/kconfig/confdata.o
> > > > >     HOSTCC  scripts/kconfig/expr.o
> > > > >     LEX     scripts/kconfig/lexer.lex.c
> > > > >     YACC    scripts/kconfig/parser.tab.[ch]
> > > > >     HOSTCC  scripts/kconfig/lexer.lex.o
> > > > >     HOSTCC  scripts/kconfig/parser.tab.o
> > > > >     HOSTCC  scripts/kconfig/preprocess.o
> > > > >     HOSTCC  scripts/kconfig/symbol.o
> > > > >     HOSTCC  scripts/kconfig/util.o
> > > > >     HOSTLD  scripts/kconfig/conf
> > > > > *** Default configuration is based on 'x86_64_defconfig'
> > > > > #
> > > > > # configuration written to .config
> > > > > #
> > > > > 
> > > > > $ grep VHOST .config
> > > > > # CONFIG_VHOST is not set
> > > > > 
> > > > > > If yes, what's your build config looks like?
> > > > > > 
> > > > > > Thanks
> > > > This was x86. Not sure if that did work before.
> > > > On s390 this is definitely a regression as the defconfig files
> > > > for s390 do select VHOST_NET
> > > > 
> > > > grep VHOST arch/s390/configs/*
> > > > arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=m
> > > > arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=m
> > > > arch/s390/configs/defconfig:CONFIG_VHOST_NET=m
> > > > arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=m
> > > > 
> > > > and this worked with 5.6, but does not work with next. Just adding
> > > > CONFIG_VHOST=m to the defconfig solves the issue, something like
> > > 
> > > Right, I think we probably need
> > > 
> > > 1) add CONFIG_VHOST=m to all defconfigs that enables
> > > CONFIG_VHOST_NET/VSOCK/SCSI.
> > > 
> > > or
> > > 
> > > 2) don't use menuconfig for CONFIG_VHOST, let NET/SCSI/VDPA just select it.
> > > 
> > > Thanks
> > OK I tried this:
> > 
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 2523a1d4290a..a314b900d479 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -19,11 +19,10 @@ menuconfig VHOST
> >   	  This option is selected by any driver which needs to access
> >   	  the core of vhost.
> > -if VHOST
> > -
> >   config VHOST_NET
> >   	tristate "Host kernel accelerator for virtio net"
> >   	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> > +	select VHOST
> >   	---help---
> >   	  This kernel module can be loaded in host kernel to accelerate
> >   	  guest networking with virtio_net. Not to be confused with virtio_net
> > @@ -35,6 +34,7 @@ config VHOST_NET
> >   config VHOST_SCSI
> >   	tristate "VHOST_SCSI TCM fabric driver"
> >   	depends on TARGET_CORE && EVENTFD
> > +	select VHOST
> >   	default n
> >   	---help---
> >   	Say M here to enable the vhost_scsi TCM fabric module
> > @@ -44,6 +44,7 @@ config VHOST_VSOCK
> >   	tristate "vhost virtio-vsock driver"
> >   	depends on VSOCKETS && EVENTFD
> >   	select VIRTIO_VSOCKETS_COMMON
> > +	select VHOST
> >   	default n
> >   	---help---
> >   	This kernel module can be loaded in the host kernel to provide AF_VSOCK
> > @@ -57,6 +58,7 @@ config VHOST_VDPA
> >   	tristate "Vhost driver for vDPA-based backend"
> >   	depends on EVENTFD
> >   	select VDPA
> > +	select VHOST
> >   	help
> >   	  This kernel module can be loaded in host kernel to accelerate
> >   	  guest virtio devices with the vDPA-based backends.
> > @@ -78,5 +80,3 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >   	  adds some overhead, it is disabled by default.
> >   	  If unsure, say "N".
> > -
> > -endif
> > 
> > 
> > But now CONFIG_VHOST is always "y", never "m".
> > Which I think will make it a built-in.
> > Didn't figure out why yet.
> 
> 
> Is it because the dependency of EVENTFD for CONFIG_VHOST?

Oh no, it's because I forgot to change menuconfig to config.


> Remove that one for this patch, I can get CONFIG_VHOST=m.
> 
> But according to documentation/kbuild/kconfig.rst, select is used for option
> without prompt.
> 
> Thanks
> 
> 
> > 

