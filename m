Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF7C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6020661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBCI5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:57:31 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:53942 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgBCI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:57:30 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Mon,  3 Feb 2020 08:56:30 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 08:56:49 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 08:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQjVj5ZEK81BYjJJCEmtiXggObzj06pLS/8+hXsaPWSpzW3BWqoOfIV0Adj4wgCEq9kP4WqIa8k7wFB83cOEAfkmaLxyRxAyynGyKIOsFHXrgf1rQerL6TqknOnQCjIh+XlSDWTeqOTG0KXtQeAtX1x8eU8KcYv+5g1E1kCW+n3WLbSrKQ2a2nwpqAjWX0a903Ga2i23NfQoGuxmQYZ01kzJUkV4bmLQbxtHdFcmsnSBIOd0/8vEzityrcG6pj1YLuot4bD8vStIEy7U3DYiexyKWFAGy9pT78xyB2mp8bhNwiBI5ac7J5Pl3mMpGbp3y2VpULcsADr578JYJrKa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzEXaOQlK6OXaQoP4C9tQMqaLuvvieAfmVUm9F5REoE=;
 b=A16Cp5DPSsodfFvKjRPNZr+8pETrwqqg20/Bq5U01q9QtfoXzhLUgKXq7yCnqcLSZnQWn6KF1puZmkBApF65/h/pqeJ/teAenpUwNNaTpWaLMd2qOHuo4gXOipLYsONnulTOyvAPlqwmAtqFMSll4acZFBIbN22US20eoNFBRciAK/+lxKrnbqYqho0o1lhZVNPY0+INUYtyzx1QewWwDSPueMXkIwgefPo15JVO3PJoQ4K5iKbqmYTwIvmy6pOOgRKKdfnlyYtG8bbs+GtOBKKMiriRzHhK5OlbVvJF/pz3nV4FZeh4UioGVRKjZ06JAuycye+DgZkOAWtMg9mvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3269.namprd18.prod.outlook.com (52.132.245.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 08:56:47 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77%3]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 08:56:47 +0000
From:   Gang He <ghe@suse.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>
CC:     Gang He <ghe@suse.com>, <linux-kernel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: fix the oops problem when write cloned file
Date:   Mon, 3 Feb 2020 16:56:17 +0800
Message-ID: <20200203085617.29311-1-ghe@suse.com>
X-Mailer: git-send-email 2.12.3
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To CH2PR18MB3206.namprd18.prod.outlook.com
 (2603:10b6:610:14::15)
MIME-Version: 1.0
Received: from ghe-pc.suse.asia (45.122.156.254) by MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 08:56:43 +0000
X-Mailer: git-send-email 2.12.3
X-Originating-IP: [45.122.156.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4246d3-df27-4ebf-54c4-08d7a886ffd8
X-MS-TrafficTypeDiagnostic: CH2PR18MB3269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR18MB3269337BFAE7504934A62F41CF000@CH2PR18MB3269.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(2906002)(6486002)(1076003)(186003)(16526019)(6512007)(6506007)(66556008)(66946007)(66476007)(81156014)(2616005)(81166006)(956004)(26005)(8936002)(8676002)(6666004)(5660300002)(316002)(4326008)(86362001)(36756003)(52116002)(478600001)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3269;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNzT3fxB9TnIw3ByBg0wqdE9/RBaY1Pux6r6Qwso73i8tR3sNap4xeoJSvgRKHATjcGdQg9Iu9UqB/6AGhcBaIo9gQNRsyQj05cJv4KHg0F6T64oYVcBfYcYkYeCgTY75zUVhKtE+tgzOfD3FDxyerMXbc3SH8Wo3splVjyxdGegKMEp+657xY5qyJfsjFCVbJk5VhLVYnSwjRDr3ls86yv78ko085DU8261kln/zyUmN+XdnlSmx5sdRXI5cPB8nV2/aJ5c2BFRFtcXuogUyHiFbYnOKNv41o+7J/SeSjN1OWHqILEZqzwPQwNaIs9eRQpUgKUjF4NapokiOKe6VRY99MSUOobxBq74R8giCkGu5KOK9XxTcnYxHx3GYUUViotHI7oCNPCuDdMrQrB63Z4ehkXNveAENaS3qYyo48B3aaQbbUOnD+etenNV/FFOVEK2dm3FsJUHYqBL4YnXHrih5xlhbHlsHgX6R2SE7FKuTbnWJNUay5erGoU8slRj
X-MS-Exchange-AntiSpam-MessageData: KgY11nOWwdY/SvObCbbeoDdAOHUUzTwxnlABzd8nMIhFcXHn/3Oh53eLrjMfvSabF+O/wjVRlYB39j/VEgbzlk17DSgLY/ntH/da0QvQWv2eijOklDlc2WRjm/i4kat522wFG+vcSPN8HlYj1LYZtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4246d3-df27-4ebf-54c4-08d7a886ffd8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 08:56:47.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEdNPzO/8R8sY6VEXQpqnu8gGKbUrc3GYn9i+OrO6iUvAeRwXrwWEjOFiKxmfvC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3269
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing a cloned file triggers a kernel oops and the user-space
command process is also killed by the system.
The bug can be reproduced stably, e.g.
1)create a file under ocfs2 file system directory.
  journalctl -b > aa.txt
2)create a cloned file for this file.
  reflink aa.txt bb.txt
3)write the cloned file with dd command.
  dd if=/dev/zero of=bb.txt bs=512 count=1 conv=notrunc

The dd command is killed by the kernel, then you can see the oops
message via dmesg command.

[  463.875404] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  463.875413] #PF: supervisor read access in kernel mode
[  463.875416] #PF: error_code(0x0000) - not-present page
[  463.875418] PGD 0 P4D 0
[  463.875425] Oops: 0000 [#1] SMP PTI
[  463.875431] CPU: 1 PID: 2291 Comm: dd Tainted: G           OE     5.3.16-2-default
[  463.875433] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[  463.875500] RIP: 0010:ocfs2_refcount_cow+0xa4/0x5d0 [ocfs2]
[  463.875505] Code: 06 89 6c 24 38 89 eb f6 44 24 3c 02 74 be 49 8b 47 28
[  463.875508] RSP: 0018:ffffa2cb409dfce8 EFLAGS: 00010202
[  463.875512] RAX: ffff8b1ebdca8000 RBX: 0000000000000001 RCX: ffff8b1eb73a9df0
[  463.875515] RDX: 0000000000056a01 RSI: 0000000000000000 RDI: 0000000000000000
[  463.875517] RBP: 0000000000000001 R08: ffff8b1eb73a9de0 R09: 0000000000000000
[  463.875520] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  463.875522] R13: ffff8b1eb922f048 R14: 0000000000000000 R15: ffff8b1eb922f048
[  463.875526] FS:  00007f8f44d15540(0000) GS:ffff8b1ebeb00000(0000) knlGS:0000000000000000
[  463.875529] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  463.875532] CR2: 0000000000000028 CR3: 000000003c17a000 CR4: 00000000000006e0
[  463.875546] Call Trace:
[  463.875596]  ? ocfs2_inode_lock_full_nested+0x18b/0x960 [ocfs2]
[  463.875648]  ocfs2_file_write_iter+0xaf8/0xc70 [ocfs2]
[  463.875672]  new_sync_write+0x12d/0x1d0
[  463.875688]  vfs_write+0xad/0x1a0
[  463.875697]  ksys_write+0xa1/0xe0
[  463.875710]  do_syscall_64+0x60/0x1f0
[  463.875743]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  463.875758] RIP: 0033:0x7f8f4482ed44
[  463.875762] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00
[  463.875765] RSP: 002b:00007fff300a79d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  463.875769] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8f4482ed44
[  463.875771] RDX: 0000000000000200 RSI: 000055f771b5c000 RDI: 0000000000000001
[  463.875774] RBP: 0000000000000200 R08: 00007f8f44af9c78 R09: 0000000000000003
[  463.875776] R10: 000000000000089f R11: 0000000000000246 R12: 000055f771b5c000
[  463.875779] R13: 0000000000000200 R14: 0000000000000000 R15: 000055f771b5c000

This regression problem was introduced by commit e74540b28556 ("ocfs2:
protect extent tree in ocfs2_prepare_inode_for_write()").

Fixes: e74540b28556 ("ocfs2: protect extent tree in ocfs2_prepare_inode_for_write()").
Signed-off-by: Gang He <ghe@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/file.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9876db52913a..6cd5e4924e4d 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2101,17 +2101,15 @@ static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
 static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
 					    struct buffer_head **di_bh,
 					    int meta_level,
-					    int overwrite_io,
 					    int write_sem,
 					    int wait)
 {
 	int ret = 0;
 
 	if (wait)
-		ret = ocfs2_inode_lock(inode, NULL, meta_level);
+		ret = ocfs2_inode_lock(inode, di_bh, meta_level);
 	else
-		ret = ocfs2_try_inode_lock(inode,
-			overwrite_io ? NULL : di_bh, meta_level);
+		ret = ocfs2_try_inode_lock(inode, di_bh, meta_level);
 	if (ret < 0)
 		goto out;
 
@@ -2136,6 +2134,7 @@ static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
 
 out_unlock:
 	brelse(*di_bh);
+	*di_bh = NULL;
 	ocfs2_inode_unlock(inode, meta_level);
 out:
 	return ret;
@@ -2177,7 +2176,6 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 		ret = ocfs2_inode_lock_for_extent_tree(inode,
 						       &di_bh,
 						       meta_level,
-						       overwrite_io,
 						       write_sem,
 						       wait);
 		if (ret < 0) {
@@ -2233,13 +2231,13 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 							   &di_bh,
 							   meta_level,
 							   write_sem);
+			meta_level = 1;
+			write_sem = 1;
 			ret = ocfs2_inode_lock_for_extent_tree(inode,
 							       &di_bh,
 							       meta_level,
-							       overwrite_io,
-							       1,
+							       write_sem,
 							       wait);
-			write_sem = 1;
 			if (ret < 0) {
 				if (ret != -EAGAIN)
 					mlog_errno(ret);
-- 
2.12.3

