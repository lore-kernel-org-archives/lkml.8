Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE99C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A24206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGSmWOJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgDAOBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:01:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732872AbgDAOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585749697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTgkw/DNWNFnGK1V1mn43DeF8IkK7OE1WypLeTHLQVQ=;
        b=EGSmWOJm1ezZitKr3PRMFPHyrMBAydSdocSPwPQMSIRvRFUamw+B05M8Vj8hDhpgan2EyO
        JZbgQcC+5Hz6UCaJwvxm5z4agclT6myQHtZKHBGW5pXUt9W+o94RnwtB4rqWFsJU/BOshF
        CqVfkj5uT69l9QBNfeqnL7udR6I7R6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-ZeaC4PkyMmOPcPOWsTFyMg-1; Wed, 01 Apr 2020 10:01:34 -0400
X-MC-Unique: ZeaC4PkyMmOPcPOWsTFyMg-1
Received: by mail-wm1-f69.google.com with SMTP id l13so8165wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JTgkw/DNWNFnGK1V1mn43DeF8IkK7OE1WypLeTHLQVQ=;
        b=et0qht9bJrTzFSw5RF6FmRyKCm5dN6WdCALjc/ahM9nFBVZULeEAAPK+INwbf8dbtT
         Gpc5GyqTZ6/Cb6W7BgCzucAGwldpW8YliKk1G4S2UtTUBf4d3ElAYfZ6pZIgLRtgYubl
         rQdd1Ca1u6WrX4SFVqgqV23EciU8oNFjF9dA+d8n/rKphAosfQ6OzXIJEn4vyG5HOAzh
         O/9hveAuU7y8DKAPQITvbuPjoeXNKBLCh1oHZgp8mXSFzP8agcK2+MdaxM5ollStOX/z
         WV+hWIgGhFKWPL/jA79ValUsbKkI8s3GV/og6u+lQoCPUYZKLOx/YdZup5YJ5VyFE8Pt
         PPvw==
X-Gm-Message-State: ANhLgQ2bnJLojvhPlZbOFYKDn/7u61ByL6dY0k9S1IN5obIOQqhynIv+
        45eFPTaKIHFZ6xkr5rgkDC02+wawkB+yxcTQ+fFeXj4GvfgiwSLe90kWgJvLfoJEK7eOqHQUaET
        7g3rRFtVbqDchpNbZ8HxbWXfn
X-Received: by 2002:adf:9321:: with SMTP id 30mr24990292wro.330.1585749692216;
        Wed, 01 Apr 2020 07:01:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFbKox39mO56Wdb4IkMUuB5u4BTlW+FZYATXuysnk2/9j76LmESJqT/c2PrF73AgslT1nk9A==
X-Received: by 2002:adf:9321:: with SMTP id 30mr24990241wro.330.1585749691892;
        Wed, 01 Apr 2020 07:01:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id 98sm3113112wrk.52.2020.04.01.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:01:31 -0700 (PDT)
Date:   Wed, 1 Apr 2020 10:01:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, jgg@mellanox.com,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com,
        xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com,
        lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com,
        stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org,
        aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Message-ID: <20200401095820-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
 <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
 <4726da4c-11ec-3b6e-1218-6d6d365d5038@de.ibm.com>
 <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39b96e3a-9f4e-6e1d-e988-8c4bcfb55879@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:02:00PM +0200, Christian Borntraeger wrote:
> 
> 
> On 01.04.20 14:56, Christian Borntraeger wrote:
> > 
> > On 01.04.20 14:50, Jason Wang wrote:
> >>
> >> On 2020/4/1 下午7:21, Christian Borntraeger wrote:
> >>> On 26.03.20 15:01, Jason Wang wrote:
> >>>> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
> >>>> not necessarily for VM since it's a generic userspace and kernel
> >>>> communication protocol. Such dependency may prevent archs without
> >>>> virtualization support from using vhost.
> >>>>
> >>>> To solve this, a dedicated vhost menu is created under drivers so
> >>>> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> >>> FWIW, this now results in vhost not being build with defconfig kernels (in todays
> >>> linux-next).
> >>>
> >>
> >> Hi Christian:
> >>
> >> Did you meet it even with this commit https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a4be40cbcedba9b5b714f3c95182e8a45176e42d?
> > 
> > I simply used linux-next. The defconfig does NOT contain CONFIG_VHOST and therefore CONFIG_VHOST_NET and friends
> > can not be selected.
> > 
> > $ git checkout next-20200401
> > $ make defconfig
> >   HOSTCC  scripts/basic/fixdep
> >   HOSTCC  scripts/kconfig/conf.o
> >   HOSTCC  scripts/kconfig/confdata.o
> >   HOSTCC  scripts/kconfig/expr.o
> >   LEX     scripts/kconfig/lexer.lex.c
> >   YACC    scripts/kconfig/parser.tab.[ch]
> >   HOSTCC  scripts/kconfig/lexer.lex.o
> >   HOSTCC  scripts/kconfig/parser.tab.o
> >   HOSTCC  scripts/kconfig/preprocess.o
> >   HOSTCC  scripts/kconfig/symbol.o
> >   HOSTCC  scripts/kconfig/util.o
> >   HOSTLD  scripts/kconfig/conf
> > *** Default configuration is based on 'x86_64_defconfig'
> > #
> > # configuration written to .config
> > #
> > 
> > $ grep VHOST .config
> > # CONFIG_VHOST is not set
> > 
> >  
> >> If yes, what's your build config looks like?
> >>
> >> Thanks
> 
> This was x86. Not sure if that did work before.
> On s390 this is definitely a regression as the defconfig files 
> for s390 do select VHOST_NET
> 
> grep VHOST arch/s390/configs/*
> arch/s390/configs/debug_defconfig:CONFIG_VHOST_NET=m
> arch/s390/configs/debug_defconfig:CONFIG_VHOST_VSOCK=m
> arch/s390/configs/defconfig:CONFIG_VHOST_NET=m
> arch/s390/configs/defconfig:CONFIG_VHOST_VSOCK=m
> 
> and this worked with 5.6, but does not work with next. Just adding
> CONFIG_VHOST=m to the defconfig solves the issue, something like

And a bunch of other places I guess... and I guess we need to
select VHOST_RING too?
Also Jason, I just noticed that you added:

config VHOST_RING
        tristate
+        select VHOST_IOTLB
        help
          This option is selected by any driver which needs to access
          the host side of a virtio ring.

but are you sure this will do the right thing if VHOST_RING itself
selected?


> ---
>  arch/s390/configs/debug_defconfig | 5 +++--
>  arch/s390/configs/defconfig       | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 46038bc58c9e..0b83274341ce 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
>  CONFIG_CMM=m
>  CONFIG_APPLDATA_BASE=y
>  CONFIG_KVM=m
> -CONFIG_VHOST_NET=m
> -CONFIG_VHOST_VSOCK=m
>  CONFIG_OPROFILE=m
>  CONFIG_KPROBES=y
>  CONFIG_JUMP_LABEL=y
> @@ -561,6 +559,9 @@ CONFIG_VFIO_MDEV_DEVICE=m
>  CONFIG_VIRTIO_PCI=m
>  CONFIG_VIRTIO_BALLOON=m
>  CONFIG_VIRTIO_INPUT=y
> +CONFIG_VHOST=m
> +CONFIG_VHOST_NET=m
> +CONFIG_VHOST_VSOCK=m
>  CONFIG_S390_CCW_IOMMU=y
>  CONFIG_S390_AP_IOMMU=y
>  CONFIG_EXT4_FS=y
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 7cd0648c1f4e..39e69c4e8cf7 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -57,8 +57,6 @@ CONFIG_PROTECTED_VIRTUALIZATION_GUEST=y
>  CONFIG_CMM=m
>  CONFIG_APPLDATA_BASE=y
>  CONFIG_KVM=m
> -CONFIG_VHOST_NET=m
> -CONFIG_VHOST_VSOCK=m
>  CONFIG_OPROFILE=m
>  CONFIG_KPROBES=y
>  CONFIG_JUMP_LABEL=y
> @@ -557,6 +555,9 @@ CONFIG_VFIO_MDEV_DEVICE=m
>  CONFIG_VIRTIO_PCI=m
>  CONFIG_VIRTIO_BALLOON=m
>  CONFIG_VIRTIO_INPUT=y
> +CONFIG_VHOST=m
> +CONFIG_VHOST_NET=m
> +CONFIG_VHOST_VSOCK=m
>  CONFIG_S390_CCW_IOMMU=y
>  CONFIG_S390_AP_IOMMU=y
>  CONFIG_EXT4_FS=y
> -- 
> 2.25.1

