Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B801C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB13421BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAXDSFhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgFRJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgFRJcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:32:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02371C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:04 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a6so3996647qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=086vfv3gPPfJZ5VO4SEM366I1+MoqC/R0oD42Imdbh8=;
        b=fAXDSFhjAVW4D6Zy29LknWSqsBJPV7OzLPf+6YGVWWFtRLCpfWLWCTqnk00WsdEqgk
         nrmwG5o35UyKtRhmjzOZi9ZKNni8p0ucP+WXj8VRjDptiqWY8ns0pHEjH6Tr9tGa3T7S
         /aZ5M+vvTdTctOQ12ZJ4lCwqda/aajsZkK7EnSe8+ngTN9Pg2cvj9AUEzh2JJB/gSL/a
         af7HqmAVCufSsJJwNR9+epbZqE37Iq/Min3EpcTyQQvaPHuhysdkJAqRr8+1JBscNhjY
         8JvNhKSHylMudoZdr7iedjpRNhapca1tJSKmp/8xDu9WeGFdjhRjsSNz1m+qpaNL2TUI
         8SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=086vfv3gPPfJZ5VO4SEM366I1+MoqC/R0oD42Imdbh8=;
        b=G+5baya7UVRg0gIwgqklfORx5TAb2VRLj6aORIy2FDfunUUibjmuciKW98Y2KBa1w/
         f/ZXfqSpqr8F3gueiLEZuqt/4OSNInoGd3KCz/YxDyLs+Bg7FIwxvikKRngo21G6xQ00
         aZwdE8nZ1PR5UKxFB3W7BidIZhz9/tXlaRvlMWHmzU9FRDmMaxS+oQUnOm9rQCvxFikF
         Yx0Kmz2DezmSot5Y5WOWBDo/1AKWavKThM23Rxg9sB2aWYmtQ75X1/KJl9/dFxGu4viQ
         dWB/mPkIt7SF5xbll6LkW4jkODUY9NPpKZDMIhq3KMlnyjZKKMWkvwMiNv/7fu6nQKE9
         AP3Q==
X-Gm-Message-State: AOAM530K9H4/IsVUKBU2DPBjx5evH8P226hGBTstlUEj0iILF723Pj73
        vh7CmsXqkSxIADgPxyfqE0hyzzQDAw==
X-Google-Smtp-Source: ABdhPJxEeFmMNF1bE1+DiWwBprbkp2j2l6t7tHy189I4SoMWXy6UX9ktxxCFqnZGhSRak4y/9K3qlWG5kw==
X-Received: by 2002:ad4:50c4:: with SMTP id e4mr2848394qvq.45.1592472722603;
 Thu, 18 Jun 2020 02:32:02 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:31:17 +0200
In-Reply-To: <20200618093118.247375-1-elver@google.com>
Message-Id: <20200618093118.247375-3-elver@google.com>
Mime-Version: 1.0
References: <20200618093118.247375-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 2/3] kcsan: Simplify compiler flags
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the set of compiler flags for the runtime by removing cc-option
from -fno-stack-protector, because all supported compilers support it.
This saves us one compiler invocation during build.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 092ce58d2e56..fea064afc4f7 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -7,8 +7,8 @@ CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
-CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
-	$(call cc-option,-fno-stack-protector,)
+CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
+	-fno-stack-protector
 
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
-- 
2.27.0.290.gba653c62da-goog

