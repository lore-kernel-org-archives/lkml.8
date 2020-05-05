Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40111C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A9A20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEEIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:50:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbgEEIuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:50:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DE181076B764A32DC6A;
        Tue,  5 May 2020 16:50:20 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:50:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <aelior@marvell.com>, <skalluru@marvell.com>,
        <davem@davemloft.net>, <manishc@marvell.com>,
        <yuehaibing@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] bnx2x: Remove unused inline function bnx2x_vf_vlan_credit
Date:   Tue, 5 May 2020 16:50:09 +0800
Message-ID: <20200505085009.6916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 05cc5a39ddb7 ("bnx2x: add vlan filtering offload")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 5097a44686b3..b4476f44e386 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -331,27 +331,6 @@ bnx2x_vf_set_igu_info(struct bnx2x *bp, u8 igu_sb_id, u8 abs_vfid)
 	BP_VFDB(bp)->vf_sbs_pool++;
 }
 
-static inline void bnx2x_vf_vlan_credit(struct bnx2x *bp,
-					struct bnx2x_vlan_mac_obj *obj,
-					atomic_t *counter)
-{
-	struct list_head *pos;
-	int read_lock;
-	int cnt = 0;
-
-	read_lock = bnx2x_vlan_mac_h_read_lock(bp, obj);
-	if (read_lock)
-		DP(BNX2X_MSG_SP, "Failed to take vlan mac read head; continuing anyway\n");
-
-	list_for_each(pos, &obj->head)
-		cnt++;
-
-	if (!read_lock)
-		bnx2x_vlan_mac_h_read_unlock(bp, obj);
-
-	atomic_set(counter, cnt);
-}
-
 static int bnx2x_vf_vlan_mac_clear(struct bnx2x *bp, struct bnx2x_virtf *vf,
 				   int qid, bool drv_only, int type)
 {
-- 
2.17.1


