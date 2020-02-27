Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892CC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E72246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgB0Vcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:32:52 -0500
Received: from shelob.surriel.com ([96.67.55.147]:46242 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgB0Vcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:32:48 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j7Qlq-0007O1-Sd; Thu, 27 Feb 2020 16:32:38 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org, riel@fb.com
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH v2 0/2] fix THP migration for CMA allocations
Date:   Thu, 27 Feb 2020 16:32:27 -0500
Message-Id: <cover.1582321646.git.riel@surriel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transparent huge pages are allocated with __GFP_MOVABLE, and can end
up in CMA memory blocks. Transparent huge pages also have most of the
infrastructure in place to allow migration.

However, a few pieces were missing, causing THP migration to fail when
attempting to use CMA to allocate 1GB hugepages.

With these patches in place, THP migration from CMA blocks seems to
work, both for anonymous THPs and for tmpfs/shmem THPs.

v2:
- addressed comments by Vlastimil Babka and Zi Yan

Rik van Riel (2):
  mm,compaction,cma: add alloc_contig flag to compact_control
  mm,thp,compaction,cma: allow THP migration for CMA allocations

 mm/compaction.c | 16 +++++++++-------
 mm/internal.h   |  1 +
 mm/page_alloc.c |  7 +++++--
 3 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.24.1

