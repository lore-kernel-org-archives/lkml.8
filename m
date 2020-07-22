Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E15C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA2820737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgGVSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:43:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35024 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGVSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:43:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id 11so3035916qkn.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZMnAY2w7Gsu1RJzqgpSuPL6qVRoQpQhZZvqs4rgs2Q=;
        b=TTwSlw5jTkbU53PqRn1vDcGw2FqezkmcQxUSWwDVmP40ERvNl9L3BgV6P7+WiiPfrF
         yT3Pk0eLVe5o9ZatJrnXpZTETf5ChW8plGQzOEzsAgAhsJXfUYlPcoABhUw1U4J+foJX
         Xb9k1Itcgj8vLhCaKCHq9CXDCe7qoSC+colhTOCyA2JF9w2Gk/IY5NMHkRfZV/Xon/sM
         Z7YlGMcxvVdmiM7rHdUEcXO4K3sT2nldcRqSLdyjlDNVf+3XHjLphjp/4yo351aLeD1t
         iiVTHuTeZLrLPU7QPoUOsOgVQrCPr0bLfuNj+Nb4ItASoT8X5Zo7uAjy1mlaOpTUk3wc
         cPZg==
X-Gm-Message-State: AOAM532U+44sb8hn6VGa6MCCkzQoLilEyBd+hdjNAA28FbTYpwkH0BA9
        SV5gE8Urtn/QJUOWczEwGw5YLzfM
X-Google-Smtp-Source: ABdhPJzRUy/X3SaFV5EFn6YWvEy9RBAmXeflzoksCOu90tF4XY0cwCsVJSerfna6N59ZebO3dsxEyA==
X-Received: by 2002:a37:a746:: with SMTP id q67mr1425580qke.93.1595443415651;
        Wed, 22 Jul 2020 11:43:35 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b2sm547488qkf.122.2020.07.22.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:43:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: Move max-page-size option to LDFLAGS_vmlinux
Date:   Wed, 22 Jul 2020 14:43:34 -0400
Message-Id: <20200722184334.3785418-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is only required for vmlinux on 64-bit, to enforce 2MiB
alignment, so set it in LDFLAGS_vmlinux instead of KBUILD_LDFLAGS. Also
drop the ld-option check: this option was added in binutils-2.18 and all
the other places that use it already don't have the check.

This reduces the size of the intermediate ELF files
arch/x86/boot/setup.elf and arch/x86/realmode/rm/realmode.elf by about
2MiB each. The binary versions are unchanged.

Move the LDFLAGS settings to all be together and just after CFLAGS
settings are done.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/Makefile | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..1e634d7ee6eb 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -47,10 +47,6 @@ export REALMODE_CFLAGS
 # e.g.: obj-y += foo_$(BITS).o
 export BITS
 
-ifdef CONFIG_X86_NEED_RELOCS
-        LDFLAGS_vmlinux := --emit-relocs --discard-none
-endif
-
 #
 # Prevent GCC from generating any FP code by mistake.
 #
@@ -177,17 +173,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
-KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
-
-#
-# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
-# the linker to force 2MB page size regardless of the default page size used
-# by the linker.
-#
-ifdef CONFIG_X86_64
-KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
-endif
-
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -207,6 +192,23 @@ ifdef CONFIG_RETPOLINE
   endif
 endif
 
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+
+ifdef CONFIG_X86_NEED_RELOCS
+LDFLAGS_vmlinux := --emit-relocs --discard-none
+else
+LDFLAGS_vmlinux :=
+endif
+
+#
+# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
+# the linker to force 2MB page size regardless of the default page size used
+# by the linker.
+#
+ifdef CONFIG_X86_64
+LDFLAGS_vmlinux += -z max-page-size=0x200000
+endif
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
-- 
2.26.2

