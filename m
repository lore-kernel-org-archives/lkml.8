Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E47C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29020705
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ADvKaVVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCGCMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:12:01 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2142 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCGCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:12:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6302c50001>; Fri, 06 Mar 2020 18:11:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Mar 2020 18:12:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Mar 2020 18:12:00 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Mar
 2020 02:11:59 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 7 Mar 2020 02:11:59 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e6302ef0000>; Fri, 06 Mar 2020 18:11:59 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/gup: fixup for ce35133be382 mm/gup: track FOLL_PIN pages
Date:   Fri, 6 Mar 2020 18:11:57 -0800
Message-ID: <20200307021157.235726-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583547078; bh=iLW9L2KGSEmZt4RMbKRU9iH7ArJGdygY6FFfahuV/tQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=ADvKaVVX6pXY8WUtRIsve54FkosMGm3HbHmXkN7J3MO7EqMeVD1eqfL4Xk4Uh4Pgl
         RerHhHE24nq0mK2MEiC2Znu1sTxa8ZOv3xR9r1xj88KiHvtELgAUiLfKtfsxN0OySV
         EtyPkb5UJOxQ5novejG+pBg61Uvmli8uUYiRhjjrlGPbo2QI0TTXkMZtwjzKmJcm6Z
         s/6uRS1Yuo7AksZjDpzJJI/r2MaYVIJBnXDnWWDhQGOau6FYaxyQtOeOKC/m4Aiytt
         fycklPSUQDfpMcO6LA2Aac2qxAveVZY/TutWbesqSrnUR0qWFwXtKqSTDLOHTJlRXW
         OmrHPv/APW6qQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fixup for the mmotm commit ce35133be382
("mm/gup: track FOLL_PIN pages").

Add kerneldoc comments for pin_user_pages*() routines, in order
to get rid of "make -W1" warnings when building mm/gup.o.

This just adds @param documentation of:
    pin_user_pages()
    pin_user_pages_fast()
    pin_user_pages_remote()

The param documentation was stolen from other gup.c functions,
because it looks reasonable enough.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f589299b0d4a..54af3b290cb0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2766,6 +2766,12 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 /**
  * pin_user_pages_fast() - pin user pages in memory without taking locks
  *
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying pin behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long.
+ *
  * Nearly the same as get_user_pages_fast(), except that FOLL_PIN is set. =
See
  * get_user_pages_fast() for documentation on the function arguments, beca=
use
  * the arguments here are identical.
@@ -2791,6 +2797,21 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
 /**
  * pin_user_pages_remote() - pin pages of a remote process (task !=3D curr=
ent)
  *
+ * @tsk:	the task_struct to use for page fault accounting, or
+ *		NULL if faults are not to be recorded.
+ * @mm:		mm_struct of target mm
+ * @start:	starting user address
+ * @nr_pages:	number of pages from start to pin
+ * @gup_flags:	flags modifying lookup behaviour
+ * @pages:	array that receives pointers to the pages pinned.
+ *		Should be at least nr_pages long. Or NULL, if caller
+ *		only intends to ensure the pages are faulted in.
+ * @vmas:	array of pointers to vmas corresponding to each page.
+ *		Or NULL if the caller does not require them.
+ * @locked:	pointer to lock flag indicating whether lock is held and
+ *		subsequently whether VM_FAULT_RETRY functionality can be
+ *		utilised. Lock must initially be held.
+ *
  * Nearly the same as get_user_pages_remote(), except that FOLL_PIN is set=
. See
  * get_user_pages_remote() for documentation on the function arguments, be=
cause
  * the arguments here are identical.
@@ -2819,6 +2840,15 @@ EXPORT_SYMBOL(pin_user_pages_remote);
 /**
  * pin_user_pages() - pin user pages in memory for use by other devices
  *
+ * @start:	starting user address
+ * @nr_pages:	number of pages from start to pin
+ * @gup_flags:	flags modifying lookup behaviour
+ * @pages:	array that receives pointers to the pages pinned.
+ *		Should be at least nr_pages long. Or NULL, if caller
+ *		only intends to ensure the pages are faulted in.
+ * @vmas:	array of pointers to vmas corresponding to each page.
+ *		Or NULL if the caller does not require them.
+ *
  * Nearly the same as get_user_pages(), except that FOLL_TOUCH is not set,=
 and
  * FOLL_PIN is set.
  *
--=20
2.25.1

