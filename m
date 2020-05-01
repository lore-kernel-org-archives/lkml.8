Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2132C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D59B24967
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgEASWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730463AbgEASWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F05FC08ED7D;
        Fri,  1 May 2020 11:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIZ-0003Wq-PZ; Fri, 01 May 2020 20:22:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5833B1C0330;
        Fri,  1 May 2020 20:22:07 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:07 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/swait: Reword some of the main description
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422040739.18601-6-dave@stgolabs.net>
References: <20200422040739.18601-6-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <158835732731.8414.566665538600308266.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     12ac6782a40ad7636b6ef45680741825b64ab221
Gitweb:        https://git.kernel.org/tip/12ac6782a40ad7636b6ef45680741825b64ab221
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 21 Apr 2020 21:07:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:41 +02:00

sched/swait: Reword some of the main description

With both the increased use of swait and kvm no longer using
it, we can reword some of the comments. While removing Linus'
valid rant, I've also cared to explicitly mention that swait
is very different than regular wait. In addition it is
mentioned against using swait in favor of the regular flavor.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200422040739.18601-6-dave@stgolabs.net
---
 include/linux/swait.h | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9..6a8c22b 100644
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
