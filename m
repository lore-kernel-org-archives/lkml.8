Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F192084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582652138;
	bh=PeNDRn7ouKq00bGzpe3E8vy9GU1wYbIYTrNkavUhBIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ajku5gLZHim65hmJOU92wT6v6UKSgcEITR7FOe7jzSCm7iTAmktnkJqidrgJ51AAf
	 /j8nTS0FxL9w2kAZIcUx4VUMgL2t/6i7ATe+n6fyr4HaD/+Vk9pUs1tOUEbOAIGSDs
	 fDVcjlNqe+LjSx6IUWjg5u2LbArKNduT7g+bxGfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgBYRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgBYRff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:35:35 -0500
Received: from linux-8ccs.suse.de (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECD921927;
        Tue, 25 Feb 2020 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582652135;
        bh=PeNDRn7ouKq00bGzpe3E8vy9GU1wYbIYTrNkavUhBIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUlHglvu2m9gjQH+KC67u8fsVbZ3mAXOLrKVaRJF2WttpJnuXXFG3qGFcHu12RJkM
         OaKDwLe+hIIOF8cvgMtAiyt0zZdmLh7Oeq3NOAfJVYMhhRDCXkNNV3FzSXo/Pq9LSX
         afz4KdFrlG2upHV0Oxo7DLsInEhErf1CsjoWn0GE=
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 2/2] modpost: return error if module is missing ns imports and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
Date:   Tue, 25 Feb 2020 18:35:26 +0100
Message-Id: <20200225173526.9617-2-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200225173526.9617-1-jeyu@kernel.org>
References: <20200225173526.9617-1-jeyu@kernel.org>
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
index e2805fbeb99f..9ae2b1c9a870 100644
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
@@ -2211,8 +2213,11 @@ static int check_exports(struct module *mod)
 
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
 
@@ -2555,7 +2560,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awEd:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2593,6 +2598,9 @@ int main(int argc, char **argv)
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

