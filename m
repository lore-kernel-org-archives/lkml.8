Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5AB206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YzcEbgAD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhUitKgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHSI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHSIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:54:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D3C061348;
        Wed, 19 Aug 2020 01:52:13 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPnU8pyPddQW19gBJ+YOIgmFLzT1mk9Ey7bGquTkdic=;
        b=YzcEbgADRPpimgEa+z4D7MTQ9pGCKuWnwVbKpBTuKzlPiknk+NNXEkpKFQWnUswpDaxYZ0
        +mimsHvDyJ7ClStC2wm6pcdAFduq3a7qgvWSFWZNh2JkyGAhUiIXRduv6ujV0/lwO+3xtL
        iccp/plZw00yvf4Gdi3JPNhPOwmlQJ0mGnHFFXQHtOGG9pXtHG2gaYKzS0gnHuU9gXqr3R
        XiG9L5dEXe9XHaoF3zvuHSSgNalKiq/m1AzsoXRi4OwiCldgvbWNDo0Ia165A2HWiVK0zK
        +/oeGhcQ6KCj4dsUL3wOQiwrmzDN4Lj/vu7Vz2tyq1kwZZg7Fh3H9bfwyxQs4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPnU8pyPddQW19gBJ+YOIgmFLzT1mk9Ey7bGquTkdic=;
        b=MhUitKgByxj53KSjiUovfzgTJpl0DSRFcAbM4uvfM8yYLb1YkQ8KcvkRHzvlGnkZy0WAZb
        kDIqWqd7pZ+o86AA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Use event_base_rdpmc for the RDPMC
 userspace support
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-2-kan.liang@linux.intel.com>
References: <20200723171117.9918-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782713157.3192.4240252060821627383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     75608cb02ea5dd997990e2998eca3670cb71a18c
Gitweb:        https://git.kernel.org/tip/75608cb02ea5dd997990e2998eca3670cb71a18c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:34 +02:00

perf/x86: Use event_base_rdpmc for the RDPMC userspace support

The RDPMC index is always re-calculated for the RDPMC userspace support,
which is unnecessary.

The RDPMC index value is stored in the variable event_base_rdpmc for
the kernel usage, which can be used for RDPMC userspace support as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-2-kan.liang@linux.intel.com
---
 arch/x86/events/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57d..8e108ea 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2208,17 +2208,12 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 
 static int x86_pmu_event_idx(struct perf_event *event)
 {
-	int idx = event->hw.idx;
+	struct hw_perf_event *hwc = &event->hw;
 
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
-		idx -= INTEL_PMC_IDX_FIXED;
-		idx |= 1 << 30;
-	}
-
-	return idx + 1;
+	return hwc->event_base_rdpmc + 1;
 }
 
 static ssize_t get_attr_rdpmc(struct device *cdev,
