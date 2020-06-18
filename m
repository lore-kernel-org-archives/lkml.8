Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C1721655
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZflSJKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgFRF4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:56:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgFRF4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592459805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vvsTC0zu1qccVdGrPvwGZCDTTN58VYTB/3udUE8lYkM=;
        b=iZflSJKZjwUQ/vy4LCm1b4gT3zmMlPBUBQuypFYbzobTw6cYTN9F6uGQ5Cvhu4kCjlDynl
        tGB527RwF/VXA+ZSZYoNWY/rBLg26s701kxaHSFHL6B3l1+poN1FxKEFNqPvqYS28pbDzG
        QaW8HRah+1YAwpCYR/PYOv0LJnLvQvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-dpMveLesOnykM1hhHxBXzA-1; Thu, 18 Jun 2020 01:56:41 -0400
X-MC-Unique: dpMveLesOnykM1hhHxBXzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7D1835B58;
        Thu, 18 Jun 2020 05:56:39 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A9335C1D6;
        Thu, 18 Jun 2020 05:56:31 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH RFC 0/5] support batched IOTLB updating in vhost-vdpa
Date:   Thu, 18 Jun 2020 13:56:21 +0800
Message-Id: <20200618055626.25660-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to support batched IOTLB updating vhost-vdpa.

Currently vhost-vdpa accepts userspace mapping via IOTLB API, and it
can only forward one mapping to IOMMU or device through IOMMU API or
dma_map(). Though set_map() is deisgend to have the capability to pass
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

Note, this only impact the devices that want its own DMA
translation. For other type of device, no changes in behaviour.

Please reivew.

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
 include/uapi/linux/vhost_types.h |  7 ++++
 7 files changed, 110 insertions(+), 29 deletions(-)

-- 
2.20.1

