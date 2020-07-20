Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A6522B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ks6dk1mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgGTSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:12:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB56C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:12:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 124so22894839ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=foQP01o+jLLxWyYMddt7wMxz9LiizEHjChmq39E8dvQ=;
        b=ks6dk1mRoPvv5K/RguqHzZXRvpQzZ8Sma0KZPaH2f9dcYupIWG8cBMxwDl+AR4xhaV
         CH1dhBt+6QvtqFvJImE7/TQy6QanJ3RuMki6d2XjchxX6NLmodxKd/KU4im88YsqeISB
         0PdFNGrai/DE1DxfYYhfhT+51rxO3HwD7yttKR78i/mA3LXJAncVIiTIkjq0TKeK7F2b
         sHfctGLF7Zvzut+ZSeq6cb4vKRBUUEW2YtnYgEgH5jCsx4+dhdKZHZk4cn03GDcAWKAt
         Wmc6voUlwuxFz/qni4DIekfBhxrgjZWS+g8WjfJWc6pKMq891yKv8oGa2AbFZd79eTpv
         o/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=foQP01o+jLLxWyYMddt7wMxz9LiizEHjChmq39E8dvQ=;
        b=lvyDltCuvsrtQgMHeNsTR6p72z2ZxLNI9Jatr6bWejo19D6nAdDegQQRpM7BUwqEM+
         gcnsSUWCEXaDpouPEcCvOL7LPRSCOOFqeepOaCaFc2UYLlWO0VYGCIc5VuAracW81QII
         XM12q7MiQHv3oYanxQD1U3H1Jk2jFAh4DzWLoSayQCTG3sWm8xwVC6p2qfuWtlzKAk7T
         U9P3XWh3/0p9tSTkqAaUhDHVIhjZsYgy2FlWWAzYZg71am1mOHHtlCLxbgEXcbIcPacB
         kVfG/Zm1lkLhPG44RRvG/UWdjFt2kxLuPS6kx8xlWfvyXACD4EGIySBjNoP+z+uf3PNY
         3nmw==
X-Gm-Message-State: AOAM531ufQbnMV+zonYA1m8BYrGcakzv/AtKTbbA6zMOpaH7XbyDCuqz
        YTJn9Rk/byS9BJUD6pngv3ZV/T+7TjaO
X-Google-Smtp-Source: ABdhPJzqOaS4ZMz+61ASiwWqZJTx0yklQsWOZm640ChrHnJkwqqqGPaVilq3n2xbqX2bO72REcKFb38xI/gV
X-Received: by 2002:a25:fc04:: with SMTP id v4mr37291336ybd.164.1595268765617;
 Mon, 20 Jul 2020 11:12:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:12:22 -0700
Message-Id: <20200720181237.3015826-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CROSS_COMPILE is set (e.g. aarch64-linux-gnu-), if
$(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-,
GCC_TOOLCHAIN_DIR will be set to /usr/bin/.  --prefix= will be set to
/usr/bin/ and Clang as of 11 will search for both
$(prefix)aarch64-linux-gnu-$needle and $(prefix)$needle.

GCC searchs for $(prefix)aarch64-linux-gnu/$version/$needle,
$(prefix)aarch64-linux-gnu/$needle and $(prefix)$needle. In practice,
$(prefix)aarch64-linux-gnu/$needle rarely contains executables.

To better model how GCC's -B/--prefix takes in effect in practice, newer
Clang only searches for $(prefix)$needle and for example it will find
/usr/bin/as instead of /usr/bin/aarch64-linux-gnu-as.

Set --prefix= to $(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
(/usr/bin/aarch64-linux-gnu-) so that newer Clang can find the
appropriate cross compiling GNU as (when -no-integrated-as is in
effect).

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Fangrui Song <maskray@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1099
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0b5f8538bde5..3ac83e375b61 100644
--- a/Makefile
+++ b/Makefile
@@ -567,7 +567,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
-CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
-- 
2.28.0.rc0.105.gf9edc3c819-goog

