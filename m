Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85EEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8226320704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0s4eSwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEZRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:44:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726930AbgEZRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590515061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ikyw/aUF3Qy2tXbuYHy4ZgKqsS/cw/f1Zn/iqfDGVeU=;
        b=b0s4eSwRc3TmNmSOyq84laT6qWLbzPZWEFUk/lN/CWeoj7GCN9ufSajuOdm1omDtN86IpQ
        YKzlQ7dbanvhnjtgjyxs79ga1dvHabK2bolt8/nJsVptmOD9p9Mpdx6P/DEkmX5XAHrVlr
        ClAQJ9XOxOyb0qBxxJ02kTgsqGGYf2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Ca5Zx3YaMUmWyedi8SHmLg-1; Tue, 26 May 2020 13:44:17 -0400
X-MC-Unique: Ca5Zx3YaMUmWyedi8SHmLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB31100CCCA;
        Tue, 26 May 2020 17:44:16 +0000 (UTC)
Received: from llong.com (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE7919D61;
        Tue, 26 May 2020 17:44:10 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Date:   Tue, 26 May 2020 13:43:49 -0400
Message-Id: <20200526174349.8312-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found by Qian Cai that lockdep splat sometimes appears with the
"BUG: MAX_LOCKDEP_ENTRIES too low" message on linux-next. On a 32-vcpu VM
guest with a v5.7-rc7 based kernel, I looked at how many of the various
table entries were being used after bootup and after a parallel kernel
build (make -j32). The tables below show the usage statistics.

  After bootup:

  Table               Used        Max      %age
  -----               ----        ---      ----
  lock_classes[]      1834       8192      22.4
  list_entries[]     15646      32768      47.7
  lock_chains[]      20873      65536      31.8
  chain_hlocks[]     83199     327680      25.4
  stack_trace[]     146177     524288      27.9

  After parallel kernel build:

  Table               Used        Max      %age
  -----               ----        ---      ----
  lock_classes[]      1864       8192      22.8
  list_entries[]     17134      32768      52.3
  lock_chains[]      25196      65536      38.4
  chain_hlocks[]    106321     327680      32.4
  stack_trace[]     158700     524288      30.3

Percentage-wise, it can be seen that the list_entries for direct
dependencies are used much more than the other tables. So it is also
the table that is mostly likely to run out of space when running a
compex workload.

To reduce the likelihood of running out of table entries, we can increase
MAX_LOCKDEP_ENTRIES by 50% from 16384/32768 to 24576/49152.  On a 64-bit
architecture, that represents an increase in memory consumption of
917504 bytes. With that change, the percentage usage of list_entries[]
will fall to 31.8% and 34.9% respectively to make them more in line
with the other tables.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep_internals.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index baca699b94e9..6108d2fbe775 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -89,12 +89,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
-#define MAX_LOCKDEP_ENTRIES	16384UL
+#define MAX_LOCKDEP_ENTRIES	24576UL
 #define MAX_LOCKDEP_CHAINS_BITS	15
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
-#define MAX_LOCKDEP_ENTRIES	32768UL
+#define MAX_LOCKDEP_ENTRIES	49152UL
 
 #define MAX_LOCKDEP_CHAINS_BITS	16
 
-- 
2.18.1

