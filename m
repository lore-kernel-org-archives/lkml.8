Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAABC207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335007;
	bh=sF006euIo++eR4g5pjQ5qo5+ZzNtFT1xQOmPtJdFP+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBcSnnf7kPkBVdjSfdKX2biEkfMJn2UyrMYgcgql/t7Tm1fYSsOerJN3OtHOkw0We
	 MyrUuPSqb0u3MiNNiKKnXgbaBx739oOf4Q30nDDCccG7YPNESAYiOMOfEPLOVefGko
	 acxkUc1HzHtjV9BY64uCBrSCbzLzYtx6VhnKiXwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEXPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19685 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcV5017561;
        Mon, 25 May 2020 00:42:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcV5017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334969;
        bh=Yd3S7TW9ZNVdZllTI+VG7TDOlOnUIHzjxzZ67QKNq4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSdUuSORtTvlAk2Iu19NoFACgkMFOCi7PT67MtnWKrdto2JJCjcnt+UXthDqBntiv
         FGo9E9JIHn0X20d7f+JzT2x5DhuAJ770PtJm6Lp4ql1GKqLqGhKztwDs+Gn5kNM+r1
         UozwQx6KmSnnhNvmSOwCA6luklqbgtspironTN7eqyTuWocCInOIpDY3M/Nv+Z7N/W
         j8+TIGWhmz8j4t8jHZ4jqFUhaPTh3+Oe0XBNYB+ANlp5Bjb7D/p64MTdbSZ0PHhPkW
         KXru9jZO54h0S9Fzq27a8Arj41Rbl1HOYoRvyS6/b6hNOhxtxtmqom2za1HgCy/3/L
         7tQwTucoI3GYA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/29] modpost: generate vmlinux.symvers and reuse it for the second modpost
Date:   Mon, 25 May 2020 00:42:26 +0900
Message-Id: <20200524154235.380482-21-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The full build runs modpost twice, first for vmlinux.o and second for
modules.

The first pass dumps all the vmlinux symbols into Module.symvers, but
the second pass parses vmlinux again instead of reusing the dump file,
presumably because it needs to avoid accumulating stale symbols.

Loading symbol info from a dump file is faster than parsing an ELF object.
Besides, modpost deals with various issues to parse vmlinux in the second
pass.

A solution is to make the first pass dumps symbols into a separate file,
vmlinux.symvers. The second pass reads it, and parses module .o files.
The merged symbol information is dumped into Module.symvers as before.

This makes further modpost cleanups possible.

Also, it fixes the problem of 'make vmlinux', which previously overwrote
Module.symvers, throwing away module symbols.

I slightly touched scripts/link-vmlinux.sh so that vmlinux is re-linked
when you cross this commit. Otherwise, vmlinux.symvers would not be
generated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 .gitignore               |  1 +
 Makefile                 |  2 +-
 scripts/Makefile.modpost | 11 +++++++----
 scripts/link-vmlinux.sh  |  2 --
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2258e906f01c..87b9dd8a163b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@ modules.order
 /linux
 /vmlinux
 /vmlinux.32
+/vmlinux.symvers
 /vmlinux-gdb.py
 /vmlinuz
 /System.map
diff --git a/Makefile b/Makefile
index 3b25a51132ea..0a3d3828f6eb 100644
--- a/Makefile
+++ b/Makefile
@@ -1408,7 +1408,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_FILES += include/ksym \
+CLEAN_FILES += include/ksym vmlinux.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps
 
 # Directories & files removed with 'make mrproper'
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index d14143b30b7a..1c597999b6a0 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -43,17 +43,17 @@ __modpost:
 include include/config/auto.conf
 include scripts/Kbuild.include
 
-kernelsymfile := $(objtree)/Module.symvers
-
 MODPOST = scripts/mod/modpost								\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
-	$(if $(KBUILD_EXTMOD),,-o $(kernelsymfile))					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
 	$(if $(KBUILD_MODPOST_WARN),-w)
 
 ifdef MODPOST_VMLINUX
 
+# modpost options for vmlinux.o
+MODPOST += -o vmlinux.symvers
+
 quiet_cmd_modpost = MODPOST vmlinux.o
       cmd_modpost = $(MODPOST) vmlinux.o
 
@@ -68,7 +68,10 @@ MODPOST += $(subst -i,-n,$(filter -i,$(MAKEFLAGS))) -s \
 	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))
 
 ifeq ($(KBUILD_EXTMOD),)
-MODPOST += $(wildcard vmlinux)
+
+# modpost options for in-kernel modules
+MODPOST += -i vmlinux.symvers -o Module.symvers
+
 else
 
 # set src + obj - they may be used in the modules's Makefile
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d09ab4afbda4..d5af6be50b50 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -218,8 +218,6 @@ on_signals()
 }
 trap on_signals HUP INT QUIT TERM
 
-#
-#
 # Use "make V=1" to debug this script
 case "${KBUILD_VERBOSE}" in
 *1*)
-- 
2.25.1

