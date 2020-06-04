Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C65DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9F920738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA/AYhCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgFDQjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:39:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729870AbgFDQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NF2VWmtkVvO+oeaxQB5cRYXlRd5YODZUpdBaRJJyuxY=;
        b=JA/AYhCv1gpJh2cxF/SNevytUgNeqFOCGgKREap3x1HvAPmSIzOTBua88ip8dwpCQk45hJ
        ggLf/PpJocLQHBzFAgBKswjRuQ9EcpM8wfA9GMFiDalAgddTGNP1s4E8VuRM7bGi7RFldq
        1yLq5a53xrEUsnM2g39NZG8/agqQ+6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-bxUu6voQPoCX2Yz43unlkA-1; Thu, 04 Jun 2020 12:39:48 -0400
X-MC-Unique: bxUu6voQPoCX2Yz43unlkA-1
Received: by mail-wm1-f70.google.com with SMTP id l26so2177393wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF2VWmtkVvO+oeaxQB5cRYXlRd5YODZUpdBaRJJyuxY=;
        b=qffWlaLUF3oqoVd+VFB5nI8SaWtfgRsov7Q7JlciHBzhZTVthE4QexRpFCo7os4xOQ
         TwbVGKVIilkIeIH2qSPUcjoZYF/S5RGez6MpbKdC68oFNr0GYjLhyxzpa/eAHhzlr41j
         grY2WjIdavkvT2AtWo1d+buCkczUqzlOOZ3PQ1wL+wttTfP3mZpzW+/c7a8KgLLdSSJm
         zPXTuUz/I7fe0h1kFJpyb7rvvd9MRtUvoW1NqOrfIIqR9pYg2xeaiRjquntn/JZsbvvP
         NxEcyaz8nNgqZmCCcjw2+ErJpYG2fmpzytN7ICXCasPoiZpm43eyuQsGzX2iszhpWFHk
         o52A==
X-Gm-Message-State: AOAM532MoJpI91zGXlZmM82YVv6fW2PdqvQ2m8bsJ5DF2WwmfWVwdxOd
        P2R2pHh18atP4kRetjksKjjYcnv12UF5F7WDpTl/zyH4PP0MWYEDT1pGdYt07pjNUR3vtE3sLaM
        rBZPAX57723AUHD5SF75W3LUv
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr4885319wml.150.1591288787127;
        Thu, 04 Jun 2020 09:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGIG9Pfd7dIp+fBM1Zqy4JU1CRS4AWh3kfAVD0A17nuZ8iAGuKV57PyHrfO0vZBTYFbTjJTg==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr4885299wml.150.1591288786889;
        Thu, 04 Jun 2020 09:39:46 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p9sm7881636wma.48.2020.06.04.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 4/4] objtool: orc_gen: Move orc_entry out of instruction structure
Date:   Thu,  4 Jun 2020 17:39:38 +0100
Message-Id: <20200604163938.21660-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200604163938.21660-1-jthierry@redhat.com>
References: <20200604163938.21660-1-jthierry@redhat.com>
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
 tools/objtool/orc_gen.c | 83 +++++++++++++++++++++++------------------
 4 files changed, 49 insertions(+), 37 deletions(-)

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
index e74578640705..b8d199682530 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,14 +9,32 @@
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
+
+		if (!insn->sec->text)
+			continue;
+
+		od = calloc(1, sizeof(*od));
+		if (!od)
+			return -1;
+		od->insn = insn;
+		list_add_tail(&od->list, &file->orc_data_list);
+
+		orc = &od->orc;
 
 		if (!insn->sec->text)
 			continue;
@@ -139,7 +157,7 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 
 int create_orc_sections(struct objtool_file *file)
 {
-	struct instruction *insn, *prev_insn;
+	struct orc_data *od, *prev_od;
 	struct section *sec, *u_sec, *ip_relasec;
 	unsigned int idx;
 
@@ -157,23 +175,21 @@ int create_orc_sections(struct objtool_file *file)
 
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
@@ -194,33 +210,28 @@ int create_orc_sections(struct objtool_file *file)
 
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

