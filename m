Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FF9C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED302075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANFne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:43:34 -0500
Received: from mail.windriver.com ([147.11.1.11]:52178 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:43:33 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 00E5hETX001368
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 21:43:14 -0800 (PST)
Received: from pek-qwang2-d1.wrs.com (128.224.162.199) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.468.0; Mon, 13 Jan 2020 21:43:13 -0800
From:   <quanyang.wang@windriver.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quanyang.wang@windriver.com>
Subject: [PATCH] ubifs: fix memory leak from c->sup_node
Date:   Tue, 14 Jan 2020 13:43:11 +0800
Message-ID: <20200114054311.8984-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The c->sup_node is allocated in function ubifs_read_sb_node but
is not freed. This will cause memory leak as below:

unreferenced object 0xbc9ce000 (size 4096):
  comm "mount", pid 500, jiffies 4294952946 (age 315.820s)
  hex dump (first 32 bytes):
    31 18 10 06 06 7b f1 11 02 00 00 00 00 00 00 00  1....{..........
    00 10 00 00 06 00 00 00 00 00 00 00 08 00 00 00  ................
  backtrace:
    [<d1c503cd>] ubifs_read_superblock+0x48/0xebc
    [<a20e14bd>] ubifs_mount+0x974/0x1420
    [<8589ecc3>] legacy_get_tree+0x2c/0x50
    [<5f1fb889>] vfs_get_tree+0x28/0xfc
    [<bbfc7939>] do_mount+0x4f8/0x748
    [<4151f538>] ksys_mount+0x78/0xa0
    [<d59910a9>] ret_fast_syscall+0x0/0x54
    [<1cc40005>] 0x7ea02790

Free it in ubifs_umount and in the error path of mount_ubifs.

Fixes: fd6150051bec ("ubifs: Store read superblock node")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 fs/ubifs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7d4547e5202d..a4412c259bb3 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1599,6 +1599,7 @@ static int mount_ubifs(struct ubifs_info *c)
 	vfree(c->ileb_buf);
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
+	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
 	return err;
 }
@@ -1641,6 +1642,7 @@ static void ubifs_umount(struct ubifs_info *c)
 	vfree(c->ileb_buf);
 	vfree(c->sbuf);
 	kfree(c->bottom_up_buf);
+	kfree(c->sup_node);
 	ubifs_debugging_exit(c);
 }
 
-- 
2.17.1

