Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA7C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753D3207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648223;
	bh=lEYP8HaRK9SA7EpN4C7zVMsqEQ5gVGTnZtMrnAnItJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BU6Aw710FG9OjJnodoiHCQOnM5Igf8Dz18hoQdkdvS/WAXbaR+dIrXrIKonf0YM3k
	 QkDsulKlMlkuJng0OAizquBb3NTqj+bCH1puSy7QGE1MWlgBOktoxIrRCat/RkCJUT
	 PMk7YC1JNwe9j8osR8O5NorVMlRE3VnlWWZqlrOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH1U5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:57:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42060 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgH1U41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:27 -0400
Received: by mail-il1-f194.google.com with SMTP id t13so1810838ile.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mv5bR3+D06zbxqvFs+zuZPo2cV/Tfy8G7nPGXO/hjAU=;
        b=mlEFjLMn6Ycjq7otWvcjQ0dpFB8yfwwAdy61YGWLhpeyTTIrYTfV1Xr2ELqaT7+sb/
         OZY99vvMEdG+QlvXNJU3HWgLJTjnjEmk1Uts2XoA2Hi7Job8KDn1XaUncFCdd1Nkk5Gr
         N53vFydlh2Gjh8+feMJSmd5dm8aM7NMpa6vXT6OCi8SCCH0uFWU6/komNEiKR5jIuRyI
         AKIuB5dqlC5YlfvtM+VP2NcDuURMgDDQUTLvZehQuh+jUaid/kBCc55r5arjQgL8jw66
         KBB/aT88sByTsC170VB/6jUtwbLO1K4l37jTNBdzxF+a1RehnR1Yqh5qmi6BCpOcTeUv
         0yTQ==
X-Gm-Message-State: AOAM530HQ1PlGsCY7V/LE0VDqNH3clWy1Yit922UDpUncOZPxyV7y43j
        Otc2SQ5iZBozgxHBJo5K8A==
X-Google-Smtp-Source: ABdhPJyxOG80OGdnAhzUR9EE/kBXC0gtLzjMiKCfzG/7ihXt64wtyAdyn2CfQE8oPVG2Xhc9SzNmbQ==
X-Received: by 2002:a92:a1c5:: with SMTP id b66mr596524ill.71.1598648186927;
        Fri, 28 Aug 2020 13:56:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:26 -0700 (PDT)
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
Subject: [PATCH v2 4/9] tools/include: Add an initial math64.h
Date:   Fri, 28 Aug 2020 14:56:09 -0600
Message-Id: <20200828205614.3391252-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an initial math64.h similar to linux/math64.h with functions
mul_u64_u64_div64() and mul_u64_u32_shr(). This isn't a direct copy of
include/linux/math64.h as that doesn't define mul_u64_u64_div64().

Implementation was written by Peter Zilkstra based on linux/math64.h
and div64.h[1]. The original implementation was not optimal on arm64 as
__int128 division is not optimal with a call out to __udivti3, so I
dropped the __int128 variant of mul_u64_u64_div64().

[1] https://lore.kernel.org/lkml/20200322101848.GF2452@worktop.programming.kicks-ass.net/

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I'm not really sure what's desired here. Unlike most of the headers copied
into tools/, this one is not a copy from include/linux/. Perhaps adding
mul_u64_u64_div64() to include/linux/math64.h first and then copying it
over is preferred? Or I could just move this into libperf?


 tools/include/linux/math64.h | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/include/linux/math64.h

diff --git a/tools/include/linux/math64.h b/tools/include/linux/math64.h
new file mode 100644
index 000000000000..4ad45d5943dc
--- /dev/null
+++ b/tools/include/linux/math64.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MATH64_H
+#define _LINUX_MATH64_H
+
+#include <linux/types.h>
+
+#ifdef __x86_64__
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 q;
+
+	asm ("mulq %2; divq %3" : "=a" (q)
+				: "a" (a), "rm" (b), "rm" (c)
+				: "rdx");
+
+	return q;
+}
+#define mul_u64_u64_div64 mul_u64_u64_div64
+#endif
+
+#ifdef __SIZEOF_INT128__
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	return (u64)(((unsigned __int128)a * b) >> shift);
+}
+
+#else
+
+#ifdef __i386__
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	u32 high, low;
+
+	asm ("mull %[b]" : "=a" (low), "=d" (high)
+			 : [a] "a" (a), [b] "rm" (b) );
+
+	return low | ((u64)high) << 32;
+}
+#else
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#endif
+
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	u32 ah, al;
+	u64 ret;
+
+	al = a;
+	ah = a >> 32;
+
+	ret = mul_u32_u32(al, b) >> shift;
+	if (ah)
+		ret += mul_u32_u32(ah, b) << (32 - shift);
+
+	return ret;
+}
+
+#endif	/* __SIZEOF_INT128__ */
+
+#ifndef mul_u64_u64_div64
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 quot, rem;
+
+	quot = a / c;
+	rem = a % c;
+
+	return quot * b + (rem * b) / c;
+}
+#endif
+
+#endif /* _LINUX_MATH64_H */
--
2.25.1
