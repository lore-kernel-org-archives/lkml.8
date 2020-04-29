Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666DC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C772068E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSUOxeDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD2D1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbgD2D1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF03AC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so209786pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxvKdEsbzWLexhjczXLGWAsQ8wUE/7iE8HqIboMrVpI=;
        b=lSUOxeDYze8V31PTz+egnzCkEh33P7lSJWrg5PHVpeYJ6FbWnBHiqx1iV5B5gKH4mc
         mHDkgD2O1N6p2K+umxFLEmCUSx4lNQgF2ynH2aZ1IabsHKyM0KjhdKkxGc1Zo3OkUKi9
         pCBPxa1CoUm4ZFexb0FB6+ftPSqZiyaTpZMt4VlJOrjaVcSL5/B7tTibVgxy+3a0eaus
         uXP+/ICx3qNHizcr+fs2nwlSJuoRsGLX8HqkHqkHSIS0qQubC1t+0cALqtqW+36spGJC
         CYDDyuEzGiKpZqUsUjHymldoISiDajkx+RcdvKSmbCLik6iSeWmTl9smpTF7XnVU9A2E
         nBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxvKdEsbzWLexhjczXLGWAsQ8wUE/7iE8HqIboMrVpI=;
        b=r7khTK5z1InhLxVGKStSpg/etIEtwHrewXmU9xc34qk0Q8ngUNyEaU16uVc8HS5EZl
         D1Axw/KF82pfiGmVsC/BlGaDvceeaa2wcSOfwhMNXBI2Ao9PuvAg4jJ+RNlPsZ+2XnFw
         FapXqhdfTkklX4KIz8crcOhtzGerEv00Pp+TwlQX+X3CYkjtTRZS9s9X9Ig61MUbaplf
         nPyOudfYNGJK0AgqGJGHF0+86JFmyQc2Q9zXq4DUv6jAz8n42xLXp2rydLmMIBUdMUOm
         aWyfHGkQyqHjLvENdFeqp+bTQbOmUjQ2XjvvNpshRAD6DxCtUwXyG8XIsFif+/vK2BUG
         wHYg==
X-Gm-Message-State: AGi0PuZpOPxZd+IBVg5z3DiEqLERIaHuaBrCryfWUH9NsFrjN+yPcBXz
        hAos1lE8seGuDz+hu+8J9vI=
X-Google-Smtp-Source: APiQypJKSgZnczB4t88QIC6U5iAGRia6aXAWJjn7eL62QB9d/UDUX60LObRanrnaMVPF3mgsDQbpWQ==
X-Received: by 2002:a17:90a:a888:: with SMTP id h8mr679701pjq.174.1588130820755;
        Tue, 28 Apr 2020 20:27:00 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:00 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 00/10] change the implementation of the PageHighMem()
Date:   Wed, 29 Apr 2020 12:26:33 +0900
Message-Id: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Changes on v2
- add "acked-by", "reviewed-by" tags
- replace PageHighMem() with use open-code, instead of using
new PageHighMemZone() macro. Related file is "include/linux/migrate.h"

Hello,

This patchset separates two use cases of PageHighMem() by introducing
PageHighMemZone() macro. And, it changes the implementation of
PageHighMem() to reflect the actual meaning of this macro. This patchset
is a preparation step for the patchset,
"mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE" [1].

PageHighMem() is used for two different cases. One is to check if there
is a direct mapping for this page or not. The other is to check the
zone of this page, that is, weather it is the highmem type zone or not.

Until now, both the cases are the perfectly same thing. So, implementation
of the PageHighMem() uses the one case that checks if the zone of the page
is the highmem type zone or not.

"#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))"

ZONE_MOVABLE is special. It is considered as normal type zone on
!CONFIG_HIGHMEM, but, it is considered as highmem type zone
on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
on the ZONE_MOVABLE has no direct mapping until now.

However, following patchset
"mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
, which is once merged and reverted, will be tried again and will break
this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
Hence, the ZONE_MOVABLE which is considered as highmem type zone could
have the both types of pages, direct mapped and not. Since
the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
required to allocate the memory from it. And, we conservatively need to
consider the ZONE_MOVABLE as highmem type zone.

Even in this situation, PageHighMem() for the pages on the ZONE_MOVABLE
when it is called for checking the direct mapping should return correct
result. Current implementation of PageHighMem() just returns TRUE
if the zone of the page is on a highmem type zone. So, it could be wrong
if the page on the MOVABLE_ZONE is actually direct mapped.

To solve this potential problem, this patch introduces a new
PageHighMemZone() macro. In following patches, two use cases of
PageHighMem() are separated by calling proper macro, PageHighMem() and
PageHighMemZone(). Then, implementation of PageHighMem() will be changed
as just checking if the direct mapping exists or not, regardless of
the zone of the page.

Note that there are some rules to determine the proper macro.

1. If PageHighMem() is called for checking if the direct mapping exists
or not, use PageHighMem().
2. If PageHighMem() is used to predict the previous gfp_flags for
this page, use PageHighMemZone(). The zone of the page is related to
the gfp_flags.
3. If purpose of calling PageHighMem() is to count highmem page and
to interact with the system by using this count, use PageHighMemZone().
This counter is usually used to calculate the available memory for an
kernel allocation and pages on the highmem zone cannot be available
for an kernel allocation.
4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
is just copy of the previous PageHighMem() implementation and won't
be changed.

My final plan is to change the name, PageHighMem() to PageNoDirectMapped()
or something else in order to represent proper meaning.

This patchset is based on next-20200428 and you can find the full patchset on the
following link.

https://github.com/JoonsooKim/linux/tree/page_highmem-cleanup-v2.00-next-20200428

Thanks.

[1]: https://lore.kernel.org/linux-mm/1512114786-5085-1-git-send-email-iamjoonsoo.kim@lge.com

Joonsoo Kim (10):
  mm/page-flags: introduce PageHighMemZone()
  drm/ttm: separate PageHighMem() and PageHighMemZone() use case
  kexec: separate PageHighMem() and PageHighMemZone() use case
  power: separate PageHighMem() and PageHighMemZone() use case
  mm/gup: separate PageHighMem() and PageHighMemZone() use case
  mm/hugetlb: separate PageHighMem() and PageHighMemZone() use case
  mm: separate PageHighMem() and PageHighMemZone() use case
  mm/page_alloc: correct the use of is_highmem_idx()
  mm/migrate: replace PageHighMem() with open-code
  mm/page-flags: change the implementation of the PageHighMem()

 drivers/gpu/drm/ttm/ttm_memory.c         |  4 ++--
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |  2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  2 +-
 drivers/gpu/drm/ttm/ttm_tt.c             |  2 +-
 include/linux/migrate.h                  |  4 +++-
 include/linux/page-flags.h               | 10 +++++++++-
 kernel/kexec_core.c                      |  2 +-
 kernel/power/snapshot.c                  | 12 ++++++------
 mm/gup.c                                 |  2 +-
 mm/hugetlb.c                             |  2 +-
 mm/memory_hotplug.c                      |  2 +-
 mm/page_alloc.c                          |  4 ++--
 12 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.7.4

