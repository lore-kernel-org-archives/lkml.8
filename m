Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA002065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+7yt7La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbgEMSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733175AbgEMSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:24:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:24:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z17so191654oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKnnhjZf+Lvy/wEev/k/9Sd4WlZuSJaabLD4NBhl2lM=;
        b=j+7yt7La5zsrEjfpHCvrP/ii3zadlAPT++pfcnw31AUeUts/ObTRNG08y8zSxofJBe
         pVVO55p13vEaNWPs5gLdOOzL0nQKk0/rPlUlz7TKQTGzwAFAkdm/ZY00uArTWWnUC7ck
         MFu4jLFk6jdol1Zy5OvW3CDjv/cPIa5Jik6nn75o64zxg6Hwfs+qBShjwtE1KBVHt+cz
         J86GjUgaqiud+3su5GJEaGYCP5zbs2BoGNKlUWlpeH46WUWqv8n2ZD3050b1skcUYO0P
         SHV9+mH5zngcyRFtjokUvYQWlActYtxSPwn5RLO2f+2jRXIBH1lgRAGKiEgR8RlWSCHb
         GZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKnnhjZf+Lvy/wEev/k/9Sd4WlZuSJaabLD4NBhl2lM=;
        b=IEJunwu9m3O2W/OyyO3v2zVbD7j3XQYAQa3qlW4UbywthhA9xizB075cD3fAUeWsAy
         D3cqnpXGTFYkcNGRbNGCHE6LKi/8EyBU8XJn9ummVaGxkKcxFs5FkH5rmHuJeJYDxtKD
         wtBDs0it09nXBuMi9v6ZF18Tgrmy7eeGmliL8K8Y48yWr9BiOyC/vFcyFYbgcyUyCcWQ
         i2WpWf04Qc6IbfV85s4uiSE+XZCjN9VwrJxv7d7M4GDVRvYk+1JPYnYQOyh0WcAI1PJW
         paYXl7uz2sZXu7oa838rM2cKrJQB2tFc6DDDT7oczGOey+qXraetUrQNNQAHVUJgQVB8
         jsaA==
X-Gm-Message-State: AOAM533j/rY66FjU3sP9/RO2l/ytPSnMfbuj4erJhq+xo1/quQo3srKN
        mQkTzwPmk8s3yeMVDaLhwuY=
X-Google-Smtp-Source: ABdhPJzf1C10OPrTxY5CS+RUjyAPs0sTKtzwWp3zNtBoJB2+oOwSBnw6zYJ4lL5mA9H32k8Vgaq+7A==
X-Received: by 2002:a9d:2dc1:: with SMTP id g59mr604409otb.288.1589394246442;
        Wed, 13 May 2020 11:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b63sm125772otc.23.2020.05.13.11.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:24:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] drm/i915: Remove duplicate inline specifier on write_pte
Date:   Wed, 13 May 2020 11:23:40 -0700
Message-Id: <20200513182340.3968668-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang:

 drivers/gpu/drm/i915/gt/gen8_ppgtt.c:392:24: warning: duplicate
 'inline' declaration specifier [-Wduplicate-decl-specifier]
 declaration specifier [-Wduplicate-decl-specifier]
 static __always_inline inline void
                        ^
 include/linux/compiler_types.h:138:16: note: expanded from macro
 'inline'
 #define inline inline __gnu_inline __inline_maybe_unused notrace
                ^
 1 warning generated.

__always_inline is defined as 'inline __attribute__((__always_inline))'
so we do not need to specify it twice.

Fixes: 84eac0c65940 ("drm/i915/gt: Force pte cacheline to main memory")
Link: https://github.com/ClangBuiltLinux/linux/issues/1024
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index 2dc88e76ebec..699125928272 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -389,7 +389,7 @@ static int gen8_ppgtt_alloc(struct i915_address_space *vm,
 	return err;
 }
 
-static __always_inline inline void
+static __always_inline void
 write_pte(gen8_pte_t *pte, const gen8_pte_t val)
 {
 	/* Magic delays? Or can we refine these to flush all in one pass? */

base-commit: e098d7762d602be640c53565ceca342f81e55ad2
-- 
2.26.2

