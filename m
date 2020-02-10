Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C135C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DF320715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUSJjiOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJUr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:47:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgBJUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581367677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yPQQ4pseeSMJlwHO9Wp9JJRVrfULoCXznNOttcSYqHw=;
        b=YUSJjiOiy8p8NaEpWEC2rWyQlOj3drGsM/HSYKfo5Z7iZoZEAvhU5T67Y9ru9aazvGzBsa
        wuiSUTT42v5L4NGXivaRKVseXuU15/s+ol70ckM+DUJoZfG7lInL62eviCHpkw4S/RZFDg
        Ogo5ONCj0PvUcI9MbO3Z4GKdqIbiaGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-YbUKrn-uN-2QeyOuRoMS9Q-1; Mon, 10 Feb 2020 15:47:55 -0500
X-MC-Unique: YbUKrn-uN-2QeyOuRoMS9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB5A610054E3;
        Mon, 10 Feb 2020 20:47:53 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B92987B01;
        Mon, 10 Feb 2020 20:47:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] locking/mutex: Add mutex_timed_lock() to solve potential deadlock problems
Date:   Mon, 10 Feb 2020 15:46:48 -0500
Message-Id: <20200210204651.21674-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When writing to the some of the sysctl parameters or sysfs files,
locks may be taken in an order that is different from other parts of
the kernel. As a result, lockdep may complain about circular locking
dependency indicating that deadlock may actually happen in some corner
cases. Patch 3 shows an example of this in the sysfs files of the
slub allocator.

It is typically hard to change the locking order in many cases. One
possible solution is to use a trylock loop. That is considered inelegant
and it is hard to control the actual wait time.

An alternative solution proposed by this patchset is to add a new
mutex_timed_lock() call that allows an additional timeout argument. This
function will return an error code if timeout happens. The use of this
new API will prevent deadlock from happening while allowing the task
to wait a sufficient period of time before giving up.

The goal of this new API is to prevent deadlock from happening, so
timeout accuracy is not high on the priority list. A coarse-grained
and easily understood millisecond based integer timeout argument is
used. That is somewhat different from the rt_mutex_timed_lock() function
where a more precise but complex hrtimer_sleeper argument is used.

On a 4-socket 128-thread x86-64 running a 128-thread mutex locking
microbenchmark with 1ms timeout, the output of the microbenchmark were:

  Running locktest with mutex [runtime = 10s, load = 1]
  Threads = 128, Min/Mean/Max = 247,667/601,134/1,621,145
  Threads = 128, Total Rate = 7,694 kop/s; Percpu Rate = 60 kop/s

The corresponding mutex locking events were:

  mutex_handoff=2032
  mutex_optspin=3486239
  mutex_sleep=2047
  mutex_slowpath=3626
  mutex_timeout=294

Waiman Long (3):
  locking/mutex: Add mutex_timed_lock()
  locking/mutex: Enable some lock event counters
  mm/slub: Fix potential deadlock problem in slab_attr_store()

 include/linux/mutex.h             |   3 +
 kernel/locking/lock_events_list.h |   9 +++
 kernel/locking/mutex.c            | 114 +++++++++++++++++++++++++++---
 mm/slub.c                         |   7 +-
 4 files changed, 123 insertions(+), 10 deletions(-)

-- 
2.18.1

