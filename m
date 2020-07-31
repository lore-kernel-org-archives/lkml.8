Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2921D95
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlAhdGFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbgGaNVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGaNU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q7so17139887qtd.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cZVGg5u0amfQd0MGqGsL/eYTxMBPuz1AnwRmMzyUYJ0=;
        b=IlAhdGFXdQhzgdM8NFAE8/cmwACwJH3R586MycUPUD13av68O0MKakxBFGajbifiij
         P8pjU/D2TV9JcXqkPM5AwljDqDlM6/Xh7Q44bBM536cmkkaATI6FA8D3oFDNYCyXxb/B
         7g6S7Xfa04WNKtl2J2i6CwCRdgUQAWUkmAcd6bVVTj4CulLUG1bcxt6LIZfkE4/7Ovw3
         vDNUB1RwwUOz0OaGADituLWn7icQ5myR30EtNevNfI+KTvS5FFUSREnPJ2W3HXpc/TaA
         ZRS4JBHIoptqnVAQp62YQX37yMkE2kmJc/3aG5zAV66oEmHb7Gic30HM9bqzIBS95Zm+
         a+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZVGg5u0amfQd0MGqGsL/eYTxMBPuz1AnwRmMzyUYJ0=;
        b=qzKV17RqbVI1Z9dlKwgttN9vx2sI6s+/BDi2XjGdlo1iOXk8MHPwX7pGaVHYokB+EW
         dkf6qP219CW4W4S1jh2sWvLiJUvuu6OVWPEfi3oLr47LFvMwxHG19ZL0bKtHJ19kjH3G
         Zj+P0HaPTaW+jjdORHSMPG1GfMv8zZk6EFkAg8Xsj4OG10sHeo5O9eT98VdED1u+5WN4
         baCFtm+5CRJYOeZmNldznPBQuDT+BQblo+8Hff0ZkrwAZZo1HhaG6K9eO1u2UPXzu6+H
         Fmkz+vTfaIiu3oUmcrGnTC0n6hjXvNUv1x5uV1gLwq/Fyt1fPHijE8V3XG6v6K9dyaQM
         pRgg==
X-Gm-Message-State: AOAM532VYXgiNI3ganQ0hmA259BfWAjIGRmHXgMUBomAmPSBd5ZgO6qh
        nHBIHnIAaf7SF6FcRF7JQhSry29B8DQXooZw
X-Google-Smtp-Source: ABdhPJwR73zAsJMma2rrDfx76yeMCrYXlvBvcmCZjiVYwHxihMmnlltsj7puWUBtY8I2c4oVG5VZ7IV7vaenkMno
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr4125226qvo.178.1596201658775;
 Fri, 31 Jul 2020 06:20:58 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:20:41 +0200
In-Reply-To: <cover.1596199677.git.andreyknvl@google.com>
Message-Id: <403b259f1de49a7a3694531c851ac28326a586a8.1596199677.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596199677.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 4/4] kasan: adjust kasan_stack_oob for tag-based mode
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

Use OOB_TAG_OFF as access offset to land the access into the next granule.

Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index f362f2662938..53e953bb1d1d 100644
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

