Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C482087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwYQStTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgHUJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgHUJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598002112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EfuSz9sq7bu7KMXpjENGk8A6GgtVjh1dqr2JFHwc5Pc=;
        b=gwYQStTY8UthG34pFZCcCGBtFpCYX4E07q1luOhypqM2+OsxKtrulLl5oZ9yMsdBztQxd4
        7zNRhj+dXDX00OFpI1nenkkBjsf2YIMHdAZxnX/a6w3Ps0JiUl2e76BbCN8Yd699DBabBZ
        /fVj8WvKoVSX7W8/rnkcmmwgsSdvk4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-lOsv2HXYPVScwGHlISun5A-1; Fri, 21 Aug 2020 05:28:30 -0400
X-MC-Unique: lOsv2HXYPVScwGHlISun5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0AC6100CF71;
        Fri, 21 Aug 2020 09:28:28 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A5A71780;
        Fri, 21 Aug 2020 09:28:23 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 1/3] vdpa: introduce config op to get valid iova range
Date:   Fri, 21 Aug 2020 05:28:11 -0400
Message-Id: <20200821092813.8952-2-jasowang@redhat.com>
In-Reply-To: <20200821092813.8952-1-jasowang@redhat.com>
References: <20200821092813.8952-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a config op to get valid iova range from the vDPA
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index eae0bfd87d91..30bc7a7223bb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -52,6 +52,16 @@ struct vdpa_device {
 	int nvqs;
 };
 
+/**
+ * vDPA IOVA range - the IOVA range support by the device
+ * @first: start of the IOVA range
+ * @last: end of the IOVA range
+ */
+struct vdpa_iova_range {
+	u64 first;
+	u64 last;
+};
+
 /**
  * vDPA_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -151,6 +161,10 @@ struct vdpa_device {
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
+ * @get_iova_range:		Get supported iova range (optional)
+ *				@vdev: vdpa device
+ *				Returns the iova range supported by
+ *				the device.
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -216,6 +230,7 @@ struct vdpa_config_ops {
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
+	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
-- 
2.18.1

