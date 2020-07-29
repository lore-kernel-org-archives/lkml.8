Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31ACB22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fx/YiUJY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7Pe3bLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgG2Odi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Odc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD86C0619D5;
        Wed, 29 Jul 2020 07:33:32 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J78oS6lCpAEWK0i8jKQ1R3wYrtESmcd/IOnr4CpL89o=;
        b=Fx/YiUJYcaRq9pcDs56tPvpyk3bxf+Em6b9YWXfJ7M2HSxNrh88bJ+bYI9GTNI7X0Rm90V
        WWdVdPxlnw1BMDyZUMK9tiU0mRrOVxv1dWsF7pQ14NC28TbUq/6vg4DP5jPKMYhY0zpPZD
        6KsLvrjLzjOm1kPPYouvGLdIwDIoGe6bqM2Dg8s+bg/CHcZ9CsWXvISG+78JlZeV2EPYCd
        6uastwqFd3f3AfOYbYoVWHkxJgGtSvZ+8v6orJof9MJdvY5aPs63E//wa+U6GwgemA7tqT
        P+l5SJsPS2ifwtByh6OYLrjK0CL9likUxSJwPO8AGGM+eCbrPZwfSwW9OaDqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J78oS6lCpAEWK0i8jKQ1R3wYrtESmcd/IOnr4CpL89o=;
        b=N7Pe3bLP31jtcWIsEwGGLTd0zlLl6glgWgPf2bCLlhVQi4hORIZWKW3BXj47e2H4A/uF0Y
        r14yk3TYKNrS9HDQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] NFSv4: Use sequence counter with associated spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-22-a.darwish@linutronix.de>
References: <20200720155530.1173732-22-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603320921.4006.18144778096034185382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     76246c9219726c71e3f470344d8c6a566fa2535b
Gitweb:        https://git.kernel.org/tip/76246c9219726c71e3f470344d8c6a566fa2535b
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:28 +02:00

NFSv4: Use sequence counter with associated spinlock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-22-a.darwish@linutronix.de
---
 fs/nfs/nfs4_fs.h   | 2 +-
 fs/nfs/nfs4state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 2b7f6dc..210e590 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -117,7 +117,7 @@ struct nfs4_state_owner {
 	unsigned long	     so_flags;
 	struct list_head     so_states;
 	struct nfs_seqid_counter so_seqid;
-	seqcount_t	     so_reclaim_seqcount;
+	seqcount_spinlock_t  so_reclaim_seqcount;
 	struct mutex	     so_delegreturn_mutex;
 };
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a8dc25c..b1dba24 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -509,7 +509,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	nfs4_init_seqid_counter(&sp->so_seqid);
 	atomic_set(&sp->so_count, 1);
 	INIT_LIST_HEAD(&sp->so_lru);
-	seqcount_init(&sp->so_reclaim_seqcount);
+	seqcount_spinlock_init(&sp->so_reclaim_seqcount, &sp->so_lock);
 	mutex_init(&sp->so_delegreturn_mutex);
 	return sp;
 }
