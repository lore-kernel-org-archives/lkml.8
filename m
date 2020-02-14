Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8252EC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8520848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBNByh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728335AbgBNByJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:09 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6633F51318AC8064A0B;
        Fri, 14 Feb 2020 09:54:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 09:54:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <huangdaode@huawei.com>, <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 2/3] net: hns3: fix VF bandwidth does not take effect in some case
Date:   Fri, 14 Feb 2020 09:53:42 +0800
Message-ID: <1581645223-23038-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
References: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When enabling 4 TC after setting the bandwidth of VF, the bandwidth
of VF will resume to default value, because of the qset resources
changed in this case.

This patch fixes it by using a fixed VF's qset resources according to
HNAE3_MAX_TC macro.

Fixes: ee9e44248f52 ("net: hns3: add support for configuring bandwidth of VF on the host")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 180224e..28db132 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -566,7 +566,7 @@ static void hclge_tm_vport_tc_info_update(struct hclge_vport *vport)
 	 */
 	kinfo->num_tc = vport->vport_id ? 1 :
 			min_t(u16, vport->alloc_tqps, hdev->tm_info.num_tc);
-	vport->qs_offset = (vport->vport_id ? hdev->tm_info.num_tc : 0) +
+	vport->qs_offset = (vport->vport_id ? HNAE3_MAX_TC : 0) +
 				(vport->vport_id ? (vport->vport_id - 1) : 0);
 
 	max_rss_size = min_t(u16, hdev->rss_size_max,
-- 
2.7.4

