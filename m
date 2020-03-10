Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF65C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DC6222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583835199;
	bh=W4WXLijxSDpdGBdK/PX+A43pv11758d6OuOPSc0qBLA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1FlYMV5NE03V1aHyBJZHXJE3WdQHX53rqFcwu5AmxuI2mQZezs0upewfGVgZHwZA7
	 GPj75v90MNsrn9IvlWVSY6MChsxQAdvG0SKg7V96QG6l/4TJk1feQUs5BxV0UdJcxO
	 VlUpATpXlnPesD6gE3U/KkK8Pwn0t3WPslOwGzGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCJKNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:13:18 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:24944 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgCJKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:13:17 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 02AACqfU019796;
        Tue, 10 Mar 2020 19:12:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 02AACqfU019796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583835173;
        bh=9xOpIGGc+JZ3lbYb04or905H1Kt+yrULBMXg/tSCO2w=;
        h=From:To:Cc:Subject:Date:From;
        b=1J0xfzflFFAWxFgLAoJOJ8bqxm6qeEDK5W2TF1DawP6X+gFXY0I4Y1HKBT9eCvVIk
         59IvBs41Da7sDJRILCtx5upsUMhWTvsuVzK8/1jUE81a/2SvvxndXZIu5fzPm8FJP7
         3GVRgtVGE9hZXruEw2mqcYh6zeUs9INrt8UgNHhZzoyKZNGZM1U96s7o5CqQ+o3Tg6
         xfoc8vwEhnSD2IlBJ2HaJQ7pM9CJcdTLgUxi8Ej0lzU30BGRHESOapDi24ScvVvCO7
         nAzNd5Q5Uz0rC1Ribh9fiKZXAYOQ2m1L1QdKfJROkvFFYUK39mKu+r2prxtShkqws+
         Wr6Fnf1NaNFvg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, George Spelvin <lkml@sdf.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: introduce m32-flag and m64-flag
Date:   Tue, 10 Mar 2020 19:12:49 +0900
Message-Id: <20200310101250.22374-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a compiler supports multiple architectures, some compiler features
can be dependent on the target architecture.

This is typical for Clang, which supports multiple LLVM backends.
Even for GCC, we need to take care of biarch compiler cases.

It is not a problem when we evaluate cc-option in Makefiles because
cc-option is tested against the flag in question + $(KBUILD_CFLAGS).

The cc-option in Kconfig, on the other hand, does not accumulate
tested flags. Due to this simplification, it could potentially test
cc-option against a different target.

At first, Kconfig always evaluated cc-option against the host
architecture.

Since commit e8de12fb7cde ("kbuild: Check for unknown options with
cc-option usage in Kconfig and clang"), in case of cross-compiling
with Clang, the target triple is correctly passed to Kconfig.

The case with biarch GCC (and native build with Clang) is still not
handled properly. We need to pass some flags to specify the target
machine bit.

Due to the design, all the macros in Kconfig are expanded in the
parse stage, where we do not know the target bit size yet.

For example, arch/x86/Kconfig allows a user to toggle CONFIG_64BIT.
If a compiler flag -foo depends on the machine bit, it must be tested
twice, one with -m32 and the other with -m64.

However, -m32/-m64 are not always recognized. So, this commits adds
m64-flag and m32-flag macros. They expand to -m32, -m64, respectively
if supported. Or, they expand to an empty string if unsupported.

The typical usage is like this:

  config FOO
          bool
          default $(cc-option,$(m64-flag) -foo) if 64BIT
          default $(cc-option,$(m32-flag) -foo)

This is clumsy, but there is no elegant way to handle this in the
current static macro expansion.

There was discussion for static functions vs dynamic functions.
The consensus was to go as far as possible with the static functions.
(https://lkml.org/lkml/2018/3/2/22)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kconfig.include | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 85334dc8c997..496d11c92c97 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -44,3 +44,10 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
 
 # gcc version including patch level
 gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
+
+# machine bit flags
+#  $(m32-flag): -m32 if the compiler supports it, or an empty string otherwise.
+#  $(m64-flag): -m64 if the compiler supports it, or an empty string otherwise.
+cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
+m32-flag := $(cc-option-bit,-m32)
+m64-flag := $(cc-option-bit,-m64)
-- 
2.17.1

