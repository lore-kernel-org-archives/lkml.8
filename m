Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BEBC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4861C2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgaUDS6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGXHAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgGXHAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:00:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685C8C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 7so7213723ybl.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5cayCuPk2wPjGrqLjRjs0da5Omg5sZGp1EbJR3QFOWA=;
        b=XgaUDS6lp9nfPXqDpwi2F+CnJNkzEBfzakfczBxRxMHopo8/GKoQHgb1J4G2BLOPId
         Tj7TokenLtlE0yd10U3xLpw2pvexm+cQHg8qZDXd1Hds+R8Ya60ZJRzH+X1ph8/9V0NP
         gWGpMVej7a3D2OA5JAw31HMddDv9tUp2mmDz2ZVfGLMEWvFVPBmAWMbP2ZgSVe7ESAqV
         W8GVG/bfHd984S3my9TIYv7ONr7HbP4/d7XOruVcCrWouarTuQeqHybf1gWxg8jKLCOd
         1XOxupusauqtoiWHSTZ/+XEgsRxcCjs9WGMhPi069xiPfUBLCQtcY6BeixmJGEmKEamC
         JG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5cayCuPk2wPjGrqLjRjs0da5Omg5sZGp1EbJR3QFOWA=;
        b=ac+l+B0MT4P4zXWw36YBXZiOW2+Kddk1aP9IXgmzGYbeCFJ1xNdMRqgJgpgws2FVpI
         ViGfEKg+zjee77PhGDZHhEhaoMbXHO5YXOYKQ8LWzsd/y4zt3pUaUuhxunfNb9MrqOle
         ouO1DG1RYbHedCN1JEZL/NYQbkf8DQeYpz/ADipnLPGbf7/tUeXmqe+9vjGROz4SMYoy
         nsNFZvYFEbifSN3YMnnN59zNypP/PwXknhixp+dXbxX6u89v1PMOCZn8+AcwVUUvDhPp
         UYImAqwlFCcQ1x1jiyyR4wnqUB3hnIG/VyZp64Dl+k3E4iRfq4yjY5KV578lmRN6W51x
         SRrA==
X-Gm-Message-State: AOAM531PsPttsvkt3zyMonShnb78HXWic/6B69kHTMNSBQOpCvZpn5mB
        DE5jbJZLkvcFgzhud0UGdMaD0qaJbg==
X-Google-Smtp-Source: ABdhPJzcsx9MWCrFPtOouS3kHQd2xrtiLfC+0hwi+LxDJkH7/b/r8aGAco8bTXZRQ9ZDKDFku2rj0XEIzA==
X-Received: by 2002:a25:b68d:: with SMTP id s13mr13979168ybj.330.1595574031586;
 Fri, 24 Jul 2020 00:00:31 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:04 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-5-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 4/8] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add {} for readability.

Added to this series, as it would otherwise cause patch conflicts.
---
 kernel/kcsan/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4633baebf84e..e43a55643e00 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -892,14 +892,19 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
+		}                                                                                  \
 		return __atomic_load_n(ptr, memorder);                                             \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
+		}                                                                                  \
 		__atomic_store_n(ptr, v, memorder);                                                \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
@@ -908,8 +913,11 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -937,8 +945,11 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -949,8 +960,11 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
-- 
2.28.0.rc0.142.g3c755180ce-goog

