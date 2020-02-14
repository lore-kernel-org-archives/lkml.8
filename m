Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5990C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60512467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581691055;
	bh=yOTBUEtRaOoo+HtA7SV7d16J3SPYJC3G4vpshmRKMC4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Zj9Q2U+OGIDlEvd4Qfmibwb4HRIWcQgUEQtM7k3i62QcPMwRDtqVbkj2K+NPwhnmH
	 rBy7wa4CFo9BOVmNav0pVRZzIQAv7Yxz/tvhB6qcXqlf/rGk26Zd2N3ZCS8gqic1S6
	 /XLmJUQ6nI6dJUPxAZK9JaAL3VKoT08MtVKF3lfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgBNOhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgBNOhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:37:34 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B7F2187F;
        Fri, 14 Feb 2020 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691053;
        bh=yOTBUEtRaOoo+HtA7SV7d16J3SPYJC3G4vpshmRKMC4=;
        h=From:To:Cc:Subject:Date:From;
        b=xWnvJcBixIZdxmqiLT5vcGzW7TLNhm09zb0fhJO+WtQQBJTW06vxnoZMYTcWj/5n7
         08vynHuSoHBe8hQqOdggfqbdlnmjDZPUsgJ57ewUVlvVVtK0oUz4JVPVnXP1HPfzvJ
         MqEY71eirmAAPpQ4XTnATUz3ZD4yRIEy68y3c9nk=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] modpost: return error if module is missing ns imports and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
Date:   Fri, 14 Feb 2020 15:37:09 +0100
Message-Id: <20200214143709.6490-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, modpost only warns
when a module is missing namespace imports. Under this configuration, such a module
cannot be loaded into the kernel anyway, as the module loader would reject it.
We might as well return a build error when a module is missing namespace imports
under CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, so that the build
warning does not go ignored/unnoticed.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 scripts/Makefile.modpost |  1 +
 scripts/mod/modpost.c    | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index b4d3f2d122ac..a53660f910a9 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -53,6 +53,7 @@ MODPOST = scripts/mod/modpost						\
 	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
+	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS),,-N) 	\
 	$(if $(KBUILD_MODPOST_WARN),-w)
 
 ifdef MODPOST_VMLINUX
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edfdb2f4497..53e966f7d557 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
 static int sec_mismatch_fatal = 0;
 /* ignore missing files */
 static int ignore_missing_files;
+/* Return an error when there are missing namespace imports */
+static int missing_ns_import_error = 0;
 
 enum export {
 	export_plain,      export_unused,     export_gpl,
@@ -2216,9 +2218,15 @@ static int check_exports(struct module *mod)
 
 		if (exp->namespace &&
 		    !module_imports_namespace(mod, exp->namespace)) {
-			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
-			     basename, exp->name, exp->namespace);
-			add_namespace(&mod->missing_namespaces, exp->namespace);
+			if (missing_ns_import_error) {
+				merror("module %s uses symbol %s from namespace %s, but does not import it.\n",
+					basename, exp->name, exp->namespace);
+				err = 1;
+			} else {
+				warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
+				     basename, exp->name, exp->namespace);
+			}
+				add_namespace(&mod->missing_namespaces, exp->namespace);
 		}
 
 		if (!mod->gpl_compatible)
@@ -2560,7 +2568,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awEd:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2598,6 +2606,9 @@ int main(int argc, char **argv)
 		case 'E':
 			sec_mismatch_fatal = 1;
 			break;
+		case 'N':
+			missing_ns_import_error = 1;
+			break;
 		case 'd':
 			missing_namespace_deps = optarg;
 			break;
-- 
2.16.4

