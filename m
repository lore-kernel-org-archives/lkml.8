Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1238C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF3206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bNeNVIUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBCyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:54:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E818C061265
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:53:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so1781348pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcvEo160LuHDQD7qfOvAP7KcCyAU7p1FFARh/mGAmoY=;
        b=bNeNVIUp5wLd20zY7GcMyTGEK+1iPazVe7pNUjLaD0gXYItCy+3Sdv//WvvNwoKDM6
         Uv+a9vaUg3+t1WxF84thK1gkM5sHMKI+Rq2tNAhA7rAZnF0RzdZRMP6vmNwRs2hT7jbC
         A2ZuOezSk/Jtm5d8lXaE6Ct1Du9kbe7yDRf6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcvEo160LuHDQD7qfOvAP7KcCyAU7p1FFARh/mGAmoY=;
        b=RvuYD6ooxxpeANlPjfpeEjg9Rlep5HxKCG7qFQf+M4SAUQC4mYbARI5dgkDOajlbY0
         he3uHBuvepAjcgm4A7FaSDmngYAx6y4LVMpdi1DLCtBJflFUl7C8YzHpPHxe7iUG6lKT
         S9F99GBioBS7WEendRoeqlaDWnJoE8FAzx26xZVJCqjz0TAIYQkyZuxD2e8IaLqlDQT0
         TzHnOYM3pYGTkiTbu5aWOymRTkvAST8C+D8cupYDdAOAUBfu/uIXtbKfUDceqHX9llQU
         T4VOW3QRmxnvqg0X6cBfHz08WrcJBczn40fPnI4rchk2zHQYgxYcZF2Lgf4d7slc8xSF
         RTkg==
X-Gm-Message-State: AOAM530kVe2iA85Hwy3xW4x5o21mrHALNBjTu11e6To48sjG3aCMlR7j
        BqDTDJypdjx/yst5KHuR/MAi1g==
X-Google-Smtp-Source: ABdhPJy0HGMfDCWkJW2ahd3RYXmS5RA7xjHg6pHP5/RCgQANMg7x7X7wDQT+vfbBEud/U6454iTChQ==
X-Received: by 2002:a63:d34e:: with SMTP id u14mr235066pgi.122.1599015236142;
        Tue, 01 Sep 2020 19:53:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o192sm3673517pfg.81.2020.09.01.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] x86/boot/compressed: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:47 -0700
Message-Id: <20200902025347.2504702-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
References: <20200902025347.2504702-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5b7f6e175b03..871cc071c925 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -54,6 +54,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

