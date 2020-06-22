Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19E82073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jfz8nxtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgFVUxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgFVUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:53:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67371C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so3555650pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=Jfz8nxtlqDdyEUFiNYROIMCvx3CmfLB7i6PghJ1Hi/EURISUOQ/go/6wXg7kWsRNYD
         CEdymigcOLNz1dztI4QdAZRu9I+C66qxkjsJ/hePmRB2EUTooiBBhOhS3fRT899g11PY
         e1r9p/89eFlp4rd1hjPImny24bey3KDGQa2Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=c8DSazTYBp5+9lvq4rR+YK4k4JKGO6Mi+slPeRL3hm/NxVf2RBU6D6iTors7UljwSw
         Cg3PxbfX5FJP5MEE90rR0Vofj2tog3Y0sZv+YwYyKtihNNmKEoT1bttmEaNZrSPajUSo
         2iGc0BNBsRcxSzJq2fRHyHGjJU7LTADEKUlbhpZhVCWwhKz430ZH35UOJvz0lu4dvv+7
         1+b3nzMmv6fAjdz4VPTj80ryAwdcj8dYkhBQ2ehQdWOu7zFM1lEvTGFAUL8dUaaZBwSl
         Jjkbt4HZG5mMojgsQOu2ZCU4LgsPe9hepa7XmtKky9+WbKo5cRQ8Tw+ZCZfXd5/m1OKc
         P6bw==
X-Gm-Message-State: AOAM532NVj46zwMtq6/3zWftz3Xz36I+QXhZb2Zl/pJ6GJsNWJunR9Lw
        XOWkDuqn/QsIJKQzfNDagiiFzw==
X-Google-Smtp-Source: ABdhPJyWBB6BndMTxHuqz2+8/tyBjuTLToAfkoMCHeFnVOD1O3PKDOktg7HbB+hrbiRrwlvZpQKeHA==
X-Received: by 2002:a65:4304:: with SMTP id j4mr14175789pgq.152.1592859228964;
        Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm366797pjd.23.2020.06.22.13.53.46
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
Subject: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:53:41 -0700
Message-Id: <20200622205341.2987797-4-keescook@chromium.org>
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

Add the common debugging sections. Discard the unused note, rel, plt,
dyn, and hash sections that are not needed in the compressed vmlinux.
Disable .eh_frame generation in the linker and enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742f91c9..646720a05f89 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -48,6 +48,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
@@ -59,7 +60,7 @@ else
 KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := --orphan-handling=warn -T
 
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 8f1025d1f681..6fe3ecdfd685 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -75,5 +75,16 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
+
 	DISCARDS
+	/DISCARD/ : {
+		*(.note.*)
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.plt) *(.plt.*)
+		*(.dyn*)
+		*(.hash) *(.gnu.hash)
+	}
 }
-- 
2.25.1

