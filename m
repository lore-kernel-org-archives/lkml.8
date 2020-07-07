Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41513C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2619E20658
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGGNkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:40:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728137AbgGGNkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:40:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A680811DA6D63C798698;
        Tue,  7 Jul 2020 21:40:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 21:40:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <s.hauer@pengutronix.de>
Subject: [PATCH v3 1/2] ubi: fastmap: Don't produce the initial next anchor PEB when fastmap is disabled
Date:   Tue, 7 Jul 2020 21:41:00 +0800
Message-ID: <20200707134101.562776-2-chengzhihao1@huawei.com>
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

Following process triggers a memleak caused by forgetting to release the
initial next anchor PEB (CONFIG_MTD_UBI_FASTMAP is disabled):
1. attach -> __erase_worker -> produce the initial next anchor PEB
2. detach -> ubi_fastmap_close (Do nothing, it should have released the
   initial next anchor PEB)

Don't produce the initial next anchor PEB in __erase_worker() when fastmap
is disabled.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Fixes: f9c34bb529975fe ("ubi: Fix producing anchor PEBs")
Reported-by: syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com
---
 drivers/mtd/ubi/wl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 27636063ed1b..42cac572f82d 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1086,7 +1086,8 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
 	if (!err) {
 		spin_lock(&ubi->wl_lock);
 
-		if (!ubi->fm_next_anchor && e->pnum < UBI_FM_MAX_START) {
+		if (!ubi->fm_disabled && !ubi->fm_next_anchor &&
+		    e->pnum < UBI_FM_MAX_START) {
 			/* Abort anchor production, if needed it will be
 			 * enabled again in the wear leveling started below.
 			 */
-- 
2.25.4

