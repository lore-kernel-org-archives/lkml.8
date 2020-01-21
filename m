Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799F722314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chTWIakN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgAUPlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:41:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729308AbgAUPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579621270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=z+b6V5HeDud0yNsGLpuh/dUUx85IomN3FAlI0ft8ea0=;
        b=chTWIakNG7d/m224OHjgHBM6Q60L+KD4DmTv1kCsP/Q1IoKYG4of8YaNfTTk/ZaDZZsD3q
        eJYnHxR7p4lyA0vVVUbXRXWFOE2uDE5Njkl9mbOr3VFWkfY1UsZier2OZJXyfEaOr/I6oe
        O8gH1bG/hcqpUtaC+O+u4AoqaQGLiyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-_02OV-LvPEyVIJO_q3NS6w-1; Tue, 21 Jan 2020 10:41:08 -0500
X-MC-Unique: _02OV-LvPEyVIJO_q3NS6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6217B18C35C1;
        Tue, 21 Jan 2020 15:41:07 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95DB46025F;
        Tue, 21 Jan 2020 15:41:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 7/7] locking/lockdep: Add a fast path for chain_hlocks allocation
Date:   Tue, 21 Jan 2020 10:40:09 -0500
Message-Id: <20200121154009.11993-8-longman@redhat.com>
In-Reply-To: <20200121154009.11993-1-longman@redhat.com>
References: <20200121154009.11993-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 6d0f6a256d63..12148bb6d2c1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2702,15 +2702,19 @@ static inline int chain_block_size(int offset)
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
@@ -2810,6 +2814,18 @@ static int alloc_chain_hlocks(int req)
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

