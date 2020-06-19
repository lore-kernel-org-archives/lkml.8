Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B0820B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581659;
	bh=OnMZ5vdf2YOk5hWtwLFzh1/pxKKBakX8EVWv9pl+oRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6Q7J4uw4+0cxdWBvQL4vgjv30xJABQl8uSdITZLRwIkUeqduiEYcIe8EzBaXa3Nh
	 Owv79Kk/wz4Y1SbXcHoRJPRZFa3qeuHDoz8ztsEB4V1HIPAT5Tc1eFABT7QVJRYDGp
	 4Hud+JbaQNPMY93AvBuf+m0DsdqTnYX994j1NXCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404198AbgFSPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393154AbgFSPXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979D62158C;
        Fri, 19 Jun 2020 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580196;
        bh=OnMZ5vdf2YOk5hWtwLFzh1/pxKKBakX8EVWv9pl+oRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhnUcrjfHpBDnN63yOzX2ew05qiJHS4lgbkLAHO9LA9EMco3rwqTjLDyufcaofz7N
         M3/w1NkFc2AZq/VZrAcUt1xEygQC3HGbXytF3z5tlOC5NOxggvH3Wotndvh9GdtWJ6
         TeAt9YsSw3tWCiK46OG+QQxPfy2xWFdvMEswTI68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 159/376] MIPS: Truncate link address into 32bit for 32bit kernel
Date:   Fri, 19 Jun 2020 16:31:17 +0200
Message-Id: <20200619141717.847551466@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit ff487d41036035376e47972c7c522490b839ab37 ]

LLD failed to link vmlinux with 64bit load address for 32bit ELF
while bfd will strip 64bit address into 32bit silently.
To fix LLD build, we should truncate load address provided by platform
into 32bit for 32bit kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/786
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25784
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Makefile                 | 13 ++++++++++++-
 arch/mips/boot/compressed/Makefile |  2 +-
 arch/mips/kernel/vmlinux.lds.S     |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e1c44aed8156..b6ee29e4565a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -288,12 +288,23 @@ ifdef CONFIG_64BIT
   endif
 endif
 
+# When linking a 32-bit executable the LLVM linker cannot cope with a
+# 32-bit load address that has been sign-extended to 64 bits.  Simply
+# remove the upper 32 bits then, as it is safe to do so with other
+# linkers.
+ifdef CONFIG_64BIT
+	load-ld			= $(load-y)
+else
+	load-ld			= $(subst 0xffffffff,0x,$(load-y))
+endif
+
 KBUILD_AFLAGS	+= $(cflags-y)
 KBUILD_CFLAGS	+= $(cflags-y)
-KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
+KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y) -DLINKER_LOAD_ADDRESS=$(load-ld)
 KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
+		  LINKER_LOAD_ADDRESS=$(load-ld) \
 		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
 		  PLATFORM="$(platform-y)" \
 		  ITS_INPUTS="$(its-y)"
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 0df0ee8a298d..6e56caef69f0 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -90,7 +90,7 @@ ifneq ($(zload-y),)
 VMLINUZ_LOAD_ADDRESS := $(zload-y)
 else
 VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
-		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
+		$(obj)/vmlinux.bin $(LINKER_LOAD_ADDRESS))
 endif
 UIMAGE_LOADADDR = $(VMLINUZ_LOAD_ADDRESS)
 
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index a5f00ec73ea6..f185a85a27c1 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -55,7 +55,7 @@ SECTIONS
 	/* . = 0xa800000000300000; */
 	. = 0xffffffff80300000;
 #endif
-	. = VMLINUX_LOAD_ADDRESS;
+	. = LINKER_LOAD_ADDRESS;
 	/* read-only */
 	_text = .;	/* Text and read-only data */
 	.text : {
-- 
2.25.1



