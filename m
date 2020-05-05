Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CCFC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7E0206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEEClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:41:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbgEEClT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:41:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69B3EA10E30D01918601;
        Tue,  5 May 2020 10:41:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 10:41:10 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ixgbe: fix signed-integer-overflow warning
Date:   Tue, 5 May 2020 10:45:21 +0800
Message-ID: <20200505024521.24635-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ubsan report this warning, fix it by adding a unsigned suffix.

UBSAN: signed-integer-overflow in
drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:2246:26
65535 * 65537 cannot be represented in type 'int'
CPU: 21 PID: 7 Comm: kworker/u256:0 Not tainted 5.7.0-rc3-debug+ #39
Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 03/27/2020
Workqueue: ixgbe ixgbe_service_task [ixgbe]
Call trace:
 dump_backtrace+0x0/0x3f0
 show_stack+0x28/0x38
 dump_stack+0x154/0x1e4
 ubsan_epilogue+0x18/0x60
 handle_overflow+0xf8/0x148
 __ubsan_handle_mul_overflow+0x34/0x48
 ixgbe_fc_enable_generic+0x4d0/0x590 [ixgbe]
 ixgbe_service_task+0xc20/0x1f78 [ixgbe]
 process_one_work+0x8f0/0xf18
 worker_thread+0x430/0x6d0
 kthread+0x218/0x238
 ret_from_fork+0x10/0x18

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 0bd1294ba517..39c5e6fdb72c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2243,7 +2243,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 	}
 
 	/* Configure pause time (2 TCs per register) */
-	reg = hw->fc.pause_time * 0x00010001;
+	reg = hw->fc.pause_time * 0x00010001U;
 	for (i = 0; i < (MAX_TRAFFIC_CLASS / 2); i++)
 		IXGBE_WRITE_REG(hw, IXGBE_FCTTV(i), reg);
 
-- 
2.20.1

