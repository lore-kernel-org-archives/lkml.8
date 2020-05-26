Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4992053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYy4cIlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbgEZRba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:31:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C8C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:31:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f130so4556954yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KoFGqqU+J4KGd+h8gI8dCMTc7LV+YyRpHvvUmsT31Ks=;
        b=VYy4cIlP+hhv8YRSkFRmXPacxvn/fphatpnJHvQJcUDopkMHzjvMEVgmbi883wi+4u
         saQWPREkP+6SHn2z8P4PgrRxB5qYKdnbuGvGfau1oo9kpTzkMqCd/eJMs6OcKXGKRsn0
         9mAvbxLzQHEfHa2grvlfEgxvmwGxDVcrsq1kxELoJ6V2FOqncQfkPqltlxrARAr/0w0R
         F0iNuxwwQOBS1/mLXkAXbZgyrzF71moh6lhgXPSg6rXyuFI2Nu+uzg/bYoFIJz+BFIlQ
         6Gli5zS5TILjU+FrQ7uMAbacqUQ2ojKJfigmyxdtYuOX4di6w+UGpmrVLp7BgJW2ABki
         804g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KoFGqqU+J4KGd+h8gI8dCMTc7LV+YyRpHvvUmsT31Ks=;
        b=gyAglt9hVvSza9hp8FXfJ21lV9my4iC6McDMiNhMLpKU+g01k2nPyY9qanHidRYCMw
         CaVHM7sBmxPZGVJeJLzY253Wn6gn1MgAAje4MvxoXSGbEYs6LI1p6JNp9fuYs0DhZxPI
         GLfdumQOPivxFusw1pU7JFD2+AOMU7dcnBnx0+EgQP5uXE3Qc0Ces8W22lsz4omw25gX
         IjjUXXyxAObwCjXRIidljb8Yuu6tUdXakcamDOot97hvCTFaWgbhIFmQ4Kr99k2Sdn3A
         kUW0Mtq6uCF9COMaP+AkFoUocSOEjOg+hmASsHLWrDaQz6wjCIOUnflupbkGgnFtKGw3
         VSog==
X-Gm-Message-State: AOAM530U4GqlhZ1bhtxB6mh5yNO0SYwpmxd9b34zoNCZ/H1PuaVYPzuy
        sgGYjt/7CW3tFm9f5dgUKbpzGt6D2Oqg9cuVO9s=
X-Google-Smtp-Source: ABdhPJy4OvFsDSVA1K5rC0fp9UoOPwc7MTN3yrtauZDF/HHmGAky8cEISS73DZlnG5wfH1U/lI1diXeR+n60OKcrVpI=
X-Received: by 2002:a25:ec3:: with SMTP id 186mr3473690ybo.475.1590514288160;
 Tue, 26 May 2020 10:31:28 -0700 (PDT)
Date:   Tue, 26 May 2020 10:31:14 -0700
Message-Id: <20200526173117.155339-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Custom toolchains that modify the default target to -mthumb cannot
compile the arm64 compat vdso32, as
arch/arm64/include/asm/vdso/compat_gettimeofday.h
contains assembly that's invalid in -mthumb.  Force the use of -marm,
always.

Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084372
Cc: Stephen Boyd <swboyd@google.com>
Reported-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Surgeon General's Warning: changing the compiler defaults is not
recommended and can lead to spooky bugs that are hard to reproduce
upstream.

 arch/arm64/kernel/vdso32/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 3964738ebbde..c449a293d81e 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -104,6 +104,8 @@ VDSO_CFLAGS += -D__uint128_t='void*'
 # (on GCC 4.8 or older, there is unfortunately no way to silence this warning)
 VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
 VDSO_CFLAGS += -Wno-int-to-pointer-cast
+# Force vdso to be compiled in ARM mode, not THUMB.
+VDSO_CFLAGS += -marm
 
 VDSO_AFLAGS := $(VDSO_CAFLAGS)
 VDSO_AFLAGS += -D__ASSEMBLY__
-- 
2.27.0.rc0.183.gde8f92d652-goog

