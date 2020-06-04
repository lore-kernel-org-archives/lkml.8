Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BDB2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOpABfpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgFDKZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgFDKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5531C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zk2YSNLVDIg6CzFc7dqGugTGjUQyn9Y1fCSXYdtV1Fs=; b=AOpABfpSL+msrfTK9aWB3R8v80
        10+goFXOxFKDWAvi4U+/gMbvT9+FFCyYodCenOhgbhrd8Iv7SPRSE1f5eEbSnbj6Ek+3mRnufVOtF
        sMrFo2y7L7HVIYqdXtWn39rt+1IT5TtAf9uvV8O0neuJrvV9PdDRXiYYPm8NUBX7kIJPozf+Gv0pC
        68qd7Z4IamrXO6YtIjWn6aKt49DJFoaTgDaE4pLByQo1fMvzTbPChNqyo/H1i26YD5LBp074TkZpm
        yvyVmMc2Uv0tXfEQmJbQZrX51/Lf4CVBg1SzZJYFOI3OW14gzUZRJ4diEmQSz4SK3b/lovcGZ1kVa
        o3udGLPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3d-0001cD-M5; Thu, 04 Jun 2020 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F03B0306064;
        Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE92D20CAE764; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102428.135635542@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4/8] kasan: Bump required compiler version
References: <20200604102241.466509982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds config variable CC_HAS_WORKING_NOSANITIZE_ADDRESS, which will be
true if we have a compiler that does not fail builds due to
no_sanitize_address functions. This does not yet mean they work as
intended, but for automated build-tests, this is the minimum
requirement.

For example, we require that __always_inline functions used from
no_sanitize_address functions do not generate instrumentation. On GCC <=
7 this fails to build entirely, therefore we make the minimum version
GCC 8.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
---
Apply after:
https://lkml.kernel.org/r/20200602173103.931412766@infradead.org

v2:
* No longer restrict UBSAN (and KCSAN), since the attributes behave
  differently for different sanitizers. For UBSAN the above case with GCC
  <= 7 actually works fine (no compiler error). So it seems that only
  KASAN is affected by this -- let's limit our restriction to KASAN.
---
 lib/Kconfig.kasan |    4 ++++
 1 file changed, 4 insertions(+)

--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -15,11 +15,15 @@ config CC_HAS_KASAN_GENERIC
 config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
+config CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+
 config KASAN
 	bool "KASAN: runtime memory debugger"
 	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.


