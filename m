Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE21AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB1A2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHBPkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:40:03 -0400
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:43227
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725768AbgHBPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:40:02 -0400
Received: from oslab.tsinghua.edu.cn (unknown [166.111.139.112])
        by app-2 (Coremail) with SMTP id EAQGZQDHzLg33iZf1FDgAw--.2286S2;
        Sun, 02 Aug 2020 23:39:39 +0800 (CST)
From:   Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
To:     linux-net-drivers@solarflare.com, ecree@solarflare.com,
        mhabets@solarflare.com, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Subject: [PATCH] net: sfc: fix possible buffer overflow caused by bad DMA value in efx_siena_sriov_vfdi()
Date:   Sun,  2 Aug 2020 23:39:30 +0800
Message-Id: <20200802153930.5271-1-baijiaju@tsinghua.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EAQGZQDHzLg33iZf1FDgAw--.2286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxWr45Xw4rtr18ZFW7XFb_yoW8ur1fp3
        9xCa4UuFs7JrWUK3Z0ya18XFy5CayFyFykW34Yyas0vrZ5Zr93CF1kKF15ZrnrJrW8Gr4a
        krWDXFWUXFs8tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5WwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3Ma8UUUUU=
X-CM-SenderInfo: xedlyxhdmxq3pvlqwxlxdovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In efx_siena_sriov_vfdi():
  req = vf->buf.addr;

Because "vf->buf.addr" is mapped to coherent DMA (allocated in
efx_nic_alloc_buffer()), "req" is also mapped to DMA.

Then "req->op" is accessed in this function:
  if (req->op < VFDI_OP_LIMIT && vfdi_ops[req->op] != NULL) {
    rc = vfdi_ops[req->op](vf);

Because "req" is mapped to DMA, its data can be modified at any time by
malicious or malfunctioning hardware. In this case, the check 
"if (req->op < VFDI_OP_LIMIT)" can be passed, and then "req->op" can be
modified to cause buffer overflow when the driver accesses
"vfdi_ops[req->op]".

To fix this problem, "req->op" is assigned to a local variable, and then
the driver accesses this variable instead of "req->op".

Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
---
 drivers/net/ethernet/sfc/siena_sriov.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena_sriov.c b/drivers/net/ethernet/sfc/siena_sriov.c
index 83dcfcae3d4b..21a8482cbb3b 100644
--- a/drivers/net/ethernet/sfc/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena_sriov.c
@@ -875,6 +875,7 @@ static void efx_siena_sriov_vfdi(struct work_struct *work)
 	struct vfdi_req *req = vf->buf.addr;
 	struct efx_memcpy_req copy[2];
 	int rc;
+	u32 op = req->op;
 
 	/* Copy this page into the local address space */
 	memset(copy, '\0', sizeof(copy));
@@ -894,17 +895,17 @@ static void efx_siena_sriov_vfdi(struct work_struct *work)
 		return;
 	}
 
-	if (req->op < VFDI_OP_LIMIT && vfdi_ops[req->op] != NULL) {
-		rc = vfdi_ops[req->op](vf);
+	if (op < VFDI_OP_LIMIT && vfdi_ops[op] != NULL) {
+		rc = vfdi_ops[op](vf);
 		if (rc == 0) {
 			netif_dbg(efx, hw, efx->net_dev,
 				  "vfdi request %d from %s ok\n",
-				  req->op, vf->pci_name);
+				  op, vf->pci_name);
 		}
 	} else {
 		netif_dbg(efx, hw, efx->net_dev,
 			  "ERROR: Unrecognised request %d from VF %s addr "
-			  "%llx\n", req->op, vf->pci_name,
+			  "%llx\n", op, vf->pci_name,
 			  (unsigned long long)vf->req_addr);
 		rc = VFDI_RC_EOPNOTSUPP;
 	}
-- 
2.17.1

