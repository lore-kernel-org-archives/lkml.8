Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ECBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97892088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gCbGj2I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbgE0QVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:21:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58568 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgE0QVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:21:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RGIhGB149279;
        Wed, 27 May 2020 16:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=mj5MgFMqYw4HF6Q0SB3yAk6eb2qmxG2EWk+u/QGMUYM=;
 b=gCbGj2I+EVEPNjqGuDwUAdsZ7OseuIY6KZRA/VZsH8bXKL+VCkFNxbFYOnsQ8UooALyj
 ++WiEH5AL9Bo0hTJC5FTXGTRGf3q+pymnT7g+/J+oBTvIPZ0EtBLfx9Bag5HxXYRHaxZ
 QfmRQH3KTGRzwA4E0yI6zXDW6crjsqd5ceda3U+5ylYDIjXKWgzeRxmXwbxBm6QBq4oY
 9sTSUMWrihKv8LHVYoI059ttq2SKZrrPpgcolZT8C7mlrNKxlgodDC3YnfTScJXIgqWP
 /5e7CFsElHhIlfVhIrb/vur049UBe4AcUMBOQ/6pRnt0ssmbpJFWwORgRRVCsW6BJA26 fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 318xe1get9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 16:21:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RGJ3g3193273;
        Wed, 27 May 2020 16:21:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddr2v97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 16:21:16 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RGLBQ4011633;
        Wed, 27 May 2020 16:21:11 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 09:21:11 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, ming.lei@redhat.com
Subject: [PATCH v2 1/1] nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll()
Date:   Wed, 27 May 2020 09:13:52 -0700
Message-Id: <20200527161352.21227-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=1 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be a race between nvme_reap_pending_cqes() and nvme_poll(), e.g.,
when doing live reset while polling the nvme device.

      CPU X                        CPU Y
                               nvme_poll()
nvme_dev_disable()
-> nvme_stop_queues()
-> nvme_suspend_io_queues()
-> nvme_suspend_queue()
                               -> spin_lock(&nvmeq->cq_poll_lock);
-> nvme_reap_pending_cqes()
   -> nvme_process_cq()        -> nvme_process_cq()

In the above scenario, the nvme_process_cq() for the same queue may be
running on both CPU X and CPU Y concurrently.

It is much more easier to reproduce the issue when CONFIG_PREEMPT is
enabled in kernel. When CONFIG_PREEMPT is disabled, it would take longer
time for nvme_stop_queues()-->blk_mq_quiesce_queue() to wait for grace
period.

This patch protects nvme_process_cq() with nvmeq->cq_poll_lock in
nvme_reap_pending_cqes().

Fixes: fa46c6fb5d61 ("nvme/pci: move cqe check after device shutdown")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
Changed since v1:
  - Add "Fixes" tag

 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3726dc780d15..cc46e250fcac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1382,16 +1382,19 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 
 /*
  * Called only on a device that has been disabled and after all other threads
- * that can check this device's completion queues have synced. This is the
- * last chance for the driver to see a natural completion before
- * nvme_cancel_request() terminates all incomplete requests.
+ * that can check this device's completion queues have synced, except
+ * nvme_poll(). This is the last chance for the driver to see a natural
+ * completion before nvme_cancel_request() terminates all incomplete requests.
  */
 static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 {
 	int i;
 
-	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
+	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+		spin_lock(&dev->queues[i].cq_poll_lock);
 		nvme_process_cq(&dev->queues[i]);
+		spin_unlock(&dev->queues[i].cq_poll_lock);
+	}
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
-- 
2.17.1

