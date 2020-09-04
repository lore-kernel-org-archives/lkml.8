Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A12074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIDPcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgIDPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:44 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-YPYEynNpPJaq6L1fSULq2A-1; Fri, 04 Sep 2020 11:32:41 -0400
X-MC-Unique: YPYEynNpPJaq6L1fSULq2A-1
Received: by mail-ej1-f70.google.com with SMTP id d8so633239ejt.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFn51Jxy4pRAwPvXw45xwkFaIM6vyiRr+rO29b+TGyw=;
        b=C0la2Wi1C/abLzByCPJjGb0miK/yOk1mPmIgTUzjyYHWo+Bta+DQht9mLFj9wjutAM
         W4roYT4m0XWKSgjj9NLHswI5e+m3Tjx1X81AG2tLuthMLLFiIdJrAUtk5c8yGmI4KWMr
         0GOkZmVekqTEvC8C6c5cV6u/UoPMW6wDtorNo4ZB43lnmDdeuBFzuhERHn7U3auMTgFu
         0EOpPQJ9Zdx2L0w5YCj/jUAQPc+X0wmbNeo4i7z21VjTv0HitHn6KQsYSW5VvhkADF3R
         h/gkUyo4FuglB1JgYwelBZchOoYYISbIhImxefUUDWEE0tsVov9YNe/3iNW/4w3rNe7t
         rqYA==
X-Gm-Message-State: AOAM531S7lUWyzKvG0do/UkmLgfo613jMbClliUFe/Ar7WIvD1mXuCwz
        f5SL4R0OoI9icFWy95KtjhlHIpr8Hwf0XlACtrwdUYZbeVHSdjXA6H19btgMrn8aWoEsVlLnxFS
        YhafLDKgo3K0L5Ap9MSay8JPO
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr3064329ejf.134.1599233560181;
        Fri, 04 Sep 2020 08:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF7cuo3gixAQnKEIWWouNboudlxNmcXhxsXS5NYlh5fzqD6cV9MIRQmFRkdUAYYqPVrhXYTg==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr3064303ejf.134.1599233559914;
        Fri, 04 Sep 2020 08:32:39 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id c2sm6281226edu.3.2020.09.04.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:32:39 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 04/10] objtool: Abstract alternative special case handling
Date:   Fri,  4 Sep 2020 16:30:22 +0100
Message-Id: <20200904153028.32676-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some alternatives associated with a specific feature need to be treated
in a special way. Since the features and how to treat them vary from one
architecture to another, move the special case handling to arch specific
code.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/Build     |  1 +
 tools/objtool/arch/x86/special.c | 37 ++++++++++++++++++++++++++++++++
 tools/objtool/objtool.h          |  2 ++
 tools/objtool/special.c          | 32 +++++----------------------
 tools/objtool/special.h          |  2 ++
 tools/objtool/weak.c             |  2 --
 6 files changed, 47 insertions(+), 29 deletions(-)
 create mode 100644 tools/objtool/arch/x86/special.c

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 7c5004008e97..9f7869b5c5e0 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += special.o
 objtool-y += decode.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
new file mode 100644
index 000000000000..823561e4015c
--- /dev/null
+++ b/tools/objtool/arch/x86/special.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "../../special.h"
+#include "../../builtin.h"
+
+#define X86_FEATURE_POPCNT (4 * 32 + 23)
+#define X86_FEATURE_SMAP   (9 * 32 + 20)
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+	switch (feature) {
+	case X86_FEATURE_SMAP:
+		/*
+		 * If UACCESS validation is enabled; force that alternative;
+		 * otherwise force it the other way.
+		 *
+		 * What we want to avoid is having both the original and the
+		 * alternative code flow at the same time, in that case we can
+		 * find paths that see the STAC but take the NOP instead of
+		 * CLAC and the other way around.
+		 */
+		if (uaccess)
+			alt->skip_orig = true;
+		else
+			alt->skip_alt = true;
+		break;
+	case X86_FEATURE_POPCNT:
+		/*
+		 * It has been requested that we don't validate the !POPCNT
+		 * feature path which is a "very very small percentage of
+		 * machines".
+		 */
+		alt->skip_orig = true;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 46240098f08d..79716f4158e8 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -12,6 +12,8 @@
 
 #include "elf.h"
 
+#define __weak __attribute__((weak))
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index b04f395de5de..1a2420febd08 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -16,9 +16,6 @@
 #include "warn.h"
 #include "arch_special.h"
 
-#define X86_FEATURE_POPCNT (4*32+23)
-#define X86_FEATURE_SMAP   (9*32+20)
-
 struct special_entry {
 	const char *sec;
 	bool group, jump_or_nop;
@@ -54,6 +51,10 @@ struct special_entry entries[] = {
 	{},
 };
 
+void __weak arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+}
+
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
@@ -78,30 +79,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 
 		feature = *(unsigned short *)(sec->data->d_buf + offset +
 					      entry->feature);
-
-		/*
-		 * It has been requested that we don't validate the !POPCNT
-		 * feature path which is a "very very small percentage of
-		 * machines".
-		 */
-		if (feature == X86_FEATURE_POPCNT)
-			alt->skip_orig = true;
-
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
+		arch_handle_alternative(feature, alt);
 	}
 
 	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 35061530e46e..44da89afeda2 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -28,4 +28,6 @@ struct special_alt {
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+
 #endif /* _SPECIAL_H */
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 29180d599b08..7843e9a7a72f 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -9,8 +9,6 @@
 #include <errno.h>
 #include "objtool.h"
 
-#define __weak __attribute__((weak))
-
 #define UNSUPPORTED(name)						\
 ({									\
 	fprintf(stderr, "error: objtool: " name " not implemented\n");	\
-- 
2.21.3

