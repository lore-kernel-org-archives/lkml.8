Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB18AC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7DA2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M31KD4GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgBCQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:42:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30153 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731585AbgBCQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580748124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=q+0pzRP01lzKhQxJ/kFWkgbd9CvN0FqDS3mFjDxN5jg=;
        b=M31KD4GIButaWkXB/3c/MIvxRtb1mOvI3W9Iw0NEwxBe8r4KWjJlHBNrs2SOHjBSBkAZfq
        O8t3DyfbGlupxIzK9w8V73/x1TNHnmk+Iid4mV8tTWx9jc/0ARDHMfA86a7hu4Vm3Bbw1C
        J6TUUOV9PPw+iycv7xrzDGhUiqDOFcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-o8pzgJ3fOvGDQlZAeFP68Q-1; Mon, 03 Feb 2020 11:42:00 -0500
X-MC-Unique: o8pzgJ3fOvGDQlZAeFP68Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD30DB66;
        Mon,  3 Feb 2020 16:41:59 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CADD910013A7;
        Mon,  3 Feb 2020 16:41:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/7] locking/lockdep: Reuse zapped chain_hlocks entries
Date:   Mon,  3 Feb 2020 11:41:40 -0500
Message-Id: <20200203164147.17990-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v5:
  - Fix more build errors reported by kbuild test robot.

 v4:
  - Fix build errors reported by kbuild test robot.
  - Adopt the single chain block allocator code suggested by PeterZ which
    combine the last 3 patches of v3 series.
  - Add another patch to introduce a fast path in the chain block
    allocator.
  - In patch 1, move the inc_chains() out of CONFIG_TRACE_IRQFLAGS
    conditional compilation block.

 v3:
  - Move the bug fix patches to the beginning of the series.
  - Include a number of changes as suggested by PeterZ.
  - Increase MAX_CHAIN_BUCKETS from 8 to 10 to reduce the chance of using
    the unsized list.
  - Add patch 7 to add a lockdep_early_init() call.
  - Add patch 8 to allocate chain hlocks by splitting large chain block
    as a last resort.

 v2:
  - Revamp the chain_hlocks reuse patch to store the freed chain_hlocks
    information in the chain_hlocks entries themselves avoiding the
    need of a separate set of tracking structures. This, however,
    requires a minimum allocation size of at least 2. Thanks to PeterZ
    for his review and inspiring this change.
  - Remove the leakage counter as it is no longer applicable.
  - Add patch 6 to make the output of /proc/lockdep_chains more readable.

It was found that when running a workload that kept on adding lock
classes and then zapping them repetitively, the system will eventually
run out of chain_hlocks[] entries even though there were still plenty
of other lockdep data buffers available.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
  [ 4318.444809] turning off the locking correctness validator.

In order to fix this problem, we have to make chain_hlocks[] entries
reusable just like other lockdep arrays. Besides that, the patchset
also adds some zapped class and chain_hlocks counters to be tracked by
/proc/lockdep_stats. It also fixes leakage in the irq context counters
and makes the output of /proc/lockdep_chains more readable.


Waiman Long (7):
  locking/lockdep: Decrement irq context counters when removing lock
    chain
  locking/lockdep: Display irq_context names in /proc/lockdep_chains
  locking/lockdep: Track number of zapped classes
  locking/lockdep: Throw away all lock chains with zapped class
  locking/lockdep: Track number of zapped lock chains
  locking/lockdep: Reuse freed chain_hlocks entries
  locking/lockdep: Add a fast path for chain_hlocks allocation

 kernel/locking/lockdep.c           | 335 ++++++++++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  13 +-
 kernel/locking/lockdep_proc.c      |  28 ++-
 3 files changed, 311 insertions(+), 65 deletions(-)

-- 
2.18.1

