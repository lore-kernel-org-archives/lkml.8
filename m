Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E8C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4106C20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtodDgnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDIUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:25:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgDIUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586463922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8axp0M5oMyn2GgLyL35ut9Src771+7B+nC1atGx9hE=;
        b=CtodDgnmq14Flol6VGruMyhaU1bHSCY72jifTfhul+kYGHODaHiyY3/B/HBS+lTwR33Bj9
        QkxqTti1MfRM5Na21hiRn7rdTJlK3HtcaDV5IEz1CnLAxZMEW9xIPjcsxgA+JXtCUeMVmh
        9IakI0XvXCYw1Uc1ixVJsp1w3rfezkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-hDlMFfmkMGaXR6aCZ0CgOg-1; Thu, 09 Apr 2020 16:25:21 -0400
X-MC-Unique: hDlMFfmkMGaXR6aCZ0CgOg-1
Received: by mail-wr1-f71.google.com with SMTP id r17so1619703wrg.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8axp0M5oMyn2GgLyL35ut9Src771+7B+nC1atGx9hE=;
        b=GJXxAR/Kr4E6pH10orUima07Z3N1xnwhaN3jwk7J+a37qyMgu/l6L7pxDfCoLI5bCy
         qWPLfsQmIT38CFkGH1vjePe0jcvS1AcFefwKRytkR2vE0eRgHiZtdFNmI6K90aDwoERG
         0S9092ZotLRlxTx2IaBNCQ4S8Nf8mDL6r65LYoXuih1sZ+51CA0P/sWaQDS3wSaTbx2B
         WQc+X5RkVKueyuBgPU81nVfuYy+N7Lt/DkIfKd3QS1leIY18tPfq6Hm768DHwy9GKeF4
         sPhVQUW7DPE/aPFv0CKxkjek9MV4SsAWn56mDrOH3HjDC7OrE+mRLFbqbHphcdy/Nkpm
         9KUA==
X-Gm-Message-State: AGi0PuYKby5igyHNGEmtRdsH2baikEh5qs5oohG/Zqc02kdv6gbUomOu
        Gh7N08y6Du4A7go2GxAkfv0i1oZ/jyDiSMfihsjVKV0kP0cOvxgaz6Qd1YLhWFdjVNssHOsvHK7
        H4AHfec7j0nFbttPT27YyQ8C3
X-Received: by 2002:a5d:5273:: with SMTP id l19mr962754wrc.42.1586463920112;
        Thu, 09 Apr 2020 13:25:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9hgUgDJGxmm/80KKJjVxLtENNXunW/R8rpld3/YZUF/cp56xBd16lnX4CPWATeKNdabIvmw==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr962722wrc.42.1586463919863;
        Thu, 09 Apr 2020 13:25:19 -0700 (PDT)
Received: from redhat.com (bzq-109-67-97-76.red.bezeqint.net. [109.67.97.76])
        by smtp.gmail.com with ESMTPSA id s13sm25438882wrw.20.2020.04.09.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:25:19 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:25:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Networking <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        Parav Pandit <parav@mellanox.com>, kevin.tian@intel.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, aadam@redhat.com,
        Jiri Pirko <jiri@mellanox.com>, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, Bie Tiwei <tiwei.bie@intel.com>
Subject: Re: [PATCH V9 9/9] virtio: Intel IFC VF driver for VDPA
Message-ID: <20200409162427-mutt-send-email-mst@kernel.org>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-10-jasowang@redhat.com>
 <CAK8P3a1RXUXs5oYjB=Jq5cpvG11eTnmJ+vc18_-0fzgTH6envA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1RXUXs5oYjB=Jq5cpvG11eTnmJ+vc18_-0fzgTH6envA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:41:13PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 26, 2020 at 3:08 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > From: Zhu Lingshan <lingshan.zhu@intel.com>
> >
> > This commit introduced two layers to drive IFC VF:
> >
> > (1) ifcvf_base layer, which handles IFC VF NIC hardware operations and
> >     configurations.
> >
> > (2) ifcvf_main layer, which complies to VDPA bus framework,
> >     implemented device operations for VDPA bus, handles device probe,
> >     bus attaching, vring operations, etc.
> >
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > Signed-off-by: Bie Tiwei <tiwei.bie@intel.com>
> > Signed-off-by: Wang Xiao <xiao.w.wang@intel.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> > +
> > +#define IFCVF_QUEUE_ALIGNMENT  PAGE_SIZE
> > +#define IFCVF_QUEUE_MAX                32768
> > +static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> > +{
> > +       return IFCVF_QUEUE_ALIGNMENT;
> > +}
> 
> This fails to build on arm64 with 64kb page size (found in linux-next):
> 
> /drivers/vdpa/ifcvf/ifcvf_main.c: In function 'ifcvf_vdpa_get_vq_align':
> arch/arm64/include/asm/page-def.h:17:20: error: conversion from 'long
> unsigned int' to 'u16' {aka 'short unsigned int'} changes value from
> '65536' to '0' [-Werror=overflow]
>    17 | #define PAGE_SIZE  (_AC(1, UL) << PAGE_SHIFT)
>       |                    ^
> drivers/vdpa/ifcvf/ifcvf_base.h:37:31: note: in expansion of macro 'PAGE_SIZE'
>    37 | #define IFCVF_QUEUE_ALIGNMENT PAGE_SIZE
>       |                               ^~~~~~~~~
> drivers/vdpa/ifcvf/ifcvf_main.c:231:9: note: in expansion of macro
> 'IFCVF_QUEUE_ALIGNMENT'
>   231 |  return IFCVF_QUEUE_ALIGNMENT;
>       |         ^~~~~~~~~~~~~~~~~~~~~
> 
> It's probably good enough to just not allow the driver to be built in that
> configuration as it's fairly rare but unfortunately there is no simple Kconfig
> symbol for it.
> 
> In a similar driver, we did
> 
> config VMXNET3
>         tristate "VMware VMXNET3 ethernet driver"
>         depends on PCI && INET
>         depends on !(PAGE_SIZE_64KB || ARM64_64K_PAGES || \
>                      IA64_PAGE_SIZE_64KB || MICROBLAZE_64K_PAGES || \
>                      PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES)
> 
> I think we should probably make PAGE_SIZE_64KB a global symbol
> in arch/Kconfig and have it selected by the other symbols so drivers
> like yours can add a dependency for it.
> 
>          Arnd

It's probably easier to make the alignment u32 - I don't really know why it's
u16, all callers seem to assign the result to a u32 value.

