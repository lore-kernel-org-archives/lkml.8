Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93683C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A4C2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXpcLutZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGaXJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgGaXIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A9C0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so1599966pgx.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GUjcxjsZxZ8lM3nHzNDLygJ5FIXra6/aspJ0PfOUm4=;
        b=kXpcLutZEBDIK8r/VrXM0/S/M66OR5FIx7eppKkF/v1AAyqoIG1EcJSK+MAUIX1GFO
         +VctBRcweBl+L7+RbRpkCnLdW+eB6f/AB/C7ovm8+db2FE3qYt6eJuyH5G4NG9EB2Nqy
         kXp3k3nuHXo+uMdBCXjaRxsfyYI9gbQEgrOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GUjcxjsZxZ8lM3nHzNDLygJ5FIXra6/aspJ0PfOUm4=;
        b=fpfoNQTXmYztLxGDHAkJsqTg/dahI2URlEtRQyPSXToN7/uJDj7z6eupNxTmmTVEGv
         3CMxEtfPLO4U2JHhl4qMhSnULFWGPZQfL3fGVSfVNtqN9yHCqSHs5NQbQvx6ccImMKFY
         P6ozok2V/e8sjc7D1oe3sEpTE36MY5dj4oZEHh9FzSffgeK/iuIwA4gH0V/XdsTMjlgA
         Tztxqol0Mgvx8sbDrKRC1dkcjfZ4sbH7iKavYbMfaG/UKKE3UjJMVoEj4L8l3qlqfxk0
         gm4DL1nNyRDaLADeo88rtBmzmgQO3JR/tAlA8xElu7thSNHBtvFD593t9tfRAX92xDjI
         WSnQ==
X-Gm-Message-State: AOAM5313Ebvgz8TRY6SzGD52FK8J3FVU+7qVrBDuQ4uGlVxZYb4580Vn
        SBmNgJz3KWiTqZSXOJB/5Fk80g==
X-Google-Smtp-Source: ABdhPJwiN0XXHdkflMLnP3OGR+ZptMLbM44ofV7XUW+Prs0tZqxumVQ+EVPIU7ICfg7NjYmYai6cfw==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr5466462pgb.389.1596236927556;
        Fri, 31 Jul 2020 16:08:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 75sm649022pfx.187.2020.07.31.16.08.43
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
Subject: [PATCH v5 31/36] x86/build: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:15 -0700
Message-Id: <20200731230820.1742553-32-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..f8a5b2333729 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -51,6 +51,10 @@ ifdef CONFIG_X86_NEED_RELOCS
         LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 #
 # Prevent GCC from generating any FP code by mistake.
 #
-- 
2.25.1

