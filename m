Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEAC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CAB214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4th2Gwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgHUTzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHUTyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF7C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so1478184pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7lCPABz4JNrayMBdAlXz/o0k5wzYACi9B/neD0BSpY=;
        b=h4th2Gwty/g8Cg6oI4xBM2C9OsM+YtTMFNWMQxaSJxeMsiGbGHmjIpyPzRqnDYUohj
         mZEWv+JTiMGCqWpGcvezka0JZwFqupIZBq+bYlxEMz2m2f5RPnDUM/esPBUqClXzhknr
         KDHkGu/E7WUrNYpV0Two51F+fgNxBgpigGGNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7lCPABz4JNrayMBdAlXz/o0k5wzYACi9B/neD0BSpY=;
        b=T7EMTQIcSnGlzku21nyDmn7Fs8JtXhE4u/4FgtIi8BT5jCOnRk8tX1AAvE/zuVk+GH
         ItGIZMEXUSvdJ9GwTD3OQIDBPccn8qPlwQ/Yn1kHzRd3gGH0VvBNpaTSWa7CTYaYEkGn
         jLEdjFL1Kcnj1n0PJlMGyT8xJy1amy9UmaIprnZtfu3KVC/GXdylbbcjVrCgpyonJsCu
         9XrHw6NiKuOj4Z57WBypnBMDxH46cbG+tyRso8LLeESbY5wfde8gPl2c7bl4ccxdyS/b
         t4Zsh1xudnWWY9SMJE695PRqbTPBUYx4+y3Lm4g8R3fM+itTzCtDdxJIqeTMyES6R82Y
         ZxMw==
X-Gm-Message-State: AOAM531BESdtAvYPF8Ugn2LuhXnR1L5kXjfQBK23M/fIylDGpPYOrNK2
        EEs8v2xrAAVa0XmYX+qDIUpJmQ==
X-Google-Smtp-Source: ABdhPJxhC+bVf5xz8oKClettUbKDwzdI3ZXBGK3DWk9rxsSxl1YyINcFuh70sERopw/lGiEEpzQkVg==
X-Received: by 2002:a63:cd46:: with SMTP id a6mr3322488pgj.267.1598039642059;
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l67sm3026438pga.41.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 25/29] x86/build: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:06 -0700
Message-Id: <20200821194310.3089815-26-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4346ffb2e39f..ccacbf808552 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
 LDFLAGS_vmlinux += -z max-page-size=0x200000
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
-- 
2.25.1

