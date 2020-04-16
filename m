Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED78C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB18921D82
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byFJYkqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505670AbgDPKyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:54:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2505437AbgDPKuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587034201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfpjA4Z9KH1cEGlN2CGAspzLvogXdOWrRg0QkkSUUkM=;
        b=byFJYkqoanIv3EavmLc4aAPFt1A+hqFclzGGREfiMqPRqReY4iU6ucVBOiNC01nndbmfYI
        6+nFw70MLeKy30cN7GQa2tLoe62Nmj3aQbKTfZXUv0+JM1W1/exRhuwPo5wS+1D8ISdQg2
        aTXhZnQfPRPl3CJAm/XofZukZVWSZcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-uk7XGjooNvuOMtWoppfoxQ-1; Thu, 16 Apr 2020 06:47:19 -0400
X-MC-Unique: uk7XGjooNvuOMtWoppfoxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC5D8018A2;
        Thu, 16 Apr 2020 10:47:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFC641036D03;
        Thu, 16 Apr 2020 10:47:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH RFC 2/2] mm/memory_hotplug: handle memblocks only with CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Thu, 16 Apr 2020 12:47:07 +0200
Message-Id: <20200416104707.20219-3-david@redhat.com>
In-Reply-To: <20200416104707.20219-1-david@redhat.com>
References: <20200416104707.20219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in add_memory_resource() is stale: hotadd_new_pgdat() will
no longer call get_pfn_range_for_nid(), as a hotadded pgdat will simply
span no pages at all, until memory is moved to the zone/node via
move_pfn_range_to_zone() - e.g., when onlining memory blocks.

The only archs that care about memblocks for hotplugged memory (either
for iterating over all system RAM or testing for memory validity) are
arm64, s390x, and powerpc - due to CONFIG_ARCH_KEEP_MEMBLOCK. Without
CONFIG_ARCH_KEEP_MEMBLOCK, we can simply stop messing with memblocks.

For s390x, it seems to be fairly easy to avoid CONFIG_ARCH_KEEP_MEMBLOCK.
arm64 could rework most code (esp., pfn_valid(), valid_phys_addr_range()
and kexec_file_load()) to not require memblocks for hotplugged
memory. E.g., as hotplugged memory has no holes and can be identified
using !early_section(), arm64's variant of pfn_valid() could be reworked
fairly easily to not require memblocks for hotadded memory. powerpc might
be more involed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig          |  3 +++
 mm/memory_hotplug.c | 13 +++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..a063fd9cdff4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -136,6 +136,9 @@ config HAVE_FAST_GUP
 	depends on MMU
 	bool
=20
+# Don't discard allocated memory used to track "memory" and "reserved" m=
emblocks
+# after early boot, so it can still be used to test for validity of memo=
ry.
+# Also, memblocks are updated with memory hot(un)plug.
 config ARCH_KEEP_MEMBLOCK
 	bool
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9b15ce465be2..104285ee9ae8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1020,13 +1020,9 @@ int __ref add_memory_resource(int nid, struct reso=
urce *res)
=20
 	mem_hotplug_begin();
=20
-	/*
-	 * Add new range to memblock so that when hotadd_new_pgdat() is called
-	 * to allocate new pgdat, get_pfn_range_for_nid() will be able to find
-	 * this new range and calculate total pages correctly.  The range will
-	 * be removed at hot-remove time.
-	 */
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 	memblock_add_node(start, size, nid);
+#endif
=20
 	ret =3D __try_online_node(nid, false);
 	if (ret < 0)
@@ -1075,7 +1071,9 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res)
 	/* rollback pgdat allocation and others */
 	if (new_node)
 		rollback_node_hotadd(nid);
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 	memblock_remove(start, size);
+#endif
 	mem_hotplug_done();
 	return ret;
 }
@@ -1751,8 +1749,11 @@ static int __ref try_remove_memory(int nid, u64 st=
art, u64 size)
 	mem_hotplug_begin();
=20
 	arch_remove_memory(nid, start, size, NULL);
+
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 	memblock_free(start, size);
 	memblock_remove(start, size);
+#endif
 	__release_memory_resource(start, size);
=20
 	try_offline_node(nid);
--=20
2.25.1

