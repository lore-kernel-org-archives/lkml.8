Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8ADC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1222080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCrrvn5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBIKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:49:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727800AbgBIKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=z6n+AuP+O2svMC+qLOpajdzRjteK4YpkRxZlBgrn3yM=;
        b=JCrrvn5Wfq47/mk4yJUUIP04ep1hhvftSVkQLxjquJzJC/eyfnM/hcEyHD0IaabKsMnYnR
        8+s2cnVPflRJFb45BoIeQNA741BTtU76nt8JDHTNeVhvRhKc8rG5Pwrj2BIRDjQJOaEcVS
        4M/Fy2XY7RS9vsQNUcSd8FUrb8/8J/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-6lR6WDWaM16ElUdnDR3Lyg-1; Sun, 09 Feb 2020 05:49:01 -0500
X-MC-Unique: 6lR6WDWaM16ElUdnDR3Lyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E8BE184AEA0;
        Sun,  9 Feb 2020 10:49:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC73010013A7;
        Sun,  9 Feb 2020 10:48:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 7/7] mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
Date:   Sun,  9 Feb 2020 18:48:26 +0800
Message-Id: <20200209104826.3385-8-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In section_deactivate(), pfn_to_page() doesn't work any more after
ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
It caused hot remove failure, the trace is:

kernel BUG at mm/page_alloc.c:4806!
invalid opcode: 0000 [#1] SMP PTI
CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
RIP: 0010:free_pages+0x85/0xa0
Call Trace:
 __remove_pages+0x99/0xc0
 arch_remove_memory+0x23/0x4d
 try_remove_memory+0xc8/0x130
 ? walk_memory_blocks+0x72/0xa0
 __remove_memory+0xa/0x11
 acpi_memory_device_remove+0x72/0x100
 acpi_bus_trim+0x55/0x90
 acpi_device_hotplug+0x2eb/0x3d0
 acpi_hotplug_work_fn+0x1a/0x30
 process_one_work+0x1a7/0x370
 worker_thread+0x30/0x380
 ? flush_rcu_work+0x30/0x30
 kthread+0x112/0x130
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x35/0x40

Let's defer the ->section_mem_map resetting after depopulate_section_memmap()
to fix it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 623755e88255..345d065ef6ce 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -854,13 +854,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 			ms->usage = NULL;
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		ms->section_mem_map = (unsigned long)NULL;
 	}
 
 	if (section_is_early && memmap)
 		free_map_bootmem(memmap);
 	else
 		depopulate_section_memmap(pfn, nr_pages, altmap);
+
+	if(!rc)
+		ms->section_mem_map = (unsigned long)NULL;
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
-- 
2.17.2

