Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C2C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A3E2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3Ks4g/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBt2J91I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGXIeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGXIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:53 -0400
Date:   Fri, 24 Jul 2020 08:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4qC0mBGTHpvmiEhlzYGFbgKLe9cL/iUCyRxDTUqcqBM=;
        b=c3Ks4g/mmTY0oBwJA9VKSSy2nHgpK+JT3YrjTnQgYx0SeTLLnWv1+RJ+5X28RiAMD5pwSb
        G7cfNs7rmmwRRzyY2vHT675jwXcNgmLW1tVMAKIFeJQbP6kU0tEgdUF7XIvz1u+bv0M+if
        tlmftlGpIwhB0SHdZkuLZERR2ri3CPaMazkENXiYR4ax2epjMHBSnf+m2wVKv+Qeu+PVxm
        4ZdA9A+leJf3Z2qc7IjZ5gMIAHim5K4cDt7OSSdB9rejs7rtLa3jugAEt4w8Zx+yP65K33
        zDbVbH8rL9U2kSgpal9btlx8Vb5A945vXSnXHammNi8CJtNoh9/6F1hPzSntYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4qC0mBGTHpvmiEhlzYGFbgKLe9cL/iUCyRxDTUqcqBM=;
        b=gBt2J91I/ex2XUqKLpOFBbspzs1tznDzwcoAgtmNFBvXqRNP4VhPNDIhR/PeGK0zdtmaWO
        lCXf530S8Of281Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,crypto: Convert to sched_set_fifo*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557963086.4006.17442983710537449609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     dbc6d0d5a5467adb6ea5fb25844e471c7bf8fabf
Gitweb:        https://git.kernel.org/tip/dbc6d0d5a5467adb6ea5fb25844e471c7bf8fabf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:20 +02:00

sched,crypto: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Use sched_set_fifo() to request SCHED_FIFO and delegate
actual priority selection to userspace. Effectively no change in
behaviour.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/crypto_engine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 3655d9d..198a8eb 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -482,7 +482,6 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 						       int (*cbk_do_batch)(struct crypto_engine *engine),
 						       bool rt, int qlen)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 	struct crypto_engine *engine;
 
 	if (!dev)
@@ -520,7 +519,7 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 
 	if (engine->rt) {
 		dev_info(dev, "will run requests pump with realtime priority\n");
-		sched_setscheduler(engine->kworker->task, SCHED_FIFO, &param);
+		sched_set_fifo(engine->kworker->task);
 	}
 
 	return engine;
