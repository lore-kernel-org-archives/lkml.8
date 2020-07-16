Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9943C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A366E207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hc4i2Nr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGPFMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB31DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so4229046pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/BsIfvqtTzak5Mv7ZiI0+KdUGs6co1ng50/6qYskQE=;
        b=hc4i2Nr6oqKqPE2jXwZbSn/Rbqv8nFoXy79RI3Lk97cBQGfRExofkvamCUf5Oo9J3N
         yCVbSC24M4e2k7egLH4YemLumM88fh51oKP7zE1T2CXUyJgLVTt7zf5bS1cYwcC4edI3
         OGbsrEH/Xs2i9s0VV4IZDrB9e8OdDk9HfV1N3c3VbJtQ2oyhg4/xn6JqKVC4r34xpeXU
         RQAJxud14c57X1UIFFQunjHv7cruYPst8np7S+LsS/NvbvI6kHk4MzxV8aLmCTglWn/n
         B7FEK/9bbc3vgOnpC4QiAUgC6nxpnuYTSjJN+xkPXFlz5XLXb4WqqjEFKbm7lrl/n4xh
         5IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o/BsIfvqtTzak5Mv7ZiI0+KdUGs6co1ng50/6qYskQE=;
        b=OWniMjLG2r6/Bj1NCMYrJ3yLywI/HrRG0r6KXX11LA8A0X3YCKCtMDZsj4pxrndx1U
         JnMlN3mm9RN6M+uGeboXAwAvNrlV2LitgcC545STkXZ898S9yGplGrGYVCdAvGkOLiDA
         xYyFJTZNavUAvKRwKPoZPp0TqeWOmcr4VOtH4GXWUr/hszV8XO86iHpwlzOOUr99OxkN
         sR7PwxJec53oShZ0Lkf1B0LtQEeKOC0Pq0eEDfojhULvWzCwGeP0kCl1yYWYv07BVxOy
         XAYBIr1aV1nuMCvF36oFwbkqqtHMURJHUD7bEtz7o8Vj9h1OH/r2y/0Me02SqLWV5fjp
         1aww==
X-Gm-Message-State: AOAM5320tl1xrxJQ3ueuMbB+Cna+HPQqYhZNMycK28Erxw5aKbHxKwo5
        NMSdCJu+DkjhLBfAfbH+Ty8sUg==
X-Google-Smtp-Source: ABdhPJwB25v0txIQiG1pHuN6YTqIfWIpOVf/k+duttLSriG0rbXE+fdtIvbK4/pYXJVfwXjm2oYlcA==
X-Received: by 2002:a62:a217:: with SMTP id m23mr2175657pff.291.1594876328190;
        Wed, 15 Jul 2020 22:12:08 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id a26sm3499222pgm.20.2020.07.15.22.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/7] time/sched_clock: Use raw_read_seqcount_latch()
Date:   Thu, 16 Jul 2020 13:11:25 +0800
Message-Id: <20200716051130.4359-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

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
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0acaadc3156c..0deaf4b79fb4 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -70,7 +70,7 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 
 struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
-	*seq = raw_read_seqcount(&cd.seq);
+	*seq = raw_read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
 }
 
-- 
2.17.1

