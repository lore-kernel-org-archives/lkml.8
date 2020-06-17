Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A420663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGUzj02p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgFQDaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:30:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgFQDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592364609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Sic98tC9DpKLyGrIPnwXpZncoS8fVEZtxk95CX9DgA=;
        b=gGUzj02psx0GNgnmRP4b5BFOGmPwmYwuSa+iTP0JDkJs0mPN3Xm9RtLzg+n0P+dpupPzQu
        90CczatAobzh1behxXgjm/UU/AZfNRsJboY7YPTZQhONzkTO2sPfmGxI1Ta9shfcEXyCBQ
        tiDd0gnnx6SGeH1nwswGtW7+FC/wPjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-px80pxgRNBWByBK4tTPWhQ-1; Tue, 16 Jun 2020 23:30:06 -0400
X-MC-Unique: px80pxgRNBWByBK4tTPWhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 305C610059C4;
        Wed, 17 Jun 2020 03:30:04 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACE345C1BD;
        Wed, 17 Jun 2020 03:29:58 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Date:   Wed, 17 Jun 2020 11:29:44 +0800
Message-Id: <20200617032947.6371-2-jasowang@redhat.com>
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a config op to get valid iova range from the vDPA
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 239db794357c..b7633ed2500c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -41,6 +41,16 @@ struct vdpa_device {
 	unsigned int index;
 };
 
+/**
+ * vDPA IOVA range - the IOVA range support by the device
+ * @start: start of the IOVA range
+ * @end: end of the IOVA range
+ */
+struct vdpa_iova_range {
+	u64 start;
+	u64 end;
+};
+
 /**
  * vDPA_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -134,6 +144,9 @@ struct vdpa_device {
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
+ * @get_iova_range:		Get supported iova range (on-chip IOMMU)
+ *				@vdev: vdpa device
+ *				Returns the iova range supported by the device
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -195,6 +208,7 @@ struct vdpa_config_ops {
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
+	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
-- 
2.20.1

