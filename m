Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D703C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E555520857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4aJLxat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbgDAKmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:42:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgDAKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ST6XDSR3yTn2immt/fC3eihM79WPBVg+TAPpVKsE9xc=;
        b=d4aJLxatZUCJVEwi+T5JujGdW5Zhdorm3Y7+NDYyW8JmlnQK4jpjcjGjK0HPXtOThZ0s0c
        TjN0UEfEN50QY0hbQxOIVhtXBFgzo4kPDUHkGjPc2zq2CLN9y4i4l7IMbQCCQy58mMGErx
        qVo/bVzLSzQ6FqcmupHJFc+NrxZ1A/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-umh-gh4AM2qG70pmgMyRDw-1; Wed, 01 Apr 2020 06:42:10 -0400
X-MC-Unique: umh-gh4AM2qG70pmgMyRDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3DED107ACC9;
        Wed,  1 Apr 2020 10:42:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E13C100EBA6;
        Wed,  1 Apr 2020 10:42:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Yiqian Wei <yiwei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 1/2] mm/page_alloc: fix RCU stalls during deferred page initialization
Date:   Wed,  1 Apr 2020 12:41:55 +0200
Message-Id: <20200401104156.11564-2-david@redhat.com>
In-Reply-To: <20200401104156.11564-1-david@redhat.com>
References: <20200401104156.11564-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DEFERRED_STRUCT_PAGE_INIT and without CONFIG_PREEMPT, it can
happen that we get RCU stalls detected when booting up.

[   60.474005] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   60.475000] rcu:  1-...0: (0 ticks this GP) idle=3D02a/1/0x40000000000=
00000 softirq=3D1/1 fqs=3D15000
[   60.475000] rcu:  (detected by 0, t=3D60002 jiffies, g=3D-1199, q=3D1)
[   60.475000] Sending NMI from CPU 0 to CPUs 1:
[    1.760091] NMI backtrace for cpu 1
[    1.760091] CPU: 1 PID: 20 Comm: pgdatinit0 Not tainted 4.18.0-147.9.1=
.el8_1.x86_64 #1
[    1.760091] Hardware name: Red Hat KVM, BIOS 1.13.0-1.module+el8.2.0+5=
520+4e5817f3 04/01/2014
[    1.760091] RIP: 0010:__init_single_page.isra.65+0x10/0x4f
[    1.760091] Code: 48 83 cf 63 48 89 f8 0f 1f 40 00 48 89 c6 48 89 d7 e=
8 6b 18 80 ff 66 90 5b c3 31 c0 b9 10 00 00 00 49 89 f8 48 c1 e6 33 f3 ab=
 <b8> 07 00 00 00 48 c1 e2 36 41 c7 40 34 01 00 00 00 48 c1 e0 33 41
[    1.760091] RSP: 0000:ffffba783123be40 EFLAGS: 00000006
[    1.760091] RAX: 0000000000000000 RBX: fffffad34405e300 RCX: 000000000=
0000000
[    1.760091] RDX: 0000000000000000 RSI: 0010000000000000 RDI: fffffad34=
405e340
[    1.760091] RBP: 0000000033f3177e R08: fffffad34405e300 R09: 000000000=
0000002
[    1.760091] R10: 000000000000002b R11: ffff98afb691a500 R12: 000000000=
0000002
[    1.760091] R13: 0000000000000000 R14: 000000003f03ea00 R15: 000000003=
e10178c
[    1.760091] FS:  0000000000000000(0000) GS:ffff9c9ebeb00000(0000) knlG=
S:0000000000000000
[    1.760091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.760091] CR2: 00000000ffffffff CR3: 000000a1cf20a001 CR4: 000000000=
03606e0
[    1.760091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[    1.760091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[    1.760091] Call Trace:
[    1.760091]  deferred_init_pages+0x8f/0xbf
[    1.760091]  deferred_init_memmap+0x184/0x29d
[    1.760091]  ? deferred_free_pages.isra.97+0xba/0xba
[    1.760091]  kthread+0x112/0x130
[    1.760091]  ? kthread_flush_work_fn+0x10/0x10
[    1.760091]  ret_from_fork+0x35/0x40
[   89.123011] node 0 initialised, 1055935372 pages in 88650ms

The issue becomes visible when having a lot of memory (e.g., 4TB)
assigned to a single NUMA node - a system that can easily be created
using QEMU. Inside VMs on a hypervisor with quite some memory
overcommit, this is fairly easy to trigger.

Adding the cond_resched() makes RCU happy.

Reported-by: Yiqian Wei <yiwei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ca1453204e66..084cabffc90d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1877,6 +1877,7 @@ static int __init deferred_init_memmap(void *data)
 			prev_nr_pages =3D nr_pages;
 			pgdat->first_deferred_pfn =3D spfn;
 			pgdat_resize_unlock(pgdat, &flags);
+			cond_resched();
 			goto again;
 		}
 	}
--=20
2.25.1

