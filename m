Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0704920679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFBLYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:24:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5839 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgFBLYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:24:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4377ECEEEE6F8789CF8B;
        Tue,  2 Jun 2020 19:24:45 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 19:24:35 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
Subject: [PATCH v2] ubi: fastmap: Don't produce the initial anchor PEB when fastmap is disabled
Date:   Tue, 2 Jun 2020 19:24:10 +0800
Message-ID: <20200602112410.660785-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following process triggers a memleak caused by forgetting to release the
initial anchor PEB (CONFIG_MTD_UBI_FASTMAP is disabled):
1. attach -> __erase_worker -> produce the initial anchor PEB
2. detach -> ubi_fastmap_close (Do nothing, it should have released the
   initial anchor PEB)

Don't produce the initial anchor PEB in __erase_worker() when fastmap
is disabled.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Fixes: f9c34bb529975fe ("ubi: Fix producing anchor PEBs")
Reported-by: syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com
---
 drivers/mtd/ubi/wl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 5146cce5fe32..f88486ccf5d5 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1079,7 +1079,8 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
 	if (!err) {
 		spin_lock(&ubi->wl_lock);
 
-		if (!ubi->fm_anchor && e->pnum < UBI_FM_MAX_START) {
+		if (!ubi->fm_disabled && !ubi->fm_anchor &&
+		    e->pnum < UBI_FM_MAX_START) {
 			ubi->fm_anchor = e;
 			ubi->fm_do_produce_anchor = 0;
 		} else {
-- 
2.25.4

