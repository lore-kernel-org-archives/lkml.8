Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0916C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C141420706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873045;
	bh=GR6ogSxmcukOgF4mhlKqOxxYURZEZlC7F/ht+xRgJQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=weQB5V4yYWEQ9Qg9+KpxPk7UzAYGNvOgED2uAoWC6bvi7/TGcCo7rEGGmLNNhRAbd
	 R5PkELH0CalPqR1B4jQnFu47XGINpYC8O+uD65ooWSXmy3t7+q3nrE59lmZuPETKmp
	 fyIrhfursf0ATV8Z93JHnzHqs7BYqNdtTcgfa6vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgFWAoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732163AbgFWAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252CC20874;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873016;
        bh=GR6ogSxmcukOgF4mhlKqOxxYURZEZlC7F/ht+xRgJQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O63hfk33Uc841mQwyHC0jVGfE+PsV/oqXYkheo6LyuglgqOb+vlT0cN35aMhSBQXB
         RZgN/dHyveMlR9C9ZDSFS9jtQDjti0kin9/1sd8/gfnTx6VUNhFFRRIv8DvCUcU8cT
         Kxbhf+2crGK0MNUHXZdtQI1d4ic1OLTYp6uwWn8c=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] locking/osq_lock: Annotate a data race in osq_lock
Date:   Mon, 22 Jun 2020 17:43:28 -0700
Message-Id: <20200623004333.27227-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

The prev->next pointer can be accessed concurrently as noticed by KCSAN:

 write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
  osq_lock+0x25f/0x350
  osq_wait_next at kernel/locking/osq_lock.c:79
  (inlined by) osq_lock at kernel/locking/osq_lock.c:185
  rwsem_optimistic_spin
  <snip>

 read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
  osq_lock+0x196/0x350
  osq_lock at kernel/locking/osq_lock.c:157
  rwsem_optimistic_spin
  <snip>

Since the write only stores NULL to prev->next and the read tests if
prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
shattered, the code is still working correctly. Thus, mark it as an
intentional data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/osq_lock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f77349..1de006e 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 */
 
 	for (;;) {
-		if (prev->next == node &&
+		/*
+		 * cpu_relax() below implies a compiler barrier which would
+		 * prevent this comparison being optimized away.
+		 */
+		if (data_race(prev->next) == node &&
 		    cmpxchg(&prev->next, node, NULL) == node)
 			break;
 
-- 
2.9.5

