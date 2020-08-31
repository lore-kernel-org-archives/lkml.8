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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D994DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77D620782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUoF64J8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKfKbQpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHaBLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHaBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A454C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 18:11:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh5bPEdW72nBKOEmEA+hiwOlZznn/NpUJrGH+W+89fs=;
        b=qUoF64J8p02HKAe6mSUHQbF8FUqMl2IldZinbKaECMsHih23wvbkT9zQtyZYTjDyJpsXBp
        yub4HAmYX9al/S5So/znyAZkamRZ1a21twsZd3NEiG24hwUnN/zMO65VgVHdncBbXkoiiC
        YqlVxJlrA+Rkcapmy+UJADq44bLI6SPsvkymW0SEH22b1SAMnKrcrDBNsvBDoLBXdxZSOC
        IFmYxbTfkniIRHveJ7AoBb9pRbjd3pmm2ABW4w6KivHRl0SYpjh5lZ8iihplCsd6V+gVuF
        tppt5Fbnx0/iLY9+zHCMAbhYhl1Ys1dcJEJMRoB1IgiaJtlY6MyqEzG2cnm9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh5bPEdW72nBKOEmEA+hiwOlZznn/NpUJrGH+W+89fs=;
        b=HKfKbQpbD3sUbxqaCxLwXO98CXrXFC7Efxhfc65ZTLvz7LIitdkuPCxtZ1wGZ2iXojBuF6
        YA9VeSOh8GTxb5Dg==
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
Subject: [PATCH next v3 1/8] printk: ringbuffer: rename DESC_COMMITTED_MASK flag
Date:   Mon, 31 Aug 2020 03:16:51 +0206
Message-Id: <20200831011058.6286-2-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An upcoming ringbuffer support for continuous lines will allow to
reopen records with DESC_COMMITTED_MASK set. As a result, the flag
will no longer describe the final committed state. Rename it to
DESC_COMMIT_MASK as a preparation step.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 8 ++++----
 kernel/printk/printk_ringbuffer.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0659b50872b5..76248c82d557 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -361,7 +361,7 @@ static enum desc_state get_desc_state(unsigned long id,
 	if (state_val & DESC_REUSE_MASK)
 		return desc_reusable;
 
-	if (state_val & DESC_COMMITTED_MASK)
+	if (state_val & DESC_COMMIT_MASK)
 		return desc_committed;
 
 	return desc_reserved;
@@ -462,7 +462,7 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
-	unsigned long val_committed = id | DESC_COMMITTED_MASK;
+	unsigned long val_committed = id | DESC_COMMIT_MASK;
 	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
@@ -899,7 +899,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
 	if (prev_state_val &&
-	    prev_state_val != (id_prev_wrap | DESC_COMMITTED_MASK | DESC_REUSE_MASK)) {
+	    prev_state_val != (id_prev_wrap | DESC_COMMIT_MASK | DESC_REUSE_MASK)) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
@@ -1184,7 +1184,7 @@ void prb_commit(struct prb_reserved_entry *e)
 	 * this. This pairs with desc_read:B.
 	 */
 	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-				     e->id | DESC_COMMITTED_MASK)) { /* LMM(prb_commit:B) */
+				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
 		WARN_ON_ONCE(1);
 	}
 
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index e6302da041f9..dcda5e9b4676 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -115,9 +115,9 @@ struct prb_reserved_entry {
 #define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
 #define DESC_SV_BITS			(sizeof(unsigned long) * 8)
-#define DESC_COMMITTED_MASK		(1UL << (DESC_SV_BITS - 1))
+#define DESC_COMMIT_MASK		(1UL << (DESC_SV_BITS - 1))
 #define DESC_REUSE_MASK			(1UL << (DESC_SV_BITS - 2))
-#define DESC_FLAGS_MASK			(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
+#define DESC_FLAGS_MASK			(DESC_COMMIT_MASK | DESC_REUSE_MASK)
 #define DESC_ID_MASK			(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)			((sv) & DESC_ID_MASK)
 #define FAILED_LPOS			0x1
@@ -213,7 +213,7 @@ struct prb_reserved_entry {
  */
 #define BLK0_LPOS(sz_bits)	(-(_DATA_SIZE(sz_bits)))
 #define DESC0_ID(ct_bits)	DESC_ID(-(_DESCS_COUNT(ct_bits) + 1))
-#define DESC0_SV(ct_bits)	(DESC_COMMITTED_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
+#define DESC0_SV(ct_bits)	(DESC_COMMIT_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
 
 /*
  * Define a ringbuffer with an external text data buffer. The same as
-- 
2.20.1

