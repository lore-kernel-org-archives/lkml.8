Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714F22CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oq2qxSjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wB72Ahob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgH0Hyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgH0HyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:22 -0400
Date:   Thu, 27 Aug 2020 07:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMaCkBRf2g+ayYANtGgYVsSQhnMYQyNvj1YOJgXDtvk=;
        b=Oq2qxSjwq4m4R7jtFJbb4nQxoUDkXP2KO2CS6htTMgeysdVwYreQE9z/IrdILm9WD+/LMh
        K9p70mU6gsqCGIaVmSCkU49QIxkFmgV1y+7FoEPA3REg4bLHLqqRIxmZlxL4Ytfz0SIBzV
        2hGCxqY/7cSvJEQQtm5RFaoaytvC2jAcGBwAeM9o5vBvDOdY1g9TsNvuFNu7DurljA221H
        s5XnAPMNNbbvPR/5P2GuPd+rxcDWEMaicJ1RI6E6JGQvh0vH9WiJhNPaR5Za8rzlfwon8F
        KwcJHCA0CRyB/gEno6k8RXEyG64q5Zkdeum7S7QgFSnexgJ8tIz3vhkTAPG/xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMaCkBRf2g+ayYANtGgYVsSQhnMYQyNvj1YOJgXDtvk=;
        b=wB72AhobnsIRaVbXBP9eg+7bKXf3F9NMisibiDFtM5eNsw4TWbTakLqVRL9YVA472f9ZTR
        IUBlFWmyDdp8gSAw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Make __bfs(.match) return bool
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-9-boqun.feng@gmail.com>
References: <20200807074238.1632519-9-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485926.20229.14104571007024271963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     61775ed243433ff0556c4f76905929fe01e92922
Gitweb:        https://git.kernel.org/tip/61775ed243433ff0556c4f76905929fe01e92922
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:27 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:05 +02:00

lockdep: Make __bfs(.match) return bool

The "match" parameter of __bfs() is used for checking whether we hit a
match in the search, therefore it should return a boolean value rather
than an integer for better readability.

This patch then changes the return type of the function parameter and the
match functions to bool.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-9-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5abc227..78cd74d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1620,7 +1620,7 @@ static inline void bfs_init_rootb(struct lock_list *lock,
  */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
-			     int (*match)(struct lock_list *entry, void *data),
+			     bool (*match)(struct lock_list *entry, void *data),
 			     struct lock_list **target_entry,
 			     int offset)
 {
@@ -1711,7 +1711,7 @@ exit:
 static inline enum bfs_result
 __bfs_forwards(struct lock_list *src_entry,
 	       void *data,
-	       int (*match)(struct lock_list *entry, void *data),
+	       bool (*match)(struct lock_list *entry, void *data),
 	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
@@ -1722,7 +1722,7 @@ __bfs_forwards(struct lock_list *src_entry,
 static inline enum bfs_result
 __bfs_backwards(struct lock_list *src_entry,
 		void *data,
-		int (*match)(struct lock_list *entry, void *data),
+		bool (*match)(struct lock_list *entry, void *data),
 		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
@@ -1833,7 +1833,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	print_circular_bug_entry(entry, depth);
 }
 
-static inline int class_equal(struct lock_list *entry, void *data)
+static inline bool class_equal(struct lock_list *entry, void *data)
 {
 	return entry->class == data;
 }
@@ -1888,10 +1888,10 @@ static noinline void print_bfs_bug(int ret)
 	WARN(1, "lockdep bfs error:%d\n", ret);
 }
 
-static int noop_count(struct lock_list *entry, void *data)
+static bool noop_count(struct lock_list *entry, void *data)
 {
 	(*(unsigned long *)data)++;
-	return 0;
+	return false;
 }
 
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
@@ -2032,11 +2032,11 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
-static inline int usage_accumulate(struct lock_list *entry, void *mask)
+static inline bool usage_accumulate(struct lock_list *entry, void *mask)
 {
 	*(unsigned long *)mask |= entry->class->usage_mask;
 
-	return 0;
+	return false;
 }
 
 /*
@@ -2045,9 +2045,9 @@ static inline int usage_accumulate(struct lock_list *entry, void *mask)
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *mask)
+static inline bool usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & *(unsigned long *)mask;
+	return !!(entry->class->usage_mask & *(unsigned long *)mask);
 }
 
 /*
