Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72513C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511B522B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTB8YFCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbgGaNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGaNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:57 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d2so17495761qtn.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=TTB8YFCfAZYUym3DOqMkA0+g0/8FCMhabbLYjC63ds5jKSWofJg0VQEzkUAOeUvkAv
         OawmRQPqHX8efu59ZaAe98ros3DUmP0Ss8a7Vq4Zb/wi/tm+awFIxF/CfKgwZvSFl+14
         uLzjuW6ocziQZl1kRGQY1MTxcMyZA2YSd5+iDwW9PtoIy+CB70YN67dL0WPnKXf8gx5b
         Q9FeFiJvNW4S/HrxsP51PO714ruAHQfgbUWLjBUX598VNA/U/7Xu6s90EtY2PsCb5dJq
         2cWJ0yYJZaVdiW+KfIGtEa42o/G4hwOm9aAhQ0jbJ7L+5BRJ+VwXbT+cxgy8Ipj5kv4P
         +jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=obCGvzN6ssFrRyE0XhFXJW+D4uzm0AvvDrvn+ubbxZJq2d+SvPHveIB198br6VkMvG
         OP9apJfvMIFuBJDFk6SJ9H+ZCVA4QwXJQ04ibftLxw9xjuN9fplccxt3bYcyzDsYMhrt
         EjqnIhdBW83dVJ1WJCDKtgMafAI8rBB+WMlK6IvLyi2KgrI6eKxu5yRxh0kiPJu4fQpc
         ooXJ2DNsdzD3oLWKy2S2lBqm3UhP3DvzqB6wLAX/xADMeGqm/UrXXky5LeFvbnhL1aIO
         0K3hBkTTduQaKmRBjjuaNM7Q+zmbAIOHUO33X17UvL6Mp6jerpNsCOzXUk4EjEjnrQ6J
         70sg==
X-Gm-Message-State: AOAM530ijzO9ek1mviI/bNEz3iZoTAv0eusmXfFczj2Jhy52F8NqgSiB
        TmIHKXM+fa2v0hIgoZ7FKxd3Gy9grSRt6xYt
X-Google-Smtp-Source: ABdhPJwHN96/7/g73I8CKHlXT0vmgjznv7/reMovkgTBdvlRSkefiTmHjtsbRKQCpkYSHvO/GfC2zaYXn24Hy8+h
X-Received: by 2002:a0c:99c6:: with SMTP id y6mr4112285qve.86.1596201656301;
 Fri, 31 Jul 2020 06:20:56 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:20:40 +0200
In-Reply-To: <cover.1596199677.git.andreyknvl@google.com>
Message-Id: <e7febb907b539c3730780df587ce0b38dc558c3d.1596199677.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596199677.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 3/4] kasan: allow enabling stack tagging for tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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

