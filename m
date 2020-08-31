Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC360C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978E320782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAHteheX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDkNPBna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHaBLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHaBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598FEC061236
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:11:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ScDz0STeLinZrRP+O3Ca1k2Gl+P4+CxfAeZbgZtYfY=;
        b=TAHteheXWI+JAl1TS2aiXTkZhT0G8XD8YYqhYmrLrl6jmnefdnrkjYDXnqnGFkeYwGNF+o
        dIlLMQrmmQUtbrTjwh+1SSibays7ppL1mFL8ANMjmMjhiaX2EbBBg6e08oHg5qoPGw2zNZ
        I7pbco2iyBX7WnxFTCEWVmnx+C2xoVdKG39hezShsaFRBem1jsfAJWPDaoxKKRk8K489Hw
        A+lBMZnUnNUm8jGj5wxuQBGHs4LVjdsNOj7kjbXGCoU9JW9CC+51yeUv9IZR7uWOUgIg3L
        OZ+z0XUh///WbGpQr8XNRG5Vo8RFs9xRmGPEeDE55sb5MREoqcPFFL1TCaJAfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ScDz0STeLinZrRP+O3Ca1k2Gl+P4+CxfAeZbgZtYfY=;
        b=ZDkNPBna4V5+YGXUUElIddPMKkUhO2WkpZSmyQAPp9Jw3Knh60ucPN3biDT5tEWHQII4oF
        tZCZQQXyV8a5yTBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 2/8] printk: ringbuffer: change representation of reusable
Date:   Mon, 31 Aug 2020 03:16:52 +0206
Message-Id: <20200831011058.6286-3-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reusable queried state is represented by the combined flags:

    DESC_COMMIT_MASK | DESC_REUSE_MASK

There is no reason for the DESC_COMMIT_MASK to be part of that
representation. In particular, this will add confusion when more
state flags are available.

Change the representation of the reusable queried state to just
the DESC_REUSE_MASK flag.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 4 ++--
 kernel/printk/printk_ringbuffer.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 76248c82d557..d339ff7647da 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -463,7 +463,7 @@ static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
 	unsigned long val_committed = id | DESC_COMMIT_MASK;
-	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
+	unsigned long val_reusable = id | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
 
@@ -899,7 +899,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
 	if (prev_state_val &&
-	    prev_state_val != (id_prev_wrap | DESC_COMMIT_MASK | DESC_REUSE_MASK)) {
+	    get_desc_state(id_prev_wrap, prev_state_val) != desc_reusable) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index dcda5e9b4676..96ef997d7bd6 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -213,7 +213,7 @@ struct prb_reserved_entry {
  */
 #define BLK0_LPOS(sz_bits)	(-(_DATA_SIZE(sz_bits)))
 #define DESC0_ID(ct_bits)	DESC_ID(-(_DESCS_COUNT(ct_bits) + 1))
-#define DESC0_SV(ct_bits)	(DESC_COMMIT_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
+#define DESC0_SV(ct_bits)	(DESC_REUSE_MASK | DESC0_ID(ct_bits))
 
 /*
  * Define a ringbuffer with an external text data buffer. The same as
-- 
2.20.1

