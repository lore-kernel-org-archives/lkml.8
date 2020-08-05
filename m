Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31F822BF3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy1CyX+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHEINL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:13:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728344AbgHEINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596615179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx93n3fvknsCbsGgxpzpAFDzQVp4vq3Y5G/8h3L0gvs=;
        b=fy1CyX+gmBA5SpSZJdPWw0UbRUyRQmGEIIGb58//FkYi+dBE9WpK+tRdPnvSwP8hFhr5KX
        zeELsydNtFZKBtrdI7q8DayKEdjOpTACAnhAnzvCe1RD/MGrltVcBhF850ruAk5HJA+pG5
        U/pDajiEkDyNz4DEIo7jA+XVecPRFro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ipkOzgpqOdyP_vp2LDShcA-1; Wed, 05 Aug 2020 04:12:55 -0400
X-MC-Unique: ipkOzgpqOdyP_vp2LDShcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 814D6800138;
        Wed,  5 Aug 2020 08:12:53 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1CC171769;
        Wed,  5 Aug 2020 08:12:47 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
To:     Eli Cohen <eli@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804172726-mutt-send-email-mst@kernel.org>
 <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7b4b4944-9428-a6ca-8b94-69bfc2675286@redhat.com>
Date:   Wed, 5 Aug 2020 16:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午1:01, Eli Cohen wrote:
> On Tue, Aug 04, 2020 at 05:29:09PM -0400, Michael S. Tsirkin wrote:
>> On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
>>> Hi Michael,
>>> please note that this series depends on mlx5 core device driver patches
>>> in mlx5-next branch in
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
>> Thanks! OK so what's the plan for merging this?
>> Do patches at least build well enough that I can push them
>> upstream? Or do they have to go on top of the mellanox tree?
>>
> The patches are built on your linux-next branch which I updated
> yesterday.
>
> I am based on this commit:
> 776b7b25f10b (origin/linux-next) vhost: add an RPMsg API
>
> On top of that I merged
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git
>
> and after that I have Jason's patches (five patches), than one patch
> from Max and then my patches (seven).
>
> It builds fine on x84_64.
> I fixed some conflicts on Jason's patches.
>
> I also tested it to verify it's working.
>
> BTW, for some reason I did not get all the patches into my mailbox and I
> suspect they were not all sent. Did you get all the series 0-13?


I can see patch 0 to patch 12 but not patch 13 (I guess 12 is all).

Thanks


>
> Please let me know, and if needed I'll resend.
>
>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
>>>
>>> They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301
>> The ones you included, right?
>>
> Right.
>   
>>> Jason, I had to resolve some conflicts so I would appreciate of you can verify
>>> that it is ok.
>>>
>>> The following series of patches provide VDPA support for Mellanox
>>> devices. The supported devices are ConnectX6 DX and newer.
>>>
>>> Currently, only a network driver is implemented; future patches will
>>> introduce a block device driver. iperf performance on a single queue is
>>> around 12 Gbps.  Future patches will introduce multi queue support.
>>>
>>> The files are organized in such a way that code that can be used by
>>> different VDPA implementations will be placed in a common are resides in
>>> drivers/vdpa/mlx5/core.
>>>
>>> Only virtual functions are currently supported. Also, certain firmware
>>> capabilities must be set to enable the driver. Physical functions (PFs)
>>> are skipped by the driver.
>>>
>>> To make use of the VDPA net driver, one must load mlx5_vdpa. In such
>>> case, VFs will be operated by the VDPA driver. Although one can see a
>>> regular instance of a network driver on the VF, the VDPA driver takes
>>> precedence over the NIC driver, steering-wize.
>>>
>>> Currently, the device/interface infrastructure in mlx5_core is used to
>>> probe drivers. Future patches will introduce virtbus as a means to
>>> register devices and drivers and VDPA will be adapted to it.
>>>
>>> The mlx5 mode of operation required to support VDPA is switchdev mode.
>>> Once can use Linux or OVS bridge to take care of layer 2 switching.
>>>
>>> In order to provide virtio networking to a guest, an updated version of
>>> qemu is required. This version has been tested by the following quemu
>>> version:
>>>
>>> url: https://github.com/jasowang/qemu.git
>>> branch: vdpa
>>> Commit ID: 6f4e59b807db
>>>
>>>
>>> V2->V3
>>> Fix makefile to use include path relative to the root of the kernel
>>>
>>> V3-V4
>>> Rebase Jason's patches on linux-next branch
>>> Fix krobot error on mips arch
>>> Make use of the free callback to destroy resoruces on unload
>>> Use VIRTIO_F_ACCESS_PLATFORM instead of legacy VIRTIO_F_IOMMU_PLATFORM
>>> Add empty implementations for get_vq_notification() and get_vq_irq()
>>>
>>>
>>> Eli Cohen (6):
>>>    net/vdpa: Use struct for set/get vq state
>>>    vdpa: Modify get_vq_state() to return error code
>>>    vdpa/mlx5: Add hardware descriptive header file
>>>    vdpa/mlx5: Add support library for mlx5 VDPA implementation
>>>    vdpa/mlx5: Add shared memory registration code
>>>    vdpa/mlx5: Add VDPA driver for supported mlx5 devices
>>>
>>> Jason Wang (5):
>>>    vhost-vdpa: refine ioctl pre-processing
>>>    vhost: generialize backend features setting/getting
>>>    vhost-vdpa: support get/set backend features
>>>    vhost-vdpa: support IOTLB batching hints
>>>    vdpasim: support batch updating
>>>
>>> Max Gurtovoy (1):
>>>    vdpa: remove hard coded virtq num
>>>
>>>   drivers/vdpa/Kconfig                   |   19 +
>>>   drivers/vdpa/Makefile                  |    1 +
>>>   drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
>>>   drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
>>>   drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
>>>   drivers/vdpa/mlx5/Makefile             |    4 +
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
>>>   drivers/vdpa/mlx5/core/mr.c            |  484 ++++++
>>>   drivers/vdpa/mlx5/core/resources.c     |  284 ++++
>>>   drivers/vdpa/mlx5/net/main.c           |   76 +
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1965 ++++++++++++++++++++++++
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
>>>   drivers/vdpa/vdpa.c                    |    3 +
>>>   drivers/vdpa/vdpa_sim/vdpa_sim.c       |   53 +-
>>>   drivers/vhost/net.c                    |   18 +-
>>>   drivers/vhost/vdpa.c                   |   76 +-
>>>   drivers/vhost/vhost.c                  |   15 +
>>>   drivers/vhost/vhost.h                  |    2 +
>>>   include/linux/vdpa.h                   |   24 +-
>>>   include/uapi/linux/vhost.h             |    2 +
>>>   include/uapi/linux/vhost_types.h       |   11 +
>>>   22 files changed, 3284 insertions(+), 57 deletions(-)
>>>   create mode 100644 drivers/vdpa/mlx5/Makefile
>>>   create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>   create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
>>>   create mode 100644 drivers/vdpa/mlx5/core/mr.c
>>>   create mode 100644 drivers/vdpa/mlx5/core/resources.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/main.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>>>
>>> -- 
>>> 2.26.0

