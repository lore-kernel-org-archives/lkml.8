Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0AEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17ED21655
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRPzyrKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgFRF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:57:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58850 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgFRF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592459873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMPqqdA13OB8Wbq1cykQlNhk0fPsMbbs+lqAtCf74+Q=;
        b=KRPzyrKpi1VzmawOI0fD8Ecs8/KSmI5kv7qxJ67D5mJ/dXrFm+KoMYJLlNh95LoxxTBX3p
        BONrjLu996QicP4KXBNwNCTxa3QUFqL5TIJjQVUP+UQrNnaIBj13t9L9Coy0JJvKqyrVEU
        QaK+FvHK4pMQDqLhKQY+KS6vTtbylF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-zHg3apR0ONudhpoy5oB-GA-1; Thu, 18 Jun 2020 01:57:47 -0400
X-MC-Unique: zHg3apR0ONudhpoy5oB-GA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BFFD107ACF2;
        Thu, 18 Jun 2020 05:57:45 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99F25C28E;
        Thu, 18 Jun 2020 05:57:39 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH RFC 2/5] vhost: generialize backend features setting/getting
Date:   Thu, 18 Jun 2020 13:56:23 +0800
Message-Id: <20200618055626.25660-3-jasowang@redhat.com>
In-Reply-To: <20200618055626.25660-1-jasowang@redhat.com>
References: <20200618055626.25660-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the backend features setting/getting from net.c to vhost.c to be
reused by vhost-vdpa.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 18 ++----------------
 drivers/vhost/vhost.c | 15 +++++++++++++++
 drivers/vhost/vhost.h |  2 ++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 0b509be8d7b1..d88afe3f6060 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1622,21 +1622,6 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_backend_features(struct vhost_net *n, u64 features)
-{
-	int i;
-
-	mutex_lock(&n->dev.mutex);
-	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
-		mutex_lock(&n->vqs[i].vq.mutex);
-		n->vqs[i].vq.acked_backend_features = features;
-		mutex_unlock(&n->vqs[i].vq.mutex);
-	}
-	mutex_unlock(&n->dev.mutex);
-
-	return 0;
-}
-
 static int vhost_net_set_features(struct vhost_net *n, u64 features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
@@ -1737,7 +1722,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_BACKEND_FEATURES)
 			return -EOPNOTSUPP;
-		return vhost_net_set_backend_features(n, features);
+		vhost_set_backend_features(&n->dev, features);
+		return 0;
 	case VHOST_RESET_OWNER:
 		return vhost_net_reset_owner(n);
 	case VHOST_SET_OWNER:
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index dc510dc2b1ef..ba61f499d420 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2700,6 +2700,21 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 }
 EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
+{
+	struct vhost_virtqueue *vq;
+	int i;
+
+	mutex_lock(&dev->mutex);
+	for (i = 0; i < dev->nvqs; ++i) {
+		vq = dev->vqs[i];
+		mutex_lock(&vq->mutex);
+		vq->acked_backend_features = features;
+		mutex_unlock(&vq->mutex);
+	}
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(vhost_set_backend_features);
 
 static int __init vhost_init(void)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 264a2a2fae97..52753aecd82a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -223,6 +223,8 @@ void vhost_enqueue_msg(struct vhost_dev *dev,
 		       struct vhost_msg_node *node);
 struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 					 struct list_head *head);
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features);
+
 __poll_t vhost_chr_poll(struct file *file, struct vhost_dev *dev,
 			    poll_table *wait);
 ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
-- 
2.20.1

