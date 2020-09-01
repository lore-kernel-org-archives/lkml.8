Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098EC20E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iGmP64H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIAAXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIAAXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8408C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b127so11009492ybh.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Atjbr5QaPNSyc9L6JLRq74W+KdS8XUB2zK1vE7a2/Jc=;
        b=iGmP64H3esYA+SGsFIBsL1cgc8/mSV4VnGF0QbWhUYKADYl0zFeJWkcKTVVxMulSGD
         oN8UIqPoTmitci8S95u9Y4CC723EoeeSP6GsWZwbpB3PFcAr7wNomebenjqsO9TcA/Sz
         hIOsD/BN4nhVA305CipIwaW9AV/TOax/JeqvYBdJj00XVWPwPv7FHMEmQAb3NzDogfOZ
         Ws1WTprZw6t+SAp+u8yC6kWH9yYU9TvU40xW5u+Y1wBXIIlUzJcEDCTdZl2TZ6hRs1FC
         mz2PeEv+fJpa0FP/4LKGuTilfEhjV1BLufVVr7E6PIMGgOGhE6z71AM/h6IsAE8pxk99
         QKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Atjbr5QaPNSyc9L6JLRq74W+KdS8XUB2zK1vE7a2/Jc=;
        b=R6ElsTEVjtsPfzJysu7FFqTQQ/cS9NZTj8irhBaid70NPM1t7/hyKXr0gz98JHz5nA
         7HJuABnf2PrzgyllvL7T0weSlM3bimPLoadGDST1PIa6hezavYNX4GtwijPWaXYZQqTE
         jIXnqqc4ne8uyAlLDwsy5L/S7TH0FyS0khOz5bfZ2SugK/7tMoa9lYlrlX/3NWH8HX7r
         Y3mYlTq6JGxfBb4r9vCAFNochEZN/Jp04DHlw3j6yFtqUiOK20KM49V3cjcQGy5obVtN
         tuVx1fsw7iTc8KdyIjPL/pCa10s+YK71MrZo4iiNTLtGeSB1Vk1cm6cy/k3ZRBdiOntV
         4xTQ==
X-Gm-Message-State: AOAM530gzPYQj1lT3h4DhQyRCjJ6owN47di3Lk45P6cihBU9zFyrPuiy
        CytPUKzB324jHlSAWkNKU3DPORp4owvwX+PS4Fw=
X-Google-Smtp-Source: ABdhPJzDib0AAqTSSkIlG2WTMGy+UiLYAym8r3QiFmpP1iv3PIKfjeSwrpyHkChcvYpZ27S/IINuJ64ebWNoOGMf6Sw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:6908:: with SMTP id
 e8mr7239227ybc.83.1598919822850; Mon, 31 Aug 2020 17:23:42 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:25 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-7-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 6/7] kasan: Remove mentions of unsupported Clang versions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Since the kernel now requires at least Clang 10.0.1, remove any mention
of old Clang versions and simplify the documentation.

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/dev-tools/kasan.rst | 4 ++--
 lib/Kconfig.kasan                 | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 38fd5681fade..4abc84b1798c 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -13,10 +13,10 @@ KASAN uses compile-time instrumentation to insert validity checks before every
 memory access, and therefore requires a compiler version that supports that.
 
 Generic KASAN is supported in both GCC and Clang. With GCC it requires version
-8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
+8.3.0 or later. Any supported Clang version is compatible, but detection of
 out-of-bounds accesses for global variables is only supported since Clang 11.
 
-Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
+Tag-based KASAN is only supported in Clang.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
 riscv architectures, and tag-based KASAN is supported only for arm64.
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 047b53dbfd58..033a5bc67ac4 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -54,9 +54,9 @@ config KASAN_GENERIC
 	  Enables generic KASAN mode.
 
 	  This mode is supported in both GCC and Clang. With GCC it requires
-	  version 8.3.0 or later. With Clang it requires version 7.0.0 or
-	  later, but detection of out-of-bounds accesses for global variables
-	  is supported only since Clang 11.
+	  version 8.3.0 or later. Any supported Clang version is compatible,
+	  but detection of out-of-bounds accesses for global variables is
+	  supported only since Clang 11.
 
 	  This mode consumes about 1/8th of available memory at kernel start
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
@@ -78,8 +78,7 @@ config KASAN_SW_TAGS
 	  Enables software tag-based KASAN mode.
 
 	  This mode requires Top Byte Ignore support by the CPU and therefore
-	  is only supported for arm64. This mode requires Clang version 7.0.0
-	  or later.
+	  is only supported for arm64. This mode requires Clang.
 
 	  This mode consumes about 1/16th of available memory at kernel start
 	  and introduces an overhead of ~20% for the rest of the allocations.
-- 
2.28.0.402.g5ffc5be6b7-goog

