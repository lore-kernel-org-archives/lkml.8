Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D4FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854A4206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXGc9dxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgE2IDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:03:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27601 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgE2IDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590739401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3sCGk2CMdXKSPjF97sMoZKCNplEGrPAt2s8qgubR3U8=;
        b=NXGc9dxktScpRFql32ZoSC/MK5TEiok6xcFFT2hlT3RpxmqN5sYjQTz/Q5gZgeMbuktDvB
        43UmJffJRncZaouHRYhgTL3SDV87crq3ZlVEXjW1MU+PcguwNC0oLdkbAVUmpO/Dx3JZBl
        tmKitkzvDurn+Dx7Wy4a6sF+lT0kufs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-vz3bxBC7PT6Fd61srtV9jg-1; Fri, 29 May 2020 04:03:17 -0400
X-MC-Unique: vz3bxBC7PT6Fd61srtV9jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B0801855A14;
        Fri, 29 May 2020 08:03:15 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-231.pek2.redhat.com [10.72.13.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCEA499DE6;
        Fri, 29 May 2020 08:03:06 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 0/6] vDPA: doorbell mapping
Date:   Fri, 29 May 2020 16:02:57 +0800
Message-Id: <20200529080303.15449-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series introduce basic functionality of doorbell mapping support
for vhost-vDPA. Userspace program may use mmap() to map a the doorbell
of a specific virtqueue into its address space. This is help to reudce
the syscall or vmexit overhead.

A new vdpa_config_ops was introduced to report the location of the
doorbell, vhost_vdpa may then choose to map the doorbell when:

- The doorbell register is localted at page boundary
- The doorbell register does not share page with non doorbell
  registers.

With these two requriements, doorbells layout could be modelled more
easily from guest (e.g Qemu's page-per-vq model) and it would be more
safe to avoid exposing other registers to userspace directly.

IFCVF was reported to support this feature but unfortuantely the one I
used does not meet those requirements. So a new virtio-pci driver for
vDPA bus is introduced, and I verify this with page-per-vq=on with a
userspace vhost-vdpa driver in guest.

Please review.

Thanks

Jason Wang (6):
  vhost: allow device that does not depend on vhost worker
  vhost: use mmgrab() instead of mmget() for non worker device
  vdpa: introduce get_vq_notification method
  vhost_vdpa: support doorbell mapping via mmap
  vdpa: introduce virtio pci driver
  vdpa: vp_vdpa: report doorbell location

 drivers/vdpa/Kconfig           |   6 +
 drivers/vdpa/Makefile          |   1 +
 drivers/vdpa/vp_vdpa/Makefile  |   2 +
 drivers/vdpa/vp_vdpa/vp_vdpa.c | 604 +++++++++++++++++++++++++++++++++
 drivers/vhost/net.c            |   2 +-
 drivers/vhost/scsi.c           |   2 +-
 drivers/vhost/vdpa.c           |  61 +++-
 drivers/vhost/vhost.c          |  80 +++--
 drivers/vhost/vhost.h          |   2 +
 drivers/vhost/vsock.c          |   2 +-
 include/linux/vdpa.h           |  16 +
 11 files changed, 753 insertions(+), 25 deletions(-)
 create mode 100644 drivers/vdpa/vp_vdpa/Makefile
 create mode 100644 drivers/vdpa/vp_vdpa/vp_vdpa.c

-- 
2.20.1

