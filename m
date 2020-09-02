Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2200C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0C20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IgnNl1WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgIBTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:07:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19960 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:07:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fecfa0000>; Wed, 02 Sep 2020 12:05:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 12:06:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 12:06:16 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 19:06:15 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 19:06:14 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4fed260000>; Wed, 02 Sep 2020 12:06:14 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/doc: editorial pass on page migration
Date:   Wed, 2 Sep 2020 12:06:03 -0700
Message-ID: <20200902190603.13484-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599073530; bh=OXAmF1eXebh1BY3dS0vu+KNE4zUaI2ZkBhhQxdNYs/U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=IgnNl1WXR74dZhYvUmA5NdUbA86182gC8lIA0OlhHrb+k9eJG1Ee5ON7x0s3sSAjY
         brtpUHW4wDSBopa7MzDig9ar+6O9jjHBs9TARAaPfD52GhMXRTwDlD7+vfBcYOnh4z
         bFLMT0k8r9FSX891/lYupHrYJGyizaCtRZfhv3ma5vfxjfbZFNnBbZ6h4eOfJOiOkL
         XwsCoAOKZhc/kWEiB0p7TEEgEUYNSjx4s2W/3h2FQfVCk14HpIh0xha5hkvdfP2u9S
         qOAMWhT6qkYB8Q3wHR8lh9ZYtXOzjqEMoObRjHnrFxIzfJ9TeLT9qzZ7EZBfgYHzAI
         uQmf9ckiIpZvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sphinx reference links to HMM and CPUSETS, and numerous small
editorial changes to make the page_migration.rst document more readable.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 .../admin-guide/cgroup-v1/cpusets.rst         |   2 +
 Documentation/vm/hmm.rst                      |   2 +-
 Documentation/vm/page_migration.rst           | 150 +++++++++---------
 3 files changed, 80 insertions(+), 74 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentatio=
n/admin-guide/cgroup-v1/cpusets.rst
index 7ade3abd342a..5d844ed4df69 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -1,3 +1,5 @@
+.. _cpusets:
+
 =3D=3D=3D=3D=3D=3D=3D
 CPUSETS
 =3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 6f9e000757fa..7453acc1ea4f 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -1,4 +1,4 @@
-.. hmm:
+.. _hmm:
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Heterogeneous Memory Management (HMM)
diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_mi=
gration.rst
index 68883ac485fa..bde21cd2f21f 100644
--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -4,25 +4,28 @@
 Page migration
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Page migration allows the moving of the physical location of pages between
-nodes in a numa system while the process is running. This means that the
+Page migration allows moving the physical location of pages between
+nodes in a NUMA system while the process is running. This means that the
 virtual addresses that the process sees do not change. However, the
 system rearranges the physical location of those pages.
=20
-The main intend of page migration is to reduce the latency of memory acces=
s
+Also see :ref:`Heterogeneous Memory Management (HMM) <hmm>`
+for migrating pages to or from device private memory.
+
+The main intent of page migration is to reduce the latency of memory acces=
ses
 by moving pages near to the processor where the process accessing that mem=
ory
 is running.
=20
 Page migration allows a process to manually relocate the node on which its
 pages are located through the MF_MOVE and MF_MOVE_ALL options while settin=
g
-a new memory policy via mbind(). The pages of process can also be relocate=
d
+a new memory policy via mbind(). The pages of a process can also be reloca=
ted
 from another process using the sys_migrate_pages() function call. The
-migrate_pages function call takes two sets of nodes and moves pages of a
+migrate_pages() function call takes two sets of nodes and moves pages of a
 process that are located on the from nodes to the destination nodes.
 Page migration functions are provided by the numactl package by Andi Kleen
 (a version later than 0.9.3 is required. Get it from
 ftp://oss.sgi.com/www/projects/libnuma/download/). numactl provides libnum=
a
-which provides an interface similar to other numa functionality for page
+which provides an interface similar to other NUMA functionality for page
 migration.  cat ``/proc/<pid>/numa_maps`` allows an easy review of where t=
he
 pages of a process are located. See also the numa_maps documentation in th=
e
 proc(5) man page.
@@ -30,19 +33,19 @@ proc(5) man page.
 Manual migration is useful if for example the scheduler has relocated
 a process to a processor on a distant node. A batch scheduler or an
 administrator may detect the situation and move the pages of the process
-nearer to the new processor. The kernel itself does only provide
+nearer to the new processor. The kernel itself only provides
 manual page migration support. Automatic page migration may be implemented
 through user space processes that move pages. A special function call
 "move_pages" allows the moving of individual pages within a process.
-A NUMA profiler may f.e. obtain a log showing frequent off node
+For example, A NUMA profiler may obtain a log showing frequent off node
 accesses and may use the result to move pages to more advantageous
 locations.
=20
 Larger installations usually partition the system using cpusets into
 sections of nodes. Paul Jackson has equipped cpusets with the ability to
 move pages when a task is moved to another cpuset (See
-Documentation/admin-guide/cgroup-v1/cpusets.rst).
-Cpusets allows the automation of process locality. If a task is moved to
+:ref:`CPUSETS <cpusets>`).
+Cpusets allow the automation of process locality. If a task is moved to
 a new cpuset then also all its pages are moved with it so that the
 performance of the process does not sink dramatically. Also the pages
 of processes in a cpuset are moved if the allowed memory nodes of a
@@ -67,9 +70,9 @@ In kernel use of migrate_pages()
    Lists of pages to be migrated are generated by scanning over
    pages and moving them into lists. This is done by
    calling isolate_lru_page().
-   Calling isolate_lru_page increases the references to the page
+   Calling isolate_lru_page() increases the references to the page
    so that it cannot vanish while the page migration occurs.
-   It also prevents the swapper or other scans to encounter
+   It also prevents the swapper or other scans from encountering
    the page.
=20
 2. We need to have a function of type new_page_t that can be
@@ -91,23 +94,24 @@ is increased so that the page cannot be freed while pag=
e migration occurs.
=20
 Steps:
=20
-1. Lock the page to be migrated
+1. Lock the page to be migrated.
=20
 2. Ensure that writeback is complete.
=20
 3. Lock the new page that we want to move to. It is locked so that accesse=
s to
-   this (not yet uptodate) page immediately lock while the move is in prog=
ress.
+   this (not yet uptodate) page immediately block while the move is in pro=
gress.
=20
 4. All the page table references to the page are converted to migration
    entries. This decreases the mapcount of a page. If the resulting
    mapcount is not zero then we do not migrate the page. All user space
-   processes that attempt to access the page will now wait on the page loc=
k.
+   processes that attempt to access the page will now wait on the page loc=
k
+   or wait for the migration page table entry to be removed.
=20
 5. The i_pages lock is taken. This will cause all processes trying
    to access the page via the mapping to block on the spinlock.
=20
-6. The refcount of the page is examined and we back out if references rema=
in
-   otherwise we know that we are the only one referencing this page.
+6. The refcount of the page is examined and we back out if references rema=
in.
+   Otherwise, we know that we are the only one referencing this page.
=20
 7. The radix tree is checked and if it does not contain the pointer to thi=
s
    page then we back out because someone else modified the radix tree.
@@ -134,22 +138,22 @@ Steps:
=20
 15. Queued up writeback on the new page is triggered.
=20
-16. If migration entries were page then replace them with real ptes. Doing
-    so will enable access for user space processes not already waiting for
-    the page lock.
+16. If migration entries were inserted into the page table, then replace t=
hem
+    with real ptes. Doing so will enable access for user space processes n=
ot
+    already waiting for the page lock.
=20
-19. The page locks are dropped from the old and new page.
+17. The page locks are dropped from the old and new page.
     Processes waiting on the page lock will redo their page faults
     and will reach the new page.
=20
-20. The new page is moved to the LRU and can be scanned by the swapper
-    etc again.
+18. The new page is moved to the LRU and can be scanned by the swapper,
+    etc. again.
=20
 Non-LRU page migration
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Although original migration aimed for reducing the latency of memory acces=
s
-for NUMA, compaction who want to create high-order page is also main custo=
mer.
+Although migration originally aimed for reducing the latency of memory acc=
esses
+for NUMA, compaction also uses migration to create high-order pages.
=20
 Current problem of the implementation is that it is designed to migrate on=
ly
 *LRU* pages. However, there are potential non-lru pages which can be migra=
ted
@@ -158,46 +162,47 @@ in drivers, for example, zsmalloc, virtio-balloon pag=
es.
 For virtio-balloon pages, some parts of migration code path have been hook=
ed
 up and added virtio-balloon specific functions to intercept migration logi=
cs.
 It's too specific to a driver so other drivers who want to make their page=
s
-movable would have to add own specific hooks in migration path.
+movable would have to add their own specific hooks in the migration path.
=20
-To overclome the problem, VM supports non-LRU page migration which provide=
s
+To overcome the problem, VM supports non-LRU page migration which provides
 generic functions for non-LRU movable pages without driver specific hooks
-migration path.
+in the migration path.
=20
-If a driver want to make own pages movable, it should define three functio=
ns
+If a driver wants to make its pages movable, it should define three functi=
ons
 which are function pointers of struct address_space_operations.
=20
 1. ``bool (*isolate_page) (struct page *page, isolate_mode_t mode);``
=20
-   What VM expects on isolate_page function of driver is to return *true*
-   if driver isolates page successfully. On returing true, VM marks the pa=
ge
+   What VM expects on isolate_page() function of driver is to return *true=
*
+   if driver isolates the page successfully. On returning true, VM marks t=
he page
    as PG_isolated so concurrent isolation in several CPUs skip the page
    for isolation. If a driver cannot isolate the page, it should return *f=
alse*.
=20
    Once page is successfully isolated, VM uses page.lru fields so driver
-   shouldn't expect to preserve values in that fields.
+   shouldn't expect to preserve values in those fields.
=20
 2. ``int (*migratepage) (struct address_space *mapping,``
 |	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
=20
-   After isolation, VM calls migratepage of driver with isolated page.
-   The function of migratepage is to move content of the old page to new p=
age
+   After isolation, VM calls migratepage() of driver with the isolated pag=
e.
+   The function of migratepage() is to move the contents of the old page t=
o the
+   new page
    and set up fields of struct page newpage. Keep in mind that you should
    indicate to the VM the oldpage is no longer movable via __ClearPageMova=
ble()
-   under page_lock if you migrated the oldpage successfully and returns
+   under page_lock if you migrated the oldpage successfully and returned
    MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, d=
river
    can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short=
 time
-   because VM interprets -EAGAIN as "temporal migration failure". On retur=
ning
-   any error except -EAGAIN, VM will give up the page migration without re=
trying
-   in this time.
+   because VM interprets -EAGAIN as "temporary migration failure". On retu=
rning
+   any error except -EAGAIN, VM will give up the page migration without
+   retrying.
=20
-   Driver shouldn't touch page.lru field VM using in the functions.
+   Driver shouldn't touch the page.lru field while in the migratepage() fu=
nction.
=20
 3. ``void (*putback_page)(struct page *);``
=20
-   If migration fails on isolated page, VM should return the isolated page
-   to the driver so VM calls driver's putback_page with migration failed p=
age.
-   In this function, driver should put the isolated page back to the own d=
ata
+   If migration fails on the isolated page, VM should return the isolated =
page
+   to the driver so VM calls the driver's putback_page() with the isolated=
 page.
+   In this function, the driver should put the isolated page back into its=
 own data
    structure.
=20
 4. non-lru movable page flags
@@ -206,52 +211,51 @@ which are function pointers of struct address_space_o=
perations.
=20
    * PG_movable
=20
-     Driver should use the below function to make page movable under page_=
lock::
+     Driver should use the function below to make page movable under page_=
lock::
=20
 	void __SetPageMovable(struct page *page, struct address_space *mapping)
=20
      It needs argument of address_space for registering migration
      family functions which will be called by VM. Exactly speaking,
-     PG_movable is not a real flag of struct page. Rather than, VM
-     reuses page->mapping's lower bits to represent it.
+     PG_movable is not a real flag of struct page. Rather, VM
+     reuses the page->mapping's lower bits to represent it::
=20
-::
 	#define PAGE_MAPPING_MOVABLE 0x2
 	page->mapping =3D page->mapping | PAGE_MAPPING_MOVABLE;
=20
      so driver shouldn't access page->mapping directly. Instead, driver sh=
ould
-     use page_mapping which mask off the low two bits of page->mapping und=
er
-     page lock so it can get right struct address_space.
-
-     For testing of non-lru movable page, VM supports __PageMovable functi=
on.
-     However, it doesn't guarantee to identify non-lru movable page becaus=
e
-     page->mapping field is unified with other variables in struct page.
-     As well, if driver releases the page after isolation by VM, page->map=
ping
-     doesn't have stable value although it has PAGE_MAPPING_MOVABLE
-     (Look at __ClearPageMovable). But __PageMovable is cheap to catch whe=
ther
-     page is LRU or non-lru movable once the page has been isolated. Becau=
se
-     LRU pages never can have PAGE_MAPPING_MOVABLE in page->mapping. It is=
 also
+     use page_mapping() which masks off the low two bits of page->mapping =
under
+     page lock so it can get the right struct address_space.
+
+     For testing of non-lru movable pages, VM supports __PageMovable() fun=
ction.
+     However, it doesn't guarantee to identify non-lru movable pages becau=
se
+     the page->mapping field is unified with other variables in struct pag=
e.
+     If the driver releases the page after isolation by VM, page->mapping
+     doesn't have a stable value although it has PAGE_MAPPING_MOVABLE set
+     (look at __ClearPageMovable). But __PageMovable() is cheap to call wh=
ether
+     page is LRU or non-lru movable once the page has been isolated becaus=
e LRU
+     pages can never have PAGE_MAPPING_MOVABLE set in page->mapping. It is=
 also
      good for just peeking to test non-lru movable pages before more expen=
sive
-     checking with lock_page in pfn scanning to select victim.
+     checking with lock_page() in pfn scanning to select a victim.
=20
-     For guaranteeing non-lru movable page, VM provides PageMovable functi=
on.
-     Unlike __PageMovable, PageMovable functions validates page->mapping a=
nd
-     mapping->a_ops->isolate_page under lock_page. The lock_page prevents =
sudden
-     destroying of page->mapping.
+     For guaranteeing non-lru movable page, VM provides PageMovable() func=
tion.
+     Unlike __PageMovable(), PageMovable() validates page->mapping and
+     mapping->a_ops->isolate_page under lock_page(). The lock_page() preve=
nts
+     sudden destroying of page->mapping.
=20
-     Driver using __SetPageMovable should clear the flag via __ClearMovabl=
ePage
-     under page_lock before the releasing the page.
+     Drivers using __SetPageMovable() should clear the flag via
+     __ClearMovablePage() under page_lock() before the releasing the page.
=20
    * PG_isolated
=20
      To prevent concurrent isolation among several CPUs, VM marks isolated=
 page
-     as PG_isolated under lock_page. So if a CPU encounters PG_isolated no=
n-lru
-     movable page, it can skip it. Driver doesn't need to manipulate the f=
lag
-     because VM will set/clear it automatically. Keep in mind that if driv=
er
-     sees PG_isolated page, it means the page have been isolated by VM so =
it
-     shouldn't touch page.lru field.
-     PG_isolated is alias with PG_reclaim flag so driver shouldn't use the=
 flag
-     for own purpose.
+     as PG_isolated under lock_page(). So if a CPU encounters PG_isolated
+     non-lru movable page, it can skip it. Driver doesn't need to manipula=
te the
+     flag because VM will set/clear it automatically. Keep in mind that if=
 the
+     driver sees a PG_isolated page, it means the page has been isolated b=
y the
+     VM so it shouldn't touch the page.lru field.
+     The PG_isolated flag is aliased with the PG_reclaim flag so drivers
+     shouldn't use PG_isolated for its own purposes.
=20
 Monitoring Migration
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -266,8 +270,8 @@ The following events (counters) can be used to monitor =
page migration.
    512.
=20
 2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as f=
or
-   _SUCCESS, above: this will be increased by the number of subpages, if i=
t was
-   a THP.
+   PGMIGRATE_SUCCESS, above: this will be increased by the number of subpa=
ges,
+   if it was a THP.
=20
 3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
=20
--=20
2.20.1

