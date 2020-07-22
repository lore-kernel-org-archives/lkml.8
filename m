Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C5C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137ED207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUhlo0Nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cY9acV+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgGVJSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D741C0619E0;
        Wed, 22 Jul 2020 02:18:02 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxDdyHhs8dHYIRzEyhZyGTsZRDmwCHSg9QNB4EZf8FY=;
        b=zUhlo0NmAODgRptFlOsCHao8muTGHiHRUu59wdPghLQmjmWmZJHAky5zIy2yug6IfvK3Fl
        voGUfA0kvY6QqxIILfrE9q8Q6aHwtRzj71iaCi0RYxP7bpT5nM2NL4aFX0PjZg2t18AaDV
        fz3Ta0Wqhwo84hG98+Xmk6+7R4cKXFjIa8DlSJrGHc3sYIAx57Hb8s7R3R5sAtNrxZXdff
        QKDnlnmXZwJYt5850Lvb/bUUA+xCjefvZnrgWvUdVaPnsKkTxIr9lEr+pKIIWVUPdoo2uk
        jJrVtudaibgjafk3yidK+xnzaKBFCkUciUQxO3ZhmdiXG0rQoN+h/LOM+tE6dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxDdyHhs8dHYIRzEyhZyGTsZRDmwCHSg9QNB4EZf8FY=;
        b=cY9acV+3TBjDJ3zf/ijTep77l9Pq2StRRuC+eWyVDrpMi5DTiV338NnIT8YiuuWGp8/Bch
        drTe20kxqGePtUBA==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: <linux/perf_event.h>: drop a duplicated word
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200719003027.20798-1-rdunlap@infradead.org>
References: <20200719003027.20798-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159540948033.4006.2556743028468731348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c2127e14c127de2775feefdfb1444e30a129a59f
Gitweb:        https://git.kernel.org/tip/c2127e14c127de2775feefdfb1444e30a129a59f
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 18 Jul 2020 17:30:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:08 +02:00

perf: <linux/perf_event.h>: drop a duplicated word

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200719003027.20798-1-rdunlap@infradead.org
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3b22db0..0edd257 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -366,7 +366,7 @@ struct pmu {
 	 * ->stop() with PERF_EF_UPDATE will read the counter and update
 	 *  period/count values like ->read() would.
 	 *
-	 * ->start() with PERF_EF_RELOAD will reprogram the the counter
+	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
