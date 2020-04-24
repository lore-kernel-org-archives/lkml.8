Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73434C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5BD2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587730985;
	bh=YphpFFixkiyfnywxVYFRTXsrp7Q0WASly/v6cgjf3Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dFslRrZ4X4o/4h8e7n08PlyYxeTktref2Za364DImU5DXM/Eg6q7ECsk3OBCCPnYI
	 1HbMhnJRpCLbsbpmgPK8fKlu0uS4WBQ5W1VHxST+vP1veQK/f/WTJIjCC4FI8Kvoab
	 IhLEvU/LncpxlwM5H+yciVXDPg6f5xVsvUpaCjGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgDXMXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgDXMXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF1021473;
        Fri, 24 Apr 2020 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730980;
        bh=YphpFFixkiyfnywxVYFRTXsrp7Q0WASly/v6cgjf3Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4UAN+Qi0Giz9grWypihfVUxxR5ZyZx2HwN3iF5qJy+IbMGJUI2SxCUfHqP05LDBu
         Ro2Z73fYLK2s7XSv4Md+YHZU+GWzO/5Cg1l3TxQyStgI96TT/O8SiP37RXqJFCYsyH
         +EeALZdgvJzKZofMavFFDB0fd6oGR4FlTadft7kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.6 20/38] objtool: Support Clang non-section symbols in ORC dump
Date:   Fri, 24 Apr 2020 08:22:18 -0400
Message-Id: <20200424122237.9831-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 8782e7cab51b6bf01a5a86471dd82228af1ac185 ]

Historically, the relocation symbols for ORC entries have only been
section symbols:

  .text+0: sp:sp+8 bp:(und) type:call end:0

However, the Clang assembler is aggressive about stripping section
symbols.  In that case we will need to use function symbols:

  freezing_slow_path+0: sp:sp+8 bp:(und) type:call end:0

In preparation for the generation of such entries in "objtool orc
generate", add support for reading them in "objtool orc dump".

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/b811b5eb1a42602c3b523576dc5efab9ad1c174d.1585761021.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 13ccf775a83a4..ba4cbb1cdd632 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -66,7 +66,7 @@ int orc_dump(const char *_objname)
 	char *name;
 	size_t nr_sections;
 	Elf64_Addr orc_ip_addr = 0;
-	size_t shstrtab_idx;
+	size_t shstrtab_idx, strtab_idx = 0;
 	Elf *elf;
 	Elf_Scn *scn;
 	GElf_Shdr sh;
@@ -127,6 +127,8 @@ int orc_dump(const char *_objname)
 
 		if (!strcmp(name, ".symtab")) {
 			symtab = data;
+		} else if (!strcmp(name, ".strtab")) {
+			strtab_idx = i;
 		} else if (!strcmp(name, ".orc_unwind")) {
 			orc = data->d_buf;
 			orc_size = sh.sh_size;
@@ -138,7 +140,7 @@ int orc_dump(const char *_objname)
 		}
 	}
 
-	if (!symtab || !orc || !orc_ip)
+	if (!symtab || !strtab_idx || !orc || !orc_ip)
 		return 0;
 
 	if (orc_size % sizeof(*orc) != 0) {
@@ -159,21 +161,29 @@ int orc_dump(const char *_objname)
 				return -1;
 			}
 
-			scn = elf_getscn(elf, sym.st_shndx);
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
-			name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
-			if (!name || !*name) {
-				WARN_ELF("elf_strptr");
-				return -1;
+			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
+				scn = elf_getscn(elf, sym.st_shndx);
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
+				name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
+			} else {
+				name = elf_strptr(elf, strtab_idx, sym.st_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
 			}
 
 			printf("%s+%llx:", name, (unsigned long long)rela.r_addend);
-- 
2.20.1

