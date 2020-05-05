Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA16C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7177E20746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1AKO/HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgEEN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729122AbgEEN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:56:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so1185540pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dt4B0z5dYP0Uyr0mcsXM5/WpJpH1f8WRXqVG53zpmTQ=;
        b=o1AKO/HSqppLELU1zsOuB8md57x4ABxWkYQW0v5+SHl8/tgSZb0b5nHEHpDEvrmPpB
         GN7VOqsb4nUUNKhpIO0B9XpQYF9ZeJSAx+0siwZiknoYbdoui8vdgPRjiGg7O0bDXMHX
         tHv+LGww+Zj1vRW6irLa/2F3yBwMUY4+unKr3xgNmnB7kclBKRzKOVFr3f3JpYkLtVqz
         yXykZRTrGwMzyMU1d2WsduT3HrYZVdtA4vHB9y8LAV90ssDyS8Cvsv2YiG6h5wkbZSKY
         xr4xYuGYB7bmlKmUpc5BuN2gFTnYJl1Zws+Py1FkouttXtXAc4OtqXTpD8QIoWop104g
         NZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dt4B0z5dYP0Uyr0mcsXM5/WpJpH1f8WRXqVG53zpmTQ=;
        b=sRkqkTYebGNb7frwldIVuvQZn2H572kjdBEp5zHQHmLf2gaNSpaQoFsIYv/SvrEI7j
         EPiIU/hknr7t0Q44/KlWicWPjIPQq50eY3L4w9Ira05p6BOpue4wy2OjhQRZoMbn6htO
         UmIgjlUkldrMBoC0zIkCHczh4fY6RzC8HPZUMzXq6GAyQEq2acl/beqstSvCYqXf4R4z
         5OoMEob0l7DEmmVlT2uZ4JKv3AebAfgeD4gzoa9baqBExqhX1gtUX9TKnsOijh4ca/qy
         CPrkmuSsRI8WUE/hNYB58/xn6nJGTgInI+pt2E4zZiOsw+sc35csGlxk1ffN3hvAmSdv
         +Dew==
X-Gm-Message-State: AGi0PuaDdUovj0CVA6WVodwbDKiQhdB/XbwRCZstWHDXb9GhxvpEfcxY
        gqDK0ZQ1Uu04ZtjppyiuMBXiGQ==
X-Google-Smtp-Source: APiQypIHysObxDkfTPL5Ld8IioHs66VbL78eaPDd5OTIG6b36V584rOvubMrndPUJ07U5+/saSXr8w==
X-Received: by 2002:a17:90a:80c2:: with SMTP id k2mr3204469pjw.6.1588686986451;
        Tue, 05 May 2020 06:56:26 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id n34sm1724456pgl.43.2020.05.05.06.56.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:56:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/3] arm64: perf_event: Fix time_offset for arch timer
Date:   Tue,  5 May 2020 21:55:44 +0800
Message-Id: <20200505135544.6003-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505135544.6003-1-leo.yan@linaro.org>
References: <20200505135544.6003-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'userpg->time_offset' is assigned to the negative 'now', 'now' if the
value of sched clock and this value cannot reflect the time offset for
arch timer's raw counter prior to sched clock's registration.

To fix this issue, this patch invokes arch_timer_get_epoch_offset() to
read time offset prior to sched clock's registration, and assign its
negative value to 'userpg->time_offset'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..cbad7bd770fb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1163,10 +1163,12 @@ static int __init armv8_pmu_driver_init(void)
 device_initcall(armv8_pmu_driver_init)
 
 void arch_perf_update_userpage(struct perf_event *event,
-			       struct perf_event_mmap_page *userpg, u64 now)
+			       struct perf_event_mmap_page *userpg,
+			       u64 __maybe_unused now)
 {
 	u32 freq;
 	u32 shift;
+	u64 offset;
 
 	/*
 	 * Internal timekeeping for enabled/running/stopped times
@@ -1188,5 +1190,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 		userpg->time_mult >>= 1;
 	}
 	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
+
+	offset = arch_timer_get_epoch_offset();
+	userpg->time_offset = -offset;
 }
-- 
2.17.1

