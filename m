Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D21C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A22075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648217;
	bh=PenNmkEfYyNJe9Yb3cObVw+Xszffc04ByAzna1LURyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n70otiaHorxDpdMPfj+QGqW3vRWe1mrptGB0B3ixNgFZMWQqLe6TH3UhkAtVYs48E
	 xgGmfUrx+4FlOowLFp9N2RlK93YGl1fieqJ3ZCaDbBMwizHs6+/jYJ7Q9ntxuStmIq
	 czYJVsDXDh8XZUvWQ7OsfDc7gol0ZJ973Ml+DXus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH1U4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39560 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgH1U4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:33 -0400
Received: by mail-io1-f68.google.com with SMTP id h10so410497ioq.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEK3psBWYVpGsyGTRdmYNWgiavHp54wPxYJ3tZKCLfo=;
        b=WW1J2gLGPXksbVP610MymWF3SpbS5ySW87qKf8djraNnnmy3BH1thqsOPYSc8wrwOR
         oHO++njV93eViPv0OtVCq1vq5Fyt2xtsmPib4uDPu/y0CIrSwrz+vTIrz69+yfAiXtjX
         9JW6wI2102hyngZFacv6HXAIGsOe7UxIEmilMUiwidNnTCITFAVYnyPXDxxseRierGv1
         A5RRwY0GJcajHt/4kuZ1wCIwVGz5yMqqV3gQ5VVXceUyCxyUf8NK/FvIkc8GnJCkNEqm
         UHHXx8Q0mCeuXBLRbjk1feXjHsGxHfMH0fEUySyxUdb2tcAn6QriSFYbte67t2NxSvnZ
         4Zhw==
X-Gm-Message-State: AOAM533jD7bYHa9chS3jnZkXhBZC6IleQzIJwtpaZ/r9FwwRWVlUvsDy
        MhFHyH/OxCQiTR7i8ICIZQ==
X-Google-Smtp-Source: ABdhPJxLimpFXwJRuWpabg8gfiX1OX1JPpv3XwP8OJMnl7ryNd+qPAb/Yf6DBi3YddTlmfzelvIhoA==
X-Received: by 2002:a6b:7d42:: with SMTP id d2mr483313ioq.17.1598648192252;
        Fri, 28 Aug 2020 13:56:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 6/9] libperf: Add arm64 support to perf_mmap__read_self()
Date:   Fri, 28 Aug 2020 14:56:11 -0600
Message-Id: <20200828205614.3391252-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the arm64 variants for read_perf_counter() and read_timestamp().
Unfortunately the counter number is encoded into the instruction, so the
code is a bit verbose to enumerate all possible counters.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/lib/perf/mmap.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index cb07969cfdbf..6cf939aae6b6 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -13,6 +13,7 @@
 #include <internal/lib.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/stringify.h>
 #include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
@@ -294,6 +295,103 @@ static u64 read_timestamp(void)
 
 	return low | ((u64)high) << 32;
 }
+#elif defined(__aarch64__)
+#define read_sysreg(r) ({						\
+	u64 __val;							\
+	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
+	__val;								\
+})
+
+static u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+#define PMEVCNTR_READ(idx)					\
+	static u64 read_pmevcntr_##idx(void) {			\
+		return read_sysreg(pmevcntr##idx##_el0);	\
+	}
+
+PMEVCNTR_READ(0);
+PMEVCNTR_READ(1);
+PMEVCNTR_READ(2);
+PMEVCNTR_READ(3);
+PMEVCNTR_READ(4);
+PMEVCNTR_READ(5);
+PMEVCNTR_READ(6);
+PMEVCNTR_READ(7);
+PMEVCNTR_READ(8);
+PMEVCNTR_READ(9);
+PMEVCNTR_READ(10);
+PMEVCNTR_READ(11);
+PMEVCNTR_READ(12);
+PMEVCNTR_READ(13);
+PMEVCNTR_READ(14);
+PMEVCNTR_READ(15);
+PMEVCNTR_READ(16);
+PMEVCNTR_READ(17);
+PMEVCNTR_READ(18);
+PMEVCNTR_READ(19);
+PMEVCNTR_READ(20);
+PMEVCNTR_READ(21);
+PMEVCNTR_READ(22);
+PMEVCNTR_READ(23);
+PMEVCNTR_READ(24);
+PMEVCNTR_READ(25);
+PMEVCNTR_READ(26);
+PMEVCNTR_READ(27);
+PMEVCNTR_READ(28);
+PMEVCNTR_READ(29);
+PMEVCNTR_READ(30);
+
+/*
+ * Read a value direct from PMEVCNTR<idx>
+ */
+static u64 read_perf_counter(unsigned int counter)
+{
+	static u64 (* const read_f[])(void) = {
+		read_pmevcntr_0,
+		read_pmevcntr_1,
+		read_pmevcntr_2,
+		read_pmevcntr_3,
+		read_pmevcntr_4,
+		read_pmevcntr_5,
+		read_pmevcntr_6,
+		read_pmevcntr_7,
+		read_pmevcntr_8,
+		read_pmevcntr_9,
+		read_pmevcntr_10,
+		read_pmevcntr_11,
+		read_pmevcntr_13,
+		read_pmevcntr_12,
+		read_pmevcntr_14,
+		read_pmevcntr_15,
+		read_pmevcntr_16,
+		read_pmevcntr_17,
+		read_pmevcntr_18,
+		read_pmevcntr_19,
+		read_pmevcntr_20,
+		read_pmevcntr_21,
+		read_pmevcntr_22,
+		read_pmevcntr_23,
+		read_pmevcntr_24,
+		read_pmevcntr_25,
+		read_pmevcntr_26,
+		read_pmevcntr_27,
+		read_pmevcntr_28,
+		read_pmevcntr_29,
+		read_pmevcntr_30,
+		read_pmccntr
+	};
+
+	if (counter < ARRAY_SIZE(read_f))
+		return (read_f[counter])();
+
+	return 0;
+}
+
+static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
+
 #else
 static u64 read_perf_counter(unsigned int counter) { return 0; }
 static u64 read_timestamp(void) { return 0; }
-- 
2.25.1

