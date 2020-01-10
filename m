Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823CD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgAJRxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgAJRxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTM-0001nK-RA; Fri, 10 Jan 2020 18:53:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 891321C2D60;
        Fri, 10 Jan 2020 18:53:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:18 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools bitmap: Implement bitmap_equal() operation at
 bitmap API
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43757993-0b28-d8af-a6c7-ede12e3a6877@linux.intel.com>
References: <43757993-0b28-d8af-a6c7-ede12e3a6877@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157867879843.30329.11026919173397316723.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8812ad412f851216d6c39488a7e563ccc5c604cc
Gitweb:        https://git.kernel.org/tip/8812ad412f851216d6c39488a7e563ccc5c604cc
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Tue, 03 Dec 2019 14:43:33 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:04 -03:00

tools bitmap: Implement bitmap_equal() operation at bitmap API

Extend tools bitmap API with bitmap_equal() implementation.

The implementation has been derived from the kernel.

Extend tools bitmap API with bitmap_free() implementation for symmetry
with bitmap_alloc() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/43757993-0b28-d8af-a6c7-ede12e3a6877@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitmap.h | 30 ++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 05dca5c..477a1ca 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -15,6 +15,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
+int __bitmap_equal(const unsigned long *bitmap1,
+		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
@@ -124,6 +126,15 @@ static inline unsigned long *bitmap_alloc(int nbits)
 }
 
 /*
+ * bitmap_free - Free bitmap
+ * @bitmap: pointer to bitmap
+ */
+static inline void bitmap_free(unsigned long *bitmap)
+{
+	free(bitmap);
+}
+
+/*
  * bitmap_scnprintf - print bitmap list into buffer
  * @bitmap: bitmap
  * @nbits: size of bitmap
@@ -148,4 +159,23 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
+#ifdef __LITTLE_ENDIAN
+#define BITMAP_MEM_ALIGNMENT 8
+#else
+#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#endif
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
+
+static inline int bitmap_equal(const unsigned long *src1,
+			const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		return !memcmp(src1, src2, nbits / 8);
+	return __bitmap_equal(src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 3849478..5043747 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -71,3 +71,18 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			   BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+int __bitmap_equal(const unsigned long *bitmap1,
+		const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return 0;
+
+	return 1;
+}
