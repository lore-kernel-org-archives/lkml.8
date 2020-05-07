Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D5C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0424E208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEGLKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:10:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgEGLKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:10:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B08031ABE3B00C9375E2;
        Thu,  7 May 2020 19:10:01 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:09:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <yanaijie@huawei.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] igb: make igb_set_fc_watermarks() return void
Date:   Thu, 7 May 2020 19:09:15 +0800
Message-ID: <20200507110915.38349-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return 0 now, we can make it return void to
simplify the code. This fixes the following coccicheck warning:

drivers/net/ethernet/intel/igb/e1000_mac.c:728:5-12: Unneeded variable:
"ret_val". Return "0" on line 751

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 79ee0a747260..3254737c07a3 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -12,7 +12,7 @@
 #include "igb.h"
 
 static s32 igb_set_default_fc(struct e1000_hw *hw);
-static s32 igb_set_fc_watermarks(struct e1000_hw *hw);
+static void igb_set_fc_watermarks(struct e1000_hw *hw);
 
 /**
  *  igb_get_bus_info_pcie - Get PCIe bus information
@@ -687,7 +687,7 @@ s32 igb_setup_link(struct e1000_hw *hw)
 
 	wr32(E1000_FCTTV, hw->fc.pause_time);
 
-	ret_val = igb_set_fc_watermarks(hw);
+	igb_set_fc_watermarks(hw);
 
 out:
 
@@ -723,9 +723,8 @@ void igb_config_collision_dist(struct e1000_hw *hw)
  *  flow control XON frame transmission is enabled, then set XON frame
  *  tansmission as well.
  **/
-static s32 igb_set_fc_watermarks(struct e1000_hw *hw)
+static void igb_set_fc_watermarks(struct e1000_hw *hw)
 {
-	s32 ret_val = 0;
 	u32 fcrtl = 0, fcrth = 0;
 
 	/* Set the flow control receive threshold registers.  Normally,
@@ -747,8 +746,6 @@ static s32 igb_set_fc_watermarks(struct e1000_hw *hw)
 	}
 	wr32(E1000_FCRTL, fcrtl);
 	wr32(E1000_FCRTH, fcrth);
-
-	return ret_val;
 }
 
 /**
-- 
2.21.1

