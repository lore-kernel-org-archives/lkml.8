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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9887C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880FA20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlQYWVk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHNR1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgHNR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:42 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70964C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id m7so3590253wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D1t27xMSdSDZAXG6XnkOmwCyZLvn/GNAn2saMjUMSxo=;
        b=NlQYWVk4QraX9lMNNFU2PHWTbxVPbYDzAKzEJL2GKeIWAYtsuwZ+NGPCHwpmoTva1K
         n2x0xG4UAjBWm/OlfHhi29X10+mhhEwk/7sNuRZL8P0lAPl9fEdsiCWjdL2iwXdLsEwR
         V+yKO9un2mCVzG1r9njHV7HBxFTXpqU+dEydfa6rl3iW3Je0KhV5gBnWYbMnA027byWF
         LGLsd09h7esHEAdz8fA9PJ3S2QY1gB7VHdcwQC70QA6UpSchVJL5Hy+QQeBhOjsF1TLK
         Lr08Lv1S4SLXhWH8tozhudhMdSNFbCnFeaTXh+EO4RIOA9r2zLcALLaU5qa2fhw/Ecl5
         UyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D1t27xMSdSDZAXG6XnkOmwCyZLvn/GNAn2saMjUMSxo=;
        b=qmrGx4nobrwPyuWrHgjIOWU8rf1JE1gwkevAY8UCKonA4Q/fXKWikfS6v8bYbV90T0
         SnIbzGpD6ajDDxv0lgNbTAXsSHUJLZUmenvo8VHnLmytIRYoeOatfGrE/kEgInZT4ZhO
         bsGAKEid/7y+zDP03ostaYONk8qN4kmue5xZKcVlICi6HQ5flc9blj/QSu+ki8vWfW9Q
         GVPiMvisSy+toz8EOXGgOnZKD9Yo/+Dsg2pzGS/iw9Iy+0siJAA7jojgw+xn9D3+LGcJ
         mFvyA5Gvil88VkV0S32AuEqWicuTe4Tgk0rzE2mjBLjAnbQj5s6b7GovPJO+02bF2EgX
         S9MQ==
X-Gm-Message-State: AOAM532xfJJavn0om89JABxuyQbQvNJEfk03stX0kfUcfeTGjDJ6GIim
        cAnKb+YTCrSCQdkHKRaHiy4xh9FzCgCWZc+v
X-Google-Smtp-Source: ABdhPJzpZngGb1ZEeA+I2LMOF4t2XQmOQc29JrlRX//qtIxbuOUjwOocnNGAgVWjvUPc3MYLXUXVihCZ0qw94AsK
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr423906wmm.1.1597426058434;
 Fri, 14 Aug 2020 10:27:38 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:48 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <f6f402d4f5251f7413755724e2479e2042bf01e8.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 06/35] kasan: only build init.c for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory, so only build init.c that
contains shadow initialization code for software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile | 6 +++---
 mm/kasan/init.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index d532c2587731..b5517de7fc87 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -29,6 +29,6 @@ CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-obj-$(CONFIG_KASAN) := common.o init.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += tags.o tags_report.o
+obj-$(CONFIG_KASAN) := common.o report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o tags.o tags_report.o
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 754b641c83c7..20f5e1ab8d95 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains some kasan initialization code.
+ * This file contains KASAN shadow initialization code.
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
-- 
2.28.0.220.ged08abb693-goog

