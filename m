Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD02C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7747D206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588579747;
	bh=zWwLdNu0fE68y+bUt/8frkWqtComIurJrQfYBfDihBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e888EJBwNtBUeogcm7VpER7eFtowEHHXAaUWSIPr2+h3P/nDdHl31kAufLsD+2PkV
	 7OBYaIekQyJapopLGVbSiyB1kdrpaMkVJUXRDbvvlPpvP1mqElGDopgXia8/g/fMps
	 hvRyyBVHoIaBFJvocpSSQ2KgdzwpzA1aPTRPdtXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgEDIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:09:06 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:26524 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEDIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:09:06 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 044888nC016007;
        Mon, 4 May 2020 17:08:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 044888nC016007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588579690;
        bh=/3yLFIULZ1ttgr4BZxxnZusRx1L5wNRo4hrlgq8nx6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2ktfTiajg/232fM8veJ6jJiv2ERK4Vm4vgfn5RKF5lWcyF40PphFeJaa5qaXSZ+x
         KiIbJF2Fvpsi+cTiHtngdCjpJtzPe0wKhoBfgbcEoSmuufsscudbQG0C3c5VTtTyU/
         ZuVVOFPVZI5DURTI918FTQiEwGTeLqMTuo7dDRR6qjRUzgMPY0RTXFjr4pt3ZUGmbO
         2XhJYFQgZllbJZSp1u0oZHhPxMRvbsjfnpJ6EP9dIl0Sr812a6gGqgiBJDZX4Evixe
         32d4i6L37trku0gQVsDYBmmBivZbsQwFsP37zEzYiYn+sQrchjRnAI4a6C/LulOWVA
         UGLiHA35euOKQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCH 2/2] kbuild: remove {CLEAN,MRPROPER,DISTCLEAN}_DIRS
Date:   Mon,  4 May 2020 17:08:07 +0900
Message-Id: <20200504080807.126396-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200504080807.126396-1-masahiroy@kernel.org>
References: <20200504080807.126396-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge {CLEAN,MRPROPER,DISTCLEAN}_DIRS into {CLEAN,MRPROPER,DISTCLEAN}_FILES
because the difference is just the -r option passed to the 'rm' command.

Do likewise as commit 1634f2bfdb84 ("kbuild: remove clean-dirs syntax").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile         | 22 ++++++----------------
 arch/um/Makefile |  2 +-
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index ffd80afcd0bb..8a7c931cc0d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,14 +1389,14 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += include/ksym
-CLEAN_FILES += modules.builtin modules.builtin.modinfo modules.nsdeps
+CLEAN_FILES += include/ksym \
+	       modules.builtin modules.builtin.modinfo modules.nsdeps
 
 # Directories & files removed with 'make mrproper'
-MRPROPER_DIRS  += include/config include/generated          \
+MRPROPER_FILES += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
-		  debian/ snap/ tar-install/
-MRPROPER_FILES += .config .config.old .version \
+		  debian snap tar-install \
+		  .config .config.old .version \
 		  Module.symvers \
 		  signing_key.pem signing_key.priv signing_key.x509	\
 		  x509.genkey extra_certificates signing_key.x509.keyid	\
@@ -1404,12 +1404,10 @@ MRPROPER_FILES += .config .config.old .version \
 		  *.spec
 
 # Directories & files removed with 'make distclean'
-DISTCLEAN_DIRS  +=
 DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
 
 # clean - Delete most, but leave enough to build external modules
 #
-clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
 
 PHONY += archclean vmlinuxclean
@@ -1422,7 +1420,6 @@ clean: archclean vmlinuxclean
 
 # mrproper - Delete all generated files, including .config
 #
-mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
@@ -1431,18 +1428,15 @@ $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
 mrproper: clean $(mrproper-dirs)
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 
 # distclean
 #
-distclean: rm-dirs  := $(wildcard $(DISTCLEAN_DIRS))
 distclean: rm-files := $(wildcard $(DISTCLEAN_FILES))
 
 PHONY += distclean
 
 distclean: mrproper
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find $(srctree) $(RCS_FIND_IGNORE) \
 		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
@@ -1732,7 +1726,6 @@ $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
 clean: $(clean-dirs)
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
@@ -1827,11 +1820,8 @@ tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
-      cmd_rmfiles = rm -f $(rm-files)
+      cmd_rmfiles = rm -rf $(rm-files)
 
 # Run depmod only if we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 275f5ffdf6f0..3f27aa3ec0a6 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -140,7 +140,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += arch/$(SUBARCH)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.25.1

