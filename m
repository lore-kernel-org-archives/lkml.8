Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86D421BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRJULurj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgFRJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgFRJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:32:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D6C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so5882729ybt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tjAwEnOyA0tmPVPrOK6icwtI4Nv9CgkoPBXdv/shKX8=;
        b=tRJULurj8Sxkc+zLSK2XRPE/sJzXm2gi8Rw1ZetD+yF0N3p/k4ToxNkfafXK66XSAd
         TpcTuaBAJ+ou389KAKOrIX+vOyqrO4gy1J2U/SwvqOZ+i4yhI/CWQ2ugaJO7ZCuSdumP
         DXmMjiHenxaWSbm2MuLVE42jRR5c9rCbmgCd9AuwSrCozlnyODuWZhdy0aGFPX/EWD13
         2d7SoFzCnxlZn3ggvOr36Qy18Dst6mP6Nlr57sfBkOINPZhJn79bBRPFcC7OyZumU/Cs
         JemPE5rgdFQiju2YJJjCueVLGIbJjMMvDxEzGGXWmaN3xdFfNwp8BPmCar1n1ickxF7V
         zT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tjAwEnOyA0tmPVPrOK6icwtI4Nv9CgkoPBXdv/shKX8=;
        b=WNX0JOw2wfjL8C86bSEJFPut1YWRsv6BxmvJVo3p978jR/DOUzBYLltw0wggPGdfiw
         Ctcy8GHol2xNT7gDPlFJeEX6Qeih3UkwpqwG8SGedtM9R3zgD4CWRqO2vY8fMNvGmnDq
         A3s+wk47O7E1fISGFFbBwHIeO2fiSveAjOSAVtbYCJeuzRAQg0zpUzBqjM/dn2MSVVRL
         5QruJ+WkyegwGcXSVnKjDBqWM4xQJVfyMnMm1SEmE9/PHqcPYDK6hrOHgsLtAPSH04Sb
         TUlTJxX0Uo6MRqBYfUAVGJzO3KX2CJaHvM4n6FNlfq3J0nJwv+5SmLHZqEvb972e6X/j
         MXtQ==
X-Gm-Message-State: AOAM531cA0L9KVcnG6JGmJuibYaDGA3y0VJzqwkPNGKnPSMwqeQUudez
        ynp57HTAK9kincEG8QENoAZT18EK/Q==
X-Google-Smtp-Source: ABdhPJwy9+aGQsiKvvd+I3hP4gMIO0df63d901PgqqfbNUqvP+Ko0eicVQzJDje94jgUPcEfbg9b3Vo2EA==
X-Received: by 2002:a25:be02:: with SMTP id h2mr5002260ybk.315.1592472720343;
 Thu, 18 Jun 2020 02:32:00 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:31:16 +0200
In-Reply-To: <20200618093118.247375-1-elver@google.com>
Message-Id: <20200618093118.247375-2-elver@google.com>
Mime-Version: 1.0
References: <20200618093118.247375-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 1/3] kcsan: Re-add GCC as a supported compiler
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC version 11 recently implemented all requirements to correctly
support KCSAN:

1. Correct no_sanitize-attribute inlining behaviour:
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=4089df8ef4a63126b0774c39b6638845244c20d2

2. --param=tsan-distinguish-volatile
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ab2789ec507a94f1a75a6534bca51c7b39037ce0

3. --param=tsan-instrument-func-entry-exit
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=06712fc68dc9843d9af7c7ac10047f49d305ad76

Therefore, we can re-enable GCC for KCSAN, and document the new compiler
requirements.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Martin Liska <mliska@suse.cz>
---

For anyone interested to try it out before GCC 11 is released, I'd
recommend building a stable GCC 10 with the patches applied:

	git clone git://gcc.gnu.org/git/gcc.git && cd gcc
	git checkout -b gcc-10-for-kcsan releases/gcc-10.1.0
	git cherry-pick \
		4089df8ef4a63126b0774c39b6638845244c20d2 \
		ab2789ec507a94f1a75a6534bca51c7b39037ce0 \
		06712fc68dc9843d9af7c7ac10047f49d305ad76
	./configure --prefix <your-prefix> --enable-languages=c,c++
	make -j$(nproc) && make install
---
 Documentation/dev-tools/kcsan.rst | 3 ++-
 lib/Kconfig.kcsan                 | 3 ++-
 scripts/Makefile.kcsan            | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index ce4bbd918648..8fa0dd6c8614 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -8,7 +8,8 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 Usage
 -----
 
-KCSAN requires Clang version 11 or later.
+KCSAN is supported by both GCC and Clang. With GCC we require version 11 or
+later, and with Clang also require version 11 or later.
 
 To enable KCSAN configure the kernel with::
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3f3b5bca7a8f..3d282d51849b 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,7 +4,8 @@ config HAVE_ARCH_KCSAN
 	bool
 
 config HAVE_KCSAN_COMPILER
-	def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-distinguish-volatile=1))
 	help
 	  For the list of compilers that support KCSAN, please see
 	  <file:Documentation/dev-tools/kcsan.rst>.
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index bd4da1af5953..dd66206f4578 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -6,7 +6,7 @@ ifdef CONFIG_KCSAN
 ifdef CONFIG_CC_IS_CLANG
 cc-param = -mllvm -$(1)
 else
-cc-param = --param -$(1)
+cc-param = --param $(1)
 endif
 
 # Keep most options here optional, to allow enabling more compilers if absence
-- 
2.27.0.290.gba653c62da-goog

