Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F11820888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfxK3k9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgE0A52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:57:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE0A52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:57:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04R0perx174744;
        Wed, 27 May 2020 00:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=1SQ1TOvRAmYsofH3JFqW3Rc6f8U9dMkKKaEe8wf3ncM=;
 b=KfxK3k9T+tF0DbyAyrZPMsc3tSZ8kQ8UjABz3bnGiYTn7RocXdQTOoSzKjODQ9NA5Uqc
 l0W10pO8Lqzs7wgbCUx2em/zw+Ls0JVv9U7w14/bvJOFG0NmzA5A87XHtcHL3rb4j551
 2cpo1cn4qIa86/9+FqypHRphPJ/qQ+6dFHQvWm7Y3aYLRLDU8k2FqnDKbVcyoE9XCN3G
 w9uT4GwMBjHoUz/NHhmB9f4gjFcHzTQNQ+wmAGqhlL4RAZGkSmnU/9TJ2wwflfIRPP4X
 dn0Xc2PgZNj68Sjh4N7PJ6weFZfhT1XSy2M+9r6lEu3VzoIqVhoNiPFpZAKIFp51LIlx VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8qvrq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 00:57:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04R0rYnC093329;
        Wed, 27 May 2020 00:57:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 317dktetjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 00:57:08 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04R0v6qU007389;
        Wed, 27 May 2020 00:57:07 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 17:57:06 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Subject: [PATCH 1/1] nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll()
Date:   Tue, 26 May 2020 17:49:55 -0700
Message-Id: <20200527004955.19463-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=1 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=1
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270001
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

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
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

