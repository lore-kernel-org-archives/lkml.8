Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23BC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21D420715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX1tRBro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBJSng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:43:36 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:50196 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:43:35 -0500
Received: by mail-wm1-f73.google.com with SMTP id o24so142336wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20vSWayu1UQKfLLBTKC/qiTBVSsqf6DaO3yhuXkLFDM=;
        b=vX1tRBro/J0TBa84JtIPS9hubWoc7vnIyRky5jfHR3uXhua+WmB53Ljl/9Jzjcol0q
         1Gr2BZxKP1f7EnghrZfDejyfYbznCVnFbb69bkojmGn60xhlz3eWbSrqixkD3ctmGhR3
         na8PTvZCH0nWP7hzKiaY7uwJmRfvRmDSlaxIMb3Kd6YtuWnU74lmeRmfNNFuA8P+sW3P
         yIMBpHNM6rf+HgQj+1BiGLXEUIWFrU90LhHam/pIph0ZYhKYuNOCwGO3XZHgp6nRq4f9
         RoHYG/6AFN1cDI3FVFYX2aDLvKcgnzYzBSmd7ecgVRUN9mEbirS41YIp0M68gATzwCQL
         GmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20vSWayu1UQKfLLBTKC/qiTBVSsqf6DaO3yhuXkLFDM=;
        b=C5d8350X+kwrco3Kte6nogauYt4gPbjeCKOD+7depQCWl5YuxMTKPqYiJcuV2CA6ZW
         qL22+8QitA0Uu8PHr8rIxy4wGjVD9tZ83IPmNo1Q4ZldtxdaCyyKClZLnTCXi6eypCS2
         CIHW8NmK3W5F32JdFwd39MkcpaWABKfka43sWNZbmbbceXiltWxCbX6FzXYlIO2fxFTj
         CP9O42XkUgS3+kn5c4kycKtai1UNJHqnoiFJZIi3Q93kU2oYt9R8ysub61zPbJ0PUOxh
         +vy7Z2wMm1dmH0ccnZLip4fMLF9dKgJpDFPbdiNTRt9RfZ65Cv8wm/Og9zvrVyDiA/HN
         vChg==
X-Gm-Message-State: APjAAAV+g8G9Snx1VDqXXyd4SzTgozGs7o1O2mXHVNitrGi0YpyfBPXb
        nhuqDxY1j8e2CaC/cj3CfbK3WpCW8Q==
X-Google-Smtp-Source: APXvYqw8EDtB8FAo3obot+vKZzy67dU16Rb03T7dMKZ0QqLSTH/mmhPGinkX5lAWBXmF7lyVPwnJQVoZYA==
X-Received: by 2002:adf:f787:: with SMTP id q7mr3295671wrp.297.1581360213051;
 Mon, 10 Feb 2020 10:43:33 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:43:14 +0100
In-Reply-To: <20200210184317.233039-1-elver@google.com>
Message-Id: <20200210184317.233039-2-elver@google.com>
Mime-Version: 1.0
References: <20200210184317.233039-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 2/5] compiler.h, seqlock.h: Remove unnecessary kcsan.h includes
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No we longer have to include kcsan.h, since the required KCSAN interface
for both compiler.h and seqlock.h are now provided by kcsan-checks.h.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h | 2 --
 include/linux/seqlock.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c1bdf37571cb8..f504edebd5d71 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,8 +313,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
-#include <linux/kcsan.h>
-
 /**
  * data_race - mark an expression as containing intentional data races
  *
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 239701cae3764..8b97204f35a77 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,7 +37,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
-#include <linux/kcsan.h>
+#include <linux/kcsan-checks.h>
 #include <asm/processor.h>
 
 /*
-- 
2.25.0.341.g760bfbb309-goog

