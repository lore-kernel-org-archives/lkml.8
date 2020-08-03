Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C190C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F83622BF3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Raaiul7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgHCUvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:51:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgHCUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596487896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1E7lzDQVWdMD9MkNgS4uGg4D78Cpm6TklUaGLBV5l4=;
        b=Raaiul7KBBMRDL0WRypuHd0pAph3JHUfwjwwkE5+jXoJzdOLxszDMb7XhBX3DLdf08lAER
        XNsfud2NjotCzrbwH35b7+4m2ZBEqvocF1n1B/BVsWKXcz/aQK4GQlUx4fodD+kpluaGk1
        cH26HJ5cZ8WHH/CU8I45b1/Y+AdXzXw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-TdtSv8BmPnGGWXS-LJantg-1; Mon, 03 Aug 2020 16:51:33 -0400
X-MC-Unique: TdtSv8BmPnGGWXS-LJantg-1
Received: by mail-qv1-f72.google.com with SMTP id f1so16171194qvx.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1E7lzDQVWdMD9MkNgS4uGg4D78Cpm6TklUaGLBV5l4=;
        b=fefd5KzXIq7J1mISzWDCeIOgdIBqFMWlnnaXPgd5JmtlsTEUq3qOcjnpaBr2GYzZz5
         E9OfPlE0DTroCYXk4qV3ftotxOYEBWXnCUl9h0PmzzXGziHASqDnHyh4xm35h4rz4Tbe
         WeLfzSSI9qvzfwD8MtexTQoTcbnm8UWABwerB/a4sMRo1/q20/3QUq3Kj6CaB6rPcSsi
         xExBgRnnxSifkZz+ySj0pcEL/5YqwlHgbkXXM09QIhPschOiEYT3B1v+21Z5FsOdIO8f
         C/RP7CDc7+1/a7OLhFtkn5l2GM0o8zlglyodA+nkeakg+kIdUu9h2eqAmuMjaLZ2VWps
         5oag==
X-Gm-Message-State: AOAM532ZT8LJVXmeKWMw5AZSR5ATjrLTKsafMhZHdBCUbKegpLkc3SSF
        hnxz+wZga5J4pYwcFQgkhgGie+nr+lA6rgZUTOQYhkcFK9fqDN6VGzvfOMPYQunCdBjH52IFZYY
        8nCa47zjjQPp9MIQVuUIWceIn
X-Received: by 2002:ae9:ed8e:: with SMTP id c136mr18693773qkg.246.1596487893339;
        Mon, 03 Aug 2020 13:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtEVkhwhTJtr/aA7f88MqZF1BQOqNVMP1FacUjc/yOYNHz1RzD2pTTEqVY+lCyvRSo/TtJOg==
X-Received: by 2002:ae9:ed8e:: with SMTP id c136mr18693752qkg.246.1596487893054;
        Mon, 03 Aug 2020 13:51:33 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id p194sm19451914qke.16.2020.08.03.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:51:32 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:51:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200803164756-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728060539.4163-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:05:29AM +0300, Eli Cohen wrote:
> Hi Michael,
> please note that this series depends on mlx5 core device driver patches
> in mlx5-next branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> 
> They also depend Jason Wang's patches submitted a couple of weeks ago.
> 
> vdpa_sim: use the batching API
> vhost-vdpa: support batch updating

Hmm this makes merging them messy. I can ack merging them through
the mellanox tree, but
conflicts between Jason's patches and what's in my tree also exist.

How big is the dependency? Can I pick it up with your ack?

Also, mips build failures need to be dealt with.

> 
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
> Eli Cohen (7):
>   net/vdpa: Use struct for set/get vq state
>   vhost: Fix documentation
>   vdpa: Modify get_vq_state() to return error code
>   vdpa/mlx5: Add hardware descriptive header file
>   vdpa/mlx5: Add support library for mlx5 VDPA implementation
>   vdpa/mlx5: Add shared memory registration code
>   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> 
> Jason Wang (2):
>   vhost-vdpa: support batch updating
>   vdpa_sim: use the batching API
> 
> Max Gurtovoy (1):
>   vdpa: remove hard coded virtq num
> 
>  drivers/vdpa/Kconfig                   |   18 +
>  drivers/vdpa/Makefile                  |    1 +
>  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
>  drivers/vdpa/mlx5/Makefile             |    4 +
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
>  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
>  drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
>  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
>  drivers/vdpa/mlx5/net/main.c           |   76 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
>  drivers/vdpa/vdpa.c                    |    3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
>  drivers/vhost/iotlb.c                  |    4 +-
>  drivers/vhost/vdpa.c                   |   46 +-
>  include/linux/vdpa.h                   |   24 +-
>  include/uapi/linux/vhost_types.h       |    2 +
>  19 files changed, 3165 insertions(+), 59 deletions(-)
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

