Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9AC206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490606;
	bh=r82tKIi8mDH0MV9ri2qt6LEF7mgjBkWhy3KjXEKilYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wrH8gOBfNhxJkD/AwkmBBD4+62G1A9IW8un1Z+o/C0Xxb7w+hz9QdzOPnG9Kb3sxc
	 HX6UIci4ki4zikkSlt3eADGZEgRkJvlA6VB52J2y7PrBE6aAZRqf/dndjxsGRDClrM
	 KgZ9ws+AimElUkqWkuYEMjRwQbfGDZ4v94HEB5BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgDJDuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgDJDt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B5821841;
        Fri, 10 Apr 2020 03:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490596;
        bh=r82tKIi8mDH0MV9ri2qt6LEF7mgjBkWhy3KjXEKilYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKBMZA7Zk25kz0xh5k6jNFq3xat1+dvXjpVXX/Dfn+0AdpUdJT2Rhie20dsr4vloD
         T5SU9kG4eSS/a5NQHOxL9eeackCf0QI35yVlQhwnNaPf8D0WB7HC+1iJaR9s1uAyqz
         JY7K1dV4SMfSzhLN1HZnTjDEyjTCVFCgXI/cLrL4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, Qian Cai <cai@lca.pw>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 40/46] locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()
Date:   Thu,  9 Apr 2020 23:49:03 -0400
Message-Id: <20200410034909.8922-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034909.8922-1-sashal@kernel.org>
References: <20200410034909.8922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

[ Upstream commit 25016bd7f4caf5fc983bbab7403d08e64cba3004 ]

Qian Cai reported a bug when PROVE_RCU_LIST=y, and read on /proc/lockdep
triggered a warning:

  [ ] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
  ...
  [ ] Call Trace:
  [ ]  lock_is_held_type+0x5d/0x150
  [ ]  ? rcu_lockdep_current_cpu_online+0x64/0x80
  [ ]  rcu_read_lock_any_held+0xac/0x100
  [ ]  ? rcu_read_lock_held+0xc0/0xc0
  [ ]  ? __slab_free+0x421/0x540
  [ ]  ? kasan_kmalloc+0x9/0x10
  [ ]  ? __kmalloc_node+0x1d7/0x320
  [ ]  ? kvmalloc_node+0x6f/0x80
  [ ]  __bfs+0x28a/0x3c0
  [ ]  ? class_equal+0x30/0x30
  [ ]  lockdep_count_forward_deps+0x11a/0x1a0

The warning got triggered because lockdep_count_forward_deps() call
__bfs() without current->lockdep_recursion being set, as a result
a lockdep internal function (__bfs()) is checked by lockdep, which is
unexpected, and the inconsistency between the irq-off state and the
state traced by lockdep caused the warning.

Apart from this warning, lockdep internal functions like __bfs() should
always be protected by current->lockdep_recursion to avoid potential
deadlocks and data inconsistency, therefore add the
current->lockdep_recursion on-and-off section to protect __bfs() in both
lockdep_count_forward_deps() and lockdep_count_backward_deps()

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200312151258.128036-1-boqun.feng@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 35d3b6925b1ee..9ab1a965c3b92 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1719,9 +1719,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1746,9 +1748,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
-- 
2.20.1

