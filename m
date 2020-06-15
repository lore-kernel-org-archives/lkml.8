Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA5CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555B220679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UYDuKMmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgFOOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFOOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:38:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:38:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h185so7907807pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1NtAaJQbnuNgbUb1D/FsI0at4jS7yofQQpYC64HM5M=;
        b=UYDuKMmOwZdlZz6/KeX+EVpriSho+LhNzH7LrG+Thh/SIIZmeyofDwtXtRWFG31XqV
         b/bf1jkuLyzT9zFLkumChihEfVoedph8rF6sN3z08OTcMv8OXaZNiQv0ND0yalI3ewz8
         hDISCJlPgvyphk7rwMFtXmg1y8CIasdYPW6Y+uQ9LzPXj53kCVj8wvKcrIwkinIX+CP1
         NIQpPszxYenej3pFLpnHQoUhsobAlifGRpMF4gwTV9zkgR5YsyboWYcIFtVCpLtX0kKH
         VVwDYyCrtXxIKQLEbYWBnnKoqKxATGIeEduSFD2hFV77eNhdqRPzMvQuMl//iCVmuqVI
         +xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1NtAaJQbnuNgbUb1D/FsI0at4jS7yofQQpYC64HM5M=;
        b=TvMO+242Ae7gPXG5gnychGV03NRzgbvjalIKoTR03HjOeM2c9XP62CZI/l9Bl9A1VZ
         fgopC5JFn7kcyT7RehCKH6yLVIlCRN6I+DMVYJtvxOlLm29zb06PKkqYMtQZWaXD8FMl
         7nFxFlJVU0cRD7xEIj5eQUIKni4QJsvDrP66bpxSRPoHNmyn4dn22OYEuUr5I//Gua1b
         exc6+N+xfNk3KymrRX5cu+sBtLJcHoejZzUNh4FUAk0pKEw3WawF7lF+P7SU+KUN9XcH
         gsDFPDwMUJ/RccohbLjDYGXW574GKmvZzAZhfRp3bHtqr5fr4M8PO/49VM+uDAQzAkY4
         V2AA==
X-Gm-Message-State: AOAM530et5jo2NCXvKoST5+pGqG6utClNUDIgemT2Lg0kjbiPmnh48Er
        gY5d3qtbDAEnywM9lZDNSMi67gBZP1Q=
X-Google-Smtp-Source: ABdhPJxiGsnXmYIs7G3t9SMJRek0VnDmtWmhF+DPVXkG3tqC3vCgC7Z/gu3POHo0euBdrQ1pF0bQ1g==
X-Received: by 2002:a62:3382:: with SMTP id z124mr23666064pfz.263.1592231930594;
        Mon, 15 Jun 2020 07:38:50 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id y10sm12327239pgi.54.2020.06.15.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:38:49 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Chiawei Wang <chiaweiwang@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH v2]: arch: arm64: vdso: export the symbols for time()
Date:   Mon, 15 Jun 2020 07:38:24 -0700
Message-Id: <20200615143838.143137-1-salyzyn@android.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chiawei Wang <chiaweiwang@google.com>

__cvdso_time() can be found in vDSO implementation,
but the symbols for time() are not exported.

Export the symbols and run bionic-benchmarks.

BEFORE:
bionic-benchmarks32 --bionic_extra BM_time_time
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_time_time     83.6 ns         83.5 ns      8385964

bionic-benchmarks64 --bionic_extra BM_time_time
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_time_time     63.5 ns         63.4 ns     11037509

AFTER:
bionic-benchmarks32 --bionic_extra BM_time_time
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_time_time     8.57 ns         8.56 ns     81887312

bionic-benchmarks64 --bionic_extra BM_time_time
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_time_time     7.52 ns         7.51 ns     93253809

Signed-off-by: Chiawei Wang <chiaweiwang@google.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Enrico Weigelt <info@metux.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
---
v2:
- add prototypes in both vgettimeofday.c
- use __kernel_old_time_t instead of time_t
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 12 ++++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h        | 10 ++++++++++
 arch/arm64/kernel/vdso/vdso.lds.S                 |  1 +
 arch/arm64/kernel/vdso/vgettimeofday.c            |  5 +++++
 arch/arm64/kernel/vdso32/vdso.lds.S               |  1 +
 arch/arm64/kernel/vdso32/vgettimeofday.c          |  5 +++++
 6 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index b6907ae78e53..d0a5655785bd 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -14,8 +14,20 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define VDSO_HAS_TIME			1
+
 #define BUILD_VDSO32			1
 
+extern int __vdso_clock_gettime(clockid_t clock,
+				struct old_timespec32 *ts);
+extern int __vdso_clock_gettime64(clockid_t clock,
+				  struct __kernel_timespec *ts);
+extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			       struct timezone *tz);
+extern int __vdso_clock_getres(clockid_t clock_id,
+			       struct old_timespec32 *res);
+extern __kernel_old_time_t time(__kernel_old_time_t *time);
+
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index afba6ba332f8..e0dcf0dce6c0 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -11,6 +11,16 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define VDSO_HAS_TIME			1
+
+extern int __kernel_clock_gettime(clockid_t clock,
+				  struct __kernel_timespec *ts);
+extern int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
+				 struct timezone *tz);
+extern int __kernel_clock_getres(clockid_t clock_id,
+				 struct __kernel_timespec *res);
+extern __kernel_old_time_t __vdso_time(__kernel_old_time_t *time);
+
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 7ad2d3a0cd48..61dddb0af1a5 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -77,6 +77,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_time;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
index 4236cf34d7d9..9a9058ba1f89 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -23,3 +23,8 @@ int __kernel_clock_getres(clockid_t clock_id,
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
+
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *time)
+{
+	return __cvdso_time(time);
+}
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index a3944927eaeb..2222c78451b4 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -69,6 +69,7 @@ VERSION
 		__kernel_rt_sigreturn_arm;
 		__kernel_rt_sigreturn_thumb;
 		__vdso_clock_gettime64;
+		__vdso_time;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index 5acff29c5991..7eb988fa06d8 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -30,6 +30,11 @@ int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
+__kernel_old_time_t time(__kernel_old_time_t *time)
+{
+	return __cvdso_time(time);
+}
+
 /* Avoid unresolved references emitted by GCC */
 
 void __aeabi_unwind_cpp_pr0(void)
-- 
2.27.0.290.gba653c62da-goog

