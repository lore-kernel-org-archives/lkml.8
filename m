Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55ECC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1939206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTE38JUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgA0LUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:20:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729054AbgA0LUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRutrSzwK33qK4FCCu3FPTNH0IClfN1ONJlSVxlU3pI=;
        b=LTE38JUPqXvWNfWZ6yQN1aj/1PW3BzoM0ktPRr+3KVG6WugZyuIYDHsZD1J19aFcnQ1mji
        hdZUGljX9z16tCmZXIcwiAmWwWrBwTO9Nc/K62EAZTy7rir/6s0uC4Bh3h8k2Sbge6Y886
        S9F7uRSmVTdKX/3Ujg9n3vc0WEfIZxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MxXauJEVNsKYsDt2OkGm5A-1; Mon, 27 Jan 2020 06:04:40 -0500
X-MC-Unique: MxXauJEVNsKYsDt2OkGm5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8907D1902EC7;
        Mon, 27 Jan 2020 11:04:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA86719E9C;
        Mon, 27 Jan 2020 11:04:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 2/3] drivers/base/memory.c: drop pages_correctly_probed()
Date:   Mon, 27 Jan 2020 12:04:23 +0100
Message-Id: <20200127110424.5757-3-david@redhat.com>
In-Reply-To: <20200127110424.5757-1-david@redhat.com>
References: <20200127110424.5757-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pages_correctly_probed() is a leftover from ancient times. It dates
back to commit 3947be1969a9 ("[PATCH] memory hotplug: sysfs and
add/remove functions"), where Pg_reserved checks were added as a sfety ne=
t:
	/*
	 * The probe routines leave the pages reserved, just
	 * as the bootmem code does.  Make sure they're still
	 * that way.
	 */
The checks were refactored quite a bit over the years, especially in
commit b77eab7079d9 ("mm/memory_hotplug: optimize probe routine"), where
checks for present, valid, and online sections were added.

Hotplugged memory is added via add_memory(), which will create the full
memmap for the hotplugged memory, and mark all sections valid and present=
.
Only full memory blocks are onlined/offlined, so we also cannot have an
inconsistency in that regard (especially, memory blocks with some section=
s
being online and some being offline).

1. Boot memory always starts online. Since commit c5e79ef561b0
   ("mm/memory_hotplug.c: don't allow to online/offline memory blocks wit=
h
     holes") we disallow to offline any memory with holes. Therefore,
   we never online memory with holes. Present and validity checks are
   superfluous.

2. Only complete memory blocks are onlined/offlined (and especially,
   the state - online or offline - is stored for whole memory blocks).
   Besides the core, only arch/powerpc/platforms/powernv/memtrace.c
   manually calls offline_pages() and fiddels with memory block states.
   But it also only offlines complete memory blocks.

3. To make any of these conditions trigger, something would have to be
   terribly messed up in the core. (e.g., online/offline only some sectio=
ns
   of a memory block).

4. Memory unplug properly makes sure that all sysfs attributes were
   removed (and therefore, that all threads left the sysfs handlers). We
   don't have to worry about zombie devices at this point.

5. The valid_section_nr(section_nr) check is actually dead code, as it
   would never have been reached due to the
   WARN_ON_ONCE(!pfn_valid(pfn)).

No wonder we haven't seen any of these errors in a long time (or even
ever, according to my search). Let's just get rid of them. Now, all check=
s
that could hinder onlining and offlining are completely contained in
online_pages()/offline_pages().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 852fece9be1d..d384d1cdf258 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -169,45 +169,6 @@ int memory_notify(unsigned long val, void *v)
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
=20
-/*
- * The probe routines leave the pages uninitialized, just as the bootmem=
 code
- * does. Make sure we do not access them, but instead use only informati=
on from
- * within sections.
- */
-static bool pages_correctly_probed(unsigned long start_pfn)
-{
-	unsigned long section_nr =3D pfn_to_section_nr(start_pfn);
-	unsigned long section_nr_end =3D section_nr + sections_per_block;
-	unsigned long pfn =3D start_pfn;
-
-	/*
-	 * memmap between sections is not contiguous except with
-	 * SPARSEMEM_VMEMMAP. We lookup the page once per section
-	 * and assume memmap is contiguous within each section
-	 */
-	for (; section_nr < section_nr_end; section_nr++) {
-		if (WARN_ON_ONCE(!pfn_valid(pfn)))
-			return false;
-
-		if (!present_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) not present\n",
-				section_nr, pfn, pfn + PAGES_PER_SECTION);
-			return false;
-		} else if (!valid_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) no valid memmap\n",
-				section_nr, pfn, pfn + PAGES_PER_SECTION);
-			return false;
-		} else if (online_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) is already online\n",
-				section_nr, pfn, pfn + PAGES_PER_SECTION);
-			return false;
-		}
-		pfn +=3D PAGES_PER_SECTION;
-	}
-
-	return true;
-}
-
 /*
  * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
  * OK to have direct references to sparsemem variables in here.
@@ -224,9 +185,6 @@ memory_block_action(unsigned long start_section_nr, u=
nsigned long action,
=20
 	switch (action) {
 	case MEM_ONLINE:
-		if (!pages_correctly_probed(start_pfn))
-			return -EBUSY;
-
 		ret =3D online_pages(start_pfn, nr_pages, online_type, nid);
 		break;
 	case MEM_OFFLINE:
--=20
2.24.1

