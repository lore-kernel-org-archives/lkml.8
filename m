Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C112CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2BA204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGAXH31i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgFHHMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728962AbgFHHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591600336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhxlGEdhGr0WzOuPguHbjscJhIjlOzHFg1/B+oc7B6U=;
        b=OGAXH31iVs5acuwpy2ckIz6Pi5krBUVX4S+yzn+uQUQ+DUg+hHUQGFZXuU9CuAYnlsdfda
        3cR6dX0Khj0cR2IHkl4mb7ntJG/ealtUuZqmbf4VD5zGwNlpqrBXRp0YBvGc63fq1SNxZS
        TLT/XLJWFK/eAYLGkb2bWBKILXeKkaI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200--RD5z2B6N5Gel6RYKyzqtQ-1; Mon, 08 Jun 2020 03:12:14 -0400
X-MC-Unique: -RD5z2B6N5Gel6RYKyzqtQ-1
Received: by mail-wr1-f72.google.com with SMTP id l1so6760069wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhxlGEdhGr0WzOuPguHbjscJhIjlOzHFg1/B+oc7B6U=;
        b=oKVTeRp9AsWlWAi3rvDoiXJKPOE+k9OL9r18OEMe30lUtLnmfSMX4aUKlhzY5Asbew
         2MCkD68L6sXElVt9HM4jkHgHbun7ZqPjnag/bwrlMxghg8d6xugqcEnkod7ChcZaKJSo
         v1qYfpm5IYm9t994RTyrgGgsQQu742OxEidkJiyJQzkcCIEtLcILZEVkXYNpRhWbG0iF
         7jO6zbOdaPAjg4Nszrt06HjMhKDCuuSmWJ9052F+Lkmt/wSUCqsTXep9L2us+8de058V
         9e0eEX1WUaJRACk79Mhen/32UMnCVhVaFk5P9koa4vryA+KKidsUSwsQYXa0UUOQNcyC
         9nBQ==
X-Gm-Message-State: AOAM532BJ8cp3Tk3mmEjV9XVO10Et4XYzB37CzdKr2igadlCCG00XqrR
        Zp+Mfy/pcXXpP8phVc5wBE49Uq7LvqLmZEM2jewZEnX8FSX8P8NsQqpRwf+QNo/5Q0iu31sMrmA
        DCKdLt8jjCW+uFCTj8ITkg9RD
X-Received: by 2002:a1c:a505:: with SMTP id o5mr15261442wme.143.1591600332832;
        Mon, 08 Jun 2020 00:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmXKSUec9uR9Gg8n2e7owcd9iUKapNmGpnOQ2lfkMkQ0WG7tUYKFRMudlr9tw39HJG4U86tg==
X-Received: by 2002:a1c:a505:: with SMTP id o5mr15261428wme.143.1591600332610;
        Mon, 08 Jun 2020 00:12:12 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w17sm22908254wra.71.2020.06.08.00.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 00:12:12 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 4/4] objtool: orc_gen: Move orc_entry out of instruction structure
Date:   Mon,  8 Jun 2020 08:12:03 +0100
Message-Id: <20200608071203.4055-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608071203.4055-1-jthierry@redhat.com>
References: <20200608071203.4055-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One orc_entry is associated with each instruction in the object file,
but having the orc_entry contained by the instruction structure forces
architectures not implementing the orc subcommands to provide a dummy
definition of the orc_entry.

Avoid that by having orc_entries in a separate list, part of the
objtool_file.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.h   |  1 -
 tools/objtool/objtool.c |  1 +
 tools/objtool/objtool.h |  1 +
 tools/objtool/orc_gen.c | 80 ++++++++++++++++++++++-------------------
 4 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 906b5210f7ca..49f9a5cc4228 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -42,7 +42,6 @@ struct instruction {
 	struct symbol *func;
 	struct list_head stack_ops;
 	struct cfi_state cfi;
-	struct orc_entry orc;
 };
 
 struct instruction *find_insn(struct objtool_file *file,
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 71c4122cf491..4b2e8013edb8 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -61,6 +61,7 @@ struct objtool_file *objtool_setup_file(const char *_objname, bool writable)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.orc_data_list);
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index be526f3d294d..e782c4206cb2 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -16,6 +16,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head orc_data_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index e74578640705..2c4e1974bbb5 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,18 +9,33 @@
 #include "check.h"
 #include "warn.h"
 
+struct orc_data {
+	struct list_head list;
+	struct instruction *insn;
+	struct orc_entry orc;
+};
+
 int create_orc(struct objtool_file *file)
 {
 	struct instruction *insn;
 
 	for_each_insn(file, insn) {
-		struct orc_entry *orc = &insn->orc;
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
+		struct orc_entry *orc;
+		struct orc_data *od;
 
 		if (!insn->sec->text)
 			continue;
 
+		od = calloc(1, sizeof(*od));
+		if (!od)
+			return -1;
+		od->insn = insn;
+		list_add_tail(&od->list, &file->orc_data_list);
+
+		orc = &od->orc;
+
 		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
@@ -139,7 +154,7 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 
 int create_orc_sections(struct objtool_file *file)
 {
-	struct instruction *insn, *prev_insn;
+	struct orc_data *od, *prev_od;
 	struct section *sec, *u_sec, *ip_relasec;
 	unsigned int idx;
 
@@ -157,23 +172,21 @@ int create_orc_sections(struct objtool_file *file)
 
 	/* count the number of needed orcs */
 	idx = 0;
-	for_each_sec(file, sec) {
-		if (!sec->text)
-			continue;
-
-		prev_insn = NULL;
-		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn ||
-			    memcmp(&insn->orc, &prev_insn->orc,
-				   sizeof(struct orc_entry))) {
-				idx++;
-			}
-			prev_insn = insn;
+	prev_od = NULL;
+	list_for_each_entry(od, &file->orc_data_list, list) {
+		if (!prev_od ||
+		    memcmp(&od->orc, &prev_od->orc, sizeof(struct orc_entry))) {
+			idx++;
 		}
 
+		prev_od = od;
+
 		/* section terminator */
-		if (prev_insn)
+		if (list_is_last(&od->insn->list, &file->insn_list) ||
+		    list_next_entry(od->insn, list)->sec != od->insn->sec) {
+			prev_od = NULL;
 			idx++;
+		}
 	}
 	if (!idx)
 		return -1;
@@ -194,33 +207,28 @@ int create_orc_sections(struct objtool_file *file)
 
 	/* populate sections */
 	idx = 0;
-	for_each_sec(file, sec) {
-		if (!sec->text)
-			continue;
-
-		prev_insn = NULL;
-		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
-						 sizeof(struct orc_entry))) {
-
-				if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
-						     insn->sec, insn->offset,
-						     &insn->orc))
-					return -1;
-
-				idx++;
-			}
-			prev_insn = insn;
+	prev_od = NULL;
+	list_for_each_entry(od, &file->orc_data_list, list) {
+		if (!prev_od ||
+		    memcmp(&od->orc, &prev_od->orc, sizeof(struct orc_entry))) {
+			if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
+					     od->insn->sec, od->insn->offset,
+					     &od->orc))
+				return -1;
+			idx++;
 		}
 
+		prev_od = od;
+
 		/* section terminator */
-		if (prev_insn) {
+		if (list_is_last(&od->insn->list, &file->insn_list) ||
+		    list_next_entry(od->insn, list)->sec != od->insn->sec) {
 			if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
-					     prev_insn->sec,
-					     prev_insn->offset + prev_insn->len,
+					     prev_od->insn->sec,
+					     prev_od->insn->offset + prev_od->insn->len,
 					     &empty))
 				return -1;
-
+			prev_od = NULL;
 			idx++;
 		}
 	}
-- 
2.21.1

