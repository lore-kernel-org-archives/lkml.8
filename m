Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C74D24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ps/fWWDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:51:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:51:18 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MJp7bH011508
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:51:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=wHhKJrfLWj6MpxpkyhZgbVzVb0z1UthyV/WVtIZcjSE=;
 b=Ps/fWWDjRfFarxPi8X3RqDWhMZDyNYcc2JQAM/eI/as1A1/eJDATzWVvgLmoCRAk9LBg
 tEspgfC+SOayITsaVcizdu+SMLnIDHVlg8HD0/PqMmKzgz2yXEAf/KKSOM8QijWDB9Km
 oHw56CqvRQtzxDkNeme0Nh+pHc1rPa2m+VY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xp7375k8p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:51:13 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 11:50:47 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id EF83062E217A; Wed, 22 Jan 2020 11:50:41 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Date:   Wed, 22 Jan 2020 11:50:27 -0800
Message-ID: <20200122195027.2112449-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 suspectscore=1 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup events are always installed in the cpuctx. However, when it is not
installed via IPI, list_update_cgroup_event() adds it to cpuctx of current
CPU, which triggers the following with CONFIG_DEBUG_LIST:

[   31.776974] ------------[ cut here ]------------
[   31.777570] list_add double add: new=ffff888ff7cf0db0, prev=ffff888ff7ce82f0, next=ffff888ff7cf0db0.
[   31.778737] WARNING: CPU: 3 PID: 1186 at lib/list_debug.c:31 __list_add_valid+0x67/0x70
[   31.779745] Modules linked in:
[   31.780138] CPU: 3 PID: 1186 Comm: perf Tainted: G        W         5.5.0-rc6+ #3962
[   31.781125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
[   31.782199] RIP: 0010:__list_add_valid+0x67/0x70
[   31.782774] Code: c1 4c 89 c6 48 c7 c7 f8 cd 57 82 e8 43 a0 a4 ff 0f 0b 31 c0 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 48 ce 57 82 e8 29 a0 a4 ff <0f> 0b 31 c0 c3 0f 1f 40 00 48 b9 00 01 00 00 00 00 ad de 48 8b 07
[   31.785066] RSP: 0018:ffffc900013ffdb8 EFLAGS: 00010086
[   31.785713] RAX: 0000000000000000 RBX: ffff888d5bb4a000 RCX: 0000000000000007
[   31.786596] RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff888ff7cd8870
[   31.787471] RBP: ffff888ff7db0c40 R08: 0000000000001b3b R09: 0000000000000067
[   31.788352] R10: ffff888ff7db0c90 R11: ffffc900013ffc65 R12: ffff888ff7cf0c40
[   31.789229] R13: ffff888ff7ce82f0 R14: ffff888ff7cf0db0 R15: ffff888ff7cf0db0
[   31.790115] FS:  00007f14cd1557c0(0000) GS:ffff888ff7cc0000(0000) knlGS:0000000000000000
[   31.791111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.791824] CR2: 00007f675e3ace60 CR3: 0000000d55e76006 CR4: 00000000003606e0
[   31.792703] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.793583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   31.794461] Call Trace:
[   31.794776]  list_add_event+0xe5/0x230
[   31.795247]  perf_install_in_context+0x155/0x1f0
[   31.795819]  ? anon_inode_getfile+0x7f/0xd0
[   31.796342]  __do_sys_perf_event_open+0x323/0xd60
[   31.796921]  do_syscall_64+0x55/0x1c0
[   31.797384]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   31.798008] RIP: 0033:0x7f14ca4a33e9
[   31.798460] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6f 9a 2c 00 f7 d8 64 89 01 48
[   31.800729] RSP: 002b:00007ffeaf16e5a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   31.801655] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f14ca4a33e9
[   31.802536] RDX: 0000000000000006 RSI: 0000000000000003 RDI: 0000000001053fd8
[   31.803412] RBP: 00007ffeaf16e670 R08: 000000000000000c R09: 000000000000000c
[   31.804286] R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000ffffffff
[   31.805160] R13: 0000000000000006 R14: 0000000001053af0 R15: 0000000001053fc0
[   31.806031] ---[ end trace ef48f280582d1897 ]---

To reproduce this, we can simply run:
  perf stat -e cs -a &
  perf stat -e cs -G anycgroup

Fix this by installing it to cpuctx that contains event->ctx, and the
proper cgrp_cpuctx_list.

Fixes: db0503e4f675 ("perf/core: Optimize perf_install_in_event()")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d25f2de45996..2248a6090a5f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -951,9 +951,9 @@ list_update_cgroup_event(struct perf_event *event,
 
 	/*
 	 * Because cgroup events are always per-cpu events,
-	 * this will always be called from the right CPU.
+	 * @ctx == &cpuctx->ctx.
 	 */
-	cpuctx = __get_cpu_context(ctx);
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
 
 	/*
 	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
@@ -979,7 +979,8 @@ list_update_cgroup_event(struct perf_event *event,
 
 	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
 	if (add)
-		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
+		list_add(cpuctx_entry,
+			 per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 	else
 		list_del(cpuctx_entry);
 }
-- 
2.17.1

