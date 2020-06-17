Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F12C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357C22073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEIVnhxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgFQDaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:30:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgFQDaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592364603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S6LxcsbNQFyva+euo/WtpLxOTX7LsaRMorCNc/7+mDo=;
        b=IEIVnhxWXuEQUa/T3FW4dYlxXQXuAsquZKPooxG+NOcG1QZBgn99nydY/fTxle8fC4wDfr
        /SBBchuJTqe1c2eQesuW4N5wTiK7EdYuRybYsTtE4KJcnF1Y5o3QgRiEXhmOi4Y0hnXwzL
        Nb7c53+JL2U0p+abGtCdmtwURlKQxdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-cqAyHXRJOgucOdsOqjKJ9Q-1; Tue, 16 Jun 2020 23:29:59 -0400
X-MC-Unique: cqAyHXRJOgucOdsOqjKJ9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19DED10059B9;
        Wed, 17 Jun 2020 03:29:58 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400985C1BD;
        Wed, 17 Jun 2020 03:29:49 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 0/4] vDPA: API for reporting IOVA range
Date:   Wed, 17 Jun 2020 11:29:43 +0800
Message-Id: <20200617032947.6371-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Thanks

Jason Wang (4):
  vdpa: introduce config op to get valid iova range
  vdpa_sim: implement get_iova_range bus operation
  vdpa: get_iova_range() is mandatory for device specific DMA
    translation
  vhost: vdpa: report iova range

 drivers/vdpa/vdpa.c              |  4 ++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
 drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
 include/linux/vdpa.h             | 14 ++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  5 +++++
 6 files changed, 65 insertions(+)

-- 
2.20.1

