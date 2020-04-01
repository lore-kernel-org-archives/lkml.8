Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EAB2080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMpvmJIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgDAKmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:42:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732196AbgDAKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kpk8Ci93jpDTnV7e6hR75YJUex/KNBqI974L9QpVbkU=;
        b=SMpvmJIu02gsfzhldbBMxR2hIdVvSgwjMFlp0m+asqeXkasM7fEtORWQkKwX8zbKDy06ut
        qYAC/BMoTg0QzMu5PwaFr0N6ZqM/jzTFfILB+yXjUWGr0XTvymsc1FwUg2QvDnTdUQdjVI
        Kct5K9elh8Ineh08x38QPzam4fdIX04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-HNO-l5K-NauRnN8LzjEdGw-1; Wed, 01 Apr 2020 06:42:14 -0400
X-MC-Unique: HNO-l5K-NauRnN8LzjEdGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E911800D4E;
        Wed,  1 Apr 2020 10:42:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3033C100EBA6;
        Wed,  1 Apr 2020 10:42:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 2/2] mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
Date:   Wed,  1 Apr 2020 12:41:56 +0200
Message-Id: <20200401104156.11564-3-david@redhat.com>
In-Reply-To: <20200401104156.11564-1-david@redhat.com>
References: <20200401104156.11564-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PREEMPT, it can happen that we get soft lockups detected,
e.g., while booting up.

[  105.608900] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper=
/0:1]
[  105.608933] Modules linked in:
[  105.608933] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-next-20200=
331+ #4
[  105.608933] Hardware name: Red Hat KVM, BIOS 1.11.1-4.module+el8.1.0+4=
066+0f1aadab 04/01/2014
[  105.608933] RIP: 0010:__pageblock_pfn_to_page+0x134/0x1c0
[  105.608933] Code: 85 c0 74 71 4a 8b 04 d0 48 85 c0 74 68 48 01 c1 74 6=
3 f6 01 04 74 5e 48 c1 e7 06 4c 8b 05 cc 991
[  105.608933] RSP: 0000:ffffb6d94000fe60 EFLAGS: 00010286 ORIG_RAX: ffff=
ffffffffff13
[  105.608933] RAX: fffff81953250000 RBX: 000000000a4c9600 RCX: ffff8fe9f=
f7c1990
[  105.608933] RDX: ffff8fe9ff7dab80 RSI: 000000000a4c95ff RDI: 000000029=
3250000
[  105.608933] RBP: ffff8fe9ff7dab80 R08: fffff816c0000000 R09: 000000000=
0000008
[  105.608933] R10: 0000000000000014 R11: 0000000000000014 R12: 000000000=
0000000
[  105.608933] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
[  105.608933] FS:  0000000000000000(0000) GS:ffff8fe1ff400000(0000) knlG=
S:0000000000000000
[  105.608933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  105.608933] CR2: 000000000f613000 CR3: 00000088cf20a000 CR4: 000000000=
00006f0
[  105.608933] Call Trace:
[  105.608933]  set_zone_contiguous+0x56/0x70
[  105.608933]  page_alloc_init_late+0x166/0x176
[  105.608933]  kernel_init_freeable+0xfa/0x255
[  105.608933]  ? rest_init+0xaa/0xaa
[  105.608933]  kernel_init+0xa/0x106
[  105.608933]  ret_from_fork+0x35/0x40

The issue becomes visible when having a lot of memory (e.g., 4TB)
assigned to a single NUMA node - a system that can easily be created
using QEMU. Inside VMs on a hypervisor with quite some memory
overcommit, this is fairly easy to trigger.

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
index 084cabffc90d..cc4f07d52939 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1607,6 +1607,7 @@ void set_zone_contiguous(struct zone *zone)
 		if (!__pageblock_pfn_to_page(block_start_pfn,
 					     block_end_pfn, zone))
 			return;
+		cond_resched();
 	}
=20
 	/* We confirm that there is no hole */
--=20
2.25.1

