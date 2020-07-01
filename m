Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF802074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2HM49l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGAJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:09:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgGAJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593594572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7iSWdZz1MQYnvIIt6jkhrHrV7ZLYvXqE5mMXKJ+C5ME=;
        b=i2HM49l8NKqtDsONZi6jn7D7ZrPcD7yfQQkfgjuqLxrPAPzPycD6NT1sChd+5fZzLasNAR
        cZIg4nrSIzHWRr0PBVdE8PrapsHmTk/ObM9dHbFYt4LRrk06pCh695N5XdnDXdHBuu/5hT
        3zYp3US0ygLelosI7SSuyFLyCt8dHp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-ft1kK71qO1OkZUKpp4aHNw-1; Wed, 01 Jul 2020 05:09:30 -0400
X-MC-Unique: ft1kK71qO1OkZUKpp4aHNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4151005513;
        Wed,  1 Jul 2020 09:09:28 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 979BD71662;
        Wed,  1 Jul 2020 09:08:47 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/5]
Date:   Wed,  1 Jul 2020 17:08:34 +0800
Message-Id: <20200701090839.12994-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to support batched IOTLB updating vhost-vdpa.

Currently vhost-vdpa accepts userspace mapping via IOTLB API, and it
can only forward one mapping to IOMMU or device through IOMMU API or
dma_map(). Though set_map() is designed to have the capability to pass
an rbtree based mapping to vDPA device, it's still be called at least
once for each VHOST_IOTLB_UPDATE or VHOST_IOTLB_INVALIDATE. This is
because vhost-vdpa doesn't know the userspace start or stop then
updating.

So this patch introduces two flags as hints for vhost-vdpa to call
set_map() only when userspace finish a batch of IOTLB updating.

So instead of:

1) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)
2) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)
...
n) VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE -> set_map() (s)

With the help of hints, we do:

0) VHOST_IOTLB_BATCH_START

1) VHOST_IOTLB_UPDATE/INVALIDATE
...
n) VHOST_IOTLB_UPDATE/INVALIDATE

n+1) VHOST_IOTLB_BATCH_END -> set_map()

One one call of set_map() to vDPA device for a batch of IOTLB
mappings. So for the device that has its own DMA translation logic, it
can efficiently structure the memory mapping to get best performance.

Note, this only impacts the devices that want its own DMA
translation (less times of set_map() call). For other type of devices,
there's no changes in the behaviour.

Changes from RFCV1:

- tweak the comments per Michael's request

Jason Wang (5):
  vhost-vdpa: refine ioctl pre-processing
  vhost: generialize backend features setting/getting
  vhost-vdpa: support get/set backend features
  vhost-vdpa: support IOTLB batching hints
  vdpasim: support batch updating

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 40 +++++++++++++++++++++--
 drivers/vhost/net.c              | 18 ++---------
 drivers/vhost/vdpa.c             | 55 ++++++++++++++++++++++++++------
 drivers/vhost/vhost.c            | 15 +++++++++
 drivers/vhost/vhost.h            |  2 ++
 include/uapi/linux/vhost.h       |  2 ++
 include/uapi/linux/vhost_types.h | 11 +++++++
 7 files changed, 114 insertions(+), 29 deletions(-)

-- 
2.20.1

