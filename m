Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C87C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC7420739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgGPMiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgGPMiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50EC0B93C;
        Thu, 16 Jul 2020 12:38:22 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 00/15] Hwpoison soft-offline rework
Date:   Thu, 16 Jul 2020 14:37:54 +0200
Message-Id: <20200716123810.25292-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a follow-up version on [1].
That version had some flaws wrt. handling hugetlb pages, so this version
fixes it.
I checked that the case reported by Qian seems to work fine now.

Cover letter:

This patchset was initially based on Naoya's hwpoison rework [1], so
thanks to him for the initial work.
I would also like to think Naoya for testing the patchset off-line,
and report any issues he found, that was quite helpful.

This patchset aims to fix some issues laying in soft-offline handling,
but it also takes the chance and takes some further steps to perform 
cleanups and some refactoring as well.


 - Motivation:

   A customer and I were facing an issue were processes were killed
   after having soft-offlined some of their pages.
   This should not happen when soft-offlining, as it is meant to be non-disruptive.
   I was able to reproduce the issue when I stressed the memory +
   soft offlining pages in the meantime.

   After debugging the issue, I saw that the problem was that pages were returned
   back to user-space after having offlined them properly.
   So, when those pages were faulted in, the fault handler returned VM_FAULT_POISON
   all the way down to the arch handler, and it simply killed the process.

   After a further anaylsis, it became clear that the problem was that when
   kcompactd kicked in to migrate pages over, compaction_alloc callback
   was handing poisoned pages to the migrate routine.

   All this could happen because isolate_freepages_block and
   fast_isolate_freepages just check for the page to be PageBuddy,
   and since 1) poisoned pages can be part of a higher order page
   and 2) poisoned pages are also Page Buddy, they can sneak in easily.

   I also saw some other problems with sawap pages, but I suspected it
   to be the same sort of problem, so I did not follow that trace.

   The above refers to soft-offline.
   But I also saw problems with hard-offline, specially hugetlb corruption,
   and some other weird stuff. (I could paste the logs)

   The full explanation refering to the soft-offline case can be found at [2].

 - Approach:

   The taken approach is to contain those pages and never let them hit 
   neither pcplists nor buddy freelists.
   Only when they are completely out of reach, we flag them as poisoned.

   A full explanation of this can be found in patch#11 and patch#12

 - Outcome:

   With this patchset, I no longer see the issues with soft-offline.

[1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
[2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u

Naoya Horiguchi (6):
  mm,hwpoison: cleanup unused PageHuge() check
  mm, hwpoison: remove recalculating hpage
  mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
  mm,hwpoison-inject: don't pin for hwpoison_filter
  mm,hwpoison: remove MF_COUNT_INCREASED
  mm,hwpoison: remove flag argument from soft offline functions

Oscar Salvador (9):
  mm,madvise: Refactor madvise_inject_error
  mm,hwpoison: Un-export get_hwpoison_page and make it static
  mm,hwpoison: Kill put_hwpoison_page
  mm,hwpoison: Unify THP handling for hard and soft offline
  mm,hwpoison: Rework soft offline for free pages
  mm,hwpoison: Rework soft offline for in-use pages
  mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
  mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
  mm,hwpoison: introduce MF_MSG_UNSPLIT_THP

 drivers/base/memory.c      |   2 +-
 include/linux/mm.h         |  12 +-
 include/linux/page-flags.h |   6 +-
 include/ras/ras_event.h    |   3 +
 mm/hugetlb.c               |  60 +++++++-
 mm/hwpoison-inject.c       |  18 +--
 mm/madvise.c               |  37 ++---
 mm/memory-failure.c        | 307 +++++++++++++++----------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  70 +++++++--
 10 files changed, 270 insertions(+), 256 deletions(-)

-- 
2.26.2

