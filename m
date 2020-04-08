Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A347C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A820BED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDHMVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgDHMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:21:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9hR-0006Be-Ha; Wed, 08 Apr 2020 14:20:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 206F71C047B;
        Wed,  8 Apr 2020 14:20:57 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:56 -0000
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/refcount: Document interaction with
 PID_MAX_LIMIT
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200303105427.260620-1-jannh@google.com>
References: <20200303105427.260620-1-jannh@google.com>
MIME-Version: 1.0
Message-ID: <158634845677.28353.8519164850978803726.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a13f58a0cafa7b0416a2898bc3b0defbb305d108
Gitweb:        https://git.kernel.org/tip/a13f58a0cafa7b0416a2898bc3b0defbb305d108
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Tue, 03 Mar 2020 11:54:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 12:05:07 +02:00

locking/refcount: Document interaction with PID_MAX_LIMIT

Document the circumstances under which refcount_t's saturation mechanism
works deterministically.

Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200303105427.260620-1-jannh@google.com
---
 include/linux/refcount.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0ac50cf..0e3ee25 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -38,11 +38,24 @@
  * atomic operations, then the count will continue to edge closer to 0. If it
  * reaches a value of 1 before /any/ of the threads reset it to the saturated
  * value, then a concurrent refcount_dec_and_test() may erroneously free the
- * underlying object. Given the precise timing details involved with the
- * round-robin scheduling of each thread manipulating the refcount and the need
- * to hit the race multiple times in succession, there doesn't appear to be a
- * practical avenue of attack even if using refcount_add() operations with
- * larger increments.
+ * underlying object.
+ * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
+ * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
+ * With the current PID limit, if no batched refcounting operations are used and
+ * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
+ * operations, this makes it impossible for a saturated refcount to leave the
+ * saturation range, even if it is possible for multiple uses of the same
+ * refcount to nest in the context of a single task:
+ *
+ *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
+ *     0x40000000 / 0x400000 = 0x100 = 256
+ *
+ * If hundreds of references are added/removed with a single refcounting
+ * operation, it may potentially be possible to leave the saturation range; but
+ * given the precise timing details involved with the round-robin scheduling of
+ * each thread manipulating the refcount and the need to hit the race multiple
+ * times in succession, there doesn't appear to be a practical avenue of attack
+ * even if using refcount_add() operations with larger increments.
  *
  * Memory ordering
  * ===============
