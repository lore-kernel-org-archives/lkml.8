Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B7FC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D3C206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrtXSJeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgDUSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:07:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD67C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:33 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s1so841741plp.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u84nMYTM/aCcuXjZBK5Ir58g2g4r7pb0sY8hFgtOygc=;
        b=lrtXSJeHdqS4AlGPwl5fcpakFrIFrBwi1BvieZiR2diHOi7Aek6vh9r0caWr42mygV
         j27zEh/lKO11txBRZud5+PPnEUUDio26goEhFdkfBZyTXpfZ+g//bd+TE/+5zQa8B0lR
         xNC+7wRGDazkhwObDUHVxx0vrKXnAE1PUVJz4DubNHh4q+lrt0/ku4NGsbsX/y40Hk/v
         OmpxcTejoZy+SPgBawB+RxdlUb0mqpH8OxhQ/maRXB2TIxPNv/DAFU0SCNtb4lyBE4W2
         oWyd3h9hba5OLCkc5GVm6A7YVDOXCAnW1U3psgduHG1hnYr/uRlxLsv4BTFMIqNVSyVF
         8daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u84nMYTM/aCcuXjZBK5Ir58g2g4r7pb0sY8hFgtOygc=;
        b=Ezs8tn8MzXj934DLCfWpHYXlo1bz6FNG/q48Jruztnz5PjZiTl2789AQo2wXlopVNg
         612+AGiFxVi0nj62c0onjnGHvOOYpJLlH3zHSZvJQZV7xGegUkNlNNS8HdQoUszXnzI8
         otOKL8ktVnc5B3ZWGLZ44BrxUkfsavHodGZYUqYpHXcNcLLxM/0FyXtv2HTW9EE7RhLH
         ulDSCWunOtNi+wtbeximcaE/7J3jhJqsgrNxFpu2na1m/6pwxVwF8p87XyvgmzMCT1Vs
         bEQlBfpQzcRxuVB2Hq4UA9TfMzrKiP7gJvsJfPmy9jkl8znXOlSYWWaq+/gIjfbA++zX
         G11A==
X-Gm-Message-State: AGi0Pubpk4/wf9VS0dkDSx55HbUaibovEVAlGjXvAAk1+qMherlWhEjp
        CypJSArtuuZ6ThJqCRAT9UvT6U07wqNeq5MAgSQ=
X-Google-Smtp-Source: APiQypIHr6HZh1mJWTTDwEDmTgx8aECtimv9lvVH5+70PNToGcK9taxaKTFYUKVXOvOdZYsw/H0M7F1vNCSAW/DQRPI=
X-Received: by 2002:a63:545:: with SMTP id 66mr22531339pgf.66.1587492453152;
 Tue, 21 Apr 2020 11:07:33 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:07:22 -0700
In-Reply-To: <20200421180724.245410-1-samitolvanen@google.com>
Message-Id: <20200421180724.245410-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 1/3] objtool: use gelf_getsymshndx to handle >64k sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
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

