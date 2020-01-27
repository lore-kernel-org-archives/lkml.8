Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABDC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD40220716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb/w3Bb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgA0LUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:20:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727747AbgA0LUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIk00X/KXVdbLkFtuKPrEpZyGO0RG3xstfsngS1E1yw=;
        b=Jb/w3Bb1GxCVGfpM4Ibfm/mblr2VGLYlx3vHYBA5xBivn54ZtqXHwbXm4D7I7lxbcLDGxZ
        fnFlizoVn08z3IYiGIO8D+X3+Fg/qUczqxGK6mvnG7N/Lu2xOAQ+Yx+s34RYBqqBdlvQae
        X6T0k5TzqNnPCwtzK+qmX38lLfSVcdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-DEOqPzKLM7u2wxz8DVsayw-1; Mon, 27 Jan 2020 06:04:35 -0500
X-MC-Unique: DEOqPzKLM7u2wxz8DVsayw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB901083E95;
        Mon, 27 Jan 2020 11:04:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D20D19E9C;
        Mon, 27 Jan 2020 11:04:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 1/3] drivers/base/memory.c: drop section_count
Date:   Mon, 27 Jan 2020 12:04:22 +0100
Message-Id: <20200127110424.5757-2-david@redhat.com>
In-Reply-To: <20200127110424.5757-1-david@redhat.com>
References: <20200127110424.5757-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to
online/offline memory blocks with holes") we have a generic check in
offline_pages() that disallows offlining memory blocks with holes.

Memory blocks with missing sections are just another variant of these
type of blocks. We can stop checking (and especially storing) present
sections. A proper error message is now printed why offlining failed.

section_count was initially introduced in commit 07681215975e ("Driver
core: Add section count to memory_block struct") in order to detect
when it is okay to remove a memory block. It was used in commit
26bbe7ef6d5c ("drivers/base/memory.c: prohibit offlining of memory blocks
with missing sections") to disallow offlining memory blocks with missing
sections. As we refactored creation/removal of memory devices and have
a proper check for holes in place, we can drop the section_count.

This also removes a leftover comment regarding the mem_sysfs_mutex,
which was removed in commit 848e19ad3c33 ("drivers/base/memory.c: drop
the mem_sysfs_mutex").

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 17 +++--------------
 include/linux/memory.h |  1 -
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6503f5d0b749..852fece9be1d 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -292,10 +292,6 @@ static int memory_subsys_offline(struct device *dev)
 	if (mem->state =3D=3D MEM_OFFLINE)
 		return 0;
=20
-	/* Can't offline block with non-present sections */
-	if (mem->section_count !=3D sections_per_block)
-		return -EINVAL;
-
 	return memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
 }
=20
@@ -660,7 +656,7 @@ static int init_memory_block(struct memory_block **me=
mory,
=20
 static int add_memory_block(unsigned long base_section_nr)
 {
-	int ret, section_count =3D 0;
+	int section_count =3D 0;
 	struct memory_block *mem;
 	unsigned long nr;
=20
@@ -671,12 +667,8 @@ static int add_memory_block(unsigned long base_secti=
on_nr)
=20
 	if (section_count =3D=3D 0)
 		return 0;
-	ret =3D init_memory_block(&mem, base_memory_block_id(base_section_nr),
-				MEM_ONLINE);
-	if (ret)
-		return ret;
-	mem->section_count =3D section_count;
-	return 0;
+	return init_memory_block(&mem, base_memory_block_id(base_section_nr),
+				 MEM_ONLINE);
 }
=20
 static void unregister_memory(struct memory_block *memory)
@@ -714,7 +706,6 @@ int create_memory_block_devices(unsigned long start, =
unsigned long size)
 		ret =3D init_memory_block(&mem, block_id, MEM_OFFLINE);
 		if (ret)
 			break;
-		mem->section_count =3D sections_per_block;
 	}
 	if (ret) {
 		end_block_id =3D block_id;
@@ -723,7 +714,6 @@ int create_memory_block_devices(unsigned long start, =
unsigned long size)
 			mem =3D find_memory_block_by_id(block_id);
 			if (WARN_ON_ONCE(!mem))
 				continue;
-			mem->section_count =3D 0;
 			unregister_memory(mem);
 		}
 	}
@@ -752,7 +742,6 @@ void remove_memory_block_devices(unsigned long start,=
 unsigned long size)
 		mem =3D find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
-		mem->section_count =3D 0;
 		unregister_memory_block_under_nodes(mem);
 		unregister_memory(mem);
 	}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0b8d791b6669..439a89e758d8 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -26,7 +26,6 @@
 struct memory_block {
 	unsigned long start_section_nr;
 	unsigned long state;		/* serialized by the dev->lock */
-	int section_count;		/* serialized by mem_sysfs_mutex */
 	int online_type;		/* for passing data to online routine */
 	int phys_device;		/* to which fru does this belong? */
 	struct device dev;
--=20
2.24.1

