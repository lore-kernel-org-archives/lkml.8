Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00767C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE589229C4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIHOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:55:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729027AbgIHOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:24:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 973783CAAE98B997207F;
        Tue,  8 Sep 2020 22:04:42 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 22:04:36 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <aelior@marvell.com>, <skalluru@marvell.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <GR-everest-linux-l2@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] bnx2x: Fix some kernel-doc warnings
Date:   Tue, 8 Sep 2020 22:01:58 +0800
Message-ID: <20200908140158.23540-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:4238: warning: Excess function parameter 'netdev' description in 'bnx2x_setup_tc'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:4238: warning: Excess function parameter 'tc' description in 'bnx2x_setup_tc'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index e3d92e4f2193..2c0ccd4fba9b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4229,8 +4229,8 @@ void bnx2x_get_c2s_mapping(struct bnx2x *bp, u8 *c2s_map, u8 *c2s_default)
 /**
  * bnx2x_setup_tc - routine to configure net_device for multi tc
  *
- * @netdev: net device to configure
- * @tc: number of traffic classes to enable
+ * @dev: net device to configure
+ * @num_tc: number of traffic classes to enable
  *
  * callback connected to the ndo_setup_tc function pointer
  */
-- 
2.17.1

