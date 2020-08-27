Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C0DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C906520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFRmWYKt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDiPxqQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgH0H6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgH0HyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6DDC06121A;
        Thu, 27 Aug 2020 00:54:22 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3YkGOPEQgwIky67ipFw2aeIOYSOatdnKx07RKeNUrI=;
        b=EFRmWYKto8JizkRdGPCONVhvd1j+z2hrEckuB9dYgEbUEk7MsYhpwy8Bkbpf/+ROrNy46/
        agdRupTXNDKaSTbzgfD3KKnOhU5mP8IDx72ol8jHJxnRzvXBioJzbgm6Y2wsPNcC7wMOdV
        d+N3Eh5BN7F2FT/dIZhyOcqxvnmguoaAjF1tJRrBfmIKfXPNCMBeXY4oWTHNIZzZmdx3xk
        FBld43DGjO5iASkKp9jB+Zg/+x24/23KCj8hwdckOwOUY+HUhUYPla4esi0L2XRoFItEkc
        48ZsxgFxyZ/Pf0JjzSFtrWL6WtCFzeJw94pr2K/e7EF9ou9Ytvb1ZMYm+nQ3dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3YkGOPEQgwIky67ipFw2aeIOYSOatdnKx07RKeNUrI=;
        b=oDiPxqQDd9Ro3rFF0wmIRZtplbw/YDVCFILuVh69XdU6bI22eFXo2Vs2lDG5GH1mkemY/3
        6rvBbBXkYMSeIOBg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Reduce the size of lock_list::distance
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-6-boqun.feng@gmail.com>
References: <20200807074238.1632519-6-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486062.20229.11037063852084225523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bd76eca10de2eb9998d5125b08e8997cbf5508d5
Gitweb:        https://git.kernel.org/tip/bd76eca10de2eb9998d5125b08e8997cbf5508d5
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:24 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:04 +02:00

lockdep: Reduce the size of lock_list::distance

lock_list::distance is always not greater than MAX_LOCK_DEPTH (which
is 48 right now), so a u16 will fit. This patch reduces the size of
lock_list::distance to save space, so that we can introduce other fields
to help detect recursive read lock deadlocks without increasing the size
of lock_list structure.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-6-boqun.feng@gmail.com
---
 include/linux/lockdep.h  | 2 +-
 kernel/locking/lockdep.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7cae5ea..2275010 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -54,7 +54,7 @@ struct lock_list {
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	const struct lock_trace		*trace;
-	int				distance;
+	u16				distance;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 150686a..668a983 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1320,7 +1320,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, int distance,
+			    unsigned long ip, u16 distance,
 			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
@@ -2489,7 +2489,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance,
+	       struct held_lock *next, u16 distance,
 	       struct lock_trace **const trace)
 {
 	struct lock_list *entry;
@@ -2622,7 +2622,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		goto out_bug;
 
 	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
+		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
 		/*
