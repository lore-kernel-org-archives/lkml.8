Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79947C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBE2207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyRfgRhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGPFM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so4238474pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5uEgZcOvxySkXqr8EUPn06IShVdK3dXiQkAlG2OoJgw=;
        b=CyRfgRhBPlbJusvWZ2r6TphLSUqOHZjwFjCUPFk4b0NBT22sQeUDaJ717mzoDj3zAz
         MVUZsXUGOplDpyd9M+8GVQGshB2Mo8Lc0MKq7+iTRog7lrQJNWLmqK9tVvRtwlkEEUxt
         N6HKAb0924maFPbitUjI2O06iGLFFngf/67TSSZD+rtoVfQEvq+U6xUWIVZPgPziTcLY
         c03WrC2tRZeuCnvFXyccZWdySAfelGuPrVPtzSQFremFGc8NJWz6OROOUgjlpLvpZ6uF
         0l88G612fXl0BSRTEIYHmPqU46PxFQ+xAh6chUdesCpDENSxsp97o6sL0yq0hFUMKw7i
         EB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5uEgZcOvxySkXqr8EUPn06IShVdK3dXiQkAlG2OoJgw=;
        b=TlruKVLOEBFHZgRL4th4Hujw1mt+GPVVWAK5vmhSPKbtO+YE5DU9TePrZ/03C2JKQK
         W8huuWkXOZjUtaXmZSfmbMee5LwLQJUcp+ZQ1jDcTN7i1JauA6Ktb7oIhHfzL5qU37ML
         O8lBCJzSGk4EzmyXleP3cym+SWmqeBEaUGbvUmVAUiVrjyGJgdjG4uTKSjC5tb+ITUGl
         C+GCtoE0j7V+EhcUdKehPZH/aKvSmWrOdohnl0ZahuWN11Wkhq3Lx5Xl5E1nhojeAP7U
         btlN1ZmC5tKu0KoOCtg1yp5aneN6+4/lmyiLmbh0UuYcNsgmfpe6zFurDkDw+SzFcRDc
         +UYw==
X-Gm-Message-State: AOAM532KazH3QQ5oAzWlhsqub3BuYldkoTP0/DQ0y8i6NdMyVJox3vvt
        K8cZSNfp0ysfpX6URGw0OMzPww==
X-Google-Smtp-Source: ABdhPJyMvmCqRalWIJW5f9/g7nrURfOw7B8xkuE0x7liIs+vZhTKT7UKjFTL2WrzuJNWEe8iDMSN3A==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr2227739pfl.2.1594876375762;
        Wed, 15 Jul 2020 22:12:55 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id az13sm3449882pjb.34.2020.07.15.22.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:55 -0700 (PDT)
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
Subject: [PATCH v3 7/7] tools headers UAPI: Update tools's copy of linux/perf_event.h
Date:   Thu, 16 Jul 2020 13:11:30 +0800
Message-Id: <20200716051130.4359-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
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

