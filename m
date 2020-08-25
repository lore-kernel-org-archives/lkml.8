Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87190C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6421120738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP6gTQnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHYXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHYXOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:14:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F0C061574;
        Tue, 25 Aug 2020 16:14:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so63235pgl.11;
        Tue, 25 Aug 2020 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+vF/AWstA9TSWcFttjZuK5Zv8tvYzpOTR1kcqpIxJ4=;
        b=TP6gTQnJM0RrYMqJnMhPvdVQpODPKHkS1q9nkPJCEVxQDdKOY/9X3ieTQ5APjTs99s
         04ITRLlPcOJFWl6rwSne7XvO4G8AacidA26rCCkdaQWSbFH7Amr1p71zr6Br/fDCLfea
         NWqNdCjwHbjEmZxVKvtm82YSe/0on8xQExCxt0PeiSBcNSm/F6C2nz+qKpijKAFdl1MW
         /5JmxOM9bX30yDgJW/aGZHRHq/Krf8enocXS5QVfj3bdU9s1x6iqQG2lss+Rqt2Zq8Cg
         KyX7YTSYrD93j9BhIrYMVxebJtf8QAJFn088SG2rW9Um6rBKPclPYUGRnj+GfuKvcoPl
         +DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+vF/AWstA9TSWcFttjZuK5Zv8tvYzpOTR1kcqpIxJ4=;
        b=gKqmSVUDpOEbjysD8EkrKUHydJ0bKTNufjnp3n9WfIDU67f9MRBxEOk2UEwAfujPRz
         fuhD2eXRmcxdBVhIwXnurz2uE3FYBO3k/bzSYseYSyr+DdqSl6zM6Cfqqn50TiRrj4cI
         FbQOdfvJ44+vZ0hxYf/tlZHXSCNl9ZKFDT3MOrWf+PTES2neB44k93KylVu6h8Uqq99q
         AuUjyz3RayO2umimvqAhvAI4J2pUmBcocjK1yq7zy/KHC7fImRyUl6tSip2c7IS3gUpF
         QyQj9CVTdNwVWzMCBGzaO7OpcGF8XLSaTMjlK9kxz/N8NLs4zzUK7bXdM3Yfs5Osn6C3
         NwTA==
X-Gm-Message-State: AOAM530C6fAm/X2tQvWNLzXZrHjDlHUbVGpeEMwi1TsGf+SAAUfR86HI
        H8a53BaiYw8r/fa32spIljQ=
X-Google-Smtp-Source: ABdhPJwrLtxlTGlTGzN5yK2R9cmi4i37aldtK0ixWIhF7COjveVyx3OFx0tGC8UQFcylLAWCumhVuw==
X-Received: by 2002:a63:ff5f:: with SMTP id s31mr8673621pgk.333.1598397287304;
        Tue, 25 Aug 2020 16:14:47 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain (ip68-3-136-221.ph.ph.cox.net. [68.3.136.221])
        by smtp.gmail.com with ESMTPSA id b12sm141769pjz.15.2020.08.25.16.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:14:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] Documentation/llvm: Improve formatting of commands, variables, and arguments
Date:   Tue, 25 Aug 2020 16:14:38 -0700
Message-Id: <20200825231438.15682-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing a separate patch, I noticed that the formatting of the
commands, variables, and arguments was not in a monospaced font like the
rest of the Kbuild documentation (see kbuild/kconfig.rst for an
example). This is due to a lack of "::" before indented command blocks
and single backticks instead of double backticks for inline formatting.

Add those so that the document looks nicer in an HTML format, while not
ruining the look in plain text.

As a result of this, we can remove the escaped backslashes in the last
code block and move them to single backslashes.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Documentation/kbuild/llvm.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index 2aac50b97921..334df758dce3 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -23,8 +23,8 @@ supports C and the GNU C extensions required by the kernel, and is pronounced
 Clang
 -----
 
-The compiler used can be swapped out via `CC=` command line argument to `make`.
-`CC=` should be set when selecting a config and during a build.
+The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
+``CC=`` should be set when selecting a config and during a build. ::
 
 	make CC=clang defconfig
 
@@ -34,33 +34,33 @@ Cross Compiling
 ---------------
 
 A single Clang compiler binary will typically contain all supported backends,
-which can help simplify cross compiling.
+which can help simplify cross compiling. ::
 
 	ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang
 
-`CROSS_COMPILE` is not used to prefix the Clang compiler binary, instead
-`CROSS_COMPILE` is used to set a command line flag: `--target <triple>`. For
-example:
+``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
+``CROSS_COMPILE`` is used to set a command line flag: ``--target <triple>``. For
+example: ::
 
 	clang --target aarch64-linux-gnu foo.c
 
 LLVM Utilities
 --------------
 
-LLVM has substitutes for GNU binutils utilities. Kbuild supports `LLVM=1`
-to enable them.
+LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
+to enable them. ::
 
 	make LLVM=1
 
-They can be enabled individually. The full list of the parameters:
+They can be enabled individually. The full list of the parameters: ::
 
-	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \\
-	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \\
-	  READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \\
+	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
+	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \
+	  READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \
 	  HOSTLD=ld.lld
 
 Currently, the integrated assembler is disabled by default. You can pass
-`LLVM_IAS=1` to enable it.
+``LLVM_IAS=1`` to enable it.
 
 Getting Help
 ------------

base-commit: abb3438d69fb6dd5baa4ae23eafbf5b87945eff1
-- 
2.28.0

