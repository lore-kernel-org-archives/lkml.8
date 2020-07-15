Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEFC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96C82074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKwq59of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGOCF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE517C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so983698plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ipEKOYUy0lWTBEiPnpX/QvgsPhGjR8M5oL+bv/+PVNY=;
        b=OKwq59ofEQvjl0rf8+qoNtlQqNXL5ng/x/i7+TUUKBCxrzu9o/bYZHlpHT2ipdlMH8
         2sQ2Zz1lI65U364bGf66i119BtLUXETXBZk/dOs8LATJu5y3rkIygcwxAw5728KpNeKi
         jDhC46l3d64ZwdCPTL7pwDU2H6y7/6Q4RqzfTgl+qE/2UvbEK1wWZgHT5S2SMJjcbXnf
         IEHaGBzPFqfqpInLB5qWTvfhsZct2wRTcjuIsBxDVZ67SXUFSTkBXdnRCOciKV1mmySY
         BQgD+hC7EOxhuh6NeZiZvedcgjNwCXH6HxVTNRgf+6TWFDAuOrP/3JUKAqC5SHjbgwFL
         L0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ipEKOYUy0lWTBEiPnpX/QvgsPhGjR8M5oL+bv/+PVNY=;
        b=i981hLk4rijmPCJETgzRR8EO9xSXaIbRpq0ZsbAK3UP+0shZh7FxPU+rxSW06Aj+J+
         32aYEFiGbTMHDssJl5yBYyCCFt6wrUuQpBET7pKkJqiPZlF+HGMnEl+p+hQvz+9ON0du
         aybOS5o/yG8/zzRi73gvJEyBPCoPwj27tVsvNgXgjBBjHJ0fQhU7BAFc4HDq0U4LXxKB
         JPnDDHszA66314WJSpe1kUHFSPiz/HKZ14uCqprQyr1ovtDeb0FVpfLPutHWZ8HHVqoh
         YywkxbLErUr9EX1NWTEdx33ODNr+apX0oNjqbNFugRolK8DDRvxa5ZnvZDbG9gQwcbyI
         EONg==
X-Gm-Message-State: AOAM530c0fE18W8T4+eiVnl/oAkYti50rImd0VeM6CwYpYtJ2Ka2IxZW
        trEZfT8Hp1s92Oi/N6lO0JuTJW9Elv2/EQ==
X-Google-Smtp-Source: ABdhPJzCo/QzGIKdS2L42Rixd5oGY6ofdxrVlSJJ+PcSZI2ghr06QlESXk2/1dne8fRw0HHyOKflwA==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr7811371pjv.197.1594778758276;
        Tue, 14 Jul 2020 19:05:58 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id q1sm376592pfk.132.2020.07.14.19.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:05:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] perf: Add perf_event_mmap_page::cap_user_time_short ABI
Date:   Wed, 15 Jul 2020 10:05:10 +0800
Message-Id: <20200715020512.20991-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
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

