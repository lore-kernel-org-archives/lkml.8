Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE30C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CB0246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="aTYpnGkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgB1ATc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:19:32 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:51112 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbgB1ATc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:19:32 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DA5AB5C0103;
        Fri, 28 Feb 2020 01:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1582849170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=TIjae1yYHkhLUHlgAhQROPT7jyNpin+f5lZbY7zzkps=;
        b=aTYpnGkw3RWTSB31SifTZL0yjsMbDJz69Z0gy8uGkXyuSWk6m/KKz7XX5WmjZXgckfOZ3M
        qIfbPbE+1/RTZLIaVEfUpJjmSnl73LlsKSG/up6bKoNJ6bIsy76oDV/pLXp/hZbQhPn/QZ
        OPQzYoE5HuJItobQd5M3WVtI/aC/aIA=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, yamada.masahiro@socionext.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: warn if pre-UAL assembler syntax is used
Date:   Fri, 28 Feb 2020 01:19:22 +0100
Message-Id: <cd74f11eaee5d8fe3599280eb1e3812ce577c835.1582849064.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the -mno-warn-deprecated assembler flag for GCC versions newer
than 5.1 to make sure the GNU assembler warns in case non-unified
syntax is used.

This also prevents a warning when building with Clang and enabling
its integrated assembler:
clang-10: error: unsupported argument '-mno-warn-deprecated' to option 'Wa,'

This is a second attempt of commit e8c24bbda7d5 ("ARM: 8846/1: warn if
divided syntax assembler is used").

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..a6c8c9f39185 100644
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

