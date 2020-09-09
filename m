Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A7DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D620BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kibLqazc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIIVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:30:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17143 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:30:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5948d10000>; Wed, 09 Sep 2020 14:27:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 14:30:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 14:30:01 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 21:30:00 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 21:30:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5949580004>; Wed, 09 Sep 2020 14:30:00 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse=20?= <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/doc: add usage description for migrate_vma_*()
Date:   Wed, 9 Sep 2020 14:29:56 -0700
Message-ID: <20200909212956.20104-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599686865; bh=9pn2LAJQ88Ern7DgcA6IA3HL7U+bde50sQiNMbe+78A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=kibLqazczBhICvNhHQybzFkZ0zo4zJqPgza2W2xlfjtdWeGWCMeURoezbns3nQJKB
         7skLSbzBvGyPAeR1vSknOjjUF2D0X077AFeQPOdesNJdySV2RkHOqM2BbHQ5mSmtCy
         EHGbUS10OXJGJIwVeUptqiTWvCA2vwKnFdtew0sXv4NrS+tmJjgdydJddw9f0y4/Lr
         1bJiKyTiIE670maHK1Yt8Ny7WHuuTgl0t878mM5oGxmoipnMG87W8tnhsXkZRF4BxX
         xpVyqf2vAbrBpRkN1AbApeiCqk5hcFOczmvTgFmKl8RRbY/eAzALlrde9Y4AFSfcgs
         i3hC+iQwtV1dQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
API usage by device drivers is not well documented.
Add a description for how device drivers are expected to use it.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

There shouldn't be any merge conflict with my previous patch which
touched hmm.rst but since Jonathan Corbet took my last patch, perhaps he
would like to take this one through his tree too.

 Documentation/vm/hmm.rst | 137 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7453acc1ea4f..dd9f76a4ef29 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -271,10 +271,139 @@ map those pages from the CPU side.
 Migration to and from device memory
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Because the CPU cannot access device memory, migration must use the device=
 DMA
-engine to perform copy from and to device memory. For this we need to use
-migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize() helpe=
rs.
-
+Because the CPU cannot access device memory directly, the device driver mu=
st
+use hardware DMA or device specific load/store instructions to migrate dat=
a.
+The migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
+functions are designed to make drivers easier to write and to centralize c=
ommon
+code across drivers.
+
+Before migrating pages to device private memory, special device private
+``struct page`` need to be created. These will be used as special "swap"
+page table entries so that a CPU process will fault if it tries to access
+a page that has been migrated to device private memory.
+
+These can be allocated and freed with::
+
+    struct resource *res;
+    struct dev_pagemap pagemap;
+
+    res =3D request_free_mem_region(&iomem_resource, /* number of bytes */=
,
+                                  "name of driver resource");
+    pagemap.type =3D MEMORY_DEVICE_PRIVATE;
+    pagemap.range.start =3D res->start;
+    pagemap.range.end =3D res->end;
+    pagemap.nr_range =3D 1;
+    pagemap.ops =3D &device_devmem_ops;
+    memremap_pages(&pagemap, numa_node_id());
+
+    memunmap_pages(&pagemap);
+    release_mem_region(pagemap.range.start, range_len(&pagemap.range));
+
+There are also devm_request_free_mem_region(), devm_memremap_pages(),
+devm_memunmap_pages(), and devm_release_mem_region() when the resources ca=
n
+be tied to a ``struct device``.
+
+The overall migration steps are similar to migrating NUMA pages within sys=
tem
+memory (see :ref:`Page migration <page_migration>`) but the steps are spli=
t
+between device driver specific code and shared common code:
+
+1. ``mmap_read_lock()``
+
+   The device driver has to pass a ``struct vm_area_struct`` to
+   migrate_vma_setup() so the mmap_read_lock() or mmap_write_lock() needs =
to
+   be held for the duration of the migration.
+
+2. ``migrate_vma_setup(struct migrate_vma *args)``
+
+   The device driver initializes the ``struct migrate_vma`` fields and pas=
ses
+   the pointer to migrate_vma_setup(). The ``args->flags`` field is used t=
o
+   filter which source pages should be migrated. For example, setting
+   ``MIGRATE_VMA_SELECT_SYSTEM`` will only migrate system memory and
+   ``MIGRATE_VMA_SELECT_DEVICE_PRIVATE`` will only migrate pages residing =
in
+   device private memory. If the latter flag is set, the ``args->pgmap_own=
er``
+   field is used to identify device private pages owned by the driver. Thi=
s
+   avoids trying to migrate device private pages residing in other devices=
.
+   Currently only anonymous private VMA ranges can be migrated to or from
+   system memory and device private memory.
+
+   One of the first steps migrate_vma_setup() does is to invalidate other
+   device's MMUs with the ``mmu_notifier_invalidate_range_start(()`` and
+   ``mmu_notifier_invalidate_range_end()`` calls around the page table
+   walks to fill in the ``args->src`` array with PFNs to be migrated.
+   The ``invalidate_range_start()`` callback is passed a
+   ``struct mmu_notifier_range`` with the ``event`` field set to
+   ``MMU_NOTIFY_MIGRATE`` and the ``migrate_pgmap_owner`` field set to
+   the ``args->pgmap_owner`` field passed to migrate_vma_setup(). This is
+   allows the device driver to skip the invalidation callback and only
+   invalidate device private MMU mappings that are actually migrating.
+   This is explained more in the next section.
+
+   While walking the page tables, a ``pte_none()`` or ``is_zero_pfn()``
+   entry results in a valid "zero" PFN stored in the ``args->src`` array.
+   This lets the driver allocate device private memory and clear it instea=
d
+   of copying a page of zeros. Valid PTE entries to system memory or
+   device private struct pages will be locked with ``lock_page()``, isolat=
ed
+   from the LRU (if system memory since device private pages are not on
+   the LRU), unmapped from the process, and a special migration PTE is
+   inserted in place of the original PTE.
+   migrate_vma_setup() also clears the ``args->dst`` array.
+
+3. The device driver allocates destination pages and copies source pages t=
o
+   destination pages.
+
+   The driver checks each ``src`` entry to see if the ``MIGRATE_PFN_MIGRAT=
E``
+   bit is set and skips entries that are not migrating. The device driver
+   can also choose to skip migrating a page by not filling in the ``dst``
+   array for that page.
+
+   The driver then allocates either a device private struct page or a
+   system memory page, locks the page with ``lock_page()``, and fills in t=
he
+   ``dst`` array entry with::
+
+   dst[i] =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+
+   Now that the driver knows that this page is being migrated, it can
+   invalidate device private MMU mappings and copy device private memory
+   to system memory or another device private page. The core Linux kernel
+   handles CPU page table invalidations so the device driver only has to
+   invalidate its own MMU mappings.
+
+   The driver can use ``migrate_pfn_to_page(src[i])`` to get the
+   ``struct page`` of the source and either copy the source page to the
+   destination or clear the destination device private memory if the point=
er
+   is ``NULL`` meaning the source page was not populated in system memory.
+
+4. ``migrate_vma_pages()``
+
+   This step is where the migration is actually "committed".
+
+   If the source page was a ``pte_none()`` or ``is_zero_pfn()`` page, this
+   is where the newly allocated page is inserted into the CPU's page table=
.
+   This can fail if a CPU thread faults on the same page. However, the pag=
e
+   table is locked and only one of the new pages will be inserted.
+   The device driver will see that the ``MIGRATE_PFN_MIGRATE`` bit is clea=
red
+   if it loses the race.
+
+   If the source page was locked, isolated, etc. the source ``struct page`=
`
+   information is now copied to destination ``struct page`` finalizing the
+   migration on the CPU side.
+
+5. Device driver updates device MMU page tables for pages still migrating,
+   rolling back pages not migrating.
+
+   If the ``src`` entry still has ``MIGRATE_PFN_MIGRATE`` bit set, the dev=
ice
+   driver can update the device MMU and set the write enable bit if the
+   ``MIGRATE_PFN_WRITE`` bit is set.
+
+6. ``migrate_vma_finalize()``
+
+   This step replaces the special migration page table entry with the new
+   page's page table entry and releases the reference to the source and
+   destination ``struct page``.
+
+7. ``mmap_read_unlock()``
+
+   The lock can now be released.
=20
 Memory cgroup (memcg) and rss accounting
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.20.1

