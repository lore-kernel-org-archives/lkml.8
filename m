Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89628C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F152080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gkxs/4L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGUEUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGUEUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:20:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA8C0619D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:20:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v10so11573518qvm.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BihrwH3YWr7bTCjry1NXThJajsBWv/A/wcqD0l396O4=;
        b=Gkxs/4L9w2KYJeqo1YzrritKtKVPQXS0nv3cFc1jhGooz2i2RqPdhiqYoQnp1qX6Fy
         v0erMgNID5uKlh2JzkyqRUT3P2dNJPgGSUmyE/T5ReFLtmy2MGmujoy8D+zW9wi/mNkp
         rOVTsvULqQVx9jc4HxHbW8MaJS/1Tgjjza0iSFEIf3TswCxVOm4j8tuNunvWr+cxf1Ts
         hZYjAoCTG/p/3fEt/AbyH4JtklfW7Es9V6gVD8dewOgW2vhglnCtms5VhrnhEVBBrkbx
         HsHa51amlowN1sfv6HI5H1SbmFc//YgFuisS3nLFiSmSjpetTSEK0L5bn028gUR8C5rs
         T+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BihrwH3YWr7bTCjry1NXThJajsBWv/A/wcqD0l396O4=;
        b=XUiA6Nn9UF/7K4mSlSxYej3Vs/8Z3hODz0Y/ZpLFsKoLDb5x+1SsjkgmK4bMRLhNfB
         t0+eeVH4ycaeQBRfpB/zxZaKLgh6Y+AAG3Jb1O2Qb2o7zv7MlzJCbOS67Be8MkMKrhNN
         1x83+54nae4o5yz9QwKNnaYnh6q25vYAvtKHg5IuEU14Pj8VOwsRHCEJ9OLxbO9NMEH2
         WMsbVMdUFkZuPcyArTeSq7pzYs/g53Xly5CCRFVO7UhmdNHUBlKqjEbBjKFfAw1YVbZ3
         3gI8brtfjtpevp7+5+iJIGUr6noYW5M9umT22GA7CYUdfMvQCJWdxrD2vTnFYu7Uc+jc
         dang==
X-Gm-Message-State: AOAM531ZtPOcyknUH315vnvHxK8k7o2UfnmK/8XDaBMzHHhbWqriYRW6
        Gb3KlP8f2pR3+M/XdcxdXkYoqxeIiwD3
X-Google-Smtp-Source: ABdhPJyws38D0FLgRfDbVjjMTi43YQTPV6lXnjuE3rDLoFlOp9lJ5MDKjHMYRc9vl3OPwcPnhjiqPGbn9gBf
X-Received: by 2002:a05:6214:927:: with SMTP id dk7mr24912062qvb.26.1595305204150;
 Mon, 20 Jul 2020 21:20:04 -0700 (PDT)
Date:   Mon, 20 Jul 2020 21:19:38 -0700
Message-Id: <20200721041940.4029552-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     stable@vger.kernel.org, Jian Cai <jiancai@google.com>,
        Bill Wendling <morbo@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CROSS_COMPILE is set (e.g. aarch64-linux-gnu-), if
$(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-elfedit,
GCC_TOOLCHAIN_DIR will be set to /usr/bin/.  --prefix= will be set to
/usr/bin/ and Clang as of 11 will search for both
$(prefix)aarch64-linux-gnu-$needle and $(prefix)$needle.

GCC searchs for $(prefix)aarch64-linux-gnu/$version/$needle,
$(prefix)aarch64-linux-gnu/$needle and $(prefix)$needle. In practice,
$(prefix)aarch64-linux-gnu/$needle rarely contains executables.

To better model how GCC's -B/--prefix takes in effect in practice, newer
Clang (since
https://github.com/llvm/llvm-project/commit/3452a0d8c17f7166f479706b293caf6ac76ffd90)
only searches for $(prefix)$needle. Currently it will find /usr/bin/as
instead of /usr/bin/aarch64-linux-gnu-as.

Set --prefix= to $(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
(/usr/bin/aarch64-linux-gnu-) so that newer Clang can find the
appropriate cross compiling GNU as (when -no-integrated-as is in
effect).

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1099
---
Changes in v2:
* Updated description to add tags and the llvm-project commit link.
* Fixed a typo.
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

