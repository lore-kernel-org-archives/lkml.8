Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65445C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D00207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335020;
	bh=95DOWnEvexa2LFsm+wUpCeMNpEuK5hb8AefYN9DPbKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYQmnWnXTko91Q1eMGke9jG0audeSTlMwp5aIIZmVsMGMYztqSRVb8Z8ppeI8ZgDa
	 t07OhYolnW5j48MXY6js9IFyEQ3fx6CL6B37o/AziTI2l+unS7NeeRNt74koFLkXHO
	 KTBIk2tFYf2zPZnlYi1dbx+UbjPedIHHDbH/B6yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEXPne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:34 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19697 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUx017561;
        Mon, 25 May 2020 00:42:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUx017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334966;
        bh=zhaRx3V/mcEAjcU9CK2PbiKh4idArNIK3xDM94cI7Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hg80agprwqdW2lP344ec6GS9cLLfQRjlDtNJg/XhTRtDwmfsU7vzlWsYuGsUzbyMb
         qHa9JNWpwyS5YNbPaW8qJDf3uOf4lsgfFf40JbBD6Uy4HzZ8C8j2YaK138Ws3x3NFy
         tLvAdwSW6a7A56Y19VLLxoatfm2Hjbk/z4ZkVaiUvf7bs2kNlFeHvJZCG0OguLbfr+
         aqF1Z1EPwU1rB4lZZE8Uai1J7jEqqSnJFp1OvmxriYUVx1UM4P0Q/8zsnTgJoaXK1x
         46iWKN/4D4pqnwnHKqfLsPQYZ4m6rvF5A4j4WvelmKhDxOawKOFhzFpbzJ5L42GP7/
         kEOzOwhMviatw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/29] modpost: track if the symbol origin is a dump file or ELF object
Date:   Mon, 25 May 2020 00:42:20 +0900
Message-Id: <20200524154235.380482-15-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meaning of sym->kernel is obscure; it is set for in-kernel symbols
loaded from Modules.symver. This happens only when we are building
external modules, and it is used to determine whether to dump symbols
to $(KBUILD_EXTMOD)/Modules.symver

It is clearer to remember whether the symbol or module came from a dump
file or ELF object.

This changes the KBUILD_EXTRA_SYMBOLS behavior. Previously, symbols
loaded from KBUILD_EXTRA_SYMBOLS are accumulated into the current
$(KBUILD_EXTMOD)/Modules.symver

Going forward, they will be only used to check symbol references, but
not dumped into the current $(KBUILD_EXTMOD)/Modules.symver. I believe
this makes more sense.

sym->vmlinux will have no user. Remove it too.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c | 15 +++++----------
 scripts/mod/modpost.h |  1 +
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2f5fab40d859..76599dd44bae 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -207,9 +207,6 @@ struct symbol {
 	int crc_valid;
 	char *namespace;
 	unsigned int weak:1;
-	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
-	unsigned int kernel:1;     /* 1 if symbol is from kernel
-				    *  (only for external modules) **/
 	unsigned int is_static:1;  /* 1 if symbol is not global */
 	enum export  export;       /* Type of export */
 	char name[];
@@ -441,8 +438,6 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	}
 
 	s->module = mod;
-	s->vmlinux   = is_vmlinux(mod->name);
-	s->kernel    = 0;
 	s->export    = export;
 	return s;
 }
@@ -2440,7 +2435,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
 /* parse Module.symvers file. line format:
  * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
  **/
-static void read_dump(const char *fname, unsigned int kernel)
+static void read_dump(const char *fname)
 {
 	char *buf, *pos, *line;
 
@@ -2479,9 +2474,9 @@ static void read_dump(const char *fname, unsigned int kernel)
 				have_vmlinux = 1;
 			mod = new_module(modname);
 			mod->skip = 1;
+			mod->from_dump = 1;
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
-		s->kernel    = kernel;
 		s->is_static = 0;
 		sym_set_crc(symname, crc);
 		sym_update_namespace(symname, namespace);
@@ -2501,7 +2496,7 @@ static int dump_sym(struct symbol *sym)
 {
 	if (!external_module)
 		return 1;
-	if (sym->vmlinux || sym->kernel)
+	if (sym->module->from_dump)
 		return 0;
 	return 1;
 }
@@ -2620,11 +2615,11 @@ int main(int argc, char **argv)
 	}
 
 	if (kernel_read)
-		read_dump(kernel_read, 1);
+		read_dump(kernel_read);
 	while (extsym_start) {
 		struct ext_sym_list *tmp;
 
-		read_dump(extsym_start->file, 0);
+		read_dump(extsym_start->file);
 		tmp = extsym_start->next;
 		free(extsym_start);
 		extsym_start = tmp;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 232a0e11fcaa..aaf3c4ad5d60 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -119,6 +119,7 @@ struct module {
 	const char *name;
 	int gpl_compatible;
 	struct symbol *unres;
+	int from_dump;  /* 1 if module was loaded from *.symver */
 	int seen;
 	int skip;
 	int has_init;
-- 
2.25.1

