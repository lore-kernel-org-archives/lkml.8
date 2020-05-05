Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA47C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1CC206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wutoE5vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgEEN4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729202AbgEEN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214DBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:56:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so814577plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tNBFhF/ggXZPZwGUiqxzSB760pgCcUxpJ37blThJNEI=;
        b=wutoE5vzHDt141cP+zqKw13AsxyZDmqimG3VCe2kulHk/dcLheB3goxZFqDEPpqLtx
         +2y45IsDhYVBFgtvCZRq43rFlnLr8Hz3ZUgo+chXAJd85QkXjRaAT/LGdcVAqYMt+01C
         Gg14jvUlpkcH2tJqBJFxDROu7sCUcugNbVqJ3Dh9w4Lgz76F5ThR2mnQR8EIceAmkRg8
         ZBA53qVz8Vipf4SyUiJnQTr0b2FT+DlIe7G48uqUT2FrSpNucBisrhkzT2fY9/tH4UAY
         v6cplZvE0huOpeElysBBMsZe3RVlLeYSU0sClPfO5mRug51Hlba9zGAUkDrzW4WBOyGf
         Kowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tNBFhF/ggXZPZwGUiqxzSB760pgCcUxpJ37blThJNEI=;
        b=aM6iIz+Cq4FNc3dCWeX2fu+8/7MTLN0B7gOb649SxGwh0hXrW8veJTHoP6egWmBHCh
         oWpZLgRLD+rK/XUrE9q53nE2On6ou0DhFf9e3LKIKCpdhYee2ClDQc1adk+c414BAqBO
         LyAvlKYu7KZAr4cAz5xa59Fiww+jQHyYTVbI+wNMWlEnqy4m0ZVGMolq7ektb+nmeol/
         5+v2Y/KpwkLbcO9rfoz6wBQBDPbARdm945kwY2X4SNyjD74+wxoe1sqQTn31rtJxk4FX
         d8tN3XDqrsHoY0m2g9QH0rEjCwEoNaiOeUKJ3a1hnJE+ZEdqWJ1jhyNNALF0Speu+ajT
         0hXg==
X-Gm-Message-State: AGi0PuaL+xjZCo1kyG5wDkzde0L5kLJlG6jtEUPo74ih+jdJzOUbodGT
        b1Adm4icN/bo2Nm23zgEtuYmXg==
X-Google-Smtp-Source: APiQypKwZbjoFvZHFkTi/sqRdibF0HSyFnmyfTDs/xFUevEDLWaZ7rJkx5mSRCyfkXmk4NQvg0TvpQ==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr3387846ply.55.1588686967626;
        Tue, 05 May 2020 06:56:07 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id w2sm2068101pfc.194.2020.05.05.06.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:56:07 -0700 (PDT)
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
Subject: [PATCH v2 1/3] time/sched_clock: Add new variant sched_clock_register_epoch()
Date:   Tue,  5 May 2020 21:55:42 +0800
Message-Id: <20200505135544.6003-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505135544.6003-1-leo.yan@linaro.org>
References: <20200505135544.6003-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except the sched clock's raw counter is used by sched clock itself, it
also can be used by other purposes in the same system, e.g. the raw
counter can be injected into hardware tracing data (like Arm's SPE) and
Perf tool can capture trace data and extract the raw counter from it
which finally can be used to generate timestamp.

Perf tool needs a way to convert sched clock's raw counter cycles into a
nanosecond that can be compared against values coming out of sched_clock.

To do this accurately, this patch adds a new variant API
sched_clock_register_epoch() with introducing an extra argument
'epoch_offset', as its naming indicates, this argument contains the
offset time (in nanosecond) for the clock source has been enabled prior
to epoch.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 include/linux/sched_clock.h | 10 ++++++++++
 kernel/time/sched_clock.c   | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 0bb04a96a6d4..98965c0c7cd4 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -10,6 +10,10 @@ extern void generic_sched_clock_init(void);
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
+
+extern void sched_clock_register_epoch(u64 (*read)(void), int bits,
+				       unsigned long rate,
+				       u64 *epoch_offset);
 #else
 static inline void generic_sched_clock_init(void) { }
 
@@ -17,6 +21,12 @@ static inline void sched_clock_register(u64 (*read)(void), int bits,
 					unsigned long rate)
 {
 }
+
+static inline void sched_clock_register_epoch(u64 (*read)(void), int bits,
+					      unsigned long rate,
+					      u64 *epoch_offset)
+{
+}
 #endif
 
 #endif
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fa3f800d7d76..b402196afc3f 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -165,7 +165,8 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 }
 
 void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+sched_clock_register_epoch(u64 (*read)(void), int bits, unsigned long rate,
+			   u64 *epoch_offset)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -204,6 +205,10 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	rd.epoch_cyc		= new_epoch;
 	rd.epoch_ns		= ns;
 
+	/* Output epoch offset (ns) to clock event driver */
+	if (epoch_offset)
+		*epoch_offset = cyc_to_ns(new_epoch & new_mask, new_mult, new_shift) - ns;
+
 	update_clock_read_data(&rd);
 
 	if (sched_clock_timer.function != NULL) {
@@ -240,6 +245,12 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
 
+void __init
+sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+{
+	sched_clock_register_epoch(read, bits, rate, NULL);
+}
+
 void __init generic_sched_clock_init(void)
 {
 	/*
-- 
2.17.1

