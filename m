Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F737C10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB02072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFKjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCFKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAANk-0000CR-FV; Fri, 06 Mar 2020 11:39:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 22A881C21BF;
        Fri,  6 Mar 2020 11:39:04 +0100 (CET)
Date:   Fri, 06 Mar 2020 10:39:03 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove pointless mmgrap() + mmdrop()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158349114388.28353.18369702179782748736.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     222993395ed38f3751287f4bd82ef46b3eb3a66d
Gitweb:        https://git.kernel.org/tip/222993395ed38f3751287f4bd82ef46b3eb3a66d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 04 Mar 2020 13:02:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Mar 2020 11:06:18 +01:00

futex: Remove pointless mmgrap() + mmdrop()

We always set 'key->private.mm' to 'current->mm', getting an extra
reference on 'current->mm' is quite pointless, because as long as the
task is blocked it isn't going to go away.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e14f7cd..3463c91 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -331,17 +331,6 @@ static void compat_exit_robust_list(struct task_struct *curr);
 static inline void compat_exit_robust_list(struct task_struct *curr) { }
 #endif
 
-static inline void futex_get_mm(union futex_key *key)
-{
-	mmgrab(key->private.mm);
-	/*
-	 * Ensure futex_get_mm() implies a full barrier such that
-	 * get_futex_key() implies a full barrier. This is relied upon
-	 * as smp_mb(); (B), see the ordering comment above.
-	 */
-	smp_mb__after_atomic();
-}
-
 /*
  * Reflects a new waiter being added to the waitqueue.
  */
@@ -432,7 +421,7 @@ static void get_futex_key_refs(union futex_key *key)
 		smp_mb();		/* explicit smp_mb(); (B) */
 		break;
 	case FUT_OFF_MMSHARED:
-		futex_get_mm(key); /* implies smp_mb(); (B) */
+		smp_mb();		/* explicit smp_mb(); (B) */
 		break;
 	default:
 		/*
@@ -465,7 +454,6 @@ static void drop_futex_key_refs(union futex_key *key)
 	case FUT_OFF_INODE:
 		break;
 	case FUT_OFF_MMSHARED:
-		mmdrop(key->private.mm);
 		break;
 	}
 }
