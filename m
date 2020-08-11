Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C840220756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NowArW/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgHKFjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgHKFjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:39:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA76C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:39:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j7so8646524qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gAVP1K6ZLdiDBp4x0JlTDJszv82bsLWnDKbp/k/SAGw=;
        b=NowArW/WIpqfcCEQcWUdGHdIr8igSp2WVNE6zlPjPrd+/jdd/y6MGpu9c+RBeOQHCu
         q+L5WTZjUOZOcqrtBP0FQyFgT3mbMM6cnWxSqJry1RHpNroEksLmFIAodB5ab1eTBMpq
         6Ih/T2Y5/0H3paEK7MkAHufI8DfyhpKUaXlRheWWdY4EaYFldTzFuEOzH+SZywtFiii6
         anyP3/4xe49f5jlEPeUcIM+rQk9Slx0tPMue80wtGB49pFQyPwDlvSP2UpeT9p167zfq
         EZQGuxa/fum6JPUK3Yjl2yK64D1OyXQPiK+cDox3DmGXlIeIz3xr9FYYpR2pD06H4+/N
         +EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gAVP1K6ZLdiDBp4x0JlTDJszv82bsLWnDKbp/k/SAGw=;
        b=LRpzRItK/3qjMhApFrQbmystagn6YxXcHdy9PqOaTHZhXxVu3Tj3p/e0I3x0CQNgiC
         FJegHXC43zphDkpfhiyWaDgROKm5+0goAzEafYjjai3p8JHa6LZfr5R0diRaYPv7itza
         zTdzAvMqXBuWJ4O9TQg9R3nlf3fWebD2DaOtnXBrdv8Seslhbtq2E9Q8HzyST9CW1XVm
         J+r+f6wUwNdl4N6qHkmXBy42z4gr7YphYnjMs1bH8vUPz/U07bdL2Z0NuJrWFzE2vbO4
         Xk4ONv4aBdHRrxEQkw40dksY2X5OGRqxuTvLeM5QpreoO4XtL18iL/NL8v6yvkDCPOKo
         RkXA==
X-Gm-Message-State: AOAM532vKUMOKZvMTOp8B92lu8pyLSU3RXEuj8aoINZNm+jJb2t46Jji
        6s3HxeH+5FOqzrb+NpBsoTrkuUi2vrEAlQ==
X-Google-Smtp-Source: ABdhPJypEXPG0RvaL7btivQ/9qX0xXbb0CBcfQpL23P90/6aEkVoasKA9CT8V+3py3W8mtnxTQP3rzIC/BaZpA==
X-Received: by 2002:a05:6214:724:: with SMTP id c4mr32552143qvz.0.1597124382423;
 Mon, 10 Aug 2020 22:39:42 -0700 (PDT)
Date:   Mon, 10 Aug 2020 22:39:13 -0700
In-Reply-To: <20200811053914.652710-1-davidgow@google.com>
Message-Id: <20200811053914.652710-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200811053914.652710-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v12 4/6] kasan: test: Make KASAN KUnit test comply with naming guidelines
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proposed KUnit test naming guidelines[1] suggest naming KUnit test
modules [suite]_kunit (and hence test source files [suite]_kunit.c).

Rename test_kunit.c to kasan_kunit.c to comply with this, and be
consistent with other KUnit tests.

[1]: https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/

Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Makefile                        | 6 +++---
 lib/{test_kasan.c => kasan_kunit.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename lib/{test_kasan.c => kasan_kunit.c} (100%)

diff --git a/lib/Makefile b/lib/Makefile
index 6ade090a29ff..ed26f56ceda2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -60,9 +60,9 @@ CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
-obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
-CFLAGS_test_kasan.o += -fno-builtin
-CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
+obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_kunit.o
+CFLAGS_kasan_kunit.o += -fno-builtin
+CFLAGS_kasan_kunit.o += $(call cc-disable-warning, vla)
 obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
diff --git a/lib/test_kasan.c b/lib/kasan_kunit.c
similarity index 100%
rename from lib/test_kasan.c
rename to lib/kasan_kunit.c
-- 
2.28.0.236.gb10cc79966-goog

