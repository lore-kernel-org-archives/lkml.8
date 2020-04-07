Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95033C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABF62082D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217784;
	bh=9SCmRP9uH8nX1LIhUPHY4aB9lDvFEEQOfKymCRxe/cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=av2f6RUUERvx8HuwP17qecejY/E27Y6YK9cN/dJ8VI8aidLVc41ylPdtM26/087k7
	 K5mGb/5cwC2qYwZO9Y7AlWIDpUliNUaJdXCE1j+ZOs6JNQBxYqCxsUov5Ge0nNnn6r
	 Q2JEuuG17CEoHhfWBkxP78aqLf7tWvHewMBK8XAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDGADD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgDGAC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D603920801;
        Tue,  7 Apr 2020 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217777;
        bh=9SCmRP9uH8nX1LIhUPHY4aB9lDvFEEQOfKymCRxe/cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP3pO05ldSZSid/tWFFVyV4/HoOJGQctUL5rGS+m9MIGwzkj4HKcZGduPE1uvtbPR
         phYSBWkcX0qcdXZ3TG5s12BIfpK79QulLN+YBZYvtcZrVGNZjFNksUZOMBNfcNaiwb
         9kAOo+FfVmkvdaDXQ2M7w7J5zp6i2RvNe/707u1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luo bin <luobin9@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/9] hinic: fix the bug of clearing event queue
Date:   Mon,  6 Apr 2020 20:02:47 -0400
Message-Id: <20200407000252.17241-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000252.17241-1-sashal@kernel.org>
References: <20200407000252.17241-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>

[ Upstream commit 614eaa943e9fc3fcdbd4aa0692ae84973d363333 ]

should disable eq irq before freeing it, must clear event queue
depth in hw before freeing relevant memory to avoid illegal
memory access and update consumer idx to avoid invalid interrupt

Signed-off-by: Luo bin <luobin9@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
index 7cb8b9b94726d..1e631366b72b6 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
@@ -197,7 +197,7 @@ static u8 eq_cons_idx_checksum_set(u32 val)
  * eq_update_ci - update the HW cons idx of event queue
  * @eq: the event queue to update the cons idx for
  **/
-static void eq_update_ci(struct hinic_eq *eq)
+static void eq_update_ci(struct hinic_eq *eq, u32 arm_state)
 {
 	u32 val, addr = EQ_CONS_IDX_REG_ADDR(eq);
 
@@ -211,7 +211,7 @@ static void eq_update_ci(struct hinic_eq *eq)
 
 	val |= HINIC_EQ_CI_SET(eq->cons_idx, IDX)    |
 	       HINIC_EQ_CI_SET(eq->wrapped, WRAPPED) |
-	       HINIC_EQ_CI_SET(EQ_ARMED, INT_ARMED);
+	       HINIC_EQ_CI_SET(arm_state, INT_ARMED);
 
 	val |= HINIC_EQ_CI_SET(eq_cons_idx_checksum_set(val), XOR_CHKSUM);
 
@@ -356,7 +356,7 @@ static void eq_irq_handler(void *data)
 	else if (eq->type == HINIC_CEQ)
 		ceq_irq_handler(eq);
 
-	eq_update_ci(eq);
+	eq_update_ci(eq, EQ_ARMED);
 }
 
 /**
@@ -711,7 +711,7 @@ static int init_eq(struct hinic_eq *eq, struct hinic_hwif *hwif,
 	}
 
 	set_eq_ctrls(eq);
-	eq_update_ci(eq);
+	eq_update_ci(eq, EQ_ARMED);
 
 	err = alloc_eq_pages(eq);
 	if (err) {
@@ -761,18 +761,28 @@ static int init_eq(struct hinic_eq *eq, struct hinic_hwif *hwif,
  **/
 static void remove_eq(struct hinic_eq *eq)
 {
-	struct msix_entry *entry = &eq->msix_entry;
-
-	free_irq(entry->vector, eq);
+	hinic_set_msix_state(eq->hwif, eq->msix_entry.entry,
+			     HINIC_MSIX_DISABLE);
+	free_irq(eq->msix_entry.vector, eq);
 
 	if (eq->type == HINIC_AEQ) {
 		struct hinic_eq_work *aeq_work = &eq->aeq_work;
 
 		cancel_work_sync(&aeq_work->work);
+		/* clear aeq_len to avoid hw access host memory */
+		hinic_hwif_write_reg(eq->hwif,
+				     HINIC_CSR_AEQ_CTRL_1_ADDR(eq->q_id), 0);
 	} else if (eq->type == HINIC_CEQ) {
 		tasklet_kill(&eq->ceq_tasklet);
+		/* clear ceq_len to avoid hw access host memory */
+		hinic_hwif_write_reg(eq->hwif,
+				     HINIC_CSR_CEQ_CTRL_1_ADDR(eq->q_id), 0);
 	}
 
+	/* update cons_idx to avoid invalid interrupt */
+	eq->cons_idx = hinic_hwif_read_reg(eq->hwif, EQ_PROD_IDX_REG_ADDR(eq));
+	eq_update_ci(eq, EQ_NOT_ARMED);
+
 	free_eq_pages(eq);
 }
 
-- 
2.20.1

