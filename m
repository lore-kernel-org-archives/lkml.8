Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671EC35254
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0801B20733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2AiYMfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBIKtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:49:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727788AbgBIKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=UrkcXvm7NMV0Re5AiF6mLhLz+8rfznTN3+Xg74sBVcE=;
        b=O2AiYMfqiuBCTd8Pv/bsP5esC5J6qTg4Dh86KfNWNlY1wNvQc/KPgNInXJf9A1oxliEWJv
        tehfWmwcMII63We9LPOmbULV7aLHdpZqwI3bGZodPmvY2/wZwdFJHXMFRNh8vqCuqi0RR/
        bIwaNESnAdmIix6clOMeLhA1rIuWGio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-DwMZTUXjOn61rZpMJ1k2qQ-1; Sun, 09 Feb 2020 05:48:57 -0500
X-MC-Unique: DwMZTUXjOn61rZpMJ1k2qQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27B441005510;
        Sun,  9 Feb 2020 10:48:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C41ED10013A7;
        Sun,  9 Feb 2020 10:48:49 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 6/7] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Date:   Sun,  9 Feb 2020 18:48:25 +0800
Message-Id: <20200209104826.3385-7-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richardw.yang@linux.intel.com>

When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
doesn't work before sparse_init_one_section() is called. This leads to a
crash when hotplug memory.

PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #339
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
RIP: 0010:__memset+0x24/0x30
Call Trace:
 sparse_add_section+0x150/0x1d8
 __add_pages+0xbf/0x150
 add_pages+0x12/0x60
 add_memory_resource+0xc8/0x210
 ? wake_up_q+0xa0/0xa0
 __add_memory+0x62/0xb0
 acpi_memory_device_add+0x13f/0x300
 acpi_bus_attach+0xf6/0x200
 acpi_bus_scan+0x43/0x90
 acpi_device_hotplug+0x275/0x3d0
 acpi_hotplug_work_fn+0x1a/0x30
 process_one_work+0x1a7/0x370
 worker_thread+0x30/0x380
 ? flush_rcu_work+0x30/0x30
 kthread+0x112/0x130
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x35/0x40

We should use memmap as it did.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index a7e78bfe0dce..623755e88255 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -944,7 +944,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
+	page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.17.2

