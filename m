Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77163C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CF222522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJnkdnk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgAOVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:43:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729578AbgAOVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jrV3VdKCu9ANMDzwxreqt5W8Oq8oCfIw3KZrSIxFIEU=;
        b=dJnkdnk67aCOW7X7OokS7yRVUy5tPEbZq3Z0pPZzPaYuQo4thwHwoQwCfGo1rXq5pXn6+w
        s5N7JRBffWgKO5kGuTg8oM2nr/9QSXaWyGPDHBpKR0ujIAWPwlaYQ9CPcK+xI5IHevgQOr
        zkItCRkkqCd09U4R9icJKIgVZ28M7nQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-rfkX_FtKOz2eECYmiEdBlQ-1; Wed, 15 Jan 2020 16:43:32 -0500
X-MC-Unique: rfkX_FtKOz2eECYmiEdBlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31B4100551A;
        Wed, 15 Jan 2020 21:43:30 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 578A25C553;
        Wed, 15 Jan 2020 21:43:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/8] locking/lockdep: Reuse zapped chain_hlocks entries
Date:   Wed, 15 Jan 2020 16:43:05 -0500
Message-Id: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Waiman Long (8):
  locking/lockdep: Decrement irq context counters when removing lock
    chain
  locking/lockdep: Display irq_context names in /proc/lockdep_chains
  locking/lockdep: Track number of zapped classes
  locking/lockdep: Throw away all lock chains with zapped class
  locking/lockdep: Track number of zapped lock chains
  locking/lockdep: Reuse freed chain_hlocks entries
  locking/lockdep: Add lockdep_early_init() before any lock is taken
  locking/lockdep: Enable chain block splitting as last resort

 include/linux/lockdep.h            |   2 +
 init/main.c                        |   1 +
 kernel/locking/lockdep.c           | 373 ++++++++++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  15 +-
 kernel/locking/lockdep_proc.c      |  25 +-
 5 files changed, 351 insertions(+), 65 deletions(-)

-- 
2.18.1

