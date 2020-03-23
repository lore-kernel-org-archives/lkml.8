Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41591C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BDD20753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584929553;
	bh=HZMw6i0DwF3XD/CXfRTsB7eETFEpdi9MaIMtnrt76xE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t7pys+SilltMywT59GjwJFiMbnx9fUWz1XigB+8BM22pWe76lQFa8yOw35A01dvXC
	 7lHIQoDqv+H/V0F9kiTCfe3w6PKeVDoXJJ5x/6Vue7LtcpUyArFPCVcD72YTBH6xia
	 nHRZrjdRItZh8lLfUcQwrwOgvLE3vnoS4GnODw4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCWCMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:12:31 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:47452 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCWCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:12:31 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02N2B0XE005345;
        Mon, 23 Mar 2020 11:11:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02N2B0XE005345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584929461;
        bh=921IQ+kt9407iGCDk1ZEmlbnWdF8N6TUyCzyGcOHkIA=;
        h=From:To:Cc:Subject:Date:From;
        b=AsLaLubRaEcK2e+0uHzTYGp9FDfJiAMoQo3oT0Q2vqBenotASSN07zJz5Bd7g12Uj
         NlArBFCPkz7Yy3sLWH2bYO0IDVRMufDPeVGX9geH3JpFFySsL07kNuebrqSs6KpIqW
         W1Gr0jQFRXu+hC0dhVP66IqRfoUDckUNlGYkz/v0kXBUxhkOMgagaMKrEvMs4XqpTe
         rt++g2WB8pLBK458BCQIIAk06YmRNoUZe7UokQ/SEhNtOq2Dr3SN4NZnvTs9zwvwBN
         vKfD9d98wgWBxSsW2yKcgXfuxengtOMRa7SXy8hlK5tKhmgf2IWi9UPU+WzZl9cWt7
         7HAqPq1ycBbCw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        clang-built-linux@googlegroups.com, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: remove always-defined CONFIG_AS_MOVNTDQA
Date:   Mon, 23 Mar 2020 11:10:53 +0900
Message-Id: <20200323021053.17319-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AS_MOVNTDQA was introduced by commit 0b1de5d58e19 ("drm/i915:
Use SSE4.1 movntdqa to accelerate reads from WC memory").

We raise the minimal supported binutils version from time to time.
The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
required binutils version to 2.21").

I confirmed the code in $(call as-instr,...) can be assembled by the
binutils 2.21 assembler and also by Clang's integrated assembler.

Remove CONFIG_AS_MOVNTDQA, which is always defined.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/i915/Makefile      | 3 ---
 drivers/gpu/drm/i915/i915_memcpy.c | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index a1f2411aa21b..e559e53fc634 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -28,9 +28,6 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
 CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
 
-subdir-ccflags-y += \
-	$(call as-instr,movntdqa (%eax)$(comma)%xmm0,-DCONFIG_AS_MOVNTDQA)
-
 subdir-ccflags-y += -I$(srctree)/$(src)
 
 # Please keep these build lists sorted!
diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
index fdd550405fd3..7b3b83bd5ab8 100644
--- a/drivers/gpu/drm/i915/i915_memcpy.c
+++ b/drivers/gpu/drm/i915/i915_memcpy.c
@@ -35,7 +35,6 @@
 
 static DEFINE_STATIC_KEY_FALSE(has_movntdqa);
 
-#ifdef CONFIG_AS_MOVNTDQA
 static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len)
 {
 	kernel_fpu_begin();
@@ -93,10 +92,6 @@ static void __memcpy_ntdqu(void *dst, const void *src, unsigned long len)
 
 	kernel_fpu_end();
 }
-#else
-static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len) {}
-static void __memcpy_ntdqu(void *dst, const void *src, unsigned long len) {}
-#endif
 
 /**
  * i915_memcpy_from_wc: perform an accelerated *aligned* read from WC
-- 
2.17.1

