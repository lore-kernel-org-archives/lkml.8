Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FDC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22C12072C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaun3hLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBPTSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 14:18:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbgBPTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 14:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581880692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tuGE6PQn1KB7+DuvWdmcQTP1e0rV79mM3JVVfbfKivs=;
        b=gaun3hLiY+VTGl0Gu9KOt9ds777Ndo0F5Qz39M94O9nipszvXbLalDSHFHgUfITxHaK+TK
        +lp4MrWBYNDjNuVP6e+aXFgzrPJAq3C2yJa9LNU3A6+8ufVdyBhFJbhDbsC4rynP47VDdQ
        jh2YyiUQ/jCOUEULtR7mnrMNiLf+bMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-WXW4iEjeON-G447_iBq-nw-1; Sun, 16 Feb 2020 14:18:06 -0500
X-MC-Unique: WXW4iEjeON-G447_iBq-nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D21107ACC7;
        Sun, 16 Feb 2020 19:18:04 +0000 (UTC)
Received: from t490s.redhat.com (ovpn-116-86.phx2.redhat.com [10.3.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0295319756;
        Sun, 16 Feb 2020 19:18:02 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz
Subject: [PATCH] mm, numa: fix bad pmd by atomically check for pmd_trans_huge when marking page tables prot_numa
Date:   Sun, 16 Feb 2020 14:18:00 -0500
Message-Id: <20200216191800.22423-1-aquini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>
  A user reported a bug against a distribution kernel while running
  a proprietary workload described as "memory intensive that is not
  swapping" that is expected to apply to mainline kernels. The workload
  is read/write/modifying ranges of memory and checking the contents. The=
y
  reported that within a few hours that a bad PMD would be reported follo=
wed
  by a memory corruption where expected data was all zeros.  A partial re=
port
  of the bad PMD looked like

  [ 5195.338482] ../mm/pgtable-generic.c:33: bad pmd ffff8888157ba008(000=
002e0396009e2)
  [ 5195.341184] ------------[ cut here ]------------
  [ 5195.356880] kernel BUG at ../mm/pgtable-generic.c:35!
  ....
  [ 5195.410033] Call Trace:
  [ 5195.410471]  [<ffffffff811bc75d>] change_protection_range+0x7dd/0x93=
0
  [ 5195.410716]  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
  [ 5195.410918]  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
  [ 5195.411200]  [<ffffffff81098322>] task_work_run+0x72/0x90
  [ 5195.411246]  [<ffffffff81077139>] exit_to_usermode_loop+0x91/0xc2
  [ 5195.411494]  [<ffffffff81003a51>] prepare_exit_to_usermode+0x31/0x40
  [ 5195.411739]  [<ffffffff815e56af>] retint_user+0x8/0x10

  Decoding revealed that the PMD was a valid prot_numa PMD and the bad PM=
D
  was a false detection. The bug does not trigger if automatic NUMA balan=
cing
  or transparent huge pages is disabled.

  The bug is due a race in change_pmd_range between a pmd_trans_huge and
  pmd_nond_or_clear_bad check without any locks held. During the pmd_tran=
s_huge
  check, a parallel protection update under lock can have cleared the PMD
  and filled it with a prot_numa entry between the transhuge check and th=
e
  pmd_none_or_clear_bad check.

  While this could be fixed with heavy locking, it's only necessary to
  make a copy of the PMD on the stack during change_pmd_range and avoid
  races. A new helper is created for this as the check if quite subtle an=
d the
  existing similar helpful is not suitable. This passed 154 hours of test=
ing
  (usually triggers between 20 minutes and 24 hours) without detecting ba=
d
  PMDs or corruption. A basic test of an autonuma-intensive workload show=
ed
  no significant change in behaviour.

Although Mel withdrew the patch on the face of LKML comment https://lkml.=
org/lkml/2017/4/10/922
the race window aforementioned is still open, and we have reports of Linp=
ack test reporting bad
residuals after the bad PMD warning is observed. In addition to that, bad=
 rss-counter and
non-zero pgtables assertions are triggered on mm teardown for the task hi=
tting the bad PMD.

 host kernel: mm/pgtable-generic.c:40: bad pmd 00000000b3152f68(8000000d2=
d2008e7)
 ....
 host kernel: BUG: Bad rss-counter state mm:00000000b583043d idx:1 val:51=
2
 host kernel: BUG: non-zero pgtables_bytes on freeing mm: 4096

The issue is observed on a v4.18-based distribution kernel, but the race =
window is
expected to be applicable to mainline kernels, as well.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 mm/mprotect.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7a8e84f86831..9ea8cc0ab2fd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -161,6 +161,31 @@ static unsigned long change_pte_range(struct vm_area=
_struct *vma, pmd_t *pmd,
 	return pages;
 }
=20
+/*
+ * Used when setting automatic NUMA hinting protection where it is
+ * critical that a numa hinting PMD is not confused with a bad PMD.
+ */
+static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
+{
+	pmd_t pmdval =3D pmd_read_atomic(pmd);
+
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	barrier();
+#endif
+
+	if (pmd_none(pmdval))
+		return 1;
+	if (pmd_trans_huge(pmdval))
+		return 0;
+	if (unlikely(pmd_bad(pmdval))) {
+		pmd_clear_bad(pmd);
+		return 1;
+	}
+
+	return 0;
+}
+
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
@@ -178,8 +203,17 @@ static inline unsigned long change_pmd_range(struct =
vm_area_struct *vma,
 		unsigned long this_pages;
=20
 		next =3D pmd_addr_end(addr, end);
-		if (!is_swap_pmd(*pmd) && !pmd_trans_huge(*pmd) && !pmd_devmap(*pmd)
-				&& pmd_none_or_clear_bad(pmd))
+
+		/*
+		 * Automatic NUMA balancing walks the tables with mmap_sem
+		 * held for read. It's possible a parallel update to occur
+		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
+		 * check leading to a false positive and clearing.
+		 * Hence, it's ecessary to atomically read the PMD value
+		 * for all the checks.
+		 */
+		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
+		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
 			goto next;
=20
 		/* invoke the mmu notifier if the pmd is populated */
--=20
2.24.1

