Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AEEC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCB420731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD2DJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:09:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgD2DJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:09:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC86577A9F912E32341D;
        Wed, 29 Apr 2020 11:09:29 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 11:09:23 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <aviad.krawczyk@huawei.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] hinic: Use ARRAY_SIZE for nic_vf_cmd_msg_handler
Date:   Wed, 29 Apr 2020 11:15:36 +0800
Message-ID: <1588130136-49236-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix coccinelle warning, use ARRAY_SIZE

drivers/net/ethernet/huawei/hinic/hinic_sriov.c:713:43-44: WARNING: Use ARRAY_SIZE

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_sriov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
index b24788e..ac12725 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
@@ -710,8 +710,7 @@ int nic_pf_mbox_handler(void *hwdev, u16 vf_id, u8 cmd, void *buf_in,
 	if (!hwdev)
 		return -EFAULT;
 
-	cmd_number = sizeof(nic_vf_cmd_msg_handler) /
-			    sizeof(struct vf_cmd_msg_handle);
+	cmd_number = ARRAY_SIZE(nic_vf_cmd_msg_handler);
 	pfhwdev = container_of(dev, struct hinic_pfhwdev, hwdev);
 	nic_io = &dev->func_to_io;
 	for (i = 0; i < cmd_number; i++) {
-- 
2.6.2

