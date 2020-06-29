Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F7D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAWQ987y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbgF2Upm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbgF2TN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:57 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C37C008623
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:42:27 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id f68so8291821wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YyMZU7GxNPbypFBfmDC57uoWU5tN/2mz7Tk7sznQPgo=;
        b=nAWQ987yfOBPOOEYeLfBpTKXjHDjRk++j9AZflXKZXWLCMXVvd7yIsAChgHiHkG1Sb
         Ro38pXUoJKYD0KZynPUgyFkyXcggBZGtHKERFokBWq0fCQ+qKUB3HKLP7JCPiKvS2DDU
         1utkIHtk9qixo7oMbkagnHxUtzaR/8DJlPuCsGHhKo5gp92ooPOwjZo0VDpbtmLWlIP7
         flby1Y3JacGPnRjvosmrKnWbZ8lxhinI0u/YB/CamcoduNbgp/eZQuK398sUFUxKl5hY
         D5luhsAxu540KejG7TSErFAVenWrZqEs+zkoMYCh436eVyjx/ikSt4cxCc35SUYPGzAa
         HCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YyMZU7GxNPbypFBfmDC57uoWU5tN/2mz7Tk7sznQPgo=;
        b=nsSkhaElOtKxUeAnr8SbIdH+1gEqmLS1nLYk6H4wKq7jvL+PX6AxGXJv+JK3nqyBet
         ElKzEj54T7HE/Esi9joh5kd0XshhJQOWONAb0VxxpQKQ5a8BezTbRqaIxR3dFxAreT7M
         NKhcjdO0Su2Dkxl/Lxxti4a74qQk+Qi3UCyNLtv0x1mfx/yQAZLfb6miBkTr1xHkhPSA
         X5w1AZ9AbBSmwrpMOW8d30reMupxmqk1VUoKwuBaBEy2tk+L7NtbNOgivGbKQOCl/CYm
         GZ2xA6HWDgjrkwA3bq5c9RV06PtxaP6EFO+kp6r0SNZJdaELornH2FVo96F5EgZvGHKq
         Pn+Q==
X-Gm-Message-State: AOAM531PLzVjrcy02xf2K5S6g9lcZQxiL+olGVSmtjSh4/uqDi/IWgNK
        NkwXauvJTx2X70GycX/MPu1YF2Ec7Q==
X-Google-Smtp-Source: ABdhPJyMWL2D57ylMog0xr3NH7coG2BEQ8Z7wiwp0oZ1Ynp0EmpoOKeBp65JMLFjr+o/s1Uhc9XWJsZreA==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr15963963wmb.21.1593427346060;
 Mon, 29 Jun 2020 03:42:26 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:41:57 +0200
In-Reply-To: <20200629104157.3242503-1-elver@google.com>
Message-Id: <20200629104157.3242503-2-elver@google.com>
Mime-Version: 1.0
References: <20200629104157.3242503-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 2/2] kasan: Update required compiler versions in documentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        aryabinin@virtuozzo.com, ndesaulniers@google.com,
        walter-zh.wu@mediatek.com, arnd@arndb.de, dja@axtens.net,
        linux-doc@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the recently changed compiler requirements for KASAN. In
particular, we require GCC >= 8.3.0, and add a note that Clang 11
supports OOB detection of globals.

Fixes: 7b861a53e46b ("kasan: Bump required compiler version")
Fixes: acf7b0bf7dcf ("kasan: Fix required compiler version")
Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kasan.rst |  7 ++-----
 lib/Kconfig.kasan                 | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..15a2a53e77b0 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -13,11 +13,8 @@ KASAN uses compile-time instrumentation to insert validity checks before every
 memory access, and therefore requires a compiler version that supports that.
 
 Generic KASAN is supported in both GCC and Clang. With GCC it requires version
-4.9.2 or later for basic support and version 5.0 or later for detection of
-out-of-bounds accesses for stack and global variables and for inline
-instrumentation mode (see the Usage section). With Clang it requires version
-7.0.0 or later and it doesn't support detection of out-of-bounds accesses for
-global variables yet.
+8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
+out-of-bounds accesses for global variables is only supported since Clang 11.
 
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 89053defc0d9..047b53dbfd58 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -40,6 +40,7 @@ choice
 	  software tag-based KASAN (a version based on software memory
 	  tagging, arm64 only, similar to userspace HWASan, enabled with
 	  CONFIG_KASAN_SW_TAGS).
+
 	  Both generic and tag-based KASAN are strictly debugging features.
 
 config KASAN_GENERIC
@@ -51,16 +52,18 @@ config KASAN_GENERIC
 	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
-	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
-	  or later for basic support and version 5.0 or later for detection of
-	  out-of-bounds accesses for stack and global variables and for inline
-	  instrumentation mode (CONFIG_KASAN_INLINE). With Clang it requires
-	  version 3.7.0 or later and it doesn't support detection of
-	  out-of-bounds accesses for global variables yet.
+
+	  This mode is supported in both GCC and Clang. With GCC it requires
+	  version 8.3.0 or later. With Clang it requires version 7.0.0 or
+	  later, but detection of out-of-bounds accesses for global variables
+	  is supported only since Clang 11.
+
 	  This mode consumes about 1/8th of available memory at kernel start
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
 	  The performance slowdown is ~x3.
+
 	  For better error detection enable CONFIG_STACKTRACE.
+
 	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -73,15 +76,19 @@ config KASAN_SW_TAGS
 	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
+
 	  This mode requires Top Byte Ignore support by the CPU and therefore
-	  is only supported for arm64.
-	  This mode requires Clang version 7.0.0 or later.
+	  is only supported for arm64. This mode requires Clang version 7.0.0
+	  or later.
+
 	  This mode consumes about 1/16th of available memory at kernel start
 	  and introduces an overhead of ~20% for the rest of the allocations.
 	  This mode may potentially introduce problems relating to pointer
 	  casting and comparison, as it embeds tags into the top byte of each
 	  pointer.
+
 	  For better error detection enable CONFIG_STACKTRACE.
+
 	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -107,7 +114,6 @@ config KASAN_INLINE
 	  memory accesses. This is faster than outline (in some workloads
 	  it gives about x2 boost over outline instrumentation), but
 	  make kernel's .text size much bigger.
-	  For CONFIG_KASAN_GENERIC this requires GCC 5.0 or later.
 
 endchoice
 
-- 
2.27.0.212.ge8ba1cc988-goog

