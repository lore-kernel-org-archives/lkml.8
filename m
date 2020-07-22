Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF49C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB21220792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePwYqv7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGPeBmMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgGVJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbgGVJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:29 -0400
Date:   Wed, 22 Jul 2020 09:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9bGe5nDz+lbBZk9A8geV5VlItlX8zF2nR/AK4qanxw=;
        b=ePwYqv7d2xNTWZsw5vlHShkxhCJsbNK23rBsR36UZticVjoR3AQBZ507xlm2Quk+n43Cqj
        HW3j9gKiXZQIIGDxjwLBZZls2FH6l9OTXZwJ0TS3JBTxokzVnUrVzY56gm7Sf6q/G7e73Z
        7iQ+C8TSqqhMiHq1O0ZOwCWf1r/oTFnwQqAoMdIncN7YA4dO/CZYs7/7eyYO37Z3AxY76b
        ZOx0osCIVVWZUBj31nZzedXAz2FeqY6tHfeOsI72RrBdPZkPk3uUYbh22SpvcqCwftzKfO
        ur80RqF/DuUc/2fAWJwkRfH/q9ETM+g1CW3txTdNblDiJEzXZi1MgB+USThrqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9bGe5nDz+lbBZk9A8geV5VlItlX8zF2nR/AK4qanxw=;
        b=OGPeBmMCNcX/4hhFmMJ8IC4cczeefAP7rhsY9G6SJ0xjd0LljeK+EYYML6tWe/Xyq2laQK
        88QCZB/z5KVLDADw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] linux/sched/mm.h: drop duplicated words in comments
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <927ea8d8-3f6c-9b65-4c2b-63ab4bd59ef1@infradead.org>
References: <927ea8d8-3f6c-9b65-4c2b-63ab4bd59ef1@infradead.org>
MIME-Version: 1.0
Message-ID: <159540914596.4006.5608717862064477178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e0078e2eb8620079d988f150ba02a4ce9b5a946a
Gitweb:        https://git.kernel.org/tip/e0078e2eb8620079d988f150ba02a4ce9b5a946a
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 15 Jul 2020 18:30:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:05 +02:00

linux/sched/mm.h: drop duplicated words in comments

Drop doubled words "to" and "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/927ea8d8-3f6c-9b65-4c2b-63ab4bd59ef1@infradead.org
---
 include/linux/sched/mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index a98604e..6be66f5 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -23,7 +23,7 @@ extern struct mm_struct *mm_alloc(void);
  * will still exist later on and mmget_not_zero() has to be used before
  * accessing it.
  *
- * This is a preferred way to to pin @mm for a longer/unbounded amount
+ * This is a preferred way to pin @mm for a longer/unbounded amount
  * of time.
  *
  * Use mmdrop() to release the reference acquired by mmgrab().
@@ -232,7 +232,7 @@ static inline unsigned int memalloc_noio_save(void)
  * @flags: Flags to restore.
  *
  * Ends the implicit GFP_NOIO scope started by memalloc_noio_save function.
- * Always make sure that that the given flags is the return value from the
+ * Always make sure that the given flags is the return value from the
  * pairing memalloc_noio_save call.
  */
 static inline void memalloc_noio_restore(unsigned int flags)
@@ -263,7 +263,7 @@ static inline unsigned int memalloc_nofs_save(void)
  * @flags: Flags to restore.
  *
  * Ends the implicit GFP_NOFS scope started by memalloc_nofs_save function.
- * Always make sure that that the given flags is the return value from the
+ * Always make sure that the given flags is the return value from the
  * pairing memalloc_nofs_save call.
  */
 static inline void memalloc_nofs_restore(unsigned int flags)
