Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6872080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD04vvCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgDBODi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:03:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732567AbgDBODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW3IStRHotZHHVJbI4O500WA85Dxv8izDV7FvTI+lnk=;
        b=OD04vvCuMUO9ceYbIC08PTJapW+MEiHMXzurEjMdMdhjko5ni7P6eUkVKIRLA88JKOY6i/
        iEDNPzX5JHqsvxJubZZbuwmbS8MI/MbYHH5vA5M9/KuDVOuN852ngzJSuWak5g32gZ/iAE
        NvvBJf6xWQ5CxYMQLFIXfNRWR+4S7o4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-3m1XqmXdNE-kiwk8qD1TVg-1; Thu, 02 Apr 2020 10:03:31 -0400
X-MC-Unique: 3m1XqmXdNE-kiwk8qD1TVg-1
Received: by mail-qk1-f199.google.com with SMTP id r64so3074791qkc.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pW3IStRHotZHHVJbI4O500WA85Dxv8izDV7FvTI+lnk=;
        b=FlEdwr5q6pZXbNmcoCcF92bzk0CMvKOIAm8/szFJQWFo/4PASEkZ8wx+TriIiXjama
         BSBMOAcvJv5uQONYw2KYg2NN9YNwToBUEJ+jDXsOqX+Ve9HVq+QNqxZUyhlYuqRpFXzE
         ZLd86E8+qB0o0Y8YPoxsZA3XbgIaEGcC8JG65wXh1cR9Hnks/SjMLPvYnfsf9TkMMwM8
         Oyf/akUsOs3kj/525EPoVuTvPGOYDsKoU9lWC8iyrSBjlkZvnoq36S+ReJsryORcwgpv
         mjUhxKmlrbQhOOgO1/grtGzL5CixNRaWb+RlbeGjbRERDehgJq08gkhGJfvonHIBgbnQ
         f+rA==
X-Gm-Message-State: AGi0Pua7m7YUwLuTR3JvLewstCArcJwYSVkrO7Su826LZuSwXTKSYM+0
        zAuNh1YyszyGyKjv9iEPhRjEP1mpvikKPJGtlAtInC4jdbfmBrBNpCTNa5pz3sV4ZP4r4ad3hHq
        qAymsPwtfUHotLV0Hmbf/DRcV
X-Received: by 2002:ac8:32db:: with SMTP id a27mr3131758qtb.165.1585836211385;
        Thu, 02 Apr 2020 07:03:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLB2eqca8BJt9vk/5KptVL7bmZKMKTWTE9G9WXe57GBeZhOtApxHa3hrcRZ/Msl/M2CvDDzGA==
X-Received: by 2002:ac8:32db:: with SMTP id a27mr3131701qtb.165.1585836211041;
        Thu, 02 Apr 2020 07:03:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h143sm3517147qke.58.2020.04.02.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:03:30 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:03:21 -0400
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
Message-ID: <20200402100257-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <20200401092004-mutt-send-email-mst@kernel.org>
 <6b4d169a-9962-6014-5423-1507059343e9@redhat.com>
 <20200401100954-mutt-send-email-mst@kernel.org>
 <3dd3b7e7-e3d9-dba4-00fc-868081f95ab7@redhat.com>
 <20200401120643-mutt-send-email-mst@kernel.org>
 <c11c2195-88eb-2096-af47-40f2da5b389f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c11c2195-88eb-2096-af47-40f2da5b389f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:22:57AM +0800, Jason Wang wrote:
> 
> On 2020/4/2 上午12:08, Michael S. Tsirkin wrote:
> > On Wed, Apr 01, 2020 at 10:29:32PM +0800, Jason Wang wrote:
> > > >From 9b3a5d23b8bf6b0a11e65e688335d782f8e6aa5c Mon Sep 17 00:00:00 2001
> > > From: Jason Wang <jasowang@redhat.com>
> > > Date: Wed, 1 Apr 2020 22:17:27 +0800
> > > Subject: [PATCH] vhost: let CONFIG_VHOST to be selected by drivers
> > > 
> > > The defconfig on some archs enable vhost_net or vhost_vsock by
> > > default. So instead of adding CONFIG_VHOST=m to all of those files,
> > > simply letting CONFIG_VHOST to be selected by all of the vhost
> > > drivers. This fixes the build on the archs with CONFIG_VHOST_NET=m in
> > > their defconfig.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/vhost/Kconfig | 15 +++++++++++----
> > >   1 file changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index 2523a1d4290a..362b832f5338 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -11,19 +11,23 @@ config VHOST_RING
> > >   	  This option is selected by any driver which needs to access
> > >   	  the host side of a virtio ring.
> > > -menuconfig VHOST
> > > -	tristate "Host kernel accelerator for virtio (VHOST)"
> > > -	depends on EVENTFD
> > > +config VHOST
> > > +	tristate
> > >   	select VHOST_IOTLB
> > >   	help
> > >   	  This option is selected by any driver which needs to access
> > >   	  the core of vhost.
> > > -if VHOST
> > > +menuconfig VHOST_MENU
> > > +	bool "VHOST drivers"
> > > +	default y
> > > +
> > > +if VHOST_MENU
> > >   config VHOST_NET
> > >   	tristate "Host kernel accelerator for virtio net"
> > >   	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> > > +	select VHOST
> > >   	---help---
> > >   	  This kernel module can be loaded in host kernel to accelerate
> > >   	  guest networking with virtio_net. Not to be confused with virtio_net
> > > @@ -35,6 +39,7 @@ config VHOST_NET
> > >   config VHOST_SCSI
> > >   	tristate "VHOST_SCSI TCM fabric driver"
> > >   	depends on TARGET_CORE && EVENTFD
> > > +	select VHOST
> > >   	default n
> > >   	---help---
> > >   	Say M here to enable the vhost_scsi TCM fabric module
> > > @@ -43,6 +48,7 @@ config VHOST_SCSI
> > >   config VHOST_VSOCK
> > >   	tristate "vhost virtio-vsock driver"
> > >   	depends on VSOCKETS && EVENTFD
> > > +	select VHOST
> > >   	select VIRTIO_VSOCKETS_COMMON
> > >   	default n
> > >   	---help---
> > > @@ -56,6 +62,7 @@ config VHOST_VSOCK
> > >   config VHOST_VDPA
> > >   	tristate "Vhost driver for vDPA-based backend"
> > >   	depends on EVENTFD
> > > +	select VHOST
> 
> 
> This part is not squashed.
> 
> 
> > >   	select VDPA
> > >   	help
> > >   	  This kernel module can be loaded in host kernel to accelerate
> > OK so I squashed this into the original buggy patch.
> > Could you please play with vhost branch of my tree on various
> > arches? If it looks ok to you let me know I'll push
> > this to next.
> 
> 
> With the above part squashed. I've tested all the archs whose defconfig have
> VHOST_NET or VHOST_VSOCK enabled.
> 
> All looks fine.
> 
> Thanks


I'm a bit confused. So is the next tag in my tree ok now?

-- 
MST

