Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F64D2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7L0RWiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgFOQWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:22:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731045AbgFOQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592238153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fj+Ws6jrNQB44QmBkeAf7Ztl5z44gdwWQgx2FiYqdPI=;
        b=Q7L0RWiVEA8/dwmkgEHF6XTd/Z2CkV8fsWpWdAHTPQJYpBTJ5d1h5qFAErXkz2o52aQM/A
        7x0J3Pe/EaV+mspqqgQ7xWI5xr5gWdlNlOidRT6ULXihnkBY4UTfKst1EAeMx72VG3ji19
        OM2czw9Yk5S9Icmbz4GlFIXs0E9PrK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-fjpVyYLxPbOk1wWo9e-x3w-1; Mon, 15 Jun 2020 12:22:23 -0400
X-MC-Unique: fjpVyYLxPbOk1wWo9e-x3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 904ED1155BC5;
        Mon, 15 Jun 2020 16:09:24 +0000 (UTC)
Received: from llong.com (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21630108BF;
        Mon, 15 Jun 2020 16:09:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        Eric Sandeen <sandeen@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] sched, xfs: Add PF_MEMALLOC_NOLOCKDEP to fix lockdep problem in xfs
Date:   Mon, 15 Jun 2020 12:08:28 -0400
Message-Id: <20200615160830.8471-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a false positive lockdep warning in how the xfs code handle
filesystem freeze:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_internal);
                               lock(fs_reclaim);
                               lock(sb_internal);
  lock(fs_reclaim);

 *** DEADLOCK ***

This patch series works around this problem by adding a
PF_MEMALLOC_NOLOCKDEP flag and set during filesystem freeze to avoid
the lockdep splat.

Waiman Long (2):
  sched: Add PF_MEMALLOC_NOLOCKDEP flag
  xfs: Fix false positive lockdep warning with sb_internal & fs_reclaim

 fs/xfs/xfs_log.c         |  9 +++++++++
 fs/xfs/xfs_trans.c       | 30 ++++++++++++++++++++++++++----
 include/linux/sched.h    |  7 +++++++
 include/linux/sched/mm.h | 15 ++++++++++-----
 4 files changed, 52 insertions(+), 9 deletions(-)

-- 
2.18.1

