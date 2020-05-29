Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A85206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGQg29Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgE2IEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:04:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39579 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726921AbgE2IES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590739456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1yHh7jHFO9pOe6j7yGn/AkmRQQ4RAajACCa4HRcZAQ=;
        b=RGQg29NiDJ4mFxDeO/r1kVKQX7Sy13JIx5ytcJYPURQ5RdfcHmUBl8zg7UG757CpXHxUO6
        SGXTpGq3VlZNIyr1o4OLy8fUK39JDMZ2nmNTYy2MwTd5VXQF3bweCBhQu0pMIArnuyXOWv
        Tnk9Gy8wtOmHeATwMniXKw+tSS7u8Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-NMly3ZE9PAeAOMdpgn-tkg-1; Fri, 29 May 2020 04:04:13 -0400
X-MC-Unique: NMly3ZE9PAeAOMdpgn-tkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3723B1009443;
        Fri, 29 May 2020 08:04:11 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-231.pek2.redhat.com [10.72.13.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4717499DE6;
        Fri, 29 May 2020 08:04:01 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 6/6] vdpa: vp_vdpa: report doorbell location
Date:   Fri, 29 May 2020 16:03:03 +0800
Message-Id: <20200529080303.15449-7-jasowang@redhat.com>
In-Reply-To: <20200529080303.15449-1-jasowang@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for reporting doorbell location in vp_vdpa
driver. The doorbell mapping could be then enabled by e.g launching
qemu's virtio-net-pci device with page-per-vq enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vp_vdpa/vp_vdpa.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vp_vdpa/vp_vdpa.c b/drivers/vdpa/vp_vdpa/vp_vdpa.c
index e59c310e2156..a5ca49533138 100644
--- a/drivers/vdpa/vp_vdpa/vp_vdpa.c
+++ b/drivers/vdpa/vp_vdpa/vp_vdpa.c
@@ -30,6 +30,7 @@
 struct vp_vring {
 	void __iomem *notify;
 	char msix_name[256];
+	resource_size_t notify_pa;
 	struct vdpa_callback cb;
 	int irq;
 };
@@ -136,7 +137,8 @@ static int find_capability(struct pci_dev *dev, u8 cfg_type,
 	return 0;
 }
 
-static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off)
+static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off,
+				    resource_size_t *pa)
 {
 	struct pci_dev *pdev = vp_vdpa->pdev;
 	u32 offset;
@@ -149,6 +151,9 @@ static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off)
 			      off + offsetof(struct virtio_pci_cap, offset),
 			      &offset);
 
+	if (pa)
+		*pa = pci_resource_start(pdev, bar) + offset;
+
 	return vp_vdpa->base[bar] + offset;
 }
 
@@ -283,6 +288,18 @@ static u64 vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid)
 	return 0;
 }
 
+static struct vdpa_notification_area
+vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct vdpa_notification_area notify;
+
+	notify.addr = vp_vdpa->vring[qid].notify_pa;
+	notify.size = vp_vdpa->notify_off_multiplier;
+
+	return notify;
+}
+
 static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 				u64 num)
 {
@@ -423,6 +440,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_status	= vp_vdpa_set_status,
 	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
 	.get_vq_state	= vp_vdpa_get_vq_state,
+	.get_vq_notification = vp_vdpa_get_vq_notification,
 	.set_vq_state	= vp_vdpa_set_vq_state,
 	.set_vq_cb	= vp_vdpa_set_vq_cb,
 	.set_vq_ready	= vp_vdpa_set_vq_ready,
@@ -445,6 +463,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vp_vdpa *vp_vdpa;
 	int common, notify, device, ret, i;
 	struct virtio_device_id virtio_id;
+	resource_size_t notify_pa;
 	u16 notify_off;
 
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
@@ -525,9 +544,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
-	vp_vdpa->device = map_capability(vp_vdpa, device);
-	vp_vdpa->notify = map_capability(vp_vdpa, notify);
-	vp_vdpa->common = map_capability(vp_vdpa, common);
+	vp_vdpa->device = map_capability(vp_vdpa, device, NULL);
+	vp_vdpa->notify = map_capability(vp_vdpa, notify, &notify_pa);
+	vp_vdpa->common = map_capability(vp_vdpa, common, NULL);
 	vp_vdpa->id = virtio_id;
 
 	ret = vdpa_register_device(&vp_vdpa->vdpa);
@@ -545,6 +564,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		vp_vdpa->vring[i].irq = -1;
 		vp_vdpa->vring[i].notify = vp_vdpa->notify +
 			notify_off * vp_vdpa->notify_off_multiplier;
+		vp_vdpa->vring[i].notify_pa = notify_pa +
+			notify_off * vp_vdpa->notify_off_multiplier;
 	}
 
 	return 0;
-- 
2.20.1

