Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D651FC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71AD217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUFYz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:24:55 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:41640 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgAUFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:24:54 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Tue, 21 Jan 2020 05:22:44 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 21 Jan 2020 05:02:28 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 21 Jan 2020 05:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuQzNe9mr26UOawzhkF3N9HuZrRVdhot09MPPeTzttA76MGENAymaooXK838G6MeNdvl4/O458YjxNYmm0bPHA0pbU6YE3NVaKtXEDtd8hd44NTtDLYOKJ3NQcTBy43UfkeLOkUKpeym0NZo+M7W/GO0/5JKd6ZGdlkyRS9VuCwro+gMJ0vB1raK3wPzvkVmWzkZ+fWLLi0j44FRdSzOwvFtaQFwcURVQzCbVQBT61+8Xl6Xch6LSr8sr75HZ3VtdX0YYH2g7xkrNgzaQolzhvZlKxwMRfibsTyrdiCTf5P42Nk9Jg/yWp6BmhsClbKmGi3WdYCQzs/EMHVjn2hZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voH8WzTyI7KvqQ1Yy1irbPB4Mk7nilHl2iTeY5nlkRk=;
 b=OfSQRBlbu7jLlXjRXdChefViEveD+lqD51ICS8yaY2/Pi5MZuulM++thaCkUZHvujtU1UUBMvuTTl9V3s81cJ9+OxgZXfI9feOjJgN0BuBZ0+3Atod29V+CTlkPWDR58Vv1RksHFqQy7kzfkwKZ7v03YmcVurnwbTLpe+dyDhmkYiw737TZubhjrxiApsSOFSmaJmFf32Kk+ZpOt1OYQu5kagf7yXpAp+BDlSXd7z+AC8SA6TZ/lvnxD2AmeZGQtl3VZIT84ZJ4acOxQA8WnIIOwQsO0JRB74XuQQSeX+eW7TTCA0HOC8tHDhFaZZyZrhRm837aelWuPdtbqDvR3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3334.namprd18.prod.outlook.com (52.132.247.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 05:02:25 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::18a6:4bd:28d2:67de]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::18a6:4bd:28d2:67de%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 05:02:25 +0000
Received: from ghe-pc.suse.asia (45.122.156.254) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.14 via Frontend Transport; Tue, 21 Jan 2020 05:02:22 +0000
From:   Gang He <GHe@suse.com>
To:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
CC:     Gang He <GHe@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Topic: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Index: AQHV0Bf49UeZZZUyKki8pGxA20UtZA==
Date:   Tue, 21 Jan 2020 05:02:25 +0000
Message-ID: <20200121050153.13290-1-ghe@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To CH2PR18MB3206.namprd18.prod.outlook.com
 (2603:10b6:610:14::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.12.3
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 757393cc-617f-4391-9482-08d79e2f1b01
x-ms-traffictypediagnostic: CH2PR18MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3334968958204310C6F30AC6CF0D0@CH2PR18MB3334.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(6506007)(6512007)(64756008)(36756003)(478600001)(66476007)(66556008)(6486002)(81156014)(71200400001)(86362001)(8676002)(5660300002)(26005)(66946007)(1076003)(8936002)(81166006)(4326008)(186003)(16526019)(52116002)(54906003)(66446008)(2906002)(2616005)(956004)(110136005)(316002)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3334;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0W9jQhQ/+J0LgoqqWC8T4aZv7srj3/bcpJqzmP1jycBbnoBd3vgZ/AhFfnGUhLeN81gFIVetGQHROXQID78Osyt2sQA5SC7yWgYS/7Ke0r0M93ML/CJZs/uNIiLygp5lvQU0QwKm0xQIlcFuHzlTIRPTdTpkDkjZzfVWrP/MTMDIoSjFIneCXSADlwe2v1hhJHNC7L7TMa2UwxqjX8uSkMqEOPrqgNVXSBmfdAkMpemSjhIOb8wywDS5F2lKP6jphn5NW3krzqhCYHLkaCKM1c2+CLtqAnaJZuMgbTRZoM3PNdMxWM48yBtjczgsOffDsYdQ9NU0FX1AycoY50VXS30C1ElJsc07nrbkBXx65AKGonzRHhtBR4i0M0nmUS5yhAH0xeYhjVDx3l4XevD/1stKoc29U4Ir5Xc/Qmw0lB37BKtGI7O5g31uw0IBkgdA3LU2zfY1TKveoLkui68S1jqC0uaz6GLNVxhBCblGAFH8f+SxsthoJWQN7hJ9SwZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 757393cc-617f-4391-9482-08d79e2f1b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 05:02:25.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONiykd3UJ7Medyn3LV9i6zDpW7bFXvoqlEmZ2A6HRP0arTvnh49B759hXfjIL7dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3334
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

