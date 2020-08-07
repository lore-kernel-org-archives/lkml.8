Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64330C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C92177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gxa+D9jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHGDcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:32:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M9x0l6hGgdMSdeysfRvL+Tj1Vib3d3x0hYON5Gf/yYA=; b=Gxa+D9jN1VSEU0GUa8rxXokui+
        7EIbLk5Jad9g7GNZGHxu7KtoZAZz2qUB/JlSzR9SN9PvLGHn4uLZOqKy3AXe3QsW2tFq6hkB9CfNP
        KA1ei0qqB792hZ1K10rbV0qPOUDX349odwnm1QFFhjRw9cvSOH6grp0rBRWgHCq/REP8QM2elVdPr
        46Wa9oo1Qc3hNT2ba70cF59y4HlGa6qCp7kZcF7Oy9lq1cG+5DNaHbaLUjKSvRL6+YZ0k81s+zj+r
        bjdHXV8aoozLEbsCqVNbiRBhg0i/tpWK92MoMkeS+3Xd4ftvVbGGLHC8Supau+46jbo9IQ5BtWSQE
        MmyFysGA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t73-0006mk-V5; Fri, 07 Aug 2020 03:32:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] kernel: locking: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:32:05 -0700
Message-Id: <20200807033205.8292-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/locking/.
{it, no, the}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 kernel/locking/rtmutex.c   |    4 ++--
 kernel/locking/rwsem.c     |    2 +-
 kernel/locking/semaphore.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200806.orig/kernel/locking/rtmutex.c
+++ linux-next-20200806/kernel/locking/rtmutex.c
@@ -1438,7 +1438,7 @@ rt_mutex_fasttrylock(struct rt_mutex *lo
 }
 
 /*
- * Performs the wakeup of the the top-waiter and re-enables preemption.
+ * Performs the wakeup of the top-waiter and re-enables preemption.
  */
 void rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
@@ -1833,7 +1833,7 @@ struct task_struct *rt_mutex_next_owner(
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Wait for the the lock acquisition started on our behalf by
+ * Wait for the lock acquisition started on our behalf by
  * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
  * rt_mutex_cleanup_proxy_lock().
  *
--- linux-next-20200806.orig/kernel/locking/rwsem.c
+++ linux-next-20200806/kernel/locking/rwsem.c
@@ -1177,7 +1177,7 @@ rwsem_down_write_slowpath(struct rw_sema
 
 		/*
 		 * If there were already threads queued before us and:
-		 *  1) there are no no active locks, wake the front
+		 *  1) there are no active locks, wake the front
 		 *     queued process(es) as the handoff bit might be set.
 		 *  2) there are no active writers and some readers, the lock
 		 *     must be read owned; so we try to wake any read lock
--- linux-next-20200806.orig/kernel/locking/semaphore.c
+++ linux-next-20200806/kernel/locking/semaphore.c
@@ -119,7 +119,7 @@ EXPORT_SYMBOL(down_killable);
  * @sem: the semaphore to be acquired
  *
  * Try to acquire the semaphore atomically.  Returns 0 if the semaphore has
- * been acquired successfully or 1 if it it cannot be acquired.
+ * been acquired successfully or 1 if it cannot be acquired.
  *
  * NOTE: This return value is inverted from both spin_trylock and
  * mutex_trylock!  Be careful about this when converting code.
