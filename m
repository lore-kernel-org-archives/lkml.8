Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1595A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USDNhC1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHDV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:29:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44449 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbgHDV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596576558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mp8oPykQbFI3PCYtU3bJ6U6U1V5IO9G5ow6aH0G/PE4=;
        b=USDNhC1zgRuXegBTlRJjp5eZCFCn/RJKEKiuhNezhHtL++JQP/+2SoNQbLOTMfjKLAaygL
        AA5KActVkUT1Jq30DpNyWCfxCxoO54Y/UnqCvqrr1vDFGbsovjTJdCTnAicp4GDFxW63N1
        wZXBFZsurw3DZVrOq71OqqcrMOu5/Ig=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-Z2rBBekqPyqb7lcF_Dh7fA-1; Tue, 04 Aug 2020 17:29:15 -0400
X-MC-Unique: Z2rBBekqPyqb7lcF_Dh7fA-1
Received: by mail-qt1-f200.google.com with SMTP id w15so28780967qtv.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mp8oPykQbFI3PCYtU3bJ6U6U1V5IO9G5ow6aH0G/PE4=;
        b=FItqj55p3CUU/Hf1v4XFRTHyI14jXrQH5n9oEUVzfw3l7Hw5WvjqYgpG1ToXW7cXO6
         dBHwC1geZ/86E/WVD4GlHz099SxFmB7YaL+F2aADzCGvu2mCPnsfNGuyOaMFVZZPpy/g
         5L2Pz+xvh/ZboXMF8Ddkj4hzwmXqA8cP6j9Jcs+G2xLDKb+eCTDWYUMRFKz2hRHMWuci
         5SWWHvKUEBNjL/g+TIAE2/nBUVmbXo3qlMUQQ51ActvBRY9ssqXAT1jYpm2eZxYB+F55
         GSjLdVAIn8HZLD8MZE2S4NGXMIIeyDGjVQYcjrJiMKmoSn65YgMEJUxIILSKETMT9lAX
         hePw==
X-Gm-Message-State: AOAM531dNh0K6uUkxcpFhu2hwsxI8JXUEnEdDGyV0frAf4CJusYujhze
        xfaOF2Au2h7YiTRRlwBvcukjN4DG80vj3i5mlF8eBKHND9cpaI0X/sZdOR3zNN1ZZxtQ5SbeBTX
        IuhdCRPP1gfuuktFo0UJKmxgl
X-Received: by 2002:aed:38c3:: with SMTP id k61mr83720qte.11.1596576555023;
        Tue, 04 Aug 2020 14:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrZQvRXXmOImw3ZNin/9p58rw3YAMvyB6SPFfMvQL7L/uzQmZg02eL1z+mLAWH0ljJoCYKTA==
X-Received: by 2002:aed:38c3:: with SMTP id k61mr83705qte.11.1596576554750;
        Tue, 04 Aug 2020 14:29:14 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id c42sm256143qte.5.2020.08.04.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:29:14 -0700 (PDT)
Date:   Tue, 4 Aug 2020 17:29:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200804172726-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> Hi Michael,
> please note that this series depends on mlx5 core device driver patches
> in mlx5-next branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.

Thanks! OK so what's the plan for merging this?
Do patches at least build well enough that I can push them
upstream? Or do they have to go on top of the mellanox tree?


> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> 
> They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301

The ones you included, right?

> Jason, I had to resolve some conflicts so I would appreciate of you can verify
> that it is ok.
> 
> The following series of patches provide VDPA support for Mellanox
> devices. The supported devices are ConnectX6 DX and newer.
> 
> Currently, only a network driver is implemented; future patches will
> introduce a block device driver. iperf performance on a single queue is
> around 12 Gbps.  Future patches will introduce multi queue support.
> 
> The files are organized in such a way that code that can be used by
> different VDPA implementations will be placed in a common are resides in
> drivers/vdpa/mlx5/core.
> 
> Only virtual functions are currently supported. Also, certain firmware
> capabilities must be set to enable the driver. Physical functions (PFs)
> are skipped by the driver.
> 
> To make use of the VDPA net driver, one must load mlx5_vdpa. In such
> case, VFs will be operated by the VDPA driver. Although one can see a
> regular instance of a network driver on the VF, the VDPA driver takes
> precedence over the NIC driver, steering-wize.
> 
> Currently, the device/interface infrastructure in mlx5_core is used to
> probe drivers. Future patches will introduce virtbus as a means to
> register devices and drivers and VDPA will be adapted to it.
> 
> The mlx5 mode of operation required to support VDPA is switchdev mode.
> Once can use Linux or OVS bridge to take care of layer 2 switching.
> 
> In order to provide virtio networking to a guest, an updated version of
> qemu is required. This version has been tested by the following quemu
> version:
> 
> url: https://github.com/jasowang/qemu.git
> branch: vdpa
> Commit ID: 6f4e59b807db
> 
> 
> V2->V3
> Fix makefile to use include path relative to the root of the kernel
> 
> V3-V4
> Rebase Jason's patches on linux-next branch
> Fix krobot error on mips arch
> Make use of the free callback to destroy resoruces on unload
> Use VIRTIO_F_ACCESS_PLATFORM instead of legacy VIRTIO_F_IOMMU_PLATFORM
> Add empty implementations for get_vq_notification() and get_vq_irq()
> 
> 
> Eli Cohen (6):
>   net/vdpa: Use struct for set/get vq state
>   vdpa: Modify get_vq_state() to return error code
>   vdpa/mlx5: Add hardware descriptive header file
>   vdpa/mlx5: Add support library for mlx5 VDPA implementation
>   vdpa/mlx5: Add shared memory registration code
>   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> 
> Jason Wang (5):
>   vhost-vdpa: refine ioctl pre-processing
>   vhost: generialize backend features setting/getting
>   vhost-vdpa: support get/set backend features
>   vhost-vdpa: support IOTLB batching hints
>   vdpasim: support batch updating
> 
> Max Gurtovoy (1):
>   vdpa: remove hard coded virtq num
> 
>  drivers/vdpa/Kconfig                   |   19 +
>  drivers/vdpa/Makefile                  |    1 +
>  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
>  drivers/vdpa/mlx5/Makefile             |    4 +
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
>  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
>  drivers/vdpa/mlx5/core/mr.c            |  484 ++++++
>  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
>  drivers/vdpa/mlx5/net/main.c           |   76 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1965 ++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
>  drivers/vdpa/vdpa.c                    |    3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   53 +-
>  drivers/vhost/net.c                    |   18 +-
>  drivers/vhost/vdpa.c                   |   76 +-
>  drivers/vhost/vhost.c                  |   15 +
>  drivers/vhost/vhost.h                  |    2 +
>  include/linux/vdpa.h                   |   24 +-
>  include/uapi/linux/vhost.h             |    2 +
>  include/uapi/linux/vhost_types.h       |   11 +
>  22 files changed, 3284 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/Makefile
>  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
>  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
>  create mode 100644 drivers/vdpa/mlx5/core/mr.c
>  create mode 100644 drivers/vdpa/mlx5/core/resources.c
>  create mode 100644 drivers/vdpa/mlx5/net/main.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> 
> -- 
> 2.26.0

