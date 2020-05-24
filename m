Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CB2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5080520787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335077;
	bh=SB/e8/Hc6BiV/UHsRLPlmm9j+XrT8P4hWYyHAaXoyzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVp7IrxSMfggQmvUWF+oLCTGafp/Ps3TwK0KZpgM0EL+U2/dVmBkQgS5ub5zyqzgt
	 A8jJ6xfJvE8N6Os59f6fKoGDhwVhvzwa/aSc+31OCNtaK6ostDG107hJcxjvffQq4Y
	 jvx2tvFp1kCJNM7vS+HCgiR6Ma4h0GBrsen4RNKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgEXPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:36 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19704 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcV9017561;
        Mon, 25 May 2020 00:42:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcV9017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334971;
        bh=eT/3dcYsfgyUALSskbnUGaAPUnnuwqCinIOfa8/3Uoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WimpO9UPQDEePrKQ6ok+ftqlDpS/L+HvKT9CAUdRHIeBnMxm2wol59f8R0HN1xxgG
         9kmkDSJAYBUJY4j19SlBM2+0IbJAZC+QU0aXEEmmCIPx+VnbplQdL/ddLL+ch5IGTA
         OaGTmsFini5R5dHUqKGI6CtLPR0bDUCO4qHHdOG3aJ8g8hmOh/vIecWPi/4hH8XjFp
         Gs8N+3pV4p2Gp7N3IqQMCDwuJhT+9Idiw/Yx48tkfR4tOvSvbsRz72FvZdgjhMalzb
         wOnP7OhQTn6qHcvFJDLPQwNbz/b8pQhiA1wOr8dkmIZrq3LUonhp/jrZ3vkPxsgGrH
         +BxR6ZVrp+KsA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/29] modpost: add mod->is_vmlinux struct member
Date:   Mon, 25 May 2020 00:42:30 +0900
Message-Id: <20200524154235.380482-25-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_vmlinux() is called in several places to check whether the current
module is vmlinux or not.

It is faster and clearer to check mod->is_vmlinux flag.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 19 ++++++++++---------
 scripts/mod/modpost.h |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c0bc8a2ea026..0d065f8f5087 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -186,6 +186,7 @@ static struct module *new_module(const char *modname)
 
 	/* add to list */
 	mod->name = p;
+	mod->is_vmlinux = is_vmlinux(modname);
 	mod->gpl_compatible = -1;
 	mod->next = modules;
 	modules = mod;
@@ -427,11 +428,11 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 
 	if (!s) {
 		s = new_symbol(name, mod, export);
-	} else if (!external_module || is_vmlinux(s->module->name) ||
+	} else if (!external_module || s->module->is_vmlinux ||
 		   s->module == mod) {
 		warn("%s: '%s' exported twice. Previous export was in %s%s\n",
 		     mod->name, name, s->module->name,
-		     is_vmlinux(s->module->name) ? "" : ".ko");
+		     s->module->is_vmlinux ? "" : ".ko");
 		return s;
 	}
 
@@ -688,7 +689,7 @@ static void handle_modversion(const struct module *mod,
 
 	if (sym->st_shndx == SHN_UNDEF) {
 		warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n",
-		     symname, mod->name, is_vmlinux(mod->name) ? "":".ko");
+		     symname, mod->name, mod->is_vmlinux ? "" : ".ko");
 		return;
 	}
 
@@ -2011,12 +2012,12 @@ static void read_symbols(const char *modname)
 
 	mod = new_module(modname);
 
-	if (is_vmlinux(modname)) {
+	if (mod->is_vmlinux) {
 		have_vmlinux = 1;
 		mod->skip = 1;
 	}
 
-	if (!is_vmlinux(modname)) {
+	if (!mod->is_vmlinux) {
 		license = get_modinfo(&info, "license");
 		if (!license)
 			warn("missing MODULE_LICENSE() in %s\n", modname);
@@ -2075,7 +2076,7 @@ static void read_symbols(const char *modname)
 
 	check_sec_ref(mod, modname, &info);
 
-	if (!is_vmlinux(modname)) {
+	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
 		if (version || all_versions)
 			get_src_version(modname, mod->srcversion,
@@ -2345,7 +2346,7 @@ static void add_depends(struct buffer *b, struct module *mod)
 	/* Clear ->seen flag of modules that own symbols needed by this. */
 	for (s = mod->unres; s; s = s->next)
 		if (s->module)
-			s->module->seen = is_vmlinux(s->module->name);
+			s->module->seen = s->module->is_vmlinux;
 
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(depends, \"");
@@ -2462,9 +2463,9 @@ static void read_dump(const char *fname)
 			goto fail;
 		mod = find_module(modname);
 		if (!mod) {
-			if (is_vmlinux(modname))
-				have_vmlinux = 1;
 			mod = new_module(modname);
+			if (mod->is_vmlinux)
+				have_vmlinux = 1;
 			mod->skip = 1;
 			mod->from_dump = 1;
 		}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 554f02c69ac2..ec717ab20b98 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -120,6 +120,7 @@ struct module {
 	int gpl_compatible;
 	struct symbol *unres;
 	int from_dump;  /* 1 if module was loaded from *.symver */
+	int is_vmlinux;
 	int seen;
 	int skip;
 	int has_init;
-- 
2.25.1

