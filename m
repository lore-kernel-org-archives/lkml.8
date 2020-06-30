Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FCC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKGouWsv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+ZWM/A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgF3Fqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbgF3Fq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73EFC061755;
        Mon, 29 Jun 2020 22:46:26 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpdDlH3EimGLSv4f750ktc+2OOIPAdppOAHvCqowA5Q=;
        b=XKGouWsvcT94/l0qMXp+/hXRs4c1E/UJ83u5UoMayTs6s2VhUCg9o6zp7BvgOgI5XJaxPk
        eGdwDOg2vGbZ2SSI3sTICCEMQFVZfHaR3+ts/0pbo1tzLCpMj2W9sFtJR96Jv3jNeHoA6B
        9l7lRXO90k+wqIczEZo0jUPCNM7OGpQFl6gpDQ8Za4RzydTBqxXxZ0F63HW5ua6S9i+Hg4
        fwUuQ8krJ3aX/vPBe8RXQx4u5M8k/3H2aSdwHqA8K1JNG6SBgSDx3mE7Wuo8OuzNmfAUlb
        oIH3Zxxjmno55CQYlYF5JWofRhEHMlCdc7o0SauzGR0HKGoMeC5Ifn+jNk6Y7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpdDlH3EimGLSv4f750ktc+2OOIPAdppOAHvCqowA5Q=;
        b=f+ZWM/A07foL8uf6oaT9CXPbIv8JhLqZTjQJ08b9nb3g62n6CE6/tE9bF2okgV8b1m+aQ0
        QAE53rJfJjJA54BQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 18/20] userfaultfd: Use sequence counter with associated spinlock
Date:   Tue, 30 Jun 2020 07:44:50 +0200
Message-Id: <20200630054452.3675847-19-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 52de29000c7e..26e8b23594fb 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -61,7 +61,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqcount_spinlock_t refile_seq;
 	/* pseudo fd refcounting */
 	refcount_t refcount;
 	/* userfaultfd syscall flags */
@@ -1998,7 +1998,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
-- 
2.20.1

