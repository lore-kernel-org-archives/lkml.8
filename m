Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E00C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6032067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="al711nch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHDMmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgHDMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:41:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DFAC0617A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:41:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j7so28478162qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=al711nch3pGhu0oC1wlPaqYQVlVmmhVzmYHp/7d5LETFi5Rtuy1m2i6Q7VZyHZWzvU
         hgxHf9w/ckVjXi3fhG4d+LBft5K89LkjnHbAbhqXdJQf+gaDGnDI0gAmQvywiJ+Vcfpq
         fXUe1mXmVqZwCTV/bjfqcfsyDvqhOVJmyD48Oj7Db+FICYod8rKgX7Xwry1oDf2wkEup
         RR75P7hQf3YSyhtdZQyTtr0fFU1zbFApwbVSnzym/MadtAc0yGXWKQ+A2mW0MAhYz+R7
         l9TXw52PMyujrl18cxAUf/X+TsTelw+wmXc4IeyF7EmwiAsMBbLJcMRtX980kmLZ8TUT
         wSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=YdwSO9/0h2gdGuF80ENniYFMpY/Je9O4d1fW66arENdvjn/iSSmdDlt2fNaDg7/A2c
         AV3GJzWb7cfttzP5Cqcq+K6G87EX7E/WhpPy8srQB8Cwgkx0RmW9f3VbPFbOowUw2MYj
         GgWonNQTWh61KYVMbXe34j6k6EBsebQiX5VxtS3tCchDtxL9CudMPzJis60TANyVhtih
         i0k8XhheVVwPsw2MNRHjvVus75BjjZPQQGY+20e7egK8hVuKaPJDImqnz5AHG19vDteH
         mzQCNwl9e9flyqBDzzj3SXm9QxvJ0vtMf7pMNP0YhWb2OsIXCgPdj9dSiGs7wUJwEE4r
         iFEw==
X-Gm-Message-State: AOAM531sqHCU/DQBcIh2myzjc5QdPRKG8BWlcqf7YCCAlZiMr66rP1g5
        I4PfMoqXiP8AeUe5GQe71KcOtE5jqF8ek3li
X-Google-Smtp-Source: ABdhPJxNVNohw+RMFq1uv1gOt0ICKpmDjLXFJp+5X/8n8NGst2h3rqGrz443ENowh4INA9/32k2O/16zVxLTFGJ0
X-Received: by 2002:ad4:438e:: with SMTP id s14mr21419425qvr.18.1596544902628;
 Tue, 04 Aug 2020 05:41:42 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:27 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <99f7d90a4237431bf5988599fb41358e92876eb0.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 4/5] kasan: allow enabling stack tagging for tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CONFIG_KASAN_STACK to enable stack tagging.

Note, that HWASAN short granules [1] are disabled. Supporting those will
require more kernel changes.

[1] https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 scripts/Makefile.kasan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 03757cc60e06..f4beee1b0013 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -44,7 +44,8 @@ else
 endif
 
 CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
-		-mllvm -hwasan-instrument-stack=0 \
+		-mllvm -hwasan-instrument-stack=$(CONFIG_KASAN_STACK) \
+		-mllvm -hwasan-use-short-granules=0 \
 		$(instrumentation_flags)
 
 endif # CONFIG_KASAN_SW_TAGS
-- 
2.28.0.163.g6104cc2f0b6-goog

