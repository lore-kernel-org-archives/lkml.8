Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0259DC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EEF21775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHKe7K8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgBCQm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:42:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35634 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgBCQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580748130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9VWvQGPBU27LRODQE2DAzJDJigt9+M/hKMjwHQzqBmo=;
        b=GHKe7K8sBu+oI2QraYwK2qk3P2AoWVoT/Lnp8YHxsksWgCEnzagV1FTmbIyYyiWp5RvZ3v
        drXs3IX7jkza2JUFqe+T1g7VoB0AzH0M/KBjpNRNX2xTnlLFn0LY5aOtYdQutfoTUsc4UV
        BJjNk7I9mQh21DKPCgvAduOu2m3a6u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-vsiP23bRPAiOaPkuxqgK3A-1; Mon, 03 Feb 2020 11:42:06 -0500
X-MC-Unique: vsiP23bRPAiOaPkuxqgK3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155C9100726A;
        Mon,  3 Feb 2020 16:42:05 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E03510013A7;
        Mon,  3 Feb 2020 16:42:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks allocation
Date:   Mon,  3 Feb 2020 11:41:47 -0500
Message-Id: <20200203164147.17990-8-longman@redhat.com>
In-Reply-To: <20200203164147.17990-1-longman@redhat.com>
References: <20200203164147.17990-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When alloc_chain_hlocks() is called, the most likely scenario is
to allocate from the primordial chain block which holds the whole
chain_hlocks[] array initially. It is the primordial chain block if its
size is bigger than MAX_LOCK_DEPTH. As long as the number of entries left
after splitting is still bigger than MAX_CHAIN_BUCKETS it will remain
in bucket 0. By splitting out a sub-block at the end, we only need to
adjust the size without changing any of the existing linkage information.
This optimized fast path can reduce the latency of allocation requests.

This patch does change the order by which chain_hlocks entries are
allocated. The original code allocates entries from the beginning of
the array. Now it will be allocated from the end of the array backward.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 70288bb2331d..d05799872882 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2701,15 +2701,19 @@ static inline int chain_block_size(int offset)
 	return (chain_hlocks[offset + 2] << 16) | chain_hlocks[offset + 3];
 }
 
+static inline void init_chain_block_size(int offset, int size)
+{
+	chain_hlocks[offset + 2] = size >> 16;
+	chain_hlocks[offset + 3] = (u16)size;
+}
+
 static inline void init_chain_block(int offset, int next, int bucket, int size)
 {
 	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
 	chain_hlocks[offset + 1] = (u16)next;
 
-	if (bucket == 0) {
-		chain_hlocks[offset + 2] = size >> 16;
-		chain_hlocks[offset + 3] = (u16)size;
-	}
+	if (bucket == 0)
+		init_chain_block_size(offset, size);
 }
 
 static inline void add_chain_block(int offset, int size)
@@ -2809,6 +2813,18 @@ static int alloc_chain_hlocks(int req)
 			return curr;
 		}
 
+		/*
+		 * Fast path: splitting out a sub-block at the end of the
+		 * primordial chain block.
+		 */
+		if (likely((size > MAX_LOCK_DEPTH) &&
+			   (size - req > MAX_CHAIN_BUCKETS))) {
+			size -= req;
+			nr_free_chain_hlocks -= req;
+			init_chain_block_size(curr, size);
+			return curr + size;
+		}
+
 		if (size > max_size) {
 			max_prev = prev;
 			max_curr = curr;
-- 
2.18.1

