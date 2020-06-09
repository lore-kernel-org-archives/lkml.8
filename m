Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAE2206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFICJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:09:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbgFICJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:09:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE9B8658380F5715FC5F;
        Tue,  9 Jun 2020 10:09:35 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.2) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 9 Jun 2020 10:09:27 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <richard.weinberger@gmail.com>
CC:     <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <lizhe67@huawei.com>,
        <wangfangpeng1@huawei.com>, <chenjie6@huawei.com>
Subject: [PATCH v3] jffs2: fix jffs2 mounting failure
Date:   Tue, 9 Jun 2020 10:09:27 +0800
Message-ID: <20200609020927.68460-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAFLxGvzZequ2JtzaVOxSst_sH7PPWpWVF5nHv=B8oxLpy=wDjw@mail.gmail.com>
References: <CAFLxGvzZequ2JtzaVOxSst_sH7PPWpWVF5nHv=B8oxLpy=wDjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.2]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the advice mentioned in the email.
This is my v3 patch for this problem.

Mounting jffs2 on nand flash will get message "failed: I/O error"
with the steps listed below.
1.umount jffs2
2.erase nand flash
3.mount jffs2 on it (this mounting operation will be successful)
4.do chown or chmod to the mount point directory
5.umount jffs2
6.mount jffs2 on nand flash
After step 6, we will get message "mount ... failed: I/O error".

Typical image of this problem is like:
Empty space found from 0x00000000 to 0x008a0000
Inode node at xx, totlen 0x00000044, #ino 1, version 1, isize 0...

The reason for this mounting failure is that at the end of function
jffs2_scan_medium(), jffs2 will check the used_size and some info
of nr_blocks.If conditions are met, it will return -EIO.

The detail is that, in the steps listed above, step 4 will write
jffs2_raw_inode into flash without jffs2_raw_dirent, which will
cause that there are some jffs2_raw_inode but no jffs2_raw_dirent
on flash. This will meet the condition at the end of function
jffs2_scan_medium() and return -EIO if we umount jffs2 and mount it
again.

We notice that jffs2 add the value of c->unchecked_size if we find
an inode node while mounting. And jffs2 will never add the value of
c->unchecked_size in other situations. So this patch add one more
condition about c->unchecked_size of the judgement to fix this problem.

Signed-off-by: Zhe Li <lizhe67@huawei.com>
---
 fs/jffs2/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 5f7e284..db72a9d 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -261,7 +261,8 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	}
 #endif
 	if (c->nr_erasing_blocks) {
-		if ( !c->used_size && ((c->nr_free_blocks+empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
+		if (!c->used_size && !c->unchecked_size &&
+			((c->nr_free_blocks+empty_blocks+bad_blocks) != c->nr_blocks || bad_blocks == c->nr_blocks)) {
 			pr_notice("Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes\n");
 			pr_notice("empty_blocks %d, bad_blocks %d, c->nr_blocks %d\n",
 				  empty_blocks, bad_blocks, c->nr_blocks);
-- 
2.7.4


