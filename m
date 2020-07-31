Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2422D06
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HwWUijwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGaXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgGaXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB3AC0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so8075982pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw0qFrlLAeGFNQICDxZAEcvNQljVuXBAcUPpDFT6mlY=;
        b=HwWUijwCN1yHVvMTBcWpAPeJzy4e7bIML4GGEjnycX031r9VYKdxWVfS6nNaj90cTh
         WCgBr3fpJFTJ9DUUwuFweceKIqpoU17PdRLq9usS711E+wIEnR2UVx9rK2Jqm12MH2Ly
         leK+goXQHjXkoEk8FTiq2zz0QFdbtKl/unv3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw0qFrlLAeGFNQICDxZAEcvNQljVuXBAcUPpDFT6mlY=;
        b=e9SGsZOM1OwFY+TB3s8BbFn9PwGdh/7qg8XWq8rU4DlAXGaAwWB4Y074a9QhdbRzu4
         GmiNcPkk5IYpNBhX8oBTEd5BA2fosk7TSlUMA2MaHzsWD8ncVCmrNT+oqxdli7VmsTdV
         kiEOhighSrQX4dO+TcQnIHkOkYsvErEYmiaSszNzPAsURnqXVfyhVul0sMDuZToZxfEH
         6cWMz+NCtYLdVrdSARWWpSdx/GpEezpYZ+fcgb4BXTQRKwjlM6ljv2FyeM2fQt1Kc66W
         cm8e2gQetonKmzeXjCjurNwIl9NdthPePTb02VHDSArShvo3TjQDjwPnS7SSJE4sWBPL
         WpVg==
X-Gm-Message-State: AOAM530LjNccWwFlY16aB0W9qlG5MKZ+TGf22Zh/M/3O6S/QmiEtHtxB
        cHAYVYhSp/iK9DN48MnQucQVpg==
X-Google-Smtp-Source: ABdhPJz6/VTMQ01SrfhMQ/SLXbQUnTuGTkQpv8usqAy0lJH0IrS74Nhjz+iAd2EIkwdY4wSBBsMY5A==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr6354051pji.154.1596236925542;
        Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm3120709pjy.51.2020.07.31.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 21/36] arm64/build: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:05 -0700
Message-Id: <20200731230820.1742553-22-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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

With all sections now handled, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 35de43c29873..b8a3142db0dd 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
-- 
2.25.1

