Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBC3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D2121527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5Ai5zIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFQRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:53:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726971AbgFQRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592416416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=nZ5C14WBF2RL2CpjdWeV+6NmODm1y6ubQinAU14aVrY=;
        b=B5Ai5zIp9pO9v9BoIa2hhRHRGfZN6o8lpesf9WhAtor1EE3LtqooqJWLI+HHBoZrWomWDW
        h7qZGE+g2a2VHTe/9wFRcEDX31O7Vi22DPlit1Or01V5WZhBwOljlvqmaC8UOSdhKQN6Nw
        9v8VfqO0fjEjl2U0AH0bA5zSgHAKz/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-G7VIZtFjOPOhpOG9I6HNZg-1; Wed, 17 Jun 2020 13:53:32 -0400
X-MC-Unique: G7VIZtFjOPOhpOG9I6HNZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11244100CCC0;
        Wed, 17 Jun 2020 17:53:30 +0000 (UTC)
Received: from llong.com (ovpn-117-167.rdu2.redhat.com [10.10.117.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64B6580880;
        Wed, 17 Jun 2020 17:53:19 +0000 (UTC)
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
Subject: [PATCH v2 0/2] sched, xfs: Add PF_MEMALLOC_NOLOCKDEP to fix lockdep problem in xfs
Date:   Wed, 17 Jun 2020 13:53:08 -0400
Message-Id: <20200617175310.20912-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Update patch to add the frozen flag check as the XFS_TRANS_NO_WRITECOUNT
    check alone is insufficient.

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
 fs/xfs/xfs_trans.c       | 31 +++++++++++++++++++++++++++----
 include/linux/sched.h    |  7 +++++++
 include/linux/sched/mm.h | 15 ++++++++++-----
 4 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.18.1

