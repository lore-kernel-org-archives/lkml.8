Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D33E2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb1WjNxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgG3JmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:42:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgG3Jl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfibtHLF7uXMOCrc0RFW3NqEoxXXOO6XJez1MSovrRw=;
        b=eb1WjNxq5zUhUJLVTl9UNA+o+XRiIUGNuiIlsF71E03Qv+yHecbcCFXJQMGzEZiQ3h1R4+
        NhLuT/w8RxoSqjVynbaxg8GlpY9tzTNlaFMGhB7r8pDdXb7lZcsXSq+83LQcOmKpFsyGVZ
        LcppmpJ/KIEjh+f3cn4DxGy7I8ybPAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-ZhhqhucMPZaWyQ8r78MIMw-1; Thu, 30 Jul 2020 05:41:54 -0400
X-MC-Unique: ZhhqhucMPZaWyQ8r78MIMw-1
Received: by mail-wr1-f71.google.com with SMTP id w1so5713300wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfibtHLF7uXMOCrc0RFW3NqEoxXXOO6XJez1MSovrRw=;
        b=kXDAVosF6SFOB4IaiG6icfBLjGVZI8tRYnotpJmiv3iDHuW02lwOL1i+wM/Bax5AgP
         wU9nGvAZakupgAbG9gkiyaMFyrkRwdNWt+kMw3RPT7L/ullOTSLa48rLbJP8BK0M0XtY
         SZfzM5HJRy+JPeYSfspt3l5uaJHL/C66vBs1V0jDDlAw1mrYZdxOH55SbndnncJnCLBq
         ibEUf/7Vsq2qBXf/Rrep5UM8t9zuEbmY1uGLMGxgGnQy1PLpHnviSr9BhqSux5P5Q/m7
         xrTI2ui+BkgYna4ULkkFTQQqBuCfMZHlI+JCyNTlkIKBtAcTe7eByeMCDzZdt31Y69D0
         BPkw==
X-Gm-Message-State: AOAM532oUglYZ2kJ2STZFig7NXfTazuewqOwHwVZgW6ZI5OmxfIVyJmE
        xQNc40N5mdgibvIprYBiFMeEgVihFatowZQIYEFxOuWhFWE/i13tedBmNKFHPrp+ohSB/vx45j7
        XwPF1wSzzo9NkFzszC7VXWxY+
X-Received: by 2002:a5d:6cd0:: with SMTP id c16mr2035125wrc.121.1596102112524;
        Thu, 30 Jul 2020 02:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKqhhrrj0ipyJJl39TcvKw/dgOqOKI2WeK4E1FBym8QpCVhwGZCo/eRh8H4d51FrLkajkYPg==
X-Received: by 2002:a5d:6cd0:: with SMTP id c16mr2035105wrc.121.1596102112339;
        Thu, 30 Jul 2020 02:41:52 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w2sm10984807wre.5.2020.07.30.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:41:51 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of instruction structure
Date:   Thu, 30 Jul 2020 10:41:43 +0100
Message-Id: <20200730094143.27494-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094143.27494-1-jthierry@redhat.com>
References: <20200730094143.27494-1-jthierry@redhat.com>
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

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.h   |  1 -
 tools/objtool/objtool.c |  1 +
 tools/objtool/objtool.h |  1 +
 tools/objtool/orc_gen.c | 80 ++++++++++++++++++++++-------------------
 4 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 061aa96e15d3..059c43bfeb18 100644
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
index d935522c7359..fb66126b00b6 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -61,6 +61,7 @@ struct objtool_file *objtool_setup_file(const char *_objname)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.orc_data_list);
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 44415ed8c7be..e61b486d4c05 100644
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
index 66fd56c33303..00f1efd05653 100644
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
 	struct section *sec, *u_sec, *ip_relocsec;
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
-				if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
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
+			if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
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
 			if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
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
2.21.3

