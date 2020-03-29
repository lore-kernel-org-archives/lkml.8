Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E20C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824F9206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="foiZtoQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgC2SnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:10 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34786 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC2SnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:10 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3EF795C0870;
        Sun, 29 Mar 2020 20:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1585507388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=lnu+KMdllhKFSlzHplG4kJn5iW0F84lGeX1xzZIYAts=;
        b=foiZtoQOanmpdsMLM7SK+Zq7g/PZANc15HdoUTRqh11ZXs6xG/hcNgTzKX9K3M3dzSQl+B
        E0s3+n6Y6SAAYDbC7tfRDGKSsqrApx10VlZuX4uqzEm8WNv4VqtqZg0ZcwHiKOqCWC9+Q+
        BGbSPocVZYMxBX8j6qjL6Jd9Be7VxT8=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] ARM: warn if pre-UAL assembler syntax is used
Date:   Sun, 29 Mar 2020 20:43:04 +0200
Message-Id: <a651d5eaf312c771c9d2e0160ddd905550bbd4e3.1585507235.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the -mno-warn-deprecated assembler flag to make sure the GNU
assembler warns in case non-unified syntax is used.

This also prevents a warning when building with Clang and enabling its
integrated assembler:
clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'

GCC before 5.1 emits pre-UAL assembler. This can lead to warnings if
inline assembler explicitly switches to unified syntax by using the
".syntax unified" directive (e.g. arch/arm/include/asm/unified.h).
Hence keep the flag for GCC versions before 5.1.

This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
divided syntax assembler is used") which has subsequently been reverted
with commit b752bb405a13 ("Revert "ARM: 8846/1: warn if divided syntax
assembler is used"").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Reference revert commit b752bb405a13 ("Revert "ARM: 8846/1: warn if
  divided syntax assembler is used"")
- Reword commit message

 arch/arm/Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1fc32b611f8a..b37bb985a3c2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -119,21 +119,25 @@ ifeq ($(CONFIG_CC_IS_CLANG),y)
 CFLAGS_ABI	+= -meabi gnu
 endif
 
-# Accept old syntax despite ".syntax unified"
-AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
-
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
-CFLAGS_ISA	:=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=-mthumb -Wa,-mimplicit-it=always
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 KBUILD_CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
-CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=$(call cc-option,-marm,)
 AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
+ifeq ($(CONFIG_CC_IS_GCC),y)
+ifeq ($(call cc-ifversion, -lt, 0501, y), y)
+# GCC <5.1 emits pre-UAL code and causes assembler warnings, suppress them
+CFLAGS_ISA	+=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
+endif
+endif
+
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
-- 
2.25.1

