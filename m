Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B65620702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgGGLVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:21:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbgGGLVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:21:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 202F7CD21BFBA125AEEB;
        Tue,  7 Jul 2020 19:21:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 19:21:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 0/5] Support Age-Threshold based Garbage Collection for f2fs
Date:   Tue, 7 Jul 2020 19:21:23 +0800
Message-ID: <20200707112128.89136-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce a new garbage collection algorithm named ATGC
(Age Threshold based Garbage Collection) in order to enhance efficiency and
effect of background garbage collection.

ATGC algorithm tries to fliter few oldest candidates according to defined
age threshold, it selects source section in those candidates and then
select target segment which has almost the same age of source section,
finally, it migrates valid blocks from source section into target segment
with SSR allocator, enhancement shows in below aspects:
- it avoids selecting young victim section which may have high update
frequency;
- SSR write avoids unneeded movement of blocks locate in target segment;
- source section and target segment has almost the same age (update
frequency), it keeps well hot/cold separation effect;

Patch 1 introduces in-memory curseg, since it only exists in memory, so it
avoids on-disk layout change whenever we want to add a new type of log.
Firstly, adapting aligned pinfile allocation to use in-memory curseg,
later, we will use in-memory curseg in ATGC feature for migration as well.

Patch 2 changes segment's mtime definition from recording last update time
to recording average update time, so that it can indicate more precise
update time of each valid blocks in segment.

Patch 3 changes segment mtime update policy during GC, 1) don't update
original segment's mtime; 2) inherit segment's mtime from original segment
to target segment.

Patch 4 adds to support 64-bits key in rb-tree node entry, and introduce
f2fs_lookup_rb_tree_ext() to support lookup functionality with 64-bits key.

Patch 5 adds to support ATGC skeleton to enhance effect and efficiency
of BGGC.

Test and result:
- create 160 dirty segments:
 * half of them have 128 valid blocks per segment
 * left of them have 384 valid blocks per segment
- run background GC

Benefit: GC count and block movement count both decrease obviously:

- Before:
GC calls: 162 (BG: 220)

Try to move 41454 blocks (BG: 41454)
  - data blocks : 40960 (40960)

SSR: 0 blocks in 0 segments
LFS: 41364 blocks in 81 segments

- After:
GC calls: 75 (BG: 76)

Try to move 12813 blocks (BG: 12813)
  - data blocks : 12544 (12544)
 
SSR: 12032 blocks in 77 segments
LFS: 855 blocks in 2 segments

Chao Yu (5):
  f2fs: introduce inmem curseg
  f2fs: record average update time of segment
  f2fs: inherit mtime of original block during GC
  f2fs: support 64-bits key in f2fs rb-tree node entry
  f2fs: support age threshold based garbage collection

 fs/f2fs/checkpoint.c        |   7 +-
 fs/f2fs/data.c              |   2 +-
 fs/f2fs/debug.c             |  10 +-
 fs/f2fs/extent_cache.c      |  37 +++-
 fs/f2fs/f2fs.h              |  50 ++++-
 fs/f2fs/file.c              |   3 +-
 fs/f2fs/gc.c                | 373 +++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.h                |  25 +++
 fs/f2fs/segment.c           | 331 +++++++++++++++++++++++++-------
 fs/f2fs/segment.h           |  40 +++-
 fs/f2fs/super.c             |  19 +-
 include/trace/events/f2fs.h |   8 +-
 12 files changed, 798 insertions(+), 107 deletions(-)

-- 
2.26.2

