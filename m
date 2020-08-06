Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A63C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601182177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hdyP32H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHFTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:34:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16791 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgHFTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:34:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2c5af90000>; Thu, 06 Aug 2020 12:33:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 12:34:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 12:34:04 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 19:33:57 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 6 Aug 2020 19:33:57 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2c5b250001>; Thu, 06 Aug 2020 12:33:57 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/migrate: fix migrate_pgmap_owner w/o CONFIG_MMU_NOTIFIER
Date:   Thu, 6 Aug 2020 12:33:53 -0700
Message-ID: <20200806193353.7124-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596742393; bh=p8Y/nFQLLNnrnLBeQIsBixY5c1DG7LMFlrm6+gZS1x4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=hdyP32H7zn64syR4uT2rTRA19/BK9LVSo77ZlfxRaEaWLAN9mN4aJNIUt0HN/YTno
         Q5j7tY7uT8QkwqqGnkx0bKi0Y9UrLXoNzmJv2+TxP4b2KxXKY6f+2z7sn5TSA6ATRx
         fC+yCpHqC7Can5iuWzDaw6m0J+BixA/WeX6uH1YwnBjVmQiC55p9vv27jYpQmRFXa5
         eqMZADCP3xNirIgSXPKn2gpzqk00mHnO/ehVgyaH07L1Hr+P/uA99z34Xsp2l7BXjA
         mbQWdpwCL/GmJBsBtTsCNwQyk7GYyu404Ag2zVnmus/QgY3qPUgLiVwY0lVtA1hoD1
         hfs/l3kW4xWAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, when CONFIG_MMU_NOTIFIER is not set/enabled, there is a
compiler error:

../mm/migrate.c: In function 'migrate_vma_collect':
../mm/migrate.c:2481:7: error: 'struct mmu_notifier_range' has no member
named 'migrate_pgmap_owner'
  range.migrate_pgmap_owner =3D migrate->pgmap_owner;
       ^

Fixes: 998427b3ad2c ("mm/notifier: add migration invalidation type")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---

This is based on the latest linux and is for Andrew Morton's mm tree.
MMU_NOTIFIER is selected automatically by a number of other config
options so I missed this in my own testing. Thanks to Randy Dunlap for
finding it.

 include/linux/mmu_notifier.h | 13 +++++++++++++
 mm/migrate.c                 |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index c6f0708195cd..b8200782dede 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -521,6 +521,16 @@ static inline void mmu_notifier_range_init(struct mmu_=
notifier_range *range,
 	range->flags =3D flags;
 }
=20
+static inline void mmu_notifier_range_init_migrate(
+			struct mmu_notifier_range *range, unsigned int flags,
+			struct vm_area_struct *vma, struct mm_struct *mm,
+			unsigned long start, unsigned long end, void *pgmap)
+{
+	mmu_notifier_range_init(range, MMU_NOTIFY_MIGRATE, flags, vma, mm,
+				start, end);
+	range->migrate_pgmap_owner =3D pgmap;
+}
+
 #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
 ({									\
 	int __young;							\
@@ -645,6 +655,9 @@ static inline void _mmu_notifier_range_init(struct mmu_=
notifier_range *range,
=20
 #define mmu_notifier_range_init(range,event,flags,vma,mm,start,end)  \
 	_mmu_notifier_range_init(range, start, end)
+#define mmu_notifier_range_init_migrate(range, flags, vma, mm, start, end,=
 \
+					pgmap) \
+	_mmu_notifier_range_init(range, start, end)
=20
 static inline bool
 mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
diff --git a/mm/migrate.c b/mm/migrate.c
index 4fcc465736ff..d179657f8685 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2386,9 +2386,9 @@ static void migrate_vma_collect(struct migrate_vma *m=
igrate)
 	 * that the registered device driver can skip invalidating device
 	 * private page mappings that won't be migrated.
 	 */
-	mmu_notifier_range_init(&range, MMU_NOTIFY_MIGRATE, 0, migrate->vma,
-			migrate->vma->vm_mm, migrate->start, migrate->end);
-	range.migrate_pgmap_owner =3D migrate->pgmap_owner;
+	mmu_notifier_range_init_migrate(&range, 0, migrate->vma,
+		migrate->vma->vm_mm, migrate->start, migrate->end,
+		migrate->pgmap_owner);
 	mmu_notifier_invalidate_range_start(&range);
=20
 	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
--=20
2.20.1

