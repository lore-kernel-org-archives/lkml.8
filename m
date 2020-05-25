Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F3C20849
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590385652;
	bh=5k6xz6TuiGF+ullAgZUvDOvOMPBANbKX9OHAS2NHpS0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=leVu9muIJ4ONW5/tlnVnlCYm+J211wGtl3BlTiDckFBdO2tAGCW0Mf4KHN911Uh6a
	 6h/lPLvvmpFhI3jbK9dkrfznRajXdrOf2+isHbrFaWJU1uVy8Bz0Fu0UP4cXLLstkg
	 tacrbY4guqm6E/M6T9MYnOiD/J4IFVZApA2+ziqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgEYFrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:47:32 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62121 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgEYFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:47:28 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 04P5l9A0013208;
        Mon, 25 May 2020 14:47:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04P5l9A0013208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590385629;
        bh=U5HG07zP7ca2X4TcXFbTL58H0LBgSxaGOS7/4KlXXDA=;
        h=From:To:Cc:Subject:Date:From;
        b=tJu2whngR2eETQTKf6XrEQ1x1oU4lWGbp0+qxZY3OyjIafyL0Zqx4Dv54dXAId8AI
         fym6mc89UU9m9IoFCIPMc0AQWbPWRCPMVSy6KigYe/Gd7TMo2plCWnzvMJ4+C7dE7f
         sdcIysmx6GXVdbpBE1n5Qb+DALmLnTZzVcql3SBFVlVLr7FLiF7J+zkCtyOxNjApgK
         C70Um/Z4sXJfn3O0Q4XfidDrSm2DXnpQGnz91kBUE+fMLk9GlBGvfmpUNVSNRAWkDn
         bJEzKHwmL8mkqVdFQYaLlZ43D0OvgbadIOtTeSt5VG8Jl0sjTfHrTkV9yp4W1jOSa3
         cuVKTbahF5QnQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] modpost: fix potential segmentation fault for addend_i386_rel()
Date:   Mon, 25 May 2020 14:47:04 +0900
Message-Id: <20200525054705.1066033-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This may not be a practical problem, but the second pass of ARCH=i386
modpost causes segmentation fault if the -s option is not passed.

    MODPOST 12 modules
  Segmentation fault (core dumped)
  make[2]: *** [scripts/Makefile.modpost:94: __modpost] Error 139
  make[1]: *** [Makefile:1339: modules] Error 2
  make[1]: *** Waiting for unfinished jobs....

The segmentation fault occurs when section_rel() is called for vmlinux,
which is untested in regular builds. The cause of the problem is
reloc_location() returns a wrong pointer for ET_EXEC object type.
In this case, you need to subtract sechdr->sh_addr, otherwise it would
get access beyond the mmap'ed memory.

Add sym_get_data_offset() helper to avoid code duplication.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 34f2aa3a021f..a8306adb3554 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -345,19 +345,23 @@ static const char *sec_name(struct elf_info *elf, int secindex)
 	return sech_name(elf, &elf->sechdrs[secindex]);
 }
 
-static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
+static void *sym_get_data_offset(const struct elf_info *info,
+				 unsigned int secindex, unsigned long offset)
 {
-	unsigned int secindex = get_secindex(info, sym);
 	Elf_Shdr *sechdr = &info->sechdrs[secindex];
-	unsigned long offset;
 
-	offset = sym->st_value;
 	if (info->hdr->e_type != ET_REL)
 		offset -= sechdr->sh_addr;
 
 	return (void *)info->hdr + sechdr->sh_offset + offset;
 }
 
+static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
+{
+	return sym_get_data_offset(info, get_secindex(info, sym),
+				   sym->st_value);
+}
+
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
 static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
@@ -1761,11 +1765,7 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 static unsigned int *reloc_location(struct elf_info *elf,
 				    Elf_Shdr *sechdr, Elf_Rela *r)
 {
-	Elf_Shdr *sechdrs = elf->sechdrs;
-	int section = sechdr->sh_info;
-
-	return (void *)elf->hdr + sechdrs[section].sh_offset +
-		r->r_offset;
+	return sym_get_data_offset(elf, sechdr->sh_info, r->r_offset);
 }
 
 static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
-- 
2.25.1

