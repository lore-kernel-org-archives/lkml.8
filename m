Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF1C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C24220767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DV1pbRiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgDVPyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:54:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgDVPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587570849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvNOEzghjjU35z3Ri1gDht/p2r/zLVMYDB1agT7sxZk=;
        b=DV1pbRiRIum94f+DqlULBAeX3/2AJ6RuJJpWdwguTd+4b/s/dap88xw/75VVXAxUAQe9h0
        zLW7Foux2IY7JXBQZMwNpdfz91LHJipDiEipOWPnSYR4effvIraW1gnw6ueQwvg9LXKq1n
        Vye49zq4a0ztTyni8lKr96DdVvHYA20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-I5CBHWstNcyRneaJNSv7Uw-1; Wed, 22 Apr 2020 11:54:05 -0400
X-MC-Unique: I5CBHWstNcyRneaJNSv7Uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DE99801503;
        Wed, 22 Apr 2020 15:54:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-57.ams2.redhat.com [10.36.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A89B5D706;
        Wed, 22 Apr 2020 15:54:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 2/2] mm/memory_hotplug: handle memblocks only with CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Wed, 22 Apr 2020 17:53:53 +0200
Message-Id: <20200422155353.25381-3-david@redhat.com>
In-Reply-To: <20200422155353.25381-1-david@redhat.com>
References: <20200422155353.25381-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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
 mm/memory_hotplug.c | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3af64646f343..db626b8d4fdb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -133,6 +133,9 @@ config HAVE_FAST_GUP
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
index 4dc263d2525a..555137bd0882 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1025,13 +1025,8 @@ int __ref add_memory_resource(int nid, struct reso=
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
-	memblock_add_node(start, size, nid);
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
+		memblock_add_node(start, size, nid);
=20
 	ret =3D __try_online_node(nid, false);
 	if (ret < 0)
@@ -1080,7 +1075,8 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res)
 	/* rollback pgdat allocation and others */
 	if (new_node)
 		rollback_node_hotadd(nid);
-	memblock_remove(start, size);
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
+		memblock_remove(start, size);
 	mem_hotplug_done();
 	return ret;
 }
@@ -1677,8 +1673,12 @@ static int __ref try_remove_memory(int nid, u64 st=
art, u64 size)
 	mem_hotplug_begin();
=20
 	arch_remove_memory(nid, start, size, NULL);
-	memblock_free(start, size);
-	memblock_remove(start, size);
+
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
+		memblock_free(start, size);
+		memblock_remove(start, size);
+	}
+
 	__release_memory_resource(start, size);
=20
 	try_offline_node(nid);
--=20
2.25.3

