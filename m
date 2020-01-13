Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E4C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7906E20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPWpv7lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAMOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:40:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38107 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728643AbgAMOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578926447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbGm8Hi3zlVTxr/j632O0PSIM+6guj6wM2pmWx8G2xc=;
        b=iPWpv7lZgTrnTkzAhqzvXiK/ksY/HiBle0x4u/L1fr3O2XQ1eGbqJjV6NCnKi+cF8IOO+N
        qduf0U16uPWUoP31ToZPpprpBCJu0/L2HQmHYOlvTqcQoCh22GnlkZW1qKRzlrm+k0aYPF
        Wxs0mqLH8+8EjzEjQqPjHwEiYjm56Wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-bv2mHPcxMliAo2mltf5viQ-1; Mon, 13 Jan 2020 09:40:44 -0500
X-MC-Unique: bv2mHPcxMliAo2mltf5viQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B74B8107ACC7;
        Mon, 13 Jan 2020 14:40:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E2919C6A;
        Mon, 13 Jan 2020 14:40:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v1 1/2] mm/page_alloc: fix and rework pfn handling in memmap_init_zone()
Date:   Mon, 13 Jan 2020 15:40:34 +0100
Message-Id: <20200113144035.10848-2-david@redhat.com>
In-Reply-To: <20200113144035.10848-1-david@redhat.com>
References: <20200113144035.10848-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's update the pfn manually whenever we continue the loop. This makes
the code easier to read but also less error prone (and we can directly
fix one issue).

When overlap_memmap_init() returns true, pfn is updated to
"memblock_region_memory_end_pfn(r)". So it already points at the *next*
pfn to process. Incrementing the pfn another time is wrong, we might
leave one uninitialized. I spotted this by inspecting the code, so I have
no idea if this is relevant in practise (with kernelcore=3Dmirror).

Fixes: a9a9e77fbf27 ("mm: move mirrored memory specific code outside of m=
emmap_init_zone")
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a41bd7341de1..a92791512077 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5905,18 +5905,20 @@ void __meminit memmap_init_zone(unsigned long siz=
e, int nid, unsigned long zone,
 	}
 #endif
=20
-	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
+	for (pfn =3D start_pfn; pfn < end_pfn; ) {
 		/*
 		 * There can be holes in boot-time mem_map[]s handed to this
 		 * function.  They do not exist on hotplugged memory.
 		 */
 		if (context =3D=3D MEMMAP_EARLY) {
 			if (!early_pfn_valid(pfn)) {
-				pfn =3D next_pfn(pfn) - 1;
+				pfn =3D next_pfn(pfn);
 				continue;
 			}
-			if (!early_pfn_in_nid(pfn, nid))
+			if (!early_pfn_in_nid(pfn, nid)) {
+				pfn++;
 				continue;
+			}
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
 			if (defer_init(nid, pfn, end_pfn))
@@ -5944,6 +5946,7 @@ void __meminit memmap_init_zone(unsigned long size,=
 int nid, unsigned long zone,
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		}
+		pfn++;
 	}
 }
=20
--=20
2.24.1

