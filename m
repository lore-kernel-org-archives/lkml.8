Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA415C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A21021927
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OcguIZZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgBXV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:26:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37316 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:26:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01OLQlgn027242;
        Mon, 24 Feb 2020 15:26:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582579607;
        bh=4qPYELmFmgibaPNNjkEtcv7GMDHvqjmbMNb1EKBFr+c=;
        h=From:To:CC:Subject:Date;
        b=OcguIZZnpqVlndxEAUSl9GdNIesbUiQvd3GMjgqM4NZyA99Moq4qan9ggS+8MSBst
         XWZuqJuZ/YGHuafq/uMnY/3zFdU31wCkm1dLsXZ3pnyuI/muMuvVuSXvA6tWm/KVwJ
         xL6SqVyyB3jOB0XdxNenm3usdJjllFwBUd8cfFlk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OLQls2039303;
        Mon, 24 Feb 2020 15:26:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 15:26:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 15:26:47 -0600
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OLQlRO039232;
        Mon, 24 Feb 2020 15:26:47 -0600
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 01OLQlxs089088;
        Mon, 24 Feb 2020 15:26:47 -0600
From:   Suman Anna <s-anna@ti.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
Date:   Mon, 24 Feb 2020 15:26:43 -0600
Message-ID: <20200224212643.30672-1-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions vring_new_virtqueue() and __vring_new_virtqueue() are used
with split rings, and any allocations within these functions are managed
outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ring:
allocate desc state for split ring separately") allocates the desc state
within the __vring_new_virtqueue() but frees it only when the .we_own_ring
flag is set. This leads to a memory leak when freeing such allocated
virtqueues with the vring_del_virtqueue() function.

Fix this by moving the desc_state free code outside the flag and only
for split rings. Issue was discovered during testing with remoteproc
and virtio_rpmsg.

Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring separately")
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 867c7ebd3f10..58b96baa8d48 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
 					 vq->split.queue_dma_addr);
-
-			kfree(vq->split.desc_state);
 		}
 	}
+	if (!vq->packed_ring)
+		kfree(vq->split.desc_state);
 	list_del(&_vq->list);
 	kfree(vq);
 }
-- 
2.23.0

