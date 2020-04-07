Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6802078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvSZQR9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgDGNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:54:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728573AbgDGNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586267674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hECXe/ScdXiWieGl51KSz97pYlZ6hab45z2McF4NSw=;
        b=SvSZQR9AgnoJYPfUAGwD0azYnGeSD8vDpvsvijoxE9yrbdc8N7/I1SVcjSbEtpXaT57B6q
        3jY7koCDDAdHaL4S9s9i6bBF8WfgivzJtsRqwa0gpcBpOUOcuzowBQ9UbSKTLfI8Vq9y5d
        SaLDu/mTaBJ6bdyX/1D3JsD5ex4SxKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-2W7s--LtNgSfmWht8rBhpw-1; Tue, 07 Apr 2020 09:54:30 -0400
X-MC-Unique: 2W7s--LtNgSfmWht8rBhpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BFE21088384;
        Tue,  7 Apr 2020 13:54:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03C8A96FB1;
        Tue,  7 Apr 2020 13:54:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking is_mem_section_removable()
Date:   Tue,  7 Apr 2020 15:54:15 +0200
Message-Id: <20200407135416.24093-2-david@redhat.com>
In-Reply-To: <20200407135416.24093-1-david@redhat.com>
References: <20200407135416.24093-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
blocks as removable"), the user space interface to compute whether a memo=
ry
block can be offlined (exposed via
/sys/devices/system/memory/memoryX/removable) has effectively been
deprecated. We want to remove the leftovers of the kernel implementation.

When offlining a memory block (mm/memory_hotplug.c:__offline_pages()),
we'll start by:
1. Testing if it contains any holes, and reject if so
2. Testing if pages belong to different zones, and reject if so
3. Isolating the page range, checking if it contains any unmovable pages

Using is_mem_section_removable() before trying to offline is not only rac=
y,
it can easily result in false positives/negatives. Let's stop manually
checking is_mem_section_removable(), and let device_offline() handle it
completely instead. We can remove the racy is_mem_section_removable()
implementation next.

We now take more locks (e.g., memory hotplug lock when offlining and the
zone lock when isolating), but maybe we should optimize that
implementation instead if this ever becomes a real problem (after all,
memory unplug is already an expensive operation). We started using
is_mem_section_removable() in commit 51925fb3c5c9 ("powerpc/pseries:
Implement memory hotplug remove in the kernel"), with the initial
hotremove support of lmbs.

Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../platforms/pseries/hotplug-memory.c        | 26 +++----------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
index b2cde1732301..5ace2f9a277e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -337,39 +337,19 @@ static int pseries_remove_mem_node(struct device_no=
de *np)
=20
 static bool lmb_is_removable(struct drmem_lmb *lmb)
 {
-	int i, scns_per_block;
-	bool rc =3D true;
-	unsigned long pfn, block_sz;
-	u64 phys_addr;
-
 	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
 		return false;
=20
-	block_sz =3D memory_block_size_bytes();
-	scns_per_block =3D block_sz / MIN_MEMORY_BLOCK_SIZE;
-	phys_addr =3D lmb->base_addr;
-
 #ifdef CONFIG_FA_DUMP
 	/*
 	 * Don't hot-remove memory that falls in fadump boot memory area
 	 * and memory that is reserved for capturing old kernel memory.
 	 */
-	if (is_fadump_memory_area(phys_addr, block_sz))
+	if (is_fadump_memory_area(lmb->base_addr, memory_block_size_bytes()))
 		return false;
 #endif
-
-	for (i =3D 0; i < scns_per_block; i++) {
-		pfn =3D PFN_DOWN(phys_addr);
-		if (!pfn_in_present_section(pfn)) {
-			phys_addr +=3D MIN_MEMORY_BLOCK_SIZE;
-			continue;
-		}
-
-		rc =3D rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
-		phys_addr +=3D MIN_MEMORY_BLOCK_SIZE;
-	}
-
-	return rc;
+	/* device_offline() will determine if we can actually remove this lmb *=
/
+	return true;
 }
=20
 static int dlpar_add_lmb(struct drmem_lmb *);
--=20
2.25.1

