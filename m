Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0056C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734232177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h2EAl4WW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6UalHnpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0PMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:12:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgH0Lkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:42 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3QgBTKNJG7+QYcS6GyKNhaEyuGeMTlXl34dj2J4AA8=;
        b=h2EAl4WWWlzMoSZche7GuRz9vDV4hulRL/yNKrX4IYpD8X8bKaQKHsUHunIkzvAjU9lonk
        o6WLZy7rIs9RhgGOsghb3rUpQk4jSHzgZWURGmz3Csco6f/P7nvwdMSJE/ogehPuv+5rC7
        warMfIhWqlwkPQuoKJN2g+i+LDNUXxHF4vDIEEwUkCZ6vY36YFqkU3OQ44W+Ft7oApzcdd
        UCh57zoldFiIuGgUhp/DtTy/eGhMVyC9SWsR9hcgUTR2LurvkXlypKZ8PlFVt1NhpzBo0M
        nsAHACuUp5v4fQthtOG+qvGHHkcMsplP2myZR8Jtld0F79OeFhSkNB0HVv9AuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3QgBTKNJG7+QYcS6GyKNhaEyuGeMTlXl34dj2J4AA8=;
        b=6UalHnpY+QLmQ3ZrEX0SSn+b542K0ImKxbbTgSoRRMlmZaa24Ywvi0Ck2PE3mvPJKMIN61
        Tqc9c0VMwRjavPAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 1/8] time/sched_clock: Use raw_read_seqcount_latch() during suspend
Date:   Thu, 27 Aug 2020 13:40:37 +0200
Message-Id: <20200827114044.11173-2-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_clock uses seqcount_t latching to switch between two storage
places protected by the sequence counter. This allows it to have
interruptible, NMI-safe, seqcount_t write side critical sections.

Since 7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()"),
raw_read_seqcount_latch() became the standardized way for seqcount_t
latch read paths. Due to the dependent load, it has one read memory
barrier less than the currently used raw_read_seqcount() API.

Use raw_read_seqcount_latch() for the suspend path.

Commit aadd6e5caaac ("time/sched_clock: Use raw_read_seqcount_latch()")
missed changing that instance of raw_read_seqcount().

Link: https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r/20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de
References: 1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 1c03eec6ca9b..8c6b5febd7a0 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -258,7 +258,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned int seq = raw_read_seqcount(&cd.seq);
+	unsigned int seq = raw_read_seqcount_latch(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
-- 
2.28.0

