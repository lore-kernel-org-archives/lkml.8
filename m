Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_FUTURE_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B21C2D0F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE7B2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDFDYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:24:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgDFDYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:24:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 37D6B69C984608471486;
        Mon,  6 Apr 2020 11:24:28 +0800 (CST)
Received: from huawei.com (10.175.112.70) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 11:24:20 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <gregkh@linuxfoundation.org>, <puranjay12@gmail.com>,
        <robsonde@gmail.com>, <zhengbin13@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] Staging: rtl8192e: remove set but not used variable 'tmpRegC'
Date:   Tue, 7 Apr 2020 08:36:04 -0400
Message-ID: <1586262964-4582-1-git-send-email-wanghai38@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function rtl92e_start_adapter:
drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:693:15: warning: variable ‘tmpRegC’ set but not used [-Wunused-but-set-variable]

commit 94a799425eee ("rtl8192e: Split into two directories")
involved this, remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ddcd788..ff934ae 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -690,7 +690,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	u8 tmpvalue;
 	u8 ICVersion, SwitchingRegulatorOutput;
 	bool bfirmwareok = true;
-	u32 tmpRegA, tmpRegC, TempCCk;
+	u32 tmpRegA, TempCCk;
 	int i = 0;
 	u32 retry_times = 0;
 
@@ -889,8 +889,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		if (priv->IC_Cut >= IC_VersionCut_D) {
 			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 						    bMaskDWord);
-			tmpRegC = rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
-						    bMaskDWord);
+			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
+					  bMaskDWord);
 			for (i = 0; i < TxBBGainTableLength; i++) {
 				if (tmpRegA == dm_tx_bb_gain[i]) {
 					priv->rfa_txpowertrackingindex = (u8)i;
-- 
1.8.3.1

