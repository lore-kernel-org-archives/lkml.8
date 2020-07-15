Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F2AC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A63C20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOWWp9Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGOCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGOCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:06:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71867C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:06:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so1274657pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5uEgZcOvxySkXqr8EUPn06IShVdK3dXiQkAlG2OoJgw=;
        b=pOWWp9YnQGbRhp8vnvcjFzCjOY/Ptp60xa3w+pOU/QVau8l+iZKApRVWCKB3OwQiBz
         lnTthcfCxJWWgteowrvSvu9Ti0/yvZr7r2iOrdMZGCBtWv8Z64IB5X55LfjRyyv0LWwV
         ECtZ7d190zXrgGaiPuYqxOjtk+G1YIEMZvgUrNkmRus9DLuwT4FMnkNOrX5ZZdlCO4fo
         9xU0aanlhWpSxHmnqv8Zuczc2G7bTv5vRNPZ5tVDm0CgGdkypgdzom7wh8oUlSfTRB5F
         VpHstdK1QuNugsk8R3KmLMcmmqqyYeVacr35ZR5SWwUrhtbmrWTEwu4T2LHA3/xL0iIW
         59KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5uEgZcOvxySkXqr8EUPn06IShVdK3dXiQkAlG2OoJgw=;
        b=tChdXPDz3PrK3Velj9etZ36i2ZEmDU1OZgGll228ZZIr3+ooovpAKOAfoVeJa6HWHC
         GF5wJQHGZdAHROnq9NvaKCv99QBNRoZQZDIsTFbK1e/MdNsOtMBS7Q9umNiKSqstsZH5
         W4zJ7YrToAir2Wig7Bx05qfcI6mbFsSUTT2qLzXknbBu1SVkjYR57uDFIKw8BqzQKLZX
         CmUCssOJdFpaKKRdYzbphK7LrP6e1O9MLswBN7FzpzRnm61bxq+vniqfg09RN5FUFLct
         Oec/c+7g+F77zTvhcNLV2hp13V1Cwnt+/4wGU5gXdtPk9zoFlC2S07feNB8+2u4PRevk
         oWzg==
X-Gm-Message-State: AOAM530TpLOGomMLTyfuAW/REqhf1stZUsCqOB8ti9oQY2etSOkrZkA+
        Qld7HNrVRcFD1gO/DeDINIVmBcSPsSfuCQ==
X-Google-Smtp-Source: ABdhPJwMXpKq4bmzp8Tj2k831gLgHkghRRnoLsBK25hBLPT1cNEMu++Q/+CeJ5hpYTHTn55V9DEsVQ==
X-Received: by 2002:a17:90b:1c12:: with SMTP id oc18mr7615246pjb.160.1594778774962;
        Tue, 14 Jul 2020 19:06:14 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id c134sm369404pfc.115.2020.07.14.19.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:06:14 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 6/6] tools headers UAPI: Update tools's copy of linux/perf_event.h
Date:   Wed, 15 Jul 2020 10:05:12 +0800
Message-Id: <20200715020512.20991-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in the commit:

  "perf: Add perf_event_mmap_page::cap_user_time_short ABI"

This update is a prerequisite to add support for short clock counters
related ABI extension.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..21a1edd08cbe 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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

