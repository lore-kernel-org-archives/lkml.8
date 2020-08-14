Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE9CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF220774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0McFcU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgHNR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgHNR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:29 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D932EC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:28 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id g72so3423361wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iIfWl4J1G8iITi93NOgHDi/s/4XpKw61QWFW+N1x36I=;
        b=K0McFcU/NW1+4TvtV86hOikuP0uc1Kbkt2X8tcu4BRVbwNsVpniTx+A+AKeGlPqG83
         mDjfa19TeWpTVuAyrf2m4ekXSu4Ecbf1od7anACVOSDVBEjaPHpORnhAcHk92lv7DGK3
         1KsptAncsZTva96Ki3faKev2CnXqKgjzWMgc6yLoY2DRSl7Z8Cv4ahqL0N37YEsUa/LR
         nNj/HdX4ESnken+QG+7W+11MnJKKKb0UQ0oF5FhAbPlgMkNcuivbJXZT0/a3EYzegMap
         ZsB1bcAemES+BlSUgzQbTWZqOcU08p0fReSogKNCW7czoDgg8kwWLFZCZ5NsU5OFQTF3
         pLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iIfWl4J1G8iITi93NOgHDi/s/4XpKw61QWFW+N1x36I=;
        b=hNkfbd1wgAtXrZPSZnsEjS5fhzPxvU2mwMqLE3aMJqFfA87I4SXNg/eQW+E1GZuszR
         mvn17Kewho/1c9me2Tilc1WvTKDeoF2awiDiy54pRZqeYwTmLyRiu/E9cKBkwpQBcnJT
         lrvoH2h+YkI0e2NOJm439vHKsUZfMMOHX64SihXN2I6Jw2qZ2EEZ1YDdT0rl7CV4VrK8
         Lrl4QuJeV/CWkvc1WqRGpgYq2+a8VcXZ6QCu4R30doI/2mPyBPumDLkAuZnGHAQjv3GJ
         H4GErdYcr+lrZMmlkEWsPDLjMZD5o2kSXa0Ckgkz+LkC61+4dKrNJblfX3I2hpetHvay
         WM9Q==
X-Gm-Message-State: AOAM532bQ0NAF7KuyqKwMIlYV5qRJjKyql3rUYUjtIyQi0vZdSCxcbNy
        AiKGNLyp0VdLaT/Crz62BXL82Bbh6MUrFCmu
X-Google-Smtp-Source: ABdhPJy/WRGBFbHW6yzu3fXjbbh6ZfhsR5aLr+bVb6qX539D5XqF883Lkwh9f6pP5sIhJRXvKfWE1HxGbtWAPR5g
X-Received: by 2002:a1c:8094:: with SMTP id b142mr3616367wmd.59.1597426107618;
 Fri, 14 Aug 2020 10:28:27 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:09 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <4e2dea1d2163dc6f5a3ceb943f485b09cbd252e0.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 27/35] kasan, arm64: align allocations for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN uses the memory tagging approach, which requires
all allocations to be aligned to the memory granule size. Align the
allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
CONFIG_KASAN_HW_TAGS is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a4d1b5f771f6..b8a0cae38470 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte_asm.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -50,6 +51,8 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.28.0.220.ged08abb693-goog

