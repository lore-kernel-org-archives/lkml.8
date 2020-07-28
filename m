Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3772065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDbeBXKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgG1GlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:41:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbgG1GlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595918469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBVILI65w6kAlvMCmeO/p3+Mu658pM7kH5zrHcmbav8=;
        b=NDbeBXKq+ShhY/o6lRXvSECCA55DynQ48HXY3mmn8mgFyZ18tvGu8IfbxuIXiE3KvNvLm0
        P9jSSQwm/zwczBNm7eAoqayNNyH7a/GJf9WqGO+adYJzm76EWXHqgU0g/7SXo3M7t0Rrbh
        ZL3Q+SVk5LZDOuCiajubersYEXUz0SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-X3q0ApOzPtO73Lum7ivpYA-1; Tue, 28 Jul 2020 02:41:04 -0400
X-MC-Unique: X3q0ApOzPtO73Lum7ivpYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32C0106B250;
        Tue, 28 Jul 2020 06:41:01 +0000 (UTC)
Received: from [10.72.13.242] (ovpn-13-242.pek2.redhat.com [10.72.13.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E17B55D9CD;
        Tue, 28 Jul 2020 06:40:53 +0000 (UTC)
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
Date:   Tue, 28 Jul 2020 14:40:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/28 下午2:32, Eli Cohen wrote:
> On Tue, Jul 28, 2020 at 02:18:16PM +0800, Jason Wang wrote:
>> On 2020/7/28 下午2:05, Eli Cohen wrote:
>>> Hi Michael,
>>> please note that this series depends on mlx5 core device driver patches
>>> in mlx5-next branch in
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
>>>
>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
>>>
>>> They also depend Jason Wang's patches submitted a couple of weeks ago.
>>>
>>> vdpa_sim: use the batching API
>>> vhost-vdpa: support batch updating
>>
>> Just notice that a new version is posted[1] (you were cced). Talked
>> with Michael, and it's better for you to merge the new version in
>> this series.
>>
> OK, will send again. Just to make sure, I should put your series and my
> series on Michal's vhost branch, the same tree I have been using so far?


Yes. I think so.

Thanks


>
>> Sorry for not spotting this before.
>>
>> [1] https://lkml.org/lkml/2020/7/1/301
>>
>> Thanks
>>
>>
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
>>> Eli Cohen (7):
>>>    net/vdpa: Use struct for set/get vq state
>>>    vhost: Fix documentation
>>>    vdpa: Modify get_vq_state() to return error code
>>>    vdpa/mlx5: Add hardware descriptive header file
>>>    vdpa/mlx5: Add support library for mlx5 VDPA implementation
>>>    vdpa/mlx5: Add shared memory registration code
>>>    vdpa/mlx5: Add VDPA driver for supported mlx5 devices
>>>
>>> Jason Wang (2):
>>>    vhost-vdpa: support batch updating
>>>    vdpa_sim: use the batching API
>>>
>>> Max Gurtovoy (1):
>>>    vdpa: remove hard coded virtq num
>>>
>>>   drivers/vdpa/Kconfig                   |   18 +
>>>   drivers/vdpa/Makefile                  |    1 +
>>>   drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
>>>   drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
>>>   drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
>>>   drivers/vdpa/mlx5/Makefile             |    4 +
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
>>>   drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
>>>   drivers/vdpa/mlx5/core/resources.c     |  284 ++++
>>>   drivers/vdpa/mlx5/net/main.c           |   76 +
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
>>>   drivers/vdpa/vdpa.c                    |    3 +
>>>   drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
>>>   drivers/vhost/iotlb.c                  |    4 +-
>>>   drivers/vhost/vdpa.c                   |   46 +-
>>>   include/linux/vdpa.h                   |   24 +-
>>>   include/uapi/linux/vhost_types.h       |    2 +
>>>   19 files changed, 3165 insertions(+), 59 deletions(-)
>>>   create mode 100644 drivers/vdpa/mlx5/Makefile
>>>   create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>   create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
>>>   create mode 100644 drivers/vdpa/mlx5/core/mr.c
>>>   create mode 100644 drivers/vdpa/mlx5/core/resources.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/main.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>   create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>>>

