Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E4EC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F9C2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCu8hyTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIBCya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBCx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:53:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA7C06124F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 19:53:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so1643645pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPZJbcEtwfQTjOb/c8yhPFEhILSdoB+KS72tNB8EcNI=;
        b=kCu8hyTcGoY7RYojj6lkArYLYWRPCSJax2BgpnkrA4p6KHwO/KDpfqBFFVqydUb61M
         KelRtaHdh8yEvhXTfGGBKZyqjY4QUC3HvxL/Mnd4l1/NUfthfp/+uqRjf7TZvXRoaXUv
         KtH2K7YG+GNs7sb3j+14YNKypSfg/mtqzN72k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPZJbcEtwfQTjOb/c8yhPFEhILSdoB+KS72tNB8EcNI=;
        b=mRgIeeGOYPJae3Kj18o391lJTng0lyqZklAyahNHlXGX0ECdr8PbF5KH27J7a0vYAH
         ocoPEv+dDA6pAxG/cFgoOrD2L0pRd6c5PuQyLqhfLFwLk+Z4tj5HliexPp0tatW5l/YG
         vWtGF4edFuGTeXNZXYTYHS0+DyNwUnjgYamKw5X2UGLV+9PA5MWppsIlFJZe8NLyHGLX
         dHdE/eRT0QKZWZHwkE7CuhtWR68eM2qFblPnw2wbCnw1hbtnwufIynIx00i/DFq59DPi
         pGD0YkdAjQt1rji9v/WIvAuLYFHTxos2RCIE3J5C8Psm6O4hHibabuAYZFoRjVNNbCWc
         9Hhw==
X-Gm-Message-State: AOAM533PDC2KRDMOYxhn9s4VqD7FhL2m93LdnZZgf92YYPbYUinWNKu/
        NWNHC3jrlZ9k5NrlnrPrS4yPIw==
X-Google-Smtp-Source: ABdhPJxv9F6zTbZLG31keWGzI4N4ccr5wX8ALy3FKGq8wAk/IzXEKUXCP56QRYBrM4KTWBz2JqF6Qg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr253940plr.58.1599015232244;
        Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm3575074pfh.168.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
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
Subject: [PATCH v7 3/5] arm/boot: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:45 -0700
Message-Id: <20200902025347.2504702-4-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b1147b7f2c8d..58028abd05d9 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,6 +123,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-- 
2.25.1

