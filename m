Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5164A2076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHBLPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:15:52 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36431 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbgHBLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U4T1Vgj_1596366944;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4T1Vgj_1596366944)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:44 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, kuba@kernel.org, ricardo.farrington@cavium.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@alibaba.com
Subject: [PATCH] liquidio: Fix wrong return value in cn23xx_get_pf_num()
Date:   Sun,  2 Aug 2020 19:15:44 +0800
Message-Id: <20200802111544.5520-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: 0c45d7fe12c7e ("liquidio: fix use of pf in pass-through mode in a virtual machine")
Cc: Rick Farrington <ricardo.farrington@cavium.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 43d11c38b38a..4cddd628d41b 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1167,7 +1167,7 @@ static int cn23xx_get_pf_num(struct octeon_device *oct)
 		oct->pf_num = ((fdl_bit >> CN23XX_PCIE_SRIOV_FDL_BIT_POS) &
 			       CN23XX_PCIE_SRIOV_FDL_MASK);
 	} else {
-		ret = EINVAL;
+		ret = -EINVAL;
 
 		/* Under some virtual environments, extended PCI regs are
 		 * inaccessible, in which case the above read will have failed.
-- 
2.26.2

