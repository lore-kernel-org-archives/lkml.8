Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C97C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620BE20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MOtH6g06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHUTyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgHUTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E4C061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so1592361pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKGWDIrBEs2dh6Vx6JHQWt/T3ziuaJ6+D++qA+lLK7w=;
        b=MOtH6g06WVQoxhMiwvjXdIDUiCnhNQLZstpkLeL0aigF1WIuztgjF/SOV6mc40YW8E
         wDHh058AHq5ePmSwdD2DjlRGgSmRaxVSd4mi0Zx9sor/UExqSvQ8V/L8d0p9DL/TQe7y
         p5lo8dxel2Zghjrb75dYwEndSMILJRoFoM+74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKGWDIrBEs2dh6Vx6JHQWt/T3ziuaJ6+D++qA+lLK7w=;
        b=m0vMu6Txwa3fnL7whG97bXh99IIb9i4LyYKLD4BZGM2PHNVEwT4KF2saeM/sXklAPI
         63BG/e4MZVvKo2F7TP366jAYRn5/NGLqXgHUaHRxHvN6HnGXpvI4fVLUu5CxNhwQ9kzB
         r91jg0G2ZTmYjGXAwURCU0P8sozG5NU+16OXmwxyOggAScrCZep/CSvYhBL3v1gYI5pI
         /03hDiDU20RT+JaOlb3YIazw0rshfHBmv3hveJYuI5VGL7l6wXHovNrmdNgo1MV3Ereh
         BHlvI4APzmiB6r1oWhVH3k1WSdrBQJP7HUXlnLS4nGc00G5kYFTtVkKUxZmJLpQCUi1h
         ExYw==
X-Gm-Message-State: AOAM531s8Aq+vv4tpEjHE19l2u0nFWLqyTsG1FLBLwJXxbMKEaSVHhAU
        jhjzNuG6Qjj7mzMV4aD59AkKhg==
X-Google-Smtp-Source: ABdhPJxjgtmoBh+TjhY4jwZBRLmOO/t4+4cu+yIFtjbg4mFY0zXTI5TZCcanxWTLjoIsmfezhzbI5w==
X-Received: by 2002:aa7:968b:: with SMTP id f11mr3724767pfk.63.1598039640596;
        Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k29sm3378601pfp.142.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/29] arm/build: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:00 -0700
Message-Id: <20200821194310.3089815-20-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e877354515f..0aa133c4ddec 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
-- 
2.25.1

