Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A22C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C5C215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780732;
	bh=EfkWJq/3i/2AIsjETv/LMoh2J/xH1Sf+TOeH9UE6kGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JG6tHt7LnWbu7hNGRa0rfJVsYgTm2hLFuOHzWWex394I6ayn/gQFBNfgI9fQBEkJB
	 QoeSB2DVVl3LtN3T23lEbZFNKVBunGkKVhhIc1JbXJ5/KMrsRf8+TCknCUOSfpOvLu
	 7SAXgcsJR6M7f8ahoXIl5mEA4AwAz9eJIKGkm70Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCITFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbgCITE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F73222C3;
        Mon,  9 Mar 2020 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780667;
        bh=EfkWJq/3i/2AIsjETv/LMoh2J/xH1Sf+TOeH9UE6kGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoU+iiQcQRemtF9WtFffTYPxvYPEqIEOXJHiY/nJmE0WAVVE8i9aWxvgAAT2LOcwC
         W1YvIbaaDz3m67OszRPiSctz19aOC+WG+kLszzA/E8QlpvqULY2DfpiJI+GpbYdsFo
         a/a8H5FRtfolSOH3QfaV3M3S5IeiZkC12eQrdpTg=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 21/32] kcsan: Move interfaces that affects checks to kcsan-checks.h
Date:   Mon,  9 Mar 2020 12:04:09 -0700
Message-Id: <20200309190420.6100-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This moves functions that affect state changing the behaviour of
kcsan_check_access() to kcsan-checks.h. Since these are likely used with
kcsan_check_access() it makes more sense to have them in kcsan-checks.h,
to avoid including all of 'include/linux/kcsan.h'.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 48 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/kcsan.h        | 41 -------------------------------------
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf69617..8675411 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -32,10 +32,54 @@
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
-#else
+/**
+ * kcsan_nestable_atomic_begin - begin nestable atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_nestable_atomic_begin(void);
+
+/**
+ * kcsan_nestable_atomic_end - end nestable atomic region
+ */
+void kcsan_nestable_atomic_end(void);
+
+/**
+ * kcsan_flat_atomic_begin - begin flat atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_flat_atomic_begin(void);
+
+/**
+ * kcsan_flat_atomic_end - end flat atomic region
+ */
+void kcsan_flat_atomic_end(void);
+
+/**
+ * kcsan_atomic_next - consider following accesses as atomic
+ *
+ * Force treating the next n memory accesses for the current context as atomic
+ * operations.
+ *
+ * @n number of following memory accesses to treat as atomic.
+ */
+void kcsan_atomic_next(int n);
+
+#else /* CONFIG_KCSAN */
+
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
-#endif
+
+static inline void kcsan_nestable_atomic_begin(void)	{ }
+static inline void kcsan_nestable_atomic_end(void)	{ }
+static inline void kcsan_flat_atomic_begin(void)	{ }
+static inline void kcsan_flat_atomic_end(void)		{ }
+static inline void kcsan_atomic_next(int n)		{ }
+
+#endif /* CONFIG_KCSAN */
 
 /*
  * kcsan_*: Only calls into the runtime when the particular compilation unit has
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 1019e3a..7a614ca 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -56,52 +56,11 @@ void kcsan_disable_current(void);
  */
 void kcsan_enable_current(void);
 
-/**
- * kcsan_nestable_atomic_begin - begin nestable atomic region
- *
- * Accesses within the atomic region may appear to race with other accesses but
- * should be considered atomic.
- */
-void kcsan_nestable_atomic_begin(void);
-
-/**
- * kcsan_nestable_atomic_end - end nestable atomic region
- */
-void kcsan_nestable_atomic_end(void);
-
-/**
- * kcsan_flat_atomic_begin - begin flat atomic region
- *
- * Accesses within the atomic region may appear to race with other accesses but
- * should be considered atomic.
- */
-void kcsan_flat_atomic_begin(void);
-
-/**
- * kcsan_flat_atomic_end - end flat atomic region
- */
-void kcsan_flat_atomic_end(void);
-
-/**
- * kcsan_atomic_next - consider following accesses as atomic
- *
- * Force treating the next n memory accesses for the current context as atomic
- * operations.
- *
- * @n number of following memory accesses to treat as atomic.
- */
-void kcsan_atomic_next(int n);
-
 #else /* CONFIG_KCSAN */
 
 static inline void kcsan_init(void)			{ }
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
-static inline void kcsan_nestable_atomic_begin(void)	{ }
-static inline void kcsan_nestable_atomic_end(void)	{ }
-static inline void kcsan_flat_atomic_begin(void)	{ }
-static inline void kcsan_flat_atomic_end(void)		{ }
-static inline void kcsan_atomic_next(int n)		{ }
 
 #endif /* CONFIG_KCSAN */
 
-- 
2.9.5

