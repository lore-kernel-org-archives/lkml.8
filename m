Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3009C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD22078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Df4c9yTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbgDASXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732498AbgDASXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VtK5O6CtT6IFSJujN8Ou5Ycvv+Ua1bFKIedLGVkrzE=;
        b=Df4c9yTb7oaxLFzSp9YMXUIBx2hQkp0N2KH4Bs36ahNa2fU0paigvZbTltu0jbZ/sq3ju3
        Q9P0Kwx/vh42bEWJjdKCcwX7F+AzM1gfnwGe9p2L+4zJXyMXFt3wuisDZ/B6h8ZcWz5xNW
        rOUWzyeWHSZHExW0zjaG2SXFDd4KHG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-1yNWy08vPQqTSplQx0tZAg-1; Wed, 01 Apr 2020 14:23:39 -0400
X-MC-Unique: 1yNWy08vPQqTSplQx0tZAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20D5DB21;
        Wed,  1 Apr 2020 18:23:38 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD4060BEC;
        Wed,  1 Apr 2020 18:23:38 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 2/5] objtool: Support Clang non-section symbols in ORC dump
Date:   Wed,  1 Apr 2020 13:23:26 -0500
Message-Id: <b811b5eb1a42602c3b523576dc5efab9ad1c174d.1585761021.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, the relocation symbols for ORC entries have only been
section symbols:

  .text+0: sp:sp+8 bp:(und) type:call end:0

However, the Clang assembler is aggressive about stripping section
symbols.  In that case we will need to use function symbols:

  freezing_slow_path+0: sp:sp+8 bp:(und) type:call end:0

In preparation for the generation of such entries in "objtool orc
generate", add support for reading them in "objtool orc dump".

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 13ccf775a83a..ba4cbb1cdd63 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -66,7 +66,7 @@ int orc_dump(const char *_objname)
 	char *name;
 	size_t nr_sections;
 	Elf64_Addr orc_ip_addr =3D 0;
-	size_t shstrtab_idx;
+	size_t shstrtab_idx, strtab_idx =3D 0;
 	Elf *elf;
 	Elf_Scn *scn;
 	GElf_Shdr sh;
@@ -127,6 +127,8 @@ int orc_dump(const char *_objname)
=20
 		if (!strcmp(name, ".symtab")) {
 			symtab =3D data;
+		} else if (!strcmp(name, ".strtab")) {
+			strtab_idx =3D i;
 		} else if (!strcmp(name, ".orc_unwind")) {
 			orc =3D data->d_buf;
 			orc_size =3D sh.sh_size;
@@ -138,7 +140,7 @@ int orc_dump(const char *_objname)
 		}
 	}
=20
-	if (!symtab || !orc || !orc_ip)
+	if (!symtab || !strtab_idx || !orc || !orc_ip)
 		return 0;
=20
 	if (orc_size % sizeof(*orc) !=3D 0) {
@@ -159,21 +161,29 @@ int orc_dump(const char *_objname)
 				return -1;
 			}
=20
-			scn =3D elf_getscn(elf, sym.st_shndx);
-			if (!scn) {
-				WARN_ELF("elf_getscn");
-				return -1;
-			}
-
-			if (!gelf_getshdr(scn, &sh)) {
-				WARN_ELF("gelf_getshdr");
-				return -1;
-			}
-
-			name =3D elf_strptr(elf, shstrtab_idx, sh.sh_name);
-			if (!name || !*name) {
-				WARN_ELF("elf_strptr");
-				return -1;
+			if (GELF_ST_TYPE(sym.st_info) =3D=3D STT_SECTION) {
+				scn =3D elf_getscn(elf, sym.st_shndx);
+				if (!scn) {
+					WARN_ELF("elf_getscn");
+					return -1;
+				}
+
+				if (!gelf_getshdr(scn, &sh)) {
+					WARN_ELF("gelf_getshdr");
+					return -1;
+				}
+
+				name =3D elf_strptr(elf, shstrtab_idx, sh.sh_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
+			} else {
+				name =3D elf_strptr(elf, strtab_idx, sym.st_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
 			}
=20
 			printf("%s+%llx:", name, (unsigned long long)rela.r_addend);
--=20
2.21.1

