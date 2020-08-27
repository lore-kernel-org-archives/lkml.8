Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8D3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64BE20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+P+7grn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lP/qyek/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgH0H4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgH0Hy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:27 -0400
Date:   Thu, 27 Aug 2020 07:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkPkU7996GQyNSSrtEwPxCT4OpFx9sb1th4lOZSIMng=;
        b=S+P+7grnc60Szd+3AitUR+068GB7KW5/uKhRmj006+CrJnmNgb5jFEaTKnxe4IBPTubsaS
        ZYyG6Xo9Yl1V6EVj50dLASwmWBh7PaEcgtaWacd9EpSMw5D/eLXFjp4cZjN/YJ8ccnchxW
        RXOpH30qwbBmSwkaeqFk2ITMEa+9ILAsNI3ODLU2NstpmBZe54NF62iaRAJwVP37/OxOQV
        T86QleErkDo1fJRYavYFJsPUrcvTv3URlCPN+hi3QAnSTNLjKe9SN/7Pz6gQIJee6JHjxU
        LW2agxnU+0eUOzutvTsIUfZYSY3bCNwIZyMB00Gfb0NQPd1J4tV7OwRgwTQO3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkPkU7996GQyNSSrtEwPxCT4OpFx9sb1th4lOZSIMng=;
        b=lP/qyek/zJw/it01+RyQAzSGcOEctqwy9X43hDG4tCQDmNaMAJ0M2Zlu4RKSBLHZ+HaX04
        JGQuf5GewVH/+cCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep,trace: Expose tracepoints
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.782688941@infradead.org>
References: <20200821085348.782688941@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486434.20229.10477957764758069749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     eb1f00237aca2e368b93db79303f8433d1976d10
Gitweb:        https://git.kernel.org/tip/eb1f00237aca2e368b93db79303f8433d1976d10
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Aug 2020 20:53:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:56 +02:00

lockdep,trace: Expose tracepoints

The lockdep tracepoints are under the lockdep recursion counter, this
has a bunch of nasty side effects:

 - TRACE_IRQFLAGS doesn't work across the entire tracepoint

 - RCU-lockdep doesn't see the tracepoints either, hiding numerous
   "suspicious RCU usage" warnings.

Pull the trace_lock_*() tracepoints completely out from under the
lockdep recursion handling and completely rely on the trace level
recusion handling -- also, tracing *SHOULD* not be taking locks in any
case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.782688941@infradead.org
---
 kernel/locking/lockdep.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c872e95..54b74fa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4977,6 +4977,8 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	unsigned long flags;
 
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
 	if (unlikely(current->lockdep_recursion)) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
@@ -5001,7 +5003,6 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	check_flags(flags);
 
 	current->lockdep_recursion++;
-	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5013,13 +5014,15 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_release(lock, ip);
+
 	if (unlikely(current->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
+
 	current->lockdep_recursion++;
-	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5205,8 +5208,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5225,6 +5226,8 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_acquired(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
@@ -5234,7 +5237,6 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5245,6 +5247,8 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	trace_lock_contended(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
