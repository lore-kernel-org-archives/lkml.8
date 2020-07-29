Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC8022B47
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oR27WZz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzM3jRqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgG2Odx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgG2Odl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725DC061794;
        Wed, 29 Jul 2020 07:33:41 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2W2fiD5gf5zDpWAlZG2fcroDdYpSOcz7Sqwwo4UyE2Y=;
        b=oR27WZz6EzRiX6VctsGmWl3NniJY9x5hPQJbulL0cQR6SV3/VSOzeo4mXm084+B4zfmn9T
        pmT9ZOGin0Yf8ChPVPDnviL5MIlPnK7KDm3vIKw64FgttqCkL9YJ6b2/rq4o1V2PRGKkKC
        xxQRfFGY4Jf4NT8Yr/g1iaVQ3o5+t6h7f2AI9Huh5fPloSMpV15MzCrmt/5wAVoOaoZdbb
        yaUFm17LYsUDN/uSwXurEDq08ZzvvpweQwat7eXjbQkwayjcKrjMnKmx9xNXWqP0Mgqc2V
        hKvBrYsNzhPFbsN7NREe+f0WafuYfzv/0Zefn2pQotLlcOCt2QGWHJrSu4dnJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2W2fiD5gf5zDpWAlZG2fcroDdYpSOcz7Sqwwo4UyE2Y=;
        b=MzM3jRqIec7kTy45/CWz0Msp72xEp6d+T2JaGGIfxjYRsaLB6NEvggZ6SnSyrIem6I258A
        Y/4GUEah9pQvkeDw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Implement raw_seqcount_begin() in terms
 of raw_read_seqcount()
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-7-a.darwish@linutronix.de>
References: <20200720155530.1173732-7-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321925.4006.790279186396450025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     932e46365226324d2cf26d8bdec8b51ceb296948
Gitweb:        https://git.kernel.org/tip/932e46365226324d2cf26d8bdec8b51ceb296948
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:24 +02:00

seqlock: Implement raw_seqcount_begin() in terms of raw_read_seqcount()

raw_seqcount_begin() has the same code as raw_read_seqcount(), with the
exception of masking the sequence counter's LSB before returning it to
the caller.

Note, raw_seqcount_begin() masks the counter's LSB before returning it
to the caller so that read_seqcount_retry() can fail if the counter is
odd -- without the overhead of an extra branching instruction.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-7-a.darwish@linutronix.de
---
 include/linux/seqlock.h |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 85fb3ac..e885702 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -199,10 +199,11 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
  */
 static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
-	unsigned ret = READ_ONCE(s->sequence);
-	smp_rmb();
-	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
-	return ret & ~1;
+	/*
+	 * If the counter is odd, let read_seqcount_retry() fail
+	 * by decrementing the counter.
+	 */
+	return raw_read_seqcount(s) & ~1;
 }
 
 /**
