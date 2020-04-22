Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B88C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA6C206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587561038;
	bh=mCgm7sg8LoJLYGvul4DAH7mlYc5o+KQw9isaAM1qheY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fq2gBWUUpJKx6E5s6Y8XAT+3xIcfayngz/QzmoXFP5vA0cMOdWhsh4OQgldxmLLcI
	 GX/8iHGFpwRbjZ6IlVk6U89Jk1q+thqbn//+8MomcNio/6KuuKG7B0cifEO/9y4lAf
	 pbwC7zke/xDNxUBKc6yPv3apwR7tuyrbEirGC0HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDVNKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:10:37 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:16560 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgDVNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:10:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03MD8x96009223;
        Wed, 22 Apr 2020 22:08:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03MD8x96009223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587560940;
        bh=1h+5WOdcGCILcj79RbmcoYpO2NyfzYxPIDDrsK88Yh0=;
        h=From:To:Cc:Subject:Date:From;
        b=v2zxq8h59yFjiZAjQIP0PpkKsSMeVJM9FEc8GC0PfFZYoJatRGkPrIhroWkg+9+3t
         frgpJBQT1vBmoONVqSD17p9FVhmQhKZiRYvQc9YZsNtoGy6ZGk7I8j/YNyfjcH+7pJ
         vTK4e/tQzIU2WNu0yrpmKbxlv08Ab2PVoG9gJBYNnWHzbkXS5J00b+1ED+yVq/GC+h
         XfVnUngpS6aIqGz0MScU4yYk30/gqInCYSoUnXvidXXZdHWdZM+PIHUKDohViutuAu
         ylcOuDOEkcXBXrkPnLFhq52vV/NHniG0AK5+cKUaFbIvaTL07C9lwXp4rp5qzp2nql
         XFWJDnWD6N/TQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] ARM: decompressor: simplify libfdt builds
Date:   Wed, 22 Apr 2020 22:08:53 +0900
Message-Id: <20200422130853.1907809-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copying source files during the build time may not end up with
as clean code as expected.

lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
nicely. Let's follow this approach for the arm decompressor, too.

Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
the Makefile messes. Another nice thing is we no longer need to
maintain the own libfdt_env.h because the decompressor can include
<linux/libfdt_env.h>.

There is a subtle problem when generated files are turned into
check-in files.

When you are doing a rebuild of an existing object tree with O=
option, there exists stale "shipped" copies that the old Makefile
implementation created. The build system ends up with compiling the
stale generated files because Make searches for prerequisites in the
current directory, i.e. $(objtree) first, and then the directory
listed in VPATH, i.e. $(srctree).

To mend this issue, I added the following code:

  ifdef building_out_of_srctree
  $(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
  endif

This will need to stay for a while because "git bisect" crossing this
commit, otherwise, would result in a build error.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---
KernelVersion: v5.7-rc1

Changes in v5:
  - change Makefile slightly for Geert's work

Changes in v4:
  - rebased on v5.7-rc1

Changes in v3:
  - remove stale generated

Changes in v2:
  - fix build error

 arch/arm/boot/compressed/.gitignore     |  9 ------
 arch/arm/boot/compressed/Makefile       | 38 ++++++++++---------------
 arch/arm/boot/compressed/atags_to_fdt.c |  1 +
 arch/arm/boot/compressed/fdt.c          |  2 ++
 arch/arm/boot/compressed/fdt_ro.c       |  2 ++
 arch/arm/boot/compressed/fdt_rw.c       |  2 ++
 arch/arm/boot/compressed/fdt_wip.c      |  2 ++
 arch/arm/boot/compressed/libfdt_env.h   | 24 ----------------
 8 files changed, 24 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/boot/compressed/fdt.c
 create mode 100644 arch/arm/boot/compressed/fdt_ro.c
 create mode 100644 arch/arm/boot/compressed/fdt_rw.c
 create mode 100644 arch/arm/boot/compressed/fdt_wip.c
 delete mode 100644 arch/arm/boot/compressed/libfdt_env.h

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index db05c6ef3e31..60606b0f378d 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -7,12 +7,3 @@ hyp-stub.S
 piggy_data
 vmlinux
 vmlinux.lds
-
-# borrowed libfdt files
-fdt.c
-fdt.h
-fdt_ro.c
-fdt_rw.c
-fdt_wip.c
-libfdt.h
-libfdt_internal.h
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 9c11e7490292..00602a6fba04 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -76,29 +76,30 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
-# Borrowed libfdt files for the ATAG compatibility mode
-
-libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
-libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
-
-libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
-
-$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
-	$(call cmd,shipped)
-
-$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
-	$(addprefix $(obj)/,$(libfdt_hdrs))
+libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
 ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
 OBJS	+= $(libfdt_objs) atags_to_fdt.o
 endif
 
+# -fstack-protector-strong triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
+$(foreach o, $(libfdt_objs) atags_to_fdt.o, \
+	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))
+
+# These were previously generated C files. When you are building the kernel
+# with O=, make sure to remove the stale files in the output tree. Otherwise,
+# the build system wrongly compiles the stale ones.
+ifdef building_out_of_srctree
+$(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
+endif
+
 targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 lib1funcs.o ashldi3.o bswapsdi2.o \
 		 head.o $(OBJS)
 
-clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
-		$(libfdt) $(libfdt_hdrs) hyp-stub.S
+clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
@@ -107,15 +108,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-# -fstack-protector-strong triggers protection checks in this code,
-# but it is being used too early to link to meaningful stack_chk logic.
-nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
-CFLAGS_atags_to_fdt.o := $(nossp-flags-y)
-CFLAGS_fdt.o := $(nossp-flags-y)
-CFLAGS_fdt_ro.o := $(nossp-flags-y)
-CFLAGS_fdt_rw.o := $(nossp-flags-y)
-CFLAGS_fdt_wip.o := $(nossp-flags-y)
-
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
 	     -I$(obj) $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
 asflags-y := -DZIMAGE
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 64c49747f8a3..8452753efebe 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/libfdt_env.h>
 #include <asm/setup.h>
 #include <libfdt.h>
 
diff --git a/arch/arm/boot/compressed/fdt.c b/arch/arm/boot/compressed/fdt.c
new file mode 100644
index 000000000000..f8ea7a201ab1
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/fdt.c"
diff --git a/arch/arm/boot/compressed/fdt_ro.c b/arch/arm/boot/compressed/fdt_ro.c
new file mode 100644
index 000000000000..93970a4ad5ae
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_ro.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/fdt_ro.c"
diff --git a/arch/arm/boot/compressed/fdt_rw.c b/arch/arm/boot/compressed/fdt_rw.c
new file mode 100644
index 000000000000..f7c6b8b7e01c
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_rw.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/fdt_rw.c"
diff --git a/arch/arm/boot/compressed/fdt_wip.c b/arch/arm/boot/compressed/fdt_wip.c
new file mode 100644
index 000000000000..048d2c7a088d
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_wip.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/fdt_wip.c"
diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
deleted file mode 100644
index 6a0f1f524466..000000000000
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ARM_LIBFDT_ENV_H
-#define _ARM_LIBFDT_ENV_H
-
-#include <linux/limits.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <asm/byteorder.h>
-
-#define INT32_MAX	S32_MAX
-#define UINT32_MAX	U32_MAX
-
-typedef __be16 fdt16_t;
-typedef __be32 fdt32_t;
-typedef __be64 fdt64_t;
-
-#define fdt16_to_cpu(x)		be16_to_cpu(x)
-#define cpu_to_fdt16(x)		cpu_to_be16(x)
-#define fdt32_to_cpu(x)		be32_to_cpu(x)
-#define cpu_to_fdt32(x)		cpu_to_be32(x)
-#define fdt64_to_cpu(x)		be64_to_cpu(x)
-#define cpu_to_fdt64(x)		cpu_to_be64(x)
-
-#endif
-- 
2.25.1

