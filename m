Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E27722464
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2d4PRk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBFPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727557AbgBFPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aPgiA1OtmGuRouwsyuC9sSRrGiRoJxoCsokGWtKftGY=;
        b=b2d4PRk61ErQEbxNDtmMyoVOu7wM6Cc23KpHnztbCeYCpWvG+7pMnreNSaa5TiITEDFccx
        MxBAdta1DlqmrN9U/nYU+dYSF6Ul7BqNssP6UZDDU7jrAz7tUpvIydBJzBesDEAGcK9QiW
        8IqpTRf5Otc5KvJfbYYNXv1/nJHYnXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-HQSgmVpvNeq9VZ9mxPSrKw-1; Thu, 06 Feb 2020 10:24:23 -0500
X-MC-Unique: HQSgmVpvNeq9VZ9mxPSrKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B7B11050D9;
        Thu,  6 Feb 2020 15:24:21 +0000 (UTC)
Received: from llong.com (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81BDD1001B05;
        Thu,  6 Feb 2020 15:24:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/6] locking/lockdep: Reuse zapped chain_hlocks entries
Date:   Thu,  6 Feb 2020 10:24:02 -0500
Message-Id: <20200206152408.24165-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v6:
  - Drop patch 7 for now.
  - Incorporate further changes as suggested by PeterZ.
  - Increase MAX_CHAIN_BUCKETS to 16 to further minimize the possibility
    of having more than one chain block in bucket 0.

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

Waiman Long (6):
  locking/lockdep: Decrement irq context counters when removing lock
    chain
  locking/lockdep: Display irq_context names in /proc/lockdep_chains
  locking/lockdep: Track number of zapped classes
  locking/lockdep: Throw away all lock chains with zapped class
  locking/lockdep: Track number of zapped lock chains
  locking/lockdep: Reuse freed chain_hlocks entries

 kernel/locking/lockdep.c           | 332 ++++++++++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  14 +-
 kernel/locking/lockdep_proc.c      |  31 ++-
 3 files changed, 312 insertions(+), 65 deletions(-)

-- 
2.18.1

