Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EE5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C1F2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgFPHKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:10:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbgFPHKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:10:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF4DC7B672CDA1EA1E02;
        Tue, 16 Jun 2020 15:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 15:10:32 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <liu.song11@zte.com.cn>
Subject: [PATCH RFC 2/5] Revert "ubifs: Fix out-of-bounds memory access caused by abnormal value of node_len"
Date:   Tue, 16 Jun 2020 15:11:43 +0800
Message-ID: <20200616071146.2607061-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200616071146.2607061-1-chengzhihao1@huawei.com>
References: <20200616071146.2607061-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit acc5af3efa303d5f36cc8c0f61716161f6ca1384.

No need to avoid memory oob in dumping for data node alone. Later, node
length will be passed into function 'ubifs_dump_node()' which replaces
all node dumping places.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/io.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 7e4bfaf2871f..8ceb51478800 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -225,7 +225,7 @@ int ubifs_is_mapped(const struct ubifs_info *c, int lnum)
 int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 		     int offs, int quiet, int must_chk_crc)
 {
-	int err = -EINVAL, type, node_len, dump_node = 1;
+	int err = -EINVAL, type, node_len;
 	uint32_t crc, node_crc, magic;
 	const struct ubifs_ch *ch = buf;
 
@@ -278,22 +278,10 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 out_len:
 	if (!quiet)
 		ubifs_err(c, "bad node length %d", node_len);
-	if (type == UBIFS_DATA_NODE && node_len > UBIFS_DATA_NODE_SZ)
-		dump_node = 0;
 out:
 	if (!quiet) {
 		ubifs_err(c, "bad node at LEB %d:%d", lnum, offs);
-		if (dump_node) {
-			ubifs_dump_node(c, buf);
-		} else {
-			int safe_len = min3(node_len, c->leb_size - offs,
-				(int)UBIFS_MAX_DATA_NODE_SZ);
-			pr_err("\tprevent out-of-bounds memory access\n");
-			pr_err("\ttruncated data node length      %d\n", safe_len);
-			pr_err("\tcorrupted data node:\n");
-			print_hex_dump(KERN_ERR, "\t", DUMP_PREFIX_OFFSET, 32, 1,
-					buf, safe_len, 0);
-		}
+		ubifs_dump_node(c, buf);
 		dump_stack();
 	}
 	return err;
-- 
2.25.4

