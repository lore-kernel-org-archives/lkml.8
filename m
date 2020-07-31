Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B091F2076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnbNKX0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgGaXS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGaXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32EC06179F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so8525731pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkeFoLe4SBoT15Xnwf3OcmbBPE6+tbLBkxS1vM74EoU=;
        b=lnbNKX0yrfuIRdUZJkjGlbRNTiMhvfwxVpXDYRKv1uYsZkZJQBZ1H1ftIvtEueMK4i
         EZzAYJIVCHb4H0GrV5BR0w8igFvwwXmNSxL7atkIcoZ9mdukob58OhhDld9wiWglZIS7
         sG3JyHqFSitYo4Uw21wClTSyR/gc5iFGYXNV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkeFoLe4SBoT15Xnwf3OcmbBPE6+tbLBkxS1vM74EoU=;
        b=B9mgpuM6WW15JU3YXKYDF3a+zhNSvjB9irMl7dGk89IHc2yWrvULWFBKsQdjsfh966
         mpOhJvVAclb80PSqKZYzVimvfXkRFZiSS1HRql7iUbQZ5ofcnWH+TJyNZ1SmAHXaDGOu
         TBz6Aqp068KoIYCOC7UCSYwH24vhsI7v6KbLYT8yWDd7UGhMJnH3TCbQ37doudCO4aQa
         J3bZVO0/NIqCMxj4HGELLk2rx28ufe0HU75TKbA2N6Wvta2hQH+dz9ZrtJf7OQxpV9wQ
         UwuLaWmoPQyHABjruKxy3fzLXMDOWwdR4OQqrUx5LszUV2WVdVk97mU7EcrhTAXW9fuP
         3fNQ==
X-Gm-Message-State: AOAM531u23rFf8HpawiJGuHBe4pSTyQ+KUWrf8IgHCobkIcs5TLUx80r
        29ibW+xtZVs6t7UcVTcCTVcKxw==
X-Google-Smtp-Source: ABdhPJxILplFvERkTSctzaRflUxc3IVVLOxINDM9NY6mYXCEnZnb7CLsaGfG3zaF7BD2qx8JDb7lTw==
X-Received: by 2002:a17:902:a610:: with SMTP id u16mr3670388plq.197.1596237498722;
        Fri, 31 Jul 2020 16:18:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g15sm4473924pfh.70.2020.07.31.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 23/36] arm/build: Explicitly keep .ARM.attributes sections
Date:   Fri, 31 Jul 2020 16:08:07 -0700
Message-Id: <20200731230820.1742553-24-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn, explicitly keep the
.ARM.attributes section by expanding the existing ELF_DETAILS macro into
ARM_DETAILS.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 4 ++++
 arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
 arch/arm/kernel/vmlinux.lds.S      | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index a08f4301b718..c4af5182ab48 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -52,6 +52,10 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		COMMON_DISCARDS
 
+#define ARM_DETAILS							\
+		ELF_DETAILS						\
+		.ARM.attributes 0 : { *(.ARM.attributes) }
+
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 904c31fa20ed..57fcbf55f913 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,7 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index bb950c896a67..1d3d3b599635 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,7 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

