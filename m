Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24CA206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFBLvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgFBLvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5EF5B15853ECC4BC46B0;
        Tue,  2 Jun 2020 19:50:57 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 19:50:51 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>
CC:     <akpm@linux-foundation.org>, <khlebnikov@yandex-team.ru>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] mm/slub: fix a memory leak in sysfs_slab_add()
Date:   Tue, 2 Jun 2020 19:50:33 +0800
Message-ID: <20200602115033.1054-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzkaller reports for memory leak when kobject_init_and_add()
returns an error in the function sysfs_slab_add() [1]

When this happened, the function kobject_put() is not called for the
corresponding kobject, which potentially leads to memory leak.

This patch fixes the issue by calling kobject_put() even if
kobject_init_and_add() fails.

[1]
BUG: memory leak
unreferenced object 0xffff8880a6d4be88 (size 8):
  comm "syz-executor.3", pid 946, jiffies 4295772514 (age 18.396s)
  hex dump (first 8 bytes):
    70 69 64 5f 33 00 ff ff                          pid_3...
  backtrace:
    [<00000000a0980095>] kstrdup+0x35/0x70 mm/util.c:60
    [<00000000ef0cff3f>] kstrdup_const+0x3d/0x50 mm/util.c:82
    [<00000000e2461486>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
    [<000000005d749e93>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:289
    [<0000000094e31519>] kobject_add_varg lib/kobject.c:384 [inline]
    [<0000000094e31519>] kobject_init_and_add+0xd8/0x170 lib/kobject.c:473
    [<0000000060f13e32>] sysfs_slab_add+0x1d8/0x290 mm/slub.c:5811
    [<00000000fe1d9a22>] __kmem_cache_create+0x50a/0x570 mm/slub.c:4384
    [<000000006a71a1b4>] create_cache+0x113/0x1e0 mm/slab_common.c:407
    [<0000000089491438>] kmem_cache_create_usercopy+0x1a1/0x260 mm/slab_common.c:505
    [<000000008c992595>] kmem_cache_create+0xd/0x10 mm/slab_common.c:564
    [<000000005320c4b6>] create_pid_cachep kernel/pid_namespace.c:54 [inline]
    [<000000005320c4b6>] create_pid_namespace kernel/pid_namespace.c:96 [inline]
    [<000000005320c4b6>] copy_pid_ns+0x77c/0x8f0 kernel/pid_namespace.c:148
    [<00000000fc8e1a2b>] create_new_namespaces+0x26b/0xa30 kernel/nsproxy.c:95
    [<0000000080f0c9a5>] unshare_nsproxy_namespaces+0xa7/0x1e0 kernel/nsproxy.c:229
    [<0000000007e05aea>] ksys_unshare+0x3d2/0x770 kernel/fork.c:2969
    [<00000000e04c8e4b>] __do_sys_unshare kernel/fork.c:3037 [inline]
    [<00000000e04c8e4b>] __se_sys_unshare kernel/fork.c:3035 [inline]
    [<00000000e04c8e4b>] __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3035
    [<000000005c4707c7>] do_syscall_64+0xa1/0x530 arch/x86/entry/common.c:295

Fixes: 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index b762450f..63bd39c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5809,8 +5809,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
 
 	s->kobj.kset = kset;
 	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
-	if (err)
+	if (err) {
+		kobject_put(&s->kobj);
 		goto out;
+	}
 
 	err = sysfs_create_group(&s->kobj, &slab_attr_group);
 	if (err)
-- 
1.8.3.1

