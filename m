Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CAC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66652070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587472376;
	bh=LNZcHtjoWqylzeMnuv6UArID5puekmZyNjD3Fj7p+VQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kKPxm7Re37nZiBOCziE+JACXeTXgZa5xWMFUPq4cUgKN2Tw65NPC5BoDbzh8IRS0h
	 1McZ1S2jE5ukji2WsIAUkhkNoLBg3Y7TGoRD73tbvLOx+JnhpAHRnzz4KXc7I7lEkT
	 1Pj8UIsxQUP5QzP3qOgctXMcD3f+XZJxLc7sQZ/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgDUMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:32:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:65215 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgDUMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:32:55 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 03LCWTRG015942;
        Tue, 21 Apr 2020 21:32:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 03LCWTRG015942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587472350;
        bh=0/WpwSdCDKFUy0QKnGd6kunc4ELKUfh3X/2O2KfXcik=;
        h=From:To:Cc:Subject:Date:From;
        b=X2aHtr3YOdlWkBV2SK7VV1M028a+j1LTV4KNGToKlGQwnDkaD7OCRRllpZBKPrjCV
         sUR0ZGrKynik2GsO43gN7nj3gibq3lLwV3nZI5OPlv1H/j6eCJx7sO0vK7JgaEobD7
         DbMkJuR1rXLTe7PVUE6kFkP14L6w73GClrTIEvD9NLcqZaZ/H6Ek8yrw0puVcEAd+U
         jBQwn1OuoiYCRNs6SK5goRbcdI1MUoEr+bxG7YsHhVZ0nyAlsRq0Rha5OE41bvum8x
         iRCUt5MaJb4hYfJrzMmpVDAaODW6Q5iinyS2xmutgkDrsdO3mc5fvWXhoZvTxLBCva
         whipeyPUCBOxA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: ensure full rebuild when the compiler is updated
Date:   Tue, 21 Apr 2020 21:32:26 +0900
Message-Id: <20200421123227.1270021-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21c54b774744 ("kconfig: show compiler version text in the top
comment") added the environment variable, CC_VERSION_TEXT in the comment
of the top Kconfig file. It can detect the compiler update, and invoke
the syncconfig because all environment variables referenced in Kconfig
files are recorded in include/config/auto.conf.cmd

This commit makes it a CONFIG option in order to ensure the full rebuild
when the compiler is updated.

This works like as follows:

include/config/kconfig.h contains "CONFIG_CC_VERSION_TEXT" in the comment
block.

The top Makefile specifies "-include $(srctree)/include/linux/kconfig.h"
to guarantee it is included from all kernel source files.

fixdep parses every source file and all headers included from it,
searching for words prefixed with "CONFIG_". Then, fixdep finds
CONFIG_CC_VERSION_TEXT in include/config/kconfig.h and adds
include/config/cc/version/text.h into every .*.cmd file.

When the compiler is updated, syncconfig is invoked since the environment
variable is referenced. CONFIG_CC_VERSION_TEXT is updated to the new
version string, and include/config/cc/version/text.h is touched.

In the next rebuild, Make rebuilds every files since the timestamp of
include/config/cc/version/text.h is newer than that of target.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Kconfig                 |  2 --
 include/linux/kconfig.h |  9 +++++++++
 init/Kconfig            | 12 ++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index e10b3ee084d4..745bc773f567 100644
--- a/Kconfig
+++ b/Kconfig
@@ -5,8 +5,6 @@
 #
 mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
 
-comment "Compiler: $(CC_VERSION_TEXT)"
-
 source "scripts/Kconfig.include"
 
 source "init/Kconfig"
diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index cc8fa109cfa3..406b8a2521b5 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -2,6 +2,15 @@
 #ifndef __LINUX_KCONFIG_H
 #define __LINUX_KCONFIG_H
 
+/*
+ * Do not remove this comment block. This contains "CONFIG_CC_VERSION_TEXT"
+ * to ensure the full rebuild when the compiler is updated.
+ *
+ * fixdep parses this header, which is included by every kernel source file,
+ * and adds include/config/cc/version/text.h to the dependency in .*.cmd files.
+ * When the compiler is updated, syncconfig touches it so every file is rebuilt.
+ */
+
 #include <generated/autoconf.h>
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..d3d153815d88 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -8,6 +8,18 @@ config DEFCONFIG_LIST
 	default "/boot/config-$(shell,uname -r)"
 	default "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)"
 
+config CC_VERSION_TEXT
+	string
+	default "$(CC_VERSION_TEXT)"
+	help
+	  There two purposes for this entry:
+
+	  1. Reference the environment variable, CC_VERSION_TEXT, so Kconfig
+	     is invoked if the compiler is updated.
+
+	  2. Touch include/config/cc/version/text.h to force the full rebuild
+	     if the compiler is updated. See comment in include/linux/kconfig.h
+
 config CC_IS_GCC
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
 
-- 
2.25.1

