Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998BFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8227D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGPJbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:31:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbgGPJbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:31:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8601BF5814DDACD0A27C;
        Thu, 16 Jul 2020 17:31:15 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Jul 2020
 17:31:09 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-next@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <jdmason@kudzu.us>, <christophe.jaillet@wanadoo.fr>,
        <john.wanghui@huawei.com>
Subject: [PATCH] net: neterion: vxge: reduce stack usage in VXGE_COMPLETE_VPATH_TX
Date:   Thu, 16 Jul 2020 17:32:47 +0000
Message-ID: <20200716173247.78912-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning: [-Werror=-Wframe-larger-than=]

drivers/net/ethernet/neterion/vxge/vxge-main.c:
In function'VXGE_COMPLETE_VPATH_TX.isra.37':
drivers/net/ethernet/neterion/vxge/vxge-main.c:119:1:
warning: the frame size of 1056 bytes is larger than 1024 bytes

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
index b0faa737b817..97ddfc9debd4 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
@@ -100,8 +100,14 @@ static inline void VXGE_COMPLETE_VPATH_TX(struct vxge_fifo *fifo)
 	struct sk_buff **temp;
 #define NR_SKB_COMPLETED 128
 	struct sk_buff *completed[NR_SKB_COMPLETED];
+	struct sk_buff **completed;
 	int more;

+	completed = kcalloc(NR_SKB_COMPLETED, sizeof(*completed),
+			    GFP_KERNEL);
+	if (!completed)
+		return;
+
 	do {
 		more = 0;
 		skb_ptr = completed;
@@ -116,6 +122,8 @@ static inline void VXGE_COMPLETE_VPATH_TX(struct vxge_fifo *fifo)
 		for (temp = completed; temp != skb_ptr; temp++)
 			dev_consume_skb_irq(*temp);
 	} while (more);
+
+	free(completed);
 }

 static inline void VXGE_COMPLETE_ALL_TX(struct vxgedev *vdev)
--
2.17.1

