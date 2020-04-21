Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3DC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627B320724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXX1HOXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDUWI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:08:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D40C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:08:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x2so263836pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fVIRB7nPAwO8kLy6VX4zUFaducbG0VpK9IknjM4RI4M=;
        b=FXX1HOXKJ7NoZpycK1aXAxzvWkUyMHLSvNaa3Af371ceMDmmzoYJ8FRRPn7/kxTIYL
         qECNrHZdU3kJzO74hxmvqU6+PBsqV4xUPgGyIuec1ifXmuDRRG4PIZA2cZ1qTG9u8GAr
         OQkvXcv3DI1iNjEwGh+72a6J2s3RCLZozBlS2RdOpJdaV5HJUGFH51ysoysgg5JLuRYz
         LRCWNOU5cWksQUklXDG4PzmoosDZ5zWF2hUifFwmKW77s7PoRFmLKNi21yHJp6QzGSX/
         9n1vToyVgKB6Q+8iDgXCBs2yT/IRHxmbe02gk+IVv5Bvo6W0ERVFkJDAcHnxoQMcgXXt
         MKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fVIRB7nPAwO8kLy6VX4zUFaducbG0VpK9IknjM4RI4M=;
        b=eq5tNQk2xOUk3KvaNg4NvmxvoFfIfQd11odLR71uH+NUf9s8Y9uHO6Gc+sWCVFPtj1
         VTffIlH6wx7qUGrqsQIdx6poOkI+iZiCVuMWV2dOUH1HrQw29KSE9OcZ4sKyuf+mDOtR
         GnEBbxAxqvVFK4pJGIa7CTnHwyfAbGYK3obSbgBrU12HiXf/ml/PJ5Y7rolzOEfzmQ5I
         5fQXV62xorNIAhRXT78QDqY4WiwQNzhGyXGDT06bzyH5J7nQGOt5DrjO60KW2G0D8kaW
         uybAjfaLCIlLEGEV6qaIN7s3lhvF7Juqr4CtmxlTXAVKimdN0ZRGHdP+1DVfDAQgdmly
         3rPQ==
X-Gm-Message-State: AGi0PuYaHV0xQIDqgCEalL3sOsRd3xdcC3A3ZwCHucL0G95dQE+XHj8F
        kMgsE3x6130Ql9P+iFhHhdErNAzQwX0owqx00CI=
X-Google-Smtp-Source: APiQypL9e8XUj6ZMTAwWNC0wEGQbiIDAdeJIGiAEo/q8Sl4WkumgUPUz6VEo7s8myVHV/2CYLeFSTOrAdrl4jO6vIec=
X-Received: by 2002:a63:5009:: with SMTP id e9mr14580502pgb.381.1587506936222;
 Tue, 21 Apr 2020 15:08:56 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:08:42 -0700
In-Reply-To: <20200421220843.188260-1-samitolvanen@google.com>
Message-Id: <20200421220843.188260-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com> <20200421220843.188260-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2 1/2] objtool: use gelf_getsymshndx to handle >64k sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, objtool fails to load the correct section for symbols when
the index is greater than SHN_LORESERVE. Use gelf_getsymshndx instead
of gelf_getsym to handle >64k sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/elf.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f1def3..887445e87380 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -327,12 +327,14 @@ static int read_sections(struct elf *elf)
 
 static int read_symbols(struct elf *elf)
 {
-	struct section *symtab, *sec;
+	struct section *symtab, *symtab_shndx, *sec;
 	struct symbol *sym, *pfunc;
 	struct list_head *entry;
 	struct rb_node *pnode;
 	int symbols_nr, i;
 	char *coldstr;
+	Elf_Data *shndx_data = NULL;
+	Elf32_Word shndx;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
@@ -340,6 +342,10 @@ static int read_symbols(struct elf *elf)
 		return -1;
 	}
 
+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+	if (symtab_shndx)
+		shndx_data = symtab_shndx->data;
+
 	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
 
 	for (i = 0; i < symbols_nr; i++) {
@@ -353,8 +359,9 @@ static int read_symbols(struct elf *elf)
 
 		sym->idx = i;
 
-		if (!gelf_getsym(symtab->data, i, &sym->sym)) {
-			WARN_ELF("gelf_getsym");
+		if (!gelf_getsymshndx(symtab->data, shndx_data, i, &sym->sym,
+				      &shndx)) {
+			WARN_ELF("gelf_getsymshndx");
 			goto err;
 		}
 
@@ -368,10 +375,13 @@ static int read_symbols(struct elf *elf)
 		sym->type = GELF_ST_TYPE(sym->sym.st_info);
 		sym->bind = GELF_ST_BIND(sym->sym.st_info);
 
-		if (sym->sym.st_shndx > SHN_UNDEF &&
-		    sym->sym.st_shndx < SHN_LORESERVE) {
-			sym->sec = find_section_by_index(elf,
-							 sym->sym.st_shndx);
+		if ((sym->sym.st_shndx > SHN_UNDEF &&
+		     sym->sym.st_shndx < SHN_LORESERVE) ||
+		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
+			if (sym->sym.st_shndx != SHN_XINDEX)
+				shndx = sym->sym.st_shndx;
+
+			sym->sec = find_section_by_index(elf, shndx);
 			if (!sym->sec) {
 				WARN("couldn't find section for symbol %s",
 				     sym->name);
-- 
2.26.1.301.g55bc3eb7cb9-goog

