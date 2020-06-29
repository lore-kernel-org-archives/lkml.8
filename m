Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A157C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C632065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T04fL7iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbgF2Uui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731441AbgF2TNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D969C08EB15
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so2797200pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLLAJpxJCKF6GpXYjiXBbb2388G9eZDwIJVZRHrbyec=;
        b=T04fL7iRnuJApQe2EOioew1j5Rlr2BMoJuzctdqWei6PMaoDnLB/LdaL5P+9eTJj3D
         hrhcKHRUxkUBOU51xp8O7g+QcmVnD4KGJx8EsFA75GwrbM5HkoASL8Vcva2ox1Rzzz8T
         u3NLRFeCUaao3XeiyLsPIVvzOAhdDEbGOuEs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLLAJpxJCKF6GpXYjiXBbb2388G9eZDwIJVZRHrbyec=;
        b=psq8nNzQWx2CWglKhrBMjeeFqjy5LMXPcsBEXwT4I5ZWINZ2J0uCLUwPemicb2oEPV
         I1iLbBLJKtxdQFm28UzvjyaBjeJjiZ8U/u8SPuOJLbHhSYW6dSJtiWaNkctNcqtGmrjq
         Y4zUIYzltScL7QjZptEbDHR44SpN1HkaxTa6NqjSshVT2c1IKE0pfIimQlfEJz+i112+
         Q9a2UwT0MR8rWUM4TmDfzsRxVTlO2knVh6xt1HUohV2hgR6qGF9SCjEfL8Xhu8zlXYoB
         R9+YqmqVLNcC7cgrmffHOxMOr+RjDQws42bGLt+KURv+z0RNjj2Bv9kYKtBX9BBFKzgC
         JkAg==
X-Gm-Message-State: AOAM533fp7/mkgVomCHmEVI0MiUgvEz/god6mMGr6xrc3qgk/WEYV3jV
        v0vbQB3EEbbjk4NZETcSy3srZg==
X-Google-Smtp-Source: ABdhPJwNjvgfAOOh8VJ+onDG+dXJz2yzAp0DTMkKIotRBmI0ZoNMLyWXjjtPuqVD4FTZ8qL5j5J1DA==
X-Received: by 2002:a17:90a:ed87:: with SMTP id k7mr5586555pjy.31.1593411534865;
        Sun, 28 Jun 2020 23:18:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm4460965pfb.190.2020.06.28.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:37 -0700
Message-Id: <20200629061840.4065483-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
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

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.

Add missing text stub sections .vfp11_veneer and .v4_bx.

Add debug sections explicitly.

Finally enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 6 +++++-
 arch/arm/kernel/vmlinux-xip.lds.S  | 1 +
 arch/arm/kernel/vmlinux.lds.S      | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index c66b16cd8837..d44fae722e7a 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -39,6 +39,8 @@
 		__idmap_text_end = .;					\
 
 #define ARM_COMMON_DISCARD						\
+		*(.iplt) *(.rel.iplt) *(.igot.plt)                      \
+		*(.modinfo)                                             \
 		*(.discard)						\
 		*(.discard.*)
 
@@ -63,7 +65,9 @@
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
-		*(.glue_7t)
+		*(.glue_7t)						\
+		*(.vfp11_veneer)                                        \
+		*(.v4_bx)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 57fcbf55f913..11ffa79751da 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,6 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1d3d3b599635..dc672fe35de3 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
-- 
2.25.1

