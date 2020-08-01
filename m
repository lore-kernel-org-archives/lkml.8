Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FCDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EFD20725
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHAGOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 02:14:35 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53740 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgHAGOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 02:14:35 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0716C7Vd028182
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 31 Jul 2020 23:12:38 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 23:12:15 -0700
From:   <qiang.zhang@windriver.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: seq: KASAN: use-after-free Read in delete_and_unsubscribe_port
Date:   Sat, 1 Aug 2020 14:24:03 +0800
Message-ID: <20200801062403.8005-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

There is a potential race window,when a task acquire "src->list_mutex"
write sem,traverse the linked list to find "subs" objects through
parameter "info" in snd_seq_port_disconnect and then release this
write sem, before this task acquire write sem again,this write sem
may be acquired by another task, and get the same "subs" object through
the same "info" before, it could happen "use-after-free" later, so a
simple solution is to delete the object from the linked list when it
is found.

BUG: KASAN: use-after-free in list_empty include/linux/list.h:282 [inline]
BUG: KASAN: use-after-free in delete_and_unsubscribe_port+0x8b/0x450
sound/core/seq/seq_ports.c:530
Read of size 8 at addr ffff888098523060 by task syz-executor.0/7202

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 list_empty include/linux/list.h:282 [inline]
 delete_and_unsubscribe_port+0x8b/0x450 sound/core/seq/seq_ports.c:530
 snd_seq_port_disconnect+0x568/0x610 sound/core/seq/seq_ports.c:612
 snd_seq_ioctl_unsubscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_oss_midi_close+0x397/0x620 sound/core/seq/oss/seq_oss_midi.c:405
 snd_seq_oss_synth_reset+0x335/0x8b0 sound/core/seq/oss/seq_oss_synth.c:406
 snd_seq_oss_reset+0x5b/0x250 sound/core/seq/oss/seq_oss_init.c:435
 snd_seq_oss_ioctl+0x5c2/0x1090 sound/core/seq/oss/seq_oss_ioctl.c:93
 odev_ioctl+0x51/0x70 sound/core/seq/oss/seq_oss.c:174
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:760
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Allocated by task 7202:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 snd_seq_port_connect+0x66/0x460 sound/core/seq/seq_ports.c:553
 snd_seq_ioctl_subscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1484
 snd_seq_oss_midi_open+0x4db/0x830 sound/core/seq/oss/seq_oss_midi.c:364
 snd_seq_oss_synth_setup_midi+0x108/0x510 sound/core/seq/oss/seq_oss_synth.c:269
 snd_seq_oss_open+0x899/0xe90 sound/core/seq/oss/seq_oss_init.c:261
 odev_open+0x5e/0x90 sound/core/seq/oss/seq_oss.c:125
 chrdev_open+0x498/0x580 fs/char_dev.c:414
 do_dentry_open+0x813/0x1070 fs/open.c:828
 do_open fs/namei.c:3243 [inline]
 path_openat+0x278d/0x37f0 fs/namei.c:3360
 do_filp_open+0x191/0x3a0 fs/namei.c:3387
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 7203:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 snd_seq_port_disconnect+0x570/0x610 sound/core/seq/seq_ports.c:614
 snd_seq_ioctl_unsubscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_oss_midi_close+0x397/0x620 sound/core/seq/oss/seq_oss_midi.c:405
 snd_seq_oss_synth_reset+0x335/0x8b0 sound/core/seq/oss/seq_oss_synth.c:406
 snd_seq_oss_reset+0x5b/0x250 sound/core/seq/oss/seq_oss_init.c:435
 snd_seq_oss_ioctl+0x5c2/0x1090 sound/core/seq/oss/seq_oss_ioctl.c:93
 odev_ioctl+0x51/0x70 sound/core/seq/oss/seq_oss.c:174
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:760
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888098523000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 96 bytes inside of
 128-byte region [ffff888098523000, ffff888098523080)
The buggy address belongs to the page:
page:ffffea00026148c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002613988 ffffea000262c648 ffff8880aa400700
raw: 0000000000000000 ffff888098523000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888098522f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888098522f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888098523000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888098523080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888098523100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Reported-by: syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 sound/core/seq/seq_ports.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 83be6b982a87..9675d3fc146e 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -533,8 +533,7 @@ static void delete_and_unsubscribe_port(struct snd_seq_client *client,
 	grp->exclusive = 0;
 	write_unlock_irq(&grp->list_lock);
 
-	if (!empty)
-		unsubscribe_port(client, port, grp, &subs->info, ack);
+	unsubscribe_port(client, port, grp, &subs->info, ack);
 	up_write(&grp->list_mutex);
 }
 
@@ -599,6 +598,7 @@ int snd_seq_port_disconnect(struct snd_seq_client *connector,
 	list_for_each_entry(subs, &src->list_head, src_list) {
 		if (match_subs_info(info, &subs->info)) {
 			atomic_dec(&subs->ref_count); /* mark as not ready */
+			list_del_init(&subs->src_list);
 			err = 0;
 			break;
 		}
-- 
2.26.2

