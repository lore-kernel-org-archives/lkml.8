Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69FAC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4E9218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEICOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:14:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbgEICOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:14:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 54A5FDA2AAC64CB016C5;
        Sat,  9 May 2020 10:14:02 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:13:53 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] vdpasim: Fix some coccinelle warnings
Date:   Sat, 9 May 2020 10:20:02 +0800
Message-ID: <1588990802-28451-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:

drivers/vdpa/vdpa_sim/vdpa_sim.c:104:1-10: WARNING: Assignment of 0/1 to bool variable
drivers/vdpa/vdpa_sim/vdpa_sim.c:164:7-11: WARNING: Unsigned expression compared with zero: read <= 0
drivers/vdpa/vdpa_sim/vdpa_sim.c:169:7-12: WARNING: Unsigned expression compared with zero: write <= 0

1. The 'ready' variable in vdpasim_virtqueue struct is bool type.
   It is better to initialize vq->ready to false

2. Modify 'read' and 'write' variables type from size_t to ssize_t.
   And preserve the reverse christmas tree ordering of local variables.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 01c456f..c7334cc 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -101,7 +101,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 
 static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
 {
-	vq->ready = 0;
+	vq->ready = false;
 	vq->desc_addr = 0;
 	vq->driver_addr = 0;
 	vq->device_addr = 0;
@@ -131,9 +131,10 @@ static void vdpasim_work(struct work_struct *work)
 						 vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
-	size_t read, write, total_write;
-	int err;
+	ssize_t read, write;
+	size_t total_write;
 	int pkts = 0;
+	int err;
 
 	spin_lock(&vdpasim->lock);
 
-- 
2.6.2

