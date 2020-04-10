Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C3BC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJLyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:54:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgDJLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:54:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC627B95CBFA99C9DA08;
        Fri, 10 Apr 2020 19:54:36 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:54:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <yuehaibing@huawei.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] vdpasim: remove unused variable 'ret'
Date:   Fri, 10 Apr 2020 19:54:22 +0800
Message-ID: <20200410115422.42308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/vdpa/vdpa_sim/vdpa_sim.c:92:6: warning:
 variable ‘ret’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 7957d2d41fc4..01c456f7c1f7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -89,15 +89,14 @@ static struct vdpasim *dev_to_sim(struct device *dev)
 static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
-	int ret;
 
-	ret = vringh_init_iotlb(&vq->vring, vdpasim_features,
-				VDPASIM_QUEUE_MAX, false,
-				(struct vring_desc *)(uintptr_t)vq->desc_addr,
-				(struct vring_avail *)
-				(uintptr_t)vq->driver_addr,
-				(struct vring_used *)
-				(uintptr_t)vq->device_addr);
+	vringh_init_iotlb(&vq->vring, vdpasim_features,
+			  VDPASIM_QUEUE_MAX, false,
+			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
+			  (struct vring_avail *)
+			  (uintptr_t)vq->driver_addr,
+			  (struct vring_used *)
+			  (uintptr_t)vq->device_addr);
 }
 
 static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
-- 
2.17.1


