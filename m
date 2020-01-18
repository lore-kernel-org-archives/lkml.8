Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D44DC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EB12072E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579369995;
	bh=IhgNoAO3V99nXNv0RfXI8EmPEK0LnOheo172wW6tKq4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vsFMKw9PcIgzcBq2ZxZNpdaL7+rmR7uCZ4DjMXuLHRV8VRcdnW1h1teOGy4ATtJqE
	 MVx2MM3KBKf6pIuLF/6NeKxxgtx6cWOf7CIUYICatIbCMwc0+az36tN3kmCn/FmTYd
	 i1YB9r03g46Dadk5zn2FGaQ5Ee2Cj/pHtVBo/ePI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgARRxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:53:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37138 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgARRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:53:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so10693256wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0j9p8LNvW8RqHF9gvYr3mNEz1qEtM+kvT1lQCpirrFw=;
        b=tOul2G8Fc00I2sMARIOMncZ7OaZ7AUcm6R73W6lXvvD00y/c8j1S5GHPsgSe4B3fi2
         lDghNBhKZW+NILUQITY2XJABgUzs1UsOO8qbSju9VZDk+iqqrnE/8MhfkiAXKMrewpjp
         AtIULrnFkausVWrgnK9qbzd26nzwLuSDt2nE8Zc2iWOi1udeYlGkKGT6YG16SJMrK95p
         Yjhl9JwkmnwpFdw6fXmocJAfmngH/v4rHW3Q9ZJTWzDVYjm6Wf3QLUHKMiubO4qvrRN7
         R6jPRmuyWfgWpKX5AO9EfBwoCcCo4c5/eoSFbVrqKHqWYmwqsaPAOojij9OO424uBpwk
         iCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0j9p8LNvW8RqHF9gvYr3mNEz1qEtM+kvT1lQCpirrFw=;
        b=rnqTv/ANlWgV2RqaxzmgP3bdScLC/LQji5UVyerbGhZHk9lNdMlsPm4hsgRxYOLJQ2
         11YwoYeAgfcG3CZpe9FPQuUgErY761BaWAWne4KQFApNQyoLgiPeRJSoNgUTs330lE+y
         p++Z1aPoWe4+sLfvmMa+PnxG8PmQIRFIp4d5C53l7U+vTkSymFvOr09BkFmbYU7thBOx
         aRY4sJISUsnqU2cUzQqNLKUh8Kjh4k2+AXjHfFfaheW3JDvpq/DP9s1DxmRTxSqFguiV
         JnW0Uz5OBAmXsd9M96vJX7jXUXeT9qDnVB3TvuGRBhpWumx1ruu9KvcjPI+XnMkM3GKl
         NXYQ==
X-Gm-Message-State: APjAAAXGs7ZMBCOoSX4bG3F6mb6Q1yentITUGd1Jr75yRzhBXXOk9s6o
        J+1Fm2+181kWI+b8ht0vUVo=
X-Google-Smtp-Source: APXvYqyr0xh4B5zpk0wA7I2nIDbCNqpQS0E1vQ0YvausWFG2LPe5ReZr06AZoXiJ4j059VqR0Egy/w==
X-Received: by 2002:a1c:8116:: with SMTP id c22mr10590831wmd.27.1579369992066;
        Sat, 18 Jan 2020 09:53:12 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w22sm7423841wmk.34.2020.01.18.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:53:11 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:53:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20200118175309.GA19218@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 39e7234f00bc93613c086ae42d852d5f4147120a locking/rwsem: Fix kernel crash when spinning on RWSEM_OWNER_UNKNOWN

Three fixes:

 - Fix an rwsem spin-on-owner crash, introduced in v5.4
 - Fix a lockdep bug when running out of stack_trace entries, introduced in v5.4
 - Docbook fix

 Thanks,

	Ingo

------------------>
Randy Dunlap (1):
      futex: Fix kernel-doc notation warning

Waiman Long (2):
      locking/lockdep: Fix buffer overrun problem in stack_trace[]
      locking/rwsem: Fix kernel crash when spinning on RWSEM_OWNER_UNKNOWN


 kernel/futex.c           | 1 +
 kernel/locking/lockdep.c | 7 +++----
 kernel/locking/rwsem.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 03c518e9747e..0cf84c8664f2 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1178,6 +1178,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 
 /**
  * wait_for_owner_exiting - Block until the owner has exited
+ * @ret: owner's current futex lock status
  * @exiting:	Pointer to the exiting task
  *
  * Caller must hold a refcount on @exiting.
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..32406ef0d6a2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -482,7 +482,7 @@ static struct lock_trace *save_trace(void)
 	struct lock_trace *trace, *t2;
 	struct hlist_head *hash_head;
 	u32 hash;
-	unsigned int max_entries;
+	int max_entries;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
 	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
@@ -490,10 +490,8 @@ static struct lock_trace *save_trace(void)
 	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
 	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
 		LOCK_TRACE_SIZE_IN_LONGS;
-	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
-	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
-	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
+	if (max_entries <= 0) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -502,6 +500,7 @@ static struct lock_trace *save_trace(void)
 
 		return NULL;
 	}
+	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
 	hash = jhash(trace->entries, trace->nr_entries *
 		     sizeof(trace->entries[0]), 0);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44e68761f432..0d9b6be9ecc8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1226,8 +1226,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if ((wstate == WRITER_HANDOFF) &&
-		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
+		if (wstate == WRITER_HANDOFF &&
+		    rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE) == OWNER_NULL)
 			goto trylock_again;
 
 		/* Block until there are no active lockers. */
