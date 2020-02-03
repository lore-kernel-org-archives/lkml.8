Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C69C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94B720661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBCCTB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:19:01 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:47555 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgBCCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:19:00 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Mon,  3 Feb 2020 02:17:31 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 02:17:39 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 02:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1H81m7168Cr39JjAf3gDYx8MGAXJe6qSB/REJDAElIzktvOCtoEi8sJDUpogafR/p7B0fMdewV8O9uZgrYfm3RPfjQSn92NDcOsL3NaC9QQ2ygiYM+3hB5EwIXaJT8PcjQzv7hwLgMvBB/dYvA/toFKyYMzl4vTDrO6ZPIiaIj+F0Rzz4tWx+SRDi5kGNlXOnD85W0tvIefNyT+SUVmF78nGwnUGjdsa4CxAAg4/bKYFgBeoOtzMpYlWwlvDMHzf3pdgThi3nQbsrFRsvO1HbKxv6B9lVrdTTi7q/9+SeY8zb1lsuyJXpmTihPvvRIsm9XjCO3smD//brtkalrpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFBv4oQBf8PR+s7CO8jAmcXGyMcFQOla/kMC0D75sGg=;
 b=UVlGApjDqlH7TtQSKUMCvPSxoLAGqHktRBtko4DrHVNoDKVT921jCkPJPIdXH8TyfFacJjtxdtQMS0LfZ2dc7LRehF9O1CXKTNevDv0WfjaWN02AzCIr+cDNnNof+6tVVJtF+Bp0qlDcw1MAe4IUnjFR6H26Pfbr753fXn3w/clPTBaveDKjQORs2HHRTQ+I2laJzNlt8FZgUkKRMaAOP6asc6JYBtC6wk6hS7KeVRYo/NsqBXXcId0ZeApCixl7JNNbKSeEwCLx8kpTJ3wVY/pEN3MY04JckOngq/09ddsneWMwEtYGJwzjuklxdYwTwiwxJEx/Q8f0ZDSezc0uuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3094.namprd18.prod.outlook.com (52.132.247.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 02:17:38 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::1138:c9b7:e776:5c77%3]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 02:17:37 +0000
From:   Gang He <GHe@suse.com>
To:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "gechangwei@live.cn" <gechangwei@live.cn>,
        Shuning Zhang <sunny.s.zhang@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Topic: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Index: AQHV0Bf49UeZZZUyKki8pGxA20UtZKgIy58+
Date:   Mon, 3 Feb 2020 02:17:37 +0000
Message-ID: <CH2PR18MB3206F418382332EB25130477CF000@CH2PR18MB3206.namprd18.prod.outlook.com>
References: <20200121050153.13290-1-ghe@suse.com>
In-Reply-To: <20200121050153.13290-1-ghe@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-originating-ip: [114.246.34.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c2a3009-9111-4c56-a4af-08d7a84f3d1e
x-ms-traffictypediagnostic: CH2PR18MB3094:
x-microsoft-antispam-prvs: <CH2PR18MB3094E04A94374877682F9F17CF000@CH2PR18MB3094.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(66476007)(64756008)(66556008)(66446008)(52536014)(33656002)(66946007)(91956017)(76116006)(5660300002)(9686003)(4326008)(54906003)(110136005)(7696005)(55016002)(316002)(186003)(26005)(6506007)(53546011)(86362001)(478600001)(81156014)(81166006)(8936002)(71200400001)(8676002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3094;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZuBdmCSDbJG2JHmBre9s47UYjIFSRT62z5+gABDGIRgzi6CfcX6UgscjPpE0y0ay9U3v3HzeLj6xz4VUOjnGQIbZySA5Br8QrW6A0Q7ctxdg77Sn8Qe3sPXRidInYWRytli+llPccaOy+4CGmJbmr5C34+DoHv1Abiuy/TFq/LoaUWo0JSNvCMqJ4GM46tVSNpL4rVxIco+a72BU0bYCexCCo3Z9uQDXPOVjZPNipREyn2tgI7egnBopeReN7/nSFqL/ESg992CdZdCcKneU40x7BeOIdlV23BYVyIOtsMrbvt4m/N6E6uiopbpPCgMoibz6qD4d2IQ7laOp2mUBx4Ch8IWm9jJtpZGTo8NSi95jVwTVeFMT+viGM0+X7zSwUFlqkpp0YviLOqfS1VwkLs42vqL0jQ9f0xDUnWwrofo+5/WO22E1lYKfPr7sf94
x-ms-exchange-antispam-messagedata: Q0EEGAflRKyDIATdDZh9w6SxfLjTtfqrOXmWBTrxV6RbTEjXLT23aceeVmsU3otSUvOfWpyy9lpv1qqg9mmwjym2390Noqk9jVqbgfdV1JsJHVG7NkVJveyKqFuWj6AwVfE3dPH2SV2GbQTMLeIWLw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2a3009-9111-4c56-a4af-08d7a84f3d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 02:17:37.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fuNb2O8UaxOmWbyY8J1lIazk0FBlc7NbQGfDYtF+gDhx+T2btMEYC14XC5Q7AQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3094
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joseph, Changwei, Sunny and all,

Could you help to review this patch? 
This patch will fix the oops problem caused by write ocfs2 clone files.
The root cause is inode buffer head is NULL when calling ocfs2_refcount_cow.
Secondly, we should use EX meta lock when calling ocfs2_refcount_cow.

Thanks a lot.
Gang   

________________________________________
From: Gang He <GHe@suse.com>
Sent: Tuesday, January 21, 2020 1:02 PM
To: mark@fasheh.com; jlbec@evilplan.org; joseph.qi@linux.alibaba.com
Cc: Gang He; linux-kernel@vger.kernel.org; ocfs2-devel@oss.oracle.com; akpm@linux-foundation.org
Subject: [PATCH] ocfs2: fix the oops problem when write cloned file

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
-                                           int overwrite_io,
                                            int write_sem,
                                            int wait)
 {
        int ret = 0;

        if (wait)
-               ret = ocfs2_inode_lock(inode, NULL, meta_level);
+               ret = ocfs2_inode_lock(inode, di_bh, meta_level);
        else
-               ret = ocfs2_try_inode_lock(inode,
-                       overwrite_io ? NULL : di_bh, meta_level);
+               ret = ocfs2_try_inode_lock(inode, di_bh, meta_level);
        if (ret < 0)
                goto out;

@@ -2136,6 +2134,7 @@ static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,

 out_unlock:
        brelse(*di_bh);
+       *di_bh = NULL;
        ocfs2_inode_unlock(inode, meta_level);
 out:
        return ret;
@@ -2177,7 +2176,6 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
                ret = ocfs2_inode_lock_for_extent_tree(inode,
                                                       &di_bh,
                                                       meta_level,
-                                                      overwrite_io,
                                                       write_sem,
                                                       wait);
                if (ret < 0) {
@@ -2233,13 +2231,13 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
                                                           &di_bh,
                                                           meta_level,
                                                           write_sem);
+                       meta_level = 1;
+                       write_sem = 1;
                        ret = ocfs2_inode_lock_for_extent_tree(inode,
                                                               &di_bh,
                                                               meta_level,
-                                                              overwrite_io,
-                                                              1,
+                                                              write_sem,
                                                               wait);
-                       write_sem = 1;
                        if (ret < 0) {
                                if (ret != -EAGAIN)
                                        mlog_errno(ret);
--
2.12.3

