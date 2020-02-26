Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B4C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7C2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582727191;
	bh=I+02811uaLiwUb3AZQBeCUgzyvtIl/KGp1S62hAcdz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/8wNDeRY2C7Af3QCz2+S8z04v7MIOIn9syr1h9wplGUtrgzKN9zny6axLcl+z+J1
	 sw4fapSrmGfPbRMEc/G/QvGd58N/dw6Lkq8cIOp78EzmNJQaHwq2mD/pzy47UeUIgs
	 u6T0D5PZsJMSdb5cmsZag2/qLftkWbeyNbIy7PQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBZO0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbgBZO01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:26:27 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F32924683;
        Wed, 26 Feb 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582727186;
        bh=I+02811uaLiwUb3AZQBeCUgzyvtIl/KGp1S62hAcdz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3EBYdNtM+yt9wu0Rj9XNVxzsnlk7qra4+Bg1nFmv5gkcl8TPFt1XXC/LYgUraNoQ
         u+Hb4IW+skU9X6WzHw2kWk9hteq4bjGWtZc6WeAcD37cgSDksTg4TqJkrZVOQ2xqtM
         RTfAGUccPMdYeN9KmRXUswWi9TUCTFTaE6Q47xYI=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2 2/2] modpost: return error if module is missing ns imports and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
Date:   Wed, 26 Feb 2020 15:26:08 +0100
Message-Id: <20200226142608.19499-2-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200226142608.19499-1-jeyu@kernel.org>
References: <20200226142608.19499-1-jeyu@kernel.org>
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
 scripts/Makefile.modpost | 15 ++++++++-------
 scripts/mod/modpost.c    | 14 +++++++++++---
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index b4d3f2d122ac..957eed6a17a5 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -46,13 +46,14 @@ include scripts/Kbuild.include
 kernelsymfile := $(objtree)/Module.symvers
 modulesymfile := $(firstword $(KBUILD_EXTMOD))/Module.symvers
 
-MODPOST = scripts/mod/modpost						\
-	$(if $(CONFIG_MODVERSIONS),-m)					\
-	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)			\
-	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile)			\
-	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
-	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
-	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
+MODPOST = scripts/mod/modpost								\
+	$(if $(CONFIG_MODVERSIONS),-m)							\
+	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
+	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile)					\
+	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))			\
+	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))					\
+	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
+	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N) 	\
 	$(if $(KBUILD_MODPOST_WARN),-w)
 
 ifdef MODPOST_VMLINUX
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3201a2ac5cc4..d164be63c2e3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
 static int sec_mismatch_fatal = 0;
 /* ignore missing files */
 static int ignore_missing_files;
+/* If set to 1, only warn (instead of error) about missing ns imports */
+static int allow_missing_ns_imports = 0;
 
 enum export {
 	export_plain,      export_unused,     export_gpl,
@@ -2209,8 +2211,11 @@ static int check_exports(struct module *mod)
 
 		if (exp->namespace &&
 		    !module_imports_namespace(mod, exp->namespace)) {
-			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
-			     basename, exp->name, exp->namespace);
+			warn_unless(!allow_missing_ns_imports,
+				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
+				    basename, exp->name, exp->namespace);
+			if (!allow_missing_ns_imports)
+				err = 1;
 			add_namespace(&mod->missing_namespaces, exp->namespace);
 		}
 
@@ -2553,7 +2558,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awEd:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2591,6 +2596,9 @@ int main(int argc, char **argv)
 		case 'E':
 			sec_mismatch_fatal = 1;
 			break;
+		case 'N':
+			allow_missing_ns_imports = 1;
+			break;
 		case 'd':
 			missing_namespace_deps = optarg;
 			break;
-- 
2.16.4

