Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E9CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422EB20784
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0P6mE6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgELSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELSjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:39:04 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:39:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d35so15082532qtc.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ps+E68vTZBQzCMKZDqxPDdmjNakB1JNehAqdvEI79/o=;
        b=I0P6mE6Ym9/DT32bhiREK21hOmfxw7rI27s0Mf8iYKctvf5Qcac/Rdi0CdLRrpRGUQ
         IhDXj/wgrFPjnVUlux06lznPaWAVLN4k1nY+Qs6j3bUofNgqecUeBZtwrmvgQMIwhCDh
         shGsfi2Z1nZeqIk8OXcbCSgBH6Ml/VvQ/40jBGz4asbq4d2bd0uCW9Frb6HutYRDo1Af
         YIUEeGiHIwQfCR3WKZXGiF9HpdlLDvBH54cJtxO8myQdmPt11sM2N14mG3x89spPYG8l
         Jyzfl4Mc7O+Q8yinnOZsaWN+/Kt7ek9m5zOMUeLqsUBEJaaLORLH+ZLr/BkQbTM4pDL2
         EEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ps+E68vTZBQzCMKZDqxPDdmjNakB1JNehAqdvEI79/o=;
        b=PmmlxC5KttGkXOMUPktAx1GonmVDJcS/IR8/TJjPYpSZ3wgVayf3JKyUP+WQz8kPoe
         lwul2Ov5qESvwKC4u/MhjdcoNzDkJUdRAHFdGOO+5/hWZSGvF+VRTZsM9IUtlgkIwJIa
         jazREUXOcbdMZOQ4cLsBxg7UXJHvvNB9gySWe7jTqdtnfeSe7rjtwxFamKb87A5v0lgq
         vlZ4UnHZgWycmxWwT1Iz4vloMQqbw23/OQUw5gsGquaHXOHTA/RM4BZxov2VvZnu3h3r
         s6i4ArssCYjCdNvKRbCFkdTuAuXo0HIG/pKbp9Ar/p0gEKDM9OQ6JiBOnI4r3XctIBee
         W03w==
X-Gm-Message-State: AGi0PuZ2b0OlvHCVqu+aFqFYp1Twmg+xr53229OF9wG4mpVDU9a2Zp4h
        jeAMyx2jzjGO0xq2J1AIDFbzYkh1Iw==
X-Google-Smtp-Source: APiQypIoKi1a8Ko7jwnRCUxHivoNjM5LulfUCSxArPq7/C3tCbaWTjzfqGcp3ai4YxNU9V48l06GNttX3w==
X-Received: by 2002:a0c:ec4c:: with SMTP id n12mr11416847qvq.190.1589308741420;
 Tue, 12 May 2020 11:39:01 -0700 (PDT)
Date:   Tue, 12 May 2020 20:38:39 +0200
Message-Id: <20200512183839.2373-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If left plain, using __READ_ONCE and __WRITE_ONCE will result in many
false positives with KCSAN due to being instrumented normally. To fix,
we should move the kcsan_check and data_race into __*_ONCE.

Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
A proposal to fix the problem with __READ_ONCE/__WRITE_ONCE and KCSAN
false positives.

Will, please feel free to take this patch and fiddle with it until it
looks like what you want if this is completely off.

Note: Currently __WRITE_ONCE_SCALAR seems to serve no real purpose. Do
we still need it?
---
 include/linux/compiler.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 741c93c62ecf..e902ca5de811 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -224,13 +224,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+#define __READ_ONCE(x)							\
+({									\
+	kcsan_check_atomic_read(&(x), sizeof(x));			\
+	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x))); \
+})
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
-	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);		\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
 })
@@ -243,14 +246,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __WRITE_ONCE(x, val)						\
 do {									\
-	*(volatile typeof(x) *)&(x) = (val);				\
+	kcsan_check_atomic_write(&(x), sizeof(x));			\
+	data_race(*(volatile typeof(x) *)&(x) = (val));			\
 } while (0)
 
 #define __WRITE_ONCE_SCALAR(x, val)					\
 do {									\
 	typeof(x) *__xp = &(x);						\
-	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
+	__WRITE_ONCE(*__xp, val);					\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
-- 
2.26.2.645.ge9eca65c58-goog

