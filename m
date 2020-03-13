Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD6C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF290206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584117716;
	bh=b1JjrYlTSusNR1LnoA6/BWQqaqnamEJmX74yctv21Ko=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TWiA9d65i6V+SWh8UL0aABPm8R1MxNx7i4yv+qEIwZnsBPI8aHx0k4ucyhQiOxxSz
	 pI5pJzG5ZwjYJ8+DwLvL2CJuzQ05+bdl7pvhKx8p7zXabu2HZqqNN50Gl7r00mfPPY
	 neq6eksrSFbEG2ff5CjVQlJxG2BMZfaIdA5Buv6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCMQlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:41:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41796 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:41:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id i1so10020365oie.8;
        Fri, 13 Mar 2020 09:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HLgmkdRLNPltZNGuU7hAz+YtJP12He0zQoCgae73Yg=;
        b=eoXAv6yj47KXxzlNdJdd+KbcFBjs4VHzDnxyKFJcudQ/CkKosLVpJPkBw4VgXBC03/
         /s+hp+efc8MnOH15kpovNsFA1GWWOxUewJquqkXqvqQDXlZdLnSJljMozTiA8SIgBDne
         qFqAqR1PhPt2OmY63ycCWWcRJpCdgaIZu+tW6zTXeJcAtLN2NbAn2igG2fdGhoQikpUH
         jBj2Qadb4zpzHwZ7Xc0wCvlITDaKhpecidqSV0XTruDHzuuulyQtMlc9FH1D4bid1j1X
         ojFg4VEFzv1O5NOLyIoEm09nw8iVKRlxqCcCs2lr8QX34hljMZw+v2bEvDiJ+fDVuKY5
         jMQw==
X-Gm-Message-State: ANhLgQ242arLXiYCwCxFAQ3JVSxUeCNv+2sKyzIQr1f9yRZzpbM1hki5
        KNlJIn8DKR7Ng3gl2phuMt7AyRY=
X-Google-Smtp-Source: ADFU+vtGkTx32ssJ2N8vNIBiwqCwcw6XXdljoT8NcuFXrsnpp+6auMz1cU2iPFIF1qmipKmEGtjKXg==
X-Received: by 2002:a05:6808:5c7:: with SMTP id d7mr7798363oij.136.1584117714020;
        Fri, 13 Mar 2020 09:41:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j23sm2014066oib.32.2020.03.13.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:41:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] scripts/dtc: Remove unused makefile fragments
Date:   Fri, 13 Mar 2020 11:41:52 -0500
Message-Id: <20200313164152.15182-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile.dtc and Makefile.libfdt fragments from upstream dtc aren't
used by the kernel build, so let's remove them and stop syncing them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/Makefile.dtc           | 23 -----------------------
 scripts/dtc/libfdt/Makefile.libfdt | 18 ------------------
 scripts/dtc/update-dtc-source.sh   |  4 ++--
 3 files changed, 2 insertions(+), 43 deletions(-)
 delete mode 100644 scripts/dtc/Makefile.dtc
 delete mode 100644 scripts/dtc/libfdt/Makefile.libfdt

diff --git a/scripts/dtc/Makefile.dtc b/scripts/dtc/Makefile.dtc
deleted file mode 100644
index 9c467b096f03..000000000000
--- a/scripts/dtc/Makefile.dtc
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Makefile.dtc
-#
-# This is not a complete Makefile of itself.  Instead, it is designed to
-# be easily embeddable into other systems of Makefiles.
-#
-DTC_SRCS = \
-	checks.c \
-	data.c \
-	dtc.c \
-	flattree.c \
-	fstree.c \
-	livetree.c \
-	srcpos.c \
-	treesource.c \
-	util.c
-
-ifneq ($(NO_YAML),1)
-DTC_SRCS += yamltree.c
-endif
-
-DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
-DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
diff --git a/scripts/dtc/libfdt/Makefile.libfdt b/scripts/dtc/libfdt/Makefile.libfdt
deleted file mode 100644
index e54639738c8e..000000000000
--- a/scripts/dtc/libfdt/Makefile.libfdt
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
-# Makefile.libfdt
-#
-# This is not a complete Makefile of itself.  Instead, it is designed to
-# be easily embeddable into other systems of Makefiles.
-#
-LIBFDT_soname = libfdt.$(SHAREDLIB_EXT).1
-LIBFDT_INCLUDES = fdt.h libfdt.h libfdt_env.h
-LIBFDT_VERSION = version.lds
-LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c fdt_empty_tree.c \
-	fdt_addresses.c fdt_overlay.c
-LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
-LIBFDT_LIB = libfdt-$(DTC_VERSION).$(SHAREDLIB_EXT)
-
-libfdt_clean:
-	@$(VECHO) CLEAN "(libfdt)"
-	rm -f $(STD_CLEANFILES:%=$(LIBFDT_dir)/%)
-	rm -f $(LIBFDT_dir)/$(LIBFDT_soname)
diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 7dd29a0362b8..bc704e2a6a4a 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,9 +32,9 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
+		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
 		dtc-lexer.l dtc-parser.y"
-LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
+LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
 
-- 
2.20.1

