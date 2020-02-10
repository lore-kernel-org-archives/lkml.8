Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF0C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A50420715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGVoSkXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBJUsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:48:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727508AbgBJUsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581367685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TW0N6xq76UNJjvvgB9CfwhTzvPEFkdsGxeK1N99LRqw=;
        b=dGVoSkXsQd7XNCdQj2tZDu+KKFFsGdcHSrtwHxfmeuCzM2wB8bbYLA8FKAZ9JbJVCzhlKZ
        3CWryS21XIESImN1KrlIzVbmxu9CzpkB1ia0uAktroIsCJUpeUZ9FRhTrrZSDy2Kv0m+RV
        4bG7d55+D/rFvekGQQUV6QwmpNH8zYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-pyGTfwNOOcejobKxztQ4og-1; Mon, 10 Feb 2020 15:48:01 -0500
X-MC-Unique: pyGTfwNOOcejobKxztQ4og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D408A100551A;
        Mon, 10 Feb 2020 20:47:59 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE0F087B34;
        Mon, 10 Feb 2020 20:47:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] mm/slub: Fix potential deadlock problem in slab_attr_store()
Date:   Mon, 10 Feb 2020 15:46:51 -0500
Message-Id: <20200210204651.21674-4-longman@redhat.com>
In-Reply-To: <20200210204651.21674-1-longman@redhat.com>
References: <20200210204651.21674-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was seen:

    [  176.241923] ======================================================
    [  176.241924] WARNING: possible circular locking dependency detected
    [  176.241926] 4.18.0-172.rt13.29.el8.x86_64+debug #1 Not tainted
    [  176.241927] ------------------------------------------------------
    [  176.241929] slub_cpu_partia/5371 is trying to acquire lock:
    [  176.241930] ffffffffa0b83718 (slab_mutex){+.+.}, at: slab_attr_store+0x6b/0xe0
    [  176.241941] but task is already holding lock:
    [  176.241942] ffff88bb6d8b83c8 (kn->count#103){++++}, at: kernfs_fop_write+0x1cc/0x400
    [  176.241947] which lock already depends on the new lock.

    [  176.241949] the existing dependency chain (in reverse order) is:
    [  176.241949] -> #1 (kn->count#103){++++}:
    [  176.241955]        __kernfs_remove+0x616/0x800
    [  176.241957]        kernfs_remove_by_name_ns+0x3e/0x80
    [  176.241959]        sysfs_slab_add+0x1c6/0x330
    [  176.241961]        __kmem_cache_create+0x15f/0x1b0
    [  176.241964]        create_cache+0xe1/0x220
    [  176.241966]        kmem_cache_create_usercopy+0x1a3/0x260
    [  176.241967]        kmem_cache_create+0x12/0x20
    [  176.242076]        mlx5_init_fs+0x18d/0x1a00 [mlx5_core]
    [  176.242100]        mlx5_load_one+0x3b4/0x1730 [mlx5_core]
    [  176.242124]        init_one+0x901/0x11b0 [mlx5_core]
    [  176.242127]        local_pci_probe+0xd4/0x180
    [  176.242131]        work_for_cpu_fn+0x51/0xa0
    [  176.242133]        process_one_work+0x91a/0x1ac0
    [  176.242134]        worker_thread+0x536/0xb40
    [  176.242136]        kthread+0x30c/0x3d0
    [  176.242140]        ret_from_fork+0x27/0x50
    [  176.242140] -> #0 (slab_mutex){+.+.}:
    [  176.242145]        __lock_acquire+0x22cb/0x48c0
    [  176.242146]        lock_acquire+0x134/0x4c0
    [  176.242148]        _mutex_lock+0x28/0x40
    [  176.242150]        slab_attr_store+0x6b/0xe0
    [  176.242151]        kernfs_fop_write+0x251/0x400
    [  176.242154]        vfs_write+0x157/0x460
    [  176.242155]        ksys_write+0xb8/0x170
    [  176.242158]        do_syscall_64+0x13c/0x710
    [  176.242160]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
    [  176.242161]
                   other info that might help us debug this:

    [  176.242161]  Possible unsafe locking scenario:

    [  176.242162]        CPU0                    CPU1
    [  176.242163]        ----                    ----
    [  176.242163]   lock(kn->count#103);
    [  176.242165]                                lock(slab_mutex);
    [  176.242166]                                lock(kn->count#103);
    [  176.242167]   lock(slab_mutex);
    [  176.242169]
                    *** DEADLOCK ***

    [  176.242170] 3 locks held by slub_cpu_partia/5371:
    [  176.242170]  #0: ffff888705e3a800 (sb_writers#4){.+.+}, at: vfs_write+0x31c/0x460
    [  176.242174]  #1: ffff889aeec4d658 (&of->mutex){+.+.}, at: kernfs_fop_write+0x1a9/0x400
    [  176.242177]  #2: ffff88bb6d8b83c8 (kn->count#103){++++}, at: kernfs_fop_write+0x1cc/0x400
    [  176.242180]
                   stack backtrace:
    [  176.242183] CPU: 36 PID: 5371 Comm: slub_cpu_partia Not tainted 4.18.0-172.rt13.29.el8.x86_64+debug #1
    [  176.242184] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RDY1005C 11/22/2019
    [  176.242185] Call Trace:
    [  176.242190]  dump_stack+0x9a/0xf0
    [  176.242193]  check_noncircular+0x317/0x3c0
    [  176.242195]  ? print_circular_bug+0x1e0/0x1e0
    [  176.242199]  ? native_sched_clock+0x32/0x1e0
    [  176.242202]  ? sched_clock+0x5/0x10
    [  176.242205]  ? sched_clock_cpu+0x238/0x340
    [  176.242208]  __lock_acquire+0x22cb/0x48c0
    [  176.242213]  ? trace_hardirqs_on+0x10/0x10
    [  176.242215]  ? trace_hardirqs_on+0x10/0x10
    [  176.242218]  lock_acquire+0x134/0x4c0
    [  176.242220]  ? slab_attr_store+0x6b/0xe0
    [  176.242223]  _mutex_lock+0x28/0x40
    [  176.242225]  ? slab_attr_store+0x6b/0xe0
    [  176.242227]  slab_attr_store+0x6b/0xe0
    [  176.242229]  ? sysfs_file_ops+0x160/0x160
    [  176.242230]  kernfs_fop_write+0x251/0x400
    [  176.242232]  ? __sb_start_write+0x26a/0x3f0
    [  176.242234]  vfs_write+0x157/0x460
    [  176.242237]  ksys_write+0xb8/0x170
    [  176.242239]  ? __ia32_sys_read+0xb0/0xb0
    [  176.242242]  ? do_syscall_64+0xb9/0x710
    [  176.242245]  do_syscall_64+0x13c/0x710
    [  176.242247]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf

In order to fix this circular lock dependency problem, we need to do a
mutex_trylock(&slab_mutex) in slab_attr_store() for CPU0 above. A simple
trylock, however, is easy to fail causing user dissatisfaction. So the
new mutex_timed_lock() function is now used to do a trylock with a
100ms timeout.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 17dc00e33115..495bec9b66ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobject *kobj,
 	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
 		struct kmem_cache *c;
 
-		mutex_lock(&slab_mutex);
+		/*
+		 * Timeout after 100ms
+		 */
+		if (mutex_timed_lock(&slab_mutex, 100) < 0)
+			return -EBUSY;
+
 		if (s->max_attr_size < len)
 			s->max_attr_size = len;
 
-- 
2.18.1

