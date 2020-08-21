Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A5A207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRnmxguD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHUJ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:28:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgHUJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598002107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=I+BEhjcX4SAr8jSjnZvZnUPdx/ThUX5bf8qM1MA/oeM=;
        b=NRnmxguDRmIzBoUirYqGkhTQwqAkV/6OBm3AKDwJ9LCtAW45ExGK91C6REZ45Q/wk131WJ
        lzkx9xAFj4Lx034U2cvR3oLJtev58c4Q43R93Xkk6Iy23mKT1nwl8NJIPLfLSVU6M1IvTs
        eJY9u5IGWckjuE1O0dr+xO5j2dn9nSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-dG8vhwgIPHWsKBs9P1Whog-1; Fri, 21 Aug 2020 05:28:25 -0400
X-MC-Unique: dG8vhwgIPHWsKBs9P1Whog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A0A680EF8D;
        Fri, 21 Aug 2020 09:28:23 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96E387191C;
        Fri, 21 Aug 2020 09:28:15 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 0/3] vDPA: API for reporting IOVA range
Date:   Fri, 21 Aug 2020 05:28:10 -0400
Message-Id: <20200821092813.8952-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series introduces API for reporing IOVA range. This is a must for
userspace to work correclty:

- for the process that uses vhost-vDPA directly to properly allocate
  IOVA
- for VM(qemu), when vIOMMU is not enabled, fail early if GPA is out
  of range
- for VM(qemu), when vIOMMU is enabled, determine a valid guest
  address width

Please review.

Changes from V1:

- do not mandate get_iova_range() for device with its own DMA
  translation logic and assume a [0, ULLONG_MAX] range
- mandate IOVA range only for IOMMU that forcing aperture
- forbid the map which is out of the IOVA range in vhost-vDPA

Thanks

Jason Wang (3):
  vdpa: introduce config op to get valid iova range
  vhost: vdpa: report iova range
  vdpa_sim: implement get_iova_range()

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++
 drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
 include/linux/vdpa.h             | 15 ++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 5 files changed, 81 insertions(+)

-- 
2.18.1

