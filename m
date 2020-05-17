Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C1F20671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709046;
	bh=15giKF/3s32ql7R3PEYFVy/DPYrO4zHhys4k5EIDq+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vS6EhyPBDKHjxCxOANPtrmN/Gdq/Qop72NUuSMgrKa2dC6jyvHISK3Zl0w26Jy3ZB
	 rNfepv0nZ6VgebUWcyM81PpqwgKhuUtJn5Q+LmrnHZqsXNz9kmYgxpu8TRALuOqQBZ
	 Z/1qfY/HOrFeHY/DBjHba8Tln2cxHr0rZTuS5vfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgEQJup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:50:45 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38328 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgEQJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:36 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4LB018560;
        Sun, 17 May 2020 18:49:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4LB018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708954;
        bh=kyFNp6jSWWJylXeIdrvZgK47aw2CEOiIJ8nHYJlvTww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqLqCAlEN3/kegDZo3N9F72wSIxrh03f0v/KqCib66QzoFd1lvkWVwbxfyqrHEg9i
         tK3Mkrg0b6BpLxJLrP3NQvKbgsdp4vdqiF1e1TrD3pg2AfXsUT1TsThTi04LdSzKEo
         SXUblcvkYGzYE0M30WNuEtKhdabfLWtQACZaoTHi4lp/eIM0Ma27YSFDxnLrFISipX
         k+Dm4/Sw8WpuK44x77hFkjS21DDSDRGfwxHw9BYtLZ8ESWCtznEkqbDk8OXpvoX4s8
         glQB79sqk2gY/d/Cy2/H775xXs6oGL1dJzVVReNqj9NwCAFvSdDqpmfJsMoEydyrOB
         /1yIV8UnBl9KA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/29] modpost: track if the symbol origin is a dump file or ELF object
Date:   Sun, 17 May 2020 18:48:44 +0900
Message-Id: <20200517094859.2376211-15-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
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

 scripts/mod/modpost.c | 15 +++++----------
 scripts/mod/modpost.h |  1 +
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dc8f15f10da0..340b88647e94 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -197,9 +197,6 @@ struct symbol {
 	int crc_valid;
 	char *namespace;
 	unsigned int weak:1;
-	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
-	unsigned int kernel:1;     /* 1 if symbol is from kernel
-				    *  (only for external modules) **/
 	unsigned int is_static:1;  /* 1 if symbol is not global */
 	enum export  export;       /* Type of export */
 	char name[];
@@ -431,8 +428,6 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	}
 
 	s->module = mod;
-	s->vmlinux   = is_vmlinux(mod->name);
-	s->kernel    = 0;
 	s->export    = export;
 	return s;
 }
@@ -2430,7 +2425,7 @@ static void write_if_changed(struct buffer *b, const char *fname)
 /* parse Module.symvers file. line format:
  * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
  **/
-static void read_dump(const char *fname, unsigned int kernel)
+static void read_dump(const char *fname)
 {
 	char *buf, *pos, *line;
 
@@ -2469,9 +2464,9 @@ static void read_dump(const char *fname, unsigned int kernel)
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
@@ -2491,7 +2486,7 @@ static int dump_sym(struct symbol *sym)
 {
 	if (!external_module)
 		return 1;
-	if (sym->vmlinux || sym->kernel)
+	if (sym->module->from_dump)
 		return 0;
 	return 1;
 }
@@ -2610,11 +2605,11 @@ int main(int argc, char **argv)
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

