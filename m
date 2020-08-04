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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1778C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33A022CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea5YjJ7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgHDMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgHDMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:41:58 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFBC0617A5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:41:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w15so27704383qtv.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OJV+wFsSuBAEdua9Kpud4j6ZGzVdRXqmU9/PZhjVLdc=;
        b=Ea5YjJ7o620kZq8eHnshiekvC4wpoxtU/m2L83KMHr56wGFqcLIiluwTTPIuK6jPtz
         NIbahZxx/kLpiZOWX4LifN1sYL8ve+GY+nJ4uXKX/NwgeJ66FB0oBHFDCJ7CnFI+jXp5
         YfjHAXZMMGH3A1RBkM5ekVG/ygZ56FsWNDeUBLLVL1ABwVsRZPV6DZg8v5EyPdnyI/8q
         u9+woephvoS6hP7AP7QtlnSDcnrQ3oLlLY/jprakwQVQNuaNzYsx0faunrqjJ1Rwi828
         vpjJ63tAJJETQeQAfpWW300WdlbW294wpGLA7b0wjZ0R/4TF1hESmC/l3kgC9ReY8bHQ
         oJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OJV+wFsSuBAEdua9Kpud4j6ZGzVdRXqmU9/PZhjVLdc=;
        b=Q6Z64Cb0jCT7y0pFuaXELg6izRM6RTnbt+H4RX1kzO/h+q951UH9eUqzlNLevLzsq+
         w3CjSLJv2NYCK0e7qMKWaswEjBhKAdfDP9+Msb0XdSusufZ/ZIhIYpgnME/P+9RxxRhp
         sKF5FYGUG+96G5HZo9EBy/JJiuOsRRKUfyYva5CSKJ3gz2yASXoQaGDTHxi4r/agHZXe
         9RExN7trUexfsaukLueIgGBBM+LZcDEyMLvm/4lJMbaDq1bmz2+F6Agksl6nCU96E5kX
         qwDApqBn2XyfxGlQDkyfZFNWdrdM/SMSPcErmNjmcYCcih9lTPEXUEN+JorFyy53wzYQ
         blVQ==
X-Gm-Message-State: AOAM533B1yRdvSjZcsN/HybUy+wMAzRr3qgr5eTpREMsFKzkQ87LWrlR
        eDiUWFEF91Q/laDYOgVP/cMAgwubnIf3lCte
X-Google-Smtp-Source: ABdhPJxMCD1uy5OtH/rfQcGvmBrhxSjZNftrKmDoPQf463mdE8fRrlNv8GbsPVw+FCZ38SV1RL/Err4XbOOp0GEM
X-Received: by 2002:a0c:b604:: with SMTP id f4mr15297001qve.68.1596544904936;
 Tue, 04 Aug 2020 05:41:44 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:28 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <3063ab1411e92bce36061a96e25b651212e70ba6.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 5/5] kasan: adjust kasan_stack_oob for tag-based mode
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

Use OOB_TAG_OFF as access offset to land the access into the next granule.

Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7674616d0c37..5d3f496893ef 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -488,7 +488,7 @@ static noinline void __init kasan_global_oob(void)
 static noinline void __init kasan_stack_oob(void)
 {
 	char stack_array[10];
-	volatile int i = 0;
+	volatile int i = OOB_TAG_OFF;
 	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
 
 	pr_info("out-of-bounds on stack\n");
-- 
2.28.0.163.g6104cc2f0b6-goog

