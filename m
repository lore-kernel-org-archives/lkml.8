Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305D220658
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGGNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:40:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbgGGNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:40:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B353F1C52BB5475B6AB;
        Tue,  7 Jul 2020 21:40:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 21:40:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <s.hauer@pengutronix.de>
Subject: [PATCH v3 2/2] ubi: fastmap: Free fastmap next anchor peb during detach
Date:   Tue, 7 Jul 2020 21:41:01 +0800
Message-ID: <20200707134101.562776-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200707134101.562776-1-chengzhihao1@huawei.com>
References: <20200707134101.562776-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ubi_wl_entry related with the fm_next_anchor PEB is not freed during
detach, which causes a memory leak.
Don't forget to release fm_next_anchor PEB while detaching ubi from
mtd when CONFIG_MTD_UBI_FASTMAP is enabled.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Fixes: 4b68bf9a69d22d ("ubi: Select fastmap anchor PEBs considering...")
---
 drivers/mtd/ubi/fastmap-wl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index 83afc00e365a..28f55f9cf715 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -381,6 +381,11 @@ static void ubi_fastmap_close(struct ubi_device *ubi)
 		ubi->fm_anchor = NULL;
 	}
 
+	if (ubi->fm_next_anchor) {
+		return_unused_peb(ubi, ubi->fm_next_anchor);
+		ubi->fm_next_anchor = NULL;
+	}
+
 	if (ubi->fm) {
 		for (i = 0; i < ubi->fm->used_blocks; i++)
 			kfree(ubi->fm->e[i]);
-- 
2.25.4

