Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1118F207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436974AbgE2DiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:38:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436641AbgE2DiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:38:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63E0621DD35E910CA2B7;
        Fri, 29 May 2020 11:38:13 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.2) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 11:38:11 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: fix nothing output for "ls" command
Date:   Fri, 29 May 2020 11:38:09 +0800
Message-ID: <20200529033809.113516-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.2]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I find a bug that I get nothing with shell
command "ls". The test steps are listed below.
1. cd $JFFS2_MOUNT_DIR
2. touch file
3. ls

Finally I find that when command "ls" going into
function jffs2_readdir(), it get non-zero return
value from function dir_emit(). So I get nothing
from "ls", absolutely.

After checking my file system image, I find a raw
dirent node with nsize = 0. The full_scan mounting
process do not check nsize and the return value
of strnlen(rd->name, rd->nsize) carefully, which
causes function jffs2_readdir pass 0 to parameter
namelen of function dir_emit when we use command
"ls".

Of course it should never happened to find a raw
dirent with nsize = 0. In my opinion, this abnormal
phenomenon maybe cause by bad driver or bad medium.
But for rebustness reason, jffs2 should handle it.

This patch add codes to check the nsize and the
return value of strnlen(rd->name, rd->nsize). If
abnormal node is found, use function jffs2_scan_dirty_space
to deal with it.

Signed-off-by: Zhe Li <lizhe67@huawei.com>
---
 fs/jffs2/scan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 5f7e284..ff37d92 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -1065,8 +1065,21 @@ static int jffs2_scan_dirent_node(struct jffs2_sb_info *c, struct jffs2_eraseblo
 
 	pseudo_random += je32_to_cpu(rd->version);
 
+	if (rd->nsize == 0) {
+		pr_err("%s(): Node nsize is zero at 0x%08x\n", __func__, ofs);
+		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
+			return err;
+		return 0;
+	}
+
 	/* Should never happen. Did. (OLPC trac #4184)*/
 	checkedlen = strnlen(rd->name, rd->nsize);
+	if (checkedlen == 0) {
+		pr_err("Dirent at %08x get zero checkedlen\n", ofs);
+		if ((err = jffs2_scan_dirty_space(c, jeb, PAD(je32_to_cpu(rd->totlen)))))
+			return err;
+		return 0;
+	}
 	if (checkedlen < rd->nsize) {
 		pr_err("Dirent at %08x has zeroes in name. Truncating to %d chars\n",
 		       ofs, checkedlen);
-- 
2.7.4


