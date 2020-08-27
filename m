Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1133622B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxK20qgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvvxiz98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0PMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgH0Lkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120DC061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:40:54 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TountMAhWj6L2citLNZtIcuiTiV+gspqfLLvjcSxlQ=;
        b=XxK20qgztTckGR2f0mHBViWulUtVbdJufdJHKQgUyZksVwy4NSJjzY653yTqIPAPbLCRJJ
        rfXOPqOqkxxJQ7vDhKVFgk0XUgHG3rP0KMr+Aniw1+iMm/evV1sBhsQjiGkP602pePxv77
        fVuPFV5F9POtitq/3eyHz2bslWawd01JtQQDC+A2OWXsTcv2QNKl9nxUnf5nSZzs8WZdnJ
        nWS1tWZoEBkX4uZ0efeq2gXf6dptOZbgV27a0dmcXXSWpvWrnnbotwWiRfP5Edcb1yizq6
        N2EuTQR6P5UTGmHS1B2904qnczaaa0/3FWz5jwXp956IQGmznOpvK8PB+gf8gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TountMAhWj6L2citLNZtIcuiTiV+gspqfLLvjcSxlQ=;
        b=hvvxiz98eS4Ox+crMabgacjziunE5QupkEiScL9gG2bey14RIdrvuheoOxOpJh1onLeqRb
        MHks9DkACRdHBBBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 6/8] x86/tsc: Use seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:42 +0200
Message-Id: <20200827114044.11173-7-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures that only latching-safe seqcount APIs
are to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 arch/x86/kernel/tsc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 49d925043171..cbf17e9f1d03 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -54,7 +54,7 @@ struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
-	seqcount_t	   seq;		/* 32 + 4    = 36 */
+	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
 
 }; /* fits one cacheline */
 
@@ -68,19 +68,21 @@ early_param("tsc_early_khz", tsc_early_khz_setup);
 
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
+	seqcount_latch_t *seqcount;
 	int seq, idx;
 
 	preempt_disable_notrace();
 
+	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
 	do {
-		seq = this_cpu_read(cyc2ns.seq.sequence);
+		seq = raw_read_seqcount_latch(seqcount);
 		idx = seq & 1;
 
 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
 
-	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
+	} while (read_seqcount_latch_retry(seqcount, seq));
 }
 
 __always_inline void cyc2ns_read_end(void)
@@ -186,7 +188,7 @@ static void __init cyc2ns_init_boot_cpu(void)
 {
 	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
 
-	seqcount_init(&c2n->seq);
+	seqcount_latch_init(&c2n->seq);
 	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
 }
 
@@ -203,7 +205,7 @@ static void __init cyc2ns_init_secondary_cpus(void)
 
 	for_each_possible_cpu(cpu) {
 		if (cpu != this_cpu) {
-			seqcount_init(&c2n->seq);
+			seqcount_latch_init(&c2n->seq);
 			c2n = per_cpu_ptr(&cyc2ns, cpu);
 			c2n->data[0] = data[0];
 			c2n->data[1] = data[1];
-- 
2.28.0

