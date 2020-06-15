Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9048F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FAymlCvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgFOLYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:24:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552CBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:24:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so7694325pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QRZ5ywtyFsxk5MHx1800AYGN1jSYKOCI9c+NnnOAzM=;
        b=FAymlCvsvMbZ0UGo7IGXv3Sx+u4nZzqXQmkPZXbDH2rYLctsQIAQl0UybmevkxWJAh
         Y66PQ0Xbepd7cy1Qyyx0C3Jqsd5MnxaoojSyG94AsIfq4/pRnVleBjftGrY/co+YHHPc
         np2IKhqqzuZ/mktxoHGb/nI5/pcgMIXX+KsYjzG+tgft7Strlrehv9eRLCNMWSDIjiAp
         F1ea71iUqK2hT5FhESPYbfNBZviEWNmbOzyXk6Q5e8v1FogWR1v5YTh9TEyau+hw+4uP
         J1eJgjCc7gc4VAl0c3CBub5C2BsmlnoSMPg1f8s6/rqX0157r+wcmYx1iYlnmHSwmcl5
         2g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QRZ5ywtyFsxk5MHx1800AYGN1jSYKOCI9c+NnnOAzM=;
        b=VOiiy9UQ5TQdm8tl9DAEdLXecoNy6cV5C4ricXOcGwotBR//Y/QEBwqRK2wjTGnYFy
         Wbz0mpI2fnIRl3Kre+4ajVcH6XfA8l46/adse4TZd+pbfm+DlQNDuIjgfhGZxonBQ/wN
         SQrKq4wshOLHuQMic4rFfwhTcnbkaPYbCZIwJqZ1utNaH/uu+Dt4gnt0gDLy4udWOaDe
         FhV0yIxoH3xq7UGVQuOUaD/F5ArzvPyTsPqjyvRWgeUwj8goQDu0pLpx4GYmdQNGudln
         Pp0xnrE1ao5VLVhkCJblDOKzpSsQ06PrfCbtmWNMJr7UyERO6C1/2ZEv8eqivPHmizRw
         VVeA==
X-Gm-Message-State: AOAM532zW1+quidHubd7m2LEsU/8/Fk4dBMwQa/MKj1E0XFH3Ot9s5mL
        Wil+d2k2Z0H17U7F7xmymS6UYSF6Nok=
X-Google-Smtp-Source: ABdhPJywD7hLKqggb4lGrVFIGkjim2YhP5qSbAbVYtu42KtLN2murCX0vQWnPhvhXP54HoGsMJQ55A==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr23403506pfc.286.1592220271439;
        Mon, 15 Jun 2020 04:24:31 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id gg10sm12160121pjb.38.2020.06.15.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:24:30 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH]: arch: arm64: vdso: export the symbols for time()
Date:   Mon, 15 Jun 2020 04:24:05 -0700
Message-Id: <20200615112422.234735-1-salyzyn@android.com>
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
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 2 ++
 arch/arm64/include/asm/vdso/gettimeofday.h        | 2 ++
 arch/arm64/kernel/vdso/vdso.lds.S                 | 1 +
 arch/arm64/kernel/vdso/vgettimeofday.c            | 5 +++++
 arch/arm64/kernel/vdso32/vdso.lds.S               | 1 +
 arch/arm64/kernel/vdso32/vgettimeofday.c          | 5 +++++
 6 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index b6907ae78e53..55e841bff432 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -14,6 +14,8 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define VDSO_HAS_TIME			1
+
 #define BUILD_VDSO32			1
 
 static __always_inline
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index afba6ba332f8..4d2f028284a0 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -11,6 +11,8 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+#define VDSO_HAS_TIME			1
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
index 4236cf34d7d9..09be63204e74 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -23,3 +23,8 @@ int __kernel_clock_getres(clockid_t clock_id,
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
+
+time_t __kernel_time(time_t *time)
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
index 5acff29c5991..9296385e7bb8 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -30,6 +30,11 @@ int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
+time_t __vdso_time(time_t *time)
+{
+	return __cvdso_time(time);
+}
+
 /* Avoid unresolved references emitted by GCC */
 
 void __aeabi_unwind_cpp_pr0(void)
-- 
2.27.0.290.gba653c62da-goog

