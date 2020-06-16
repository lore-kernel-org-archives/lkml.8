Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F201E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRXFFBCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgFPMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFPMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:37:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C3C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:37:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so24612726ybg.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vg6gGhm8RLyRRWmBBuD4VJ0tZVLjRg4UH9yY8TubE2E=;
        b=WRXFFBCdZ47FzAZpzIxXUWHDlN7UP/JWuGhcc1uCfT2ttLAbgmyFck96Qb3vUynh01
         b6sj2MC/YevG4uY9SdW6GChWtkXfcFgmKggOvGc+QLLEn2+nGSd2CSERQrzm7acRk2+/
         N8qovJG84UH9PvJeKc87102igdLG0kVNh0Wl6lW26/v8J/exGnScK4twUf9c+ViqcqEC
         PCOOzejLEseFrbREB66/jWdPUGCt1iAkxGvN9+PupXCusai4mm6B3n0LjyskeBxbvi+F
         OoVw8hs8gTpFe2Wsvrj7OZRgwlhU/yLK/8PtKgBjzsB7oKkQF7ycYxC+rUsAltm6OsM0
         Hxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vg6gGhm8RLyRRWmBBuD4VJ0tZVLjRg4UH9yY8TubE2E=;
        b=sZpoiF+6OvyHKhqHEXEIj//kwZLVvAtn2/ZpRHm0+St9nWI706s9xAoICg9e97EIvG
         FN7RadnmtUsW3S0/Wn3vZgUVxcjznbhyGh+7QV0LJvNvQ/C+cVEnhLtpjTsfYuUdsb5q
         HXVjhOZmVAcq2q9R2eUv2voqlZoCOxSAyNJEx31/jH3FyF2oZhHYbGLwpqVceTWp2mjw
         aUheVw63mcAgLrhtOC2iUW75maswCFcz5J7n0fjtFMmqS0cNfdA4klXNzRTFU0o+d0kH
         iIhcMT8hRbjCnTakv3v9qAZIMrDePNFjGmCG9NsMcl5V8kC2epkqHgtdsgpjBw52vtBu
         lrmg==
X-Gm-Message-State: AOAM532T9ZZD3oFlNKsWza5/kZDfAbtLJv42eGh7zNGWo4+N58jLgJZc
        93zDFRDZf+Dd6bTwDeEXKBza4Vs47w==
X-Google-Smtp-Source: ABdhPJzXJ7N5NrCresOg2mK5Yb+hf1srFvLq45P0t4LgalRdR8cI7V4uzmtRzpyzoQDJ2xwybBjxJZIbdw==
X-Received: by 2002:a25:df0b:: with SMTP id w11mr4044370ybg.449.1592311019895;
 Tue, 16 Jun 2020 05:36:59 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:36:24 +0200
In-Reply-To: <20200616123625.188905-1-elver@google.com>
Message-Id: <20200616123625.188905-4-elver@google.com>
Mime-Version: 1.0
References: <20200616123625.188905-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 3/4] kcsan: Remove existing special atomic rules
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove existing special atomic rules from kcsan_is_atomic_special()
because they are no longer needed. Since we rely on the compiler
emitting instrumentation distinguishing volatile accesses, the rules
have become redundant.

Let's keep kcsan_is_atomic_special() around, so that we have an obvious
place to add special rules should the need arise in future.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/atomic.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index be9e625227f3..75fe701f4127 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -3,8 +3,7 @@
 #ifndef _KERNEL_KCSAN_ATOMIC_H
 #define _KERNEL_KCSAN_ATOMIC_H
 
-#include <linux/jiffies.h>
-#include <linux/sched.h>
+#include <linux/types.h>
 
 /*
  * Special rules for certain memory where concurrent conflicting accesses are
@@ -13,8 +12,7 @@
  */
 static bool kcsan_is_atomic_special(const volatile void *ptr)
 {
-	/* volatile globals that have been observed in data races. */
-	return ptr == &jiffies || ptr == &current->state;
+	return false;
 }
 
 #endif /* _KERNEL_KCSAN_ATOMIC_H */
-- 
2.27.0.290.gba653c62da-goog

