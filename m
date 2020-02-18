Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD3C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D312072C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+7ylDYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRDmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:42:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726166AbgBRDmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581997336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zCAxDlJ3syP6wOa/zXMRKka+Gte3dfdAhWl4i7enSc=;
        b=h+7ylDYDdvvl1yQaHaswyKuNLsrqg04nFxmmuMnpThC8kdbtlCyMginrIPgMYRYfIKEe27
        /SdUi8Bae1YzvFVzMtkhhdyql7ZCtZDYYfc/9V3ZNid1Z2m/XomTNr3eN4gT0UQYYeHz4r
        YS1Tdetb1YGX6ZTcjycfrBnOEJvreEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-dAUUlF0mPbKsOQbTiVPkKw-1; Mon, 17 Feb 2020 22:42:05 -0500
X-MC-Unique: dAUUlF0mPbKsOQbTiVPkKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82FCC1857347;
        Tue, 18 Feb 2020 03:42:04 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D988B10027BA;
        Tue, 18 Feb 2020 03:42:03 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] objtool: Improve call destination function detection
Date:   Mon, 17 Feb 2020 21:41:54 -0600
Message-Id: <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581997059.git.jpoimboe@redhat.com>
References: <cover.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent clang change, combined with a binutils bug, can trigger a
situation where a ".Lprintk$local" STT_NOTYPE symbol gets created at the
same offset as the "printk" STT_FUNC symbol.  This confuses objtool:

  kernel/printk/printk.o: warning: objtool: ignore_loglevel_setup()+0x10:=
 can't find call dest symbol at .text+0xc67

Improve the call destination detection by looking specifically for an
STT_FUNC symbol.

Link: https://github.com/ClangBuiltLinux/linux/issues/872
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=3D25551
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 27 ++++++++++++++++++---------
 tools/objtool/elf.c   | 14 ++++++++++++--
 tools/objtool/elf.h   |  1 +
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e7227649bac7..da0767128f61 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -415,8 +415,8 @@ static void add_ignores(struct objtool_file *file)
 			break;
=20
 		case STT_SECTION:
-			func =3D find_symbol_by_offset(rela->sym->sec, rela->addend);
-			if (!func || func->type !=3D STT_FUNC)
+			func =3D find_func_by_offset(rela->sym->sec, rela->addend);
+			if (!func)
 				continue;
 			break;
=20
@@ -679,10 +679,14 @@ static int add_call_destinations(struct objtool_fil=
e *file)
 					       insn->len);
 		if (!rela) {
 			dest_off =3D insn->offset + insn->len + insn->immediate;
-			insn->call_dest =3D find_symbol_by_offset(insn->sec,
-								dest_off);
+			insn->call_dest =3D find_func_by_offset(insn->sec, dest_off);
+			if (!insn->call_dest)
+				insn->call_dest =3D find_symbol_by_offset(insn->sec, dest_off);
=20
-			if (!insn->call_dest && !insn->ignore) {
+			if (insn->ignore)
+				continue;
+
+			if (!insn->call_dest) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
 				if (retpoline)
@@ -690,11 +694,16 @@ static int add_call_destinations(struct objtool_fil=
e *file)
 				return -1;
 			}
=20
+			if (insn->func && insn->call_dest->type !=3D STT_FUNC) {
+				WARN_FUNC("unsupported call to non-function",
+					  insn->sec, insn->offset);
+				return -1;
+			}
+
 		} else if (rela->sym->type =3D=3D STT_SECTION) {
-			insn->call_dest =3D find_symbol_by_offset(rela->sym->sec,
-								rela->addend+4);
-			if (!insn->call_dest ||
-			    insn->call_dest->type !=3D STT_FUNC) {
+			insn->call_dest =3D find_func_by_offset(rela->sym->sec,
+							      rela->addend+4);
+			if (!insn->call_dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%x",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index edba4745f25a..cc4601c879ce 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -62,8 +62,18 @@ struct symbol *find_symbol_by_offset(struct section *s=
ec, unsigned long offset)
 	struct symbol *sym;
=20
 	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type !=3D STT_SECTION &&
-		    sym->offset =3D=3D offset)
+		if (sym->type !=3D STT_SECTION && sym->offset =3D=3D offset)
+			return sym;
+
+	return NULL;
+}
+
+struct symbol *find_func_by_offset(struct section *sec, unsigned long of=
fset)
+{
+	struct symbol *sym;
+
+	list_for_each_entry(sym, &sec->symbol_list, list)
+		if (sym->type =3D=3D STT_FUNC && sym->offset =3D=3D offset)
 			return sym;
=20
 	return NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 44150204db4d..a1963259b930 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -77,6 +77,7 @@ struct elf {
=20
 struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
+struct symbol *find_func_by_offset(struct section *sec, unsigned long of=
fset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long =
offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long=
 offset);
--=20
2.21.1

