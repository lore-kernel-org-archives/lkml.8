Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C538C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CFA2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/dR2Xzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgG3NZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgG3NZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:25:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC99C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:25:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so14344096wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUEiWZ9pO6UikEPfnSxWzM8COZBi2CR+f41vrCc2PbU=;
        b=G/dR2XzgwW5YtNdUxo7l6BrOSY8dlaYGR3bL6VO/Qt+dAQs46+Fzql3lsSJws7Ri4K
         rmU53JAod/zYnRODSPbMlaQo/8wdoxS+NhVSLUnbEdnX33Cnthrx5VCzfsKRS1cZrrZr
         bYkGxpJpV0ADVvKBgCgabzkJBiMLxlR9IaD0CnCip0jLeZaVkNIJ8ztHFDgrknltpQEu
         Qcy1/uXwU4UYBxPcAWWpYYyyQZf+BnIArF6YasmLRsCp+UznJe2+UrgHjb1GAVK/dFSB
         qq2aPX3+QhJtfjDWYK7IYVoTZVQ3VNW2kh6sWOEz9cZryUZTFgMQAw7XrR3xsd3hm9VP
         dfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUEiWZ9pO6UikEPfnSxWzM8COZBi2CR+f41vrCc2PbU=;
        b=q9BGkSIO70jRh88MbRFZ5XJd/+Q1LJe6zpiZ4WGC2zi4Aqj043TniNcdmYlU9UNtZd
         rvxpr00Lm+a5muTESj+gGEmEXz3MLTe96l+hh/9wCm9BmJJ2U/gzQtSN+32SvtTI4Y86
         niC5G/J1CzRgMPfBcLagrBmNcJsu55T/2PAskgWBI5cQvLz9WgrPH3cbqUIn5iGNFFQE
         jovPKw1zjjpTvtQ6ju+llpwmRx4takoYrATTTOEYpMFgGV2ENDKDcoAkthe1d6MZhSuw
         OnYKHclqwlQv8JFq1PoBLqhxbfi/APJhtPP3v1ZLj3ZPOYxXV2uuhxyiTity7bR6yOGe
         mY8g==
X-Gm-Message-State: AOAM530KgdLRl/BQT2t3+T5UTJMeu7JKV7iQdlstA9kPg9gTIlEzaD2j
        j2NImmG8kWcqhLX3Ym8H/xjplw==
X-Google-Smtp-Source: ABdhPJxUh0JNkpM1blwpstAX29yKD5NnvCsKPNTg2SbOEjWPbmwEW4f53P8bEqqdzEpR20ArFW0tjw==
X-Received: by 2002:adf:94c5:: with SMTP id 63mr2776837wrr.34.1596115524080;
        Thu, 30 Jul 2020 06:25:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b4ef:bd7f:473a:9fdf])
        by smtp.gmail.com with ESMTPSA id b142sm6483931wmd.19.2020.07.30.06.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:25:22 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        android-kvm@google.com, kernel-team@google.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH] KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text
Date:   Thu, 30 Jul 2020 14:25:19 +0100
Message-Id: <20200730132519.48787-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some compilers may put a subset of generated functions into '.text.*'
ELF sections and the linker may leverage this division to optimize ELF
layout. Unfortunately, the recently introduced HYPCOPY command assumes
that all executable code (with the exception of specialized sections
such as '.hyp.idmap.text') is in the '.text' section. If this
assumption is broken, code in '.text.*' will be merged into kernel
proper '.text' instead of the '.hyp.text' that is mapped in EL2.

To ensure that this cannot happen, insert an OBJDUMP assertion into
HYPCOPY. The command dumps a list of ELF sections in the input object
file and greps for '.text.'. If found, compilation fails. Tested with
both binutils' and LLVM's objdump (the output format is different).

GCC offers '-fno-reorder-functions' to disable this behaviour. Select
the flag if it is available. From inspection of GCC source (latest
Git in July 2020), this flag does force all code into '.text'.
By default, GCC uses profile data, heuristics and attributes to select
a subsection.

LLVM/Clang currently does not have a similar optimization pass. It can
place static constructors into '.text.startup' and it's optimizer can
be provided with profile data to reorder hot/cold functions. Neither
of these is applicable to nVHE hyp code. If this changes in the future,
the OBJDUMP assertion should alert users to the problem.

Patch based off kvmarm/next (commit a394cf6e85).

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 0b34414557d6..aef76487edc2 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -20,10 +20,30 @@ $(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
 $(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
 	$(call if_changed,hypcopy)
 
+# Disable reordering functions by GCC (enabled at -O2).
+# This pass puts functions into '.text.*' sections to aid the linker
+# in optimizing ELF layout. See HYPCOPY comment below for more info.
+ccflags-y += $(call cc-option,-fno-reorder-functions)
+
+# The HYPCOPY command uses `objcopy` to prefix all ELF symbol names
+# and relevant ELF section names to avoid clashes with VHE code/data.
+#
+# Hyp code is assumed to be in the '.text' section of the input object
+# files (with the exception of specialized sections such as
+# '.hyp.idmap.text'). This assumption may be broken by a compiler that
+# divides code into sections like '.text.unlikely' so as to optimize
+# ELF layout. HYPCOPY checks that no such sections exist in the input
+# using `objdump`, otherwise they would be linked together with other
+# kernel code and not memory-mapped correctly at runtime.
 quiet_cmd_hypcopy = HYPCOPY $@
-      cmd_hypcopy = $(OBJCOPY)	--prefix-symbols=__kvm_nvhe_		\
-				--rename-section=.text=.hyp.text	\
-				$< $@
+      cmd_hypcopy =							\
+	if $(OBJDUMP) -h $< | grep -F '.text.'; then			\
+		echo "$@: function reordering not supported in nVHE hyp code" >&2; \
+		/bin/false;						\
+	fi;								\
+	$(OBJCOPY) --prefix-symbols=__kvm_nvhe_				\
+		   --rename-section=.text=.hyp.text			\
+		   $< $@
 
 # Remove ftrace and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-- 
2.28.0.163.g6104cc2f0b6-goog

