Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3EEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84AF2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esMzQ+n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgFVUx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgFVUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:53:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so8104576pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J12VhRTqgJpmi5aYvdeNr1OD+w8Og3rd0GL/+L6WxZo=;
        b=esMzQ+n+iXtc2PIo7G5WhjLWzlwEQEWTnCn0jc9M+bhYvDiN4ly8dmxAjMb3Kwrg16
         L4kMSTHpsg1ezuqUefpd8pqIghBhrMNzKuoKmzxSU56QEqkx+3cHzNYhUqh1W+Bw5mfz
         D8sHnkXFijfR4LE2WqHLOdz1N4+fc/D40hTpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J12VhRTqgJpmi5aYvdeNr1OD+w8Og3rd0GL/+L6WxZo=;
        b=M52sqObVgejCWq4VgvPFbFAnl0L4sz9Zu8d05SaqEptcyXoJL2sKQv0RhYUpnXvbf1
         sMCPhbJZ7MblUC0yUEn6lVZcOdOVC0Guwn4KxFBW3i+p55DlAlBVY3++THrM/UposcuA
         NJ2GZM9FHvnuTFVOcxfC0uHr0FtRNWjEV1bz/ijujPvKH5rz0BVPH3sGw/M6QJbZ659t
         wAITLJsPdAFORu1Gtu8gE15e7ll9wJeVh3BoYblqqUqdyj0a8Dy5XXQrhMWiPTL4Tqlf
         HCkazyN27YkN50JT5kPqB//Oa7q/92S/majHQNl1862jUQnTOtriX3r/AldMKuMpjHyq
         J5qA==
X-Gm-Message-State: AOAM531Q+f4CQg+KdknL31XQKsSjHWVASxsvNzPHzEmqMumXWtCt3UmT
        H8LiKDlvYzkq74qQwdSu7LOTkg==
X-Google-Smtp-Source: ABdhPJzxIixGhRmJRuCdpYzXTAIrYew4FUikqBsMrvCmf1HSmpK9qo0lZm21eNG5rQSBCMARl+qkAQ==
X-Received: by 2002:a17:90a:2461:: with SMTP id h88mr20910740pje.180.1592859228184;
        Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm15052964pfr.89.2020.06.22.13.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] x86/build: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:53:40 -0700
Message-Id: <20200622205341.2987797-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205341.2987797-1-keescook@chromium.org>
References: <20200622205341.2987797-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Discards the unused rela, plt, and got sections that are not needed
in the final vmlinux, and enable orphan section warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile             | 4 ++++
 arch/x86/kernel/vmlinux.lds.S | 6 ++++++
 2 files changed, 10 insertions(+)

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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..bb085ceeaaad 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -412,6 +412,12 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.got) *(.got.*)
+		*(.igot.*) *(.iplt)
+	}
 }
 
 
-- 
2.25.1

