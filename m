Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A827420658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPvm7CWt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNrpRIq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgGOL7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:59:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F35C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 04:59:06 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594814341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/Hw+7u7aBxeaVg0fnGygmITDj3v4tIkOl2+fAUxPTA=;
        b=yPvm7CWthkRwlgkbg7g+faKOFs7NJk5qxg8qwKA5nL8eKSbGvhGte1Wk7qi7IQL0FSRFYk
        hIzoPza7nioo4DDk51dvAslE9Jzr2bo8V56WpkGviOaJvGH7tyUF9RPAnkuLcq+BN8W/51
        juhHRRzevdx88N+vmlySdiTMSN2TuCIXZNOwezf74nu6T7mVA7Goxa2S8cyQmOD0lvRbqZ
        czhk3/wxsFBgedPVCwHQgVqVlr/VKNiOitSIAX4Yw7eA7Q7De9CkqtTSq2dhAawVEDYrz8
        QJLZWcObt5Y2xkzhtCkEEYq2TitT+AYe+Ra3dZnwQx2AgcJjwtt8pzqz2uQOIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594814341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/Hw+7u7aBxeaVg0fnGygmITDj3v4tIkOl2+fAUxPTA=;
        b=oNrpRIq83+0jvmZcDwfQAsaE9OgkuYiwLJQw1Jtukv/q1VpPzrB9AVnPYwXiiCSZdsisJq
        oyeq+HTEY0CQieCQ==
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, John Ogness <jogness@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH] time/sched_clock: Use raw_read_seqcount_latch()
Date:   Wed, 15 Jul 2020 13:59:01 +0200
Message-Id: <20200715115901.515956-1-a.darwish@linutronix.de>
In-Reply-To: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
References: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
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
latch read paths. Due to the dependent load, it also has one read
memory barrier less than the currently used raw_read_seqcount() API.

Use raw_read_seqcount_latch() for the seqcount_t latch read path.

Link: https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r/20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de
References: 1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fa3f800d7d76..ea007928d681 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -100,7 +100,7 @@ unsigned long long notrace sched_clock(void)
 	struct clock_read_data *rd;

 	do {
-		seq = raw_read_seqcount(&cd.seq);
+		seq = raw_read_seqcount_latch(&cd.seq);
 		rd = cd.read_data + (seq & 1);

 		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
--
2.20.1
