Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108AC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DB6207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bh5ySB4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGPFMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so4268777pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1eiDx750W5TLv9xcl+J4+klU55EJ+/NLxR5IMbapo/w=;
        b=Bh5ySB4xAmR52HC1OH0iXNGC70GZFINorsNKoAexjqz5/RQbvbOhLzF+zVjwhiKXud
         Wv6mI91XeQrXw2gOMKprlLbs2qPcKNK9jdA3dLOQ7J3U35/A0VYpYFzyaSFWcNSAHslK
         c2xnAjYkSJEpOvFxYOtpWX6w1ufOvI0eXWxVoHOoHe4QPtr0KfYhJqYW9iIBjVYbmv1c
         J/3jTzOH1qvz8YyVffpocpLlGapdbR6m54sPIjPe0Uyk1lvcuOwnlM/89YPz3jmH8q58
         aEeb9zGlQmmPy2p7ey12hb8lpepPgEShlkr9hQAJRZg7NmwB4mRL7xMgajtKp++9eCl/
         Cq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1eiDx750W5TLv9xcl+J4+klU55EJ+/NLxR5IMbapo/w=;
        b=FNT+mgvXhD5XY3C9jdkcH653EH9RqHNwSduSZYQ/JwSKx0lvo7gnzMjL9qtEy+G5b8
         uFyc5yniRkfbi21kWfrjVYVNKCBdyiI7DsgFFnQxKGdvsvUJvji8nNODe+XasuU3ABaa
         XyNgKXEZF5yXmvldYrD7O2wQMu4b+He3FUBqwtJggC8EwYYcMbR1kwu3uztzmxoSMpLl
         BHBMSF8hPleSwXEuImCu3XsYGSEt6xTSsUeMubRRkX3jxhP6oCneu9M1UMCh+BpOMGF7
         wX7O96oUZ/0aJvuQNInHSZrdA0i+m+m91+GpmUjv1CwkFsKuhTbiCV3LlhOycwtFKGmW
         X0YQ==
X-Gm-Message-State: AOAM531l2b7h3tT3iUbs69ZUaYeg2GO4vE7xMa3YTurfd7lGLKDY/t9O
        /ybALWelujealV5hoobDGu6m1A==
X-Google-Smtp-Source: ABdhPJxWZ4yrWVleVc9uo+BhXQllLqdxl67XUscUvWSXbZ8qaPwQyIVvxGNtPCOShlN2uq6b716gjA==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr2833586pgv.28.1594876355312;
        Wed, 15 Jul 2020 22:12:35 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id m16sm3602382pfd.101.2020.07.15.22.12.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:34 -0700 (PDT)
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
Subject: [PATCH v3 5/7] perf: Add perf_event_mmap_page::cap_user_time_short ABI
Date:   Thu, 16 Jul 2020 13:11:28 +0800
Message-Id: <20200716051130.4359-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In order to support short clock counters, provide an ABI extension.

As a whole:

    u64 time, delta, cyc = read_cycle_counter();

+   if (cap_user_time_short)
+	cyc = time_cycle + ((cyc - time_cycle) & time_mask);

    delta = mul_u64_u32_shr(cyc, time_mult, time_shift);

    if (cap_user_time_zero)
	time = time_zero + delta;

    delta += time_offset;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 include/uapi/linux/perf_event.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..21a1edd08cbe 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -532,9 +532,10 @@ struct perf_event_mmap_page {
 				cap_bit0_is_deprecated	: 1, /* Always 1, signals that bit 0 is zero */
 
 				cap_user_rdpmc		: 1, /* The RDPMC instruction can be used to read counts */
-				cap_user_time		: 1, /* The time_* fields are used */
+				cap_user_time		: 1, /* The time_{shift,mult,offset} fields are used */
 				cap_user_time_zero	: 1, /* The time_zero field is used */
-				cap_____res		: 59;
+				cap_user_time_short	: 1, /* the time_{cycle,mask} fields are used */
+				cap_____res		: 58;
 		};
 	};
 
@@ -593,13 +594,29 @@ struct perf_event_mmap_page {
 	 *               ((rem * time_mult) >> time_shift);
 	 */
 	__u64	time_zero;
+
 	__u32	size;			/* Header size up to __reserved[] fields. */
+	__u32	__reserved_1;
+
+	/*
+	 * If cap_usr_time_short, the hardware clock is less than 64bit wide
+	 * and we must compute the 'cyc' value, as used by cap_usr_time, as:
+	 *
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask)
+	 *
+	 * NOTE: this form is explicitly chosen such that cap_usr_time_short
+	 *       is a correction on top of cap_usr_time, and code that doesn't
+	 *       know about cap_usr_time_short still works under the assumption
+	 *       the counter doesn't wrap.
+	 */
+	__u64	time_cycles;
+	__u64	time_mask;
 
 		/*
 		 * Hole for extension of the self monitor capabilities
 		 */
 
-	__u8	__reserved[118*8+4];	/* align to 1k. */
+	__u8	__reserved[116*8];	/* align to 1k. */
 
 	/*
 	 * Control data for the mmap() data buffer.
-- 
2.17.1

