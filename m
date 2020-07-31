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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09843206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lr9or3Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgGaXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgGaXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6003C0611E1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so4681174pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=Lr9or3Hp0DSvQYElAg+xki465Vdb1uAtDe85PRDbs1d8wZ08VYB9OlhllbtENPVieR
         V70iE3+WoadE5MGnu8i8GLUrfRA1t5+LbrYMwG75g0Vr4sqB1S8u5be8NrKejxdMS7gm
         byUy6rMjO1J+JL4A2Xwyw8hGAHymoJEGFEhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=gG4V1WjyJLKiGfcU0sGIN+IdGqDE17THG6DNXl49WX4XGMrBdXQHMHiWuaXceB4UYO
         txu7i5Ir0zZGwMSlBIe0/ArSoYgPDPrII5aQLD0S3A5yvig2x8hTVMwwD2Vj1R/NAeGV
         zx3+JUgVJ9xgzRwkxcCwY4b7DKv2+jiHD1lag51YmXRg5Lsd7sKs3+3dC09x887E2CzM
         fDG5nMHtC8euxJVmj1OgP2ApNHynz4MDF6i+VTY/yJ6P2P7UJwYZ4Fo9EvHNpcygATrp
         KB8icCEb2iOgvEY64rhxNYDBHKB7+I7hs0gvkmvSVd59Dz8/eembwnKa8rMiRSwn5+md
         Fyvw==
X-Gm-Message-State: AOAM5302oMGAcGiL3ZMdhh+eFQRcvcZhA2/SWFV//NpHLVfq0FkpMOmp
        NYQsocOVHpsed5JaVr1okRAKcg==
X-Google-Smtp-Source: ABdhPJwhHCIH/rXPbloue7Ao7LwdLWcpC7pKCtwRdsLSguHj3gdxjmuhn4CNI2OYzSlwA+KLPraTmQ==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr3631713pjw.146.1596236931297;
        Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm11218113pff.10.2020.07.31.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
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
Subject: [PATCH v5 35/36] x86/boot/compressed: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:19 -0700
Message-Id: <20200731230820.1742553-36-keescook@chromium.org>
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

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 43b49e1f5b6d..f8270d924858 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -53,6 +53,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += --orphan-handling=warn
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

