Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7429206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgDVEMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:12:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgDVEL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:11:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E94DAE6E;
        Wed, 22 Apr 2020 04:11:55 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, pbonzini@redhat.com
Cc:     bigeasy@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/5] sched/swait: Reword some of the main description
Date:   Tue, 21 Apr 2020 21:07:39 -0700
Message-Id: <20200422040739.18601-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422040739.18601-1-dave@stgolabs.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With both the increased use of swait and kvm no longer using
it, we can reword some of the comments. While removing Linus'
valid rant, I've also cared to explicitly mention that swait
is very different than regular wait. In addition it is
mentioned against using swait in favor of the regular flavor.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/swait.h | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9986d4..6a8c22b8c2a5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -9,23 +9,10 @@
 #include <asm/current.h>
 
 /*
- * BROKEN wait-queues.
- *
- * These "simple" wait-queues are broken garbage, and should never be
- * used. The comments below claim that they are "similar" to regular
- * wait-queues, but the semantics are actually completely different, and
- * every single user we have ever had has been buggy (or pointless).
- *
- * A "swake_up_one()" only wakes up _one_ waiter, which is not at all what
- * "wake_up()" does, and has led to problems. In other cases, it has
- * been fine, because there's only ever one waiter (kvm), but in that
- * case gthe whole "simple" wait-queue is just pointless to begin with,
- * since there is no "queue". Use "wake_up_process()" with a direct
- * pointer instead.
- *
- * While these are very similar to regular wait queues (wait.h) the most
- * important difference is that the simple waitqueue allows for deterministic
- * behaviour -- IOW it has strictly bounded IRQ and lock hold times.
+ * Simple waitqueues are semantically very different to regular wait queues
+ * (wait.h). The most important difference is that the simple waitqueue allows
+ * for deterministic behaviour -- IOW it has strictly bounded IRQ and lock hold
+ * times.
  *
  * Mainly, this is accomplished by two things. Firstly not allowing swake_up_all
  * from IRQ disabled, and dropping the lock upon every wakeup, giving a higher
@@ -39,7 +26,7 @@
  *    sleeper state.
  *
  *  - the !exclusive mode; because that leads to O(n) wakeups, everything is
- *    exclusive.
+ *    exclusive. As such swake_up_one will only ever awake _one_ waiter.
  *
  *  - custom wake callback functions; because you cannot give any guarantees
  *    about random code. This also allows swait to be used in RT, such that
-- 
2.16.4

