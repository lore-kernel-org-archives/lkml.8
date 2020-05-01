Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D89C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED5A216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gP803iqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEAVmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgEAVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:42:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1712C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:42:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 7so4875144pjo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=M2Ic6ijDAIUJ++DLKvrkOIgT8v+NxBiKNWzd47csepc=;
        b=gP803iqaO4QrnYUjJNgpxvaevB//s2kHiZuiKJmN4lv18yp+untdOWKAkxLA0Aixiz
         hVDPkpjCbZdOa0NLOrmxPFqo5jCJBPvlYV+iaVIJrhtT77AMIsKMTUzunQ6Lu7/pnjUW
         oIJ5uQjESQD5VCc1Q+qE3IfOW4IUQUwOwvuzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=M2Ic6ijDAIUJ++DLKvrkOIgT8v+NxBiKNWzd47csepc=;
        b=mPijk61SqGXm9Or6Mfz5lkij4VEcGhaHVSYGH30rBxEjnEHMoYIK2dE3fXeDYIs4df
         0a+T+67JWdw6GLK6BpBTOYMPcC9cZfr5s50ve6nGQfURw51vvE6HLJSsRRg5gcyZmNcS
         eHhbedhQpcIYPD3yTv622Rzp+I1py3oGi0Ecs9cnbEldYzpX+MZwC/oFGLm88/C+Yr3C
         HXK1zv97Saghd39V6CKIz4mqsrwhIX8sK1aegehz4j4wU9xZ6cEGXYCGrF+jbPpeXOfn
         g12DF88tTBL07RZ6X53RD1zqiutKKAQmKy+0KioDQLNmUoYGn65ySZmZGZke0/b8hUAO
         eCiw==
X-Gm-Message-State: AGi0PuZlfOQy1nMwbEciFpGFBaLNStOT/SIuAUrIxySgumGetLMJAEZq
        H5m7i0+AfeTMzcCqlZJKD29ZQg==
X-Google-Smtp-Source: APiQypIbxpFjvJzgHZfRO+fTgiu6bpM1PAgt/j/n4oBoWFuIEh57iOk2wWUXn6q+4D4FeQChYzp3sg==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr6348171plb.255.1588369362498;
        Fri, 01 May 2020 14:42:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w69sm3039952pff.168.2020.05.01.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:42:41 -0700 (PDT)
Date:   Fri, 1 May 2020 14:42:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Disable UBSAN_ALIGNMENT under COMPILE_TEST
Message-ID: <202005011433.C42EA3E2D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for UBSAN_ALIGNMENT already mentions that it should
not be used on all*config builds (and for efficient-unaligned-access
architectures), so just refactor the Kconfig to correctly implement this
so randconfigs will stop creating insane images that freak out
objtool under CONFIG_UBSAN_TRAP (due to the false positives producing
functions that never return, etc).

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-next/202004231224.D6B3B650@keescook/
Fixes: 0887a7ebc977 ("ubsan: add trap instrumentation option")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.ubsan                                 | 15 ++++++---------
 .../testing/selftests/wireguard/qemu/debug.config |  1 -
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 48469c95d78e..929211039bac 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -60,18 +60,15 @@ config UBSAN_SANITIZE_ALL
 	  Enabling this option will get kernel image size increased
 	  significantly.
 
-config UBSAN_NO_ALIGNMENT
-	bool "Disable checking of pointers alignment"
-	default y if HAVE_EFFICIENT_UNALIGNED_ACCESS
+config UBSAN_ALIGNMENT
+	bool "Enable checks for pointers alignment"
+	default !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	depends on !X86 || !COMPILE_TEST
 	help
-	  This option disables the check of unaligned memory accesses.
-	  This option should be used when building allmodconfig.
-	  Disabling this option on architectures that support unaligned
+	  This option enables the check of unaligned memory accesses.
+	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
-config UBSAN_ALIGNMENT
-	def_bool !UBSAN_NO_ALIGNMENT
-
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
 	depends on m
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 807fa7dc60b8..b50c2085c1ac 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -25,7 +25,6 @@ CONFIG_KASAN=y
 CONFIG_KASAN_INLINE=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_SANITIZE_ALL=y
-CONFIG_UBSAN_NO_ALIGNMENT=y
 CONFIG_UBSAN_NULL=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=8192
-- 
2.20.1


-- 
Kees Cook
