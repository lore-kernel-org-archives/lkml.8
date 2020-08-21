Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401D920738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GF8WNGGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHUTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHUTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:44:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79898C06138F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t6so1254915pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SO+UGcbCrLenHkErAflqsGtJX/MLOFJ7NqTGBJ73x8=;
        b=GF8WNGGbz0L91U/cKK8hFCLiRU4GwBwG4dOQCTOrpJCd24QY/0vGi6vnGJMoYwqo9j
         tg5x5+RDELdR2JEO4trH7JtQZw3eWL1PnG0VNMUjRiMWm8/9k2VtuwglST1tWIBAWTS1
         P+x+GSWOlYP3io7XqFUjxcgSnBkW/qZP7U2eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SO+UGcbCrLenHkErAflqsGtJX/MLOFJ7NqTGBJ73x8=;
        b=blA97oGORqv7EJ/jJjR48V9OxbgwxLBtSNIi72JfaYJ6QhONlEHNn87zpVE9JfuAbq
         5KwEROKM1M46oO1RlSK3fzYWbJIrXoNNRRXje86r4EJkWWrWrsRGlAQEXtiS7KB4NbOx
         cJkoBGyC6RXD4Q7XfAV2aZCwm0aPFIVveDuzr32lrVmzuufbCmLE9OY9IxvMDBiE/DAE
         16R1VtCbjWXfc7k6q1S96tlnvT51kpGFNkwPaD/c1K1Iy5UNAUJBHOAfFxf5+DRgMu2W
         EdmTBSi9NcZ1TXSYZLQpm3fA+KdMLLT4O//RCd73yZHE0OfweD+BSy+ufjEitKLRSeTr
         uigg==
X-Gm-Message-State: AOAM531rr0g/LXarqyKqmogve1CdnSPgQZoyTs9/ac8KgE2DukautIIW
        L5Xs33Q1wwN1S0MS+a+/TyaPyg==
X-Google-Smtp-Source: ABdhPJzikcTbC/fNRsbXZsG6J+yKOcBq9l6HMfMb0yjrQqmgOT0JeBslBYouM6YVYP4aQU9tg4bQUA==
X-Received: by 2002:a17:902:d691:: with SMTP id v17mr3392145ply.235.1598039071121;
        Fri, 21 Aug 2020 12:44:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o66sm2795858pgo.25.2020.08.21.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
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
Subject: [PATCH v6 18/29] arm/build: Assert for unwanted sections
Date:   Fri, 21 Aug 2020 12:42:59 -0700
Message-Id: <20200821194310.3089815-19-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for warning on orphan sections, enforce
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 11 +++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S  |  2 ++
 arch/arm/kernel/vmlinux.lds.S      |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 6624dd97475c..4a91428c324d 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -52,6 +52,17 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		COMMON_DISCARDS
 
+/*
+ * Sections that should stay zero sized, which is safer to explicitly
+ * check instead of blindly discarding.
+ */
+#define ARM_ASSERTS							\
+	.plt : {							\
+		*(.iplt) *(.rel.iplt) *(.iplt) *(.igot.plt)		\
+	}								\
+	ASSERT(SIZEOF(.plt) == 0,					\
+	       "Unexpected run-time procedure linkages detected!")
+
 #define ARM_DETAILS							\
 		ELF_DETAILS						\
 		.ARM.attributes 0 : { *(.ARM.attributes) }
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 11ffa79751da..50136828f5b5 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -152,6 +152,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index dc672fe35de3..5f4922e858d0 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -151,6 +151,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

