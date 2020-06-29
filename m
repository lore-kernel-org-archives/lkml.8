Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67235C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA6206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOmizTnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgF2U5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgF2TNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:06 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD5C008621
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:42:25 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id j16so11057490wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cd/DuDkUFEfbY/EbJHKe01td49IpW+ZHgFOrWbd6mno=;
        b=EOmizTnmdW1stEhyikixAOAJYGNG4JoVNWc2K1UIoT2JVQHjKWidyg6GyKAfxeutDo
         Izz6Jb9AabLjANhiyZ1a51F4CzD6c9LtAZ/GOpx6AfFdiW8D7phD7bDT+tXG0Lo5Ouc/
         Lb/RgLaaYJmf5aDyZk+27Eom2mSnHL1jztE/Fn308ky7gMOfKxFlWWr8GG3JLQcPHCte
         a9ibrJCVH/AtS6TnRrPA8ECia7qZhTlL3vsVK6eBhl+oanmtWmzattunVuJq3HeY+w4/
         XHIgMgHxvNAAzqoE5KXLAvT/LsTMdnBVfj8vaIEGnh/ZHVZgl4wyhueBOaWoqg5RlBxs
         zOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cd/DuDkUFEfbY/EbJHKe01td49IpW+ZHgFOrWbd6mno=;
        b=m2sCY1+cqgarumhJ2yxTgsjiarm337jdil0Gkk/SkQ4THwoXAz9j+SYXaGrJloUCJL
         Jy88YpDyS/fGoSqVC3mpHoba9DsX0BimsxXk2A3JrCXzk1+4KuMuqpAaA7wwaoh1ViFl
         24WMy7McQQOKwj2j2bdIjGWWcr3PoH3FZuQwq5IA2clwAqrgV4dMEbBBPp+BhRqdKX3c
         1v+w5KB3/ZF1at0VmLHFLtCIC3KiK4u2R2+UVWs1Z9DkWpGQhVezzltslSOT4epyiPJ6
         Kd14acKY7cYKcpgoTjS1u9EVo+gYl2ORrh/6gBTOtkL9sZ0ewNYEFRMCaICKSzIbxYsh
         mBNA==
X-Gm-Message-State: AOAM5335s44Rwi73AFM9JhqjJf+GHdDw4KfqavDfS6fsM09QzYl3QS2+
        oLkIEVibpA2y17SJOoF0eRtd6CqzNg==
X-Google-Smtp-Source: ABdhPJwcer+5LT1CvjxBJy31tjF/CKb14qtGBiWuvjYtpLPhyBTlm1yqEYg+TmCM21m65nLocFTZVkZDPg==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr16866593wmj.39.1593427343578;
 Mon, 29 Jun 2020 03:42:23 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:41:56 +0200
Message-Id: <20200629104157.3242503-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 1/2] kasan: Improve and simplify Kconfig.kasan
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

Turn 'KASAN' into a menuconfig, to avoid cluttering its parent menu with
the suboptions if enabled. Use 'if KASAN ... endif' instead of having
to 'depend on KASAN' for each entry.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kasan | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 34b84bcbd3d9..89053defc0d9 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -18,7 +18,7 @@ config CC_HAS_KASAN_SW_TAGS
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
 
-config KASAN
+menuconfig KASAN
 	bool "KASAN: runtime memory debugger"
 	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
@@ -29,9 +29,10 @@ config KASAN
 	  designed to find out-of-bounds accesses and use-after-free bugs.
 	  See Documentation/dev-tools/kasan.rst for details.
 
+if KASAN
+
 choice
 	prompt "KASAN mode"
-	depends on KASAN
 	default KASAN_GENERIC
 	help
 	  KASAN has two modes: generic KASAN (similar to userspace ASan,
@@ -88,7 +89,6 @@ endchoice
 
 choice
 	prompt "Instrumentation type"
-	depends on KASAN
 	default KASAN_OUTLINE
 
 config KASAN_OUTLINE
@@ -113,7 +113,6 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
-	depends on KASAN
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
@@ -134,7 +133,7 @@ config KASAN_STACK
 
 config KASAN_S390_4_LEVEL_PAGING
 	bool "KASan: use 4-level paging"
-	depends on KASAN && S390
+	depends on S390
 	help
 	  Compiling the kernel with KASan disables automatic 3-level vs
 	  4-level paging selection. 3-level paging is used by default (up
@@ -151,7 +150,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on KASAN && HAVE_ARCH_KASAN_VMALLOC
+	depends on HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
@@ -164,8 +163,10 @@ config KASAN_VMALLOC
 
 config TEST_KASAN
 	tristate "Module for testing KASAN for bug detection"
-	depends on m && KASAN
+	depends on m
 	help
 	  This is a test module doing various nasty things like
 	  out of bounds accesses, use after free. It is useful for testing
 	  kernel debugging features like KASAN.
+
+endif # KASAN
-- 
2.27.0.212.ge8ba1cc988-goog

