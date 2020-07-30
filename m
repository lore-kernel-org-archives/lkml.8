Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B32075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdtxqKKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgG3JrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57769 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgG3JrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wi8mm7gHwd6vIQMzZEoFyCS7pwa2saGRLGk8mEsioFE=;
        b=XdtxqKKZfO1Bwa6uEEZzt4PWQmim0kJ34Zzuj/fbKg6LS+GnHWRIo44mmalf63K8Wp7rZU
        SqLgumPu4pEQCv0ZeKlxb8GldWmhVKV+Gq2VN1nqlpf/CIwKHw5Zh2ZcAlTe55SBIUCB84
        l6FSEWYap5Jut6Ogdo4rdoHUf7ELwQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-3iLfaSOyPhyM-MGgj31FqQ-1; Thu, 30 Jul 2020 05:47:02 -0400
X-MC-Unique: 3iLfaSOyPhyM-MGgj31FqQ-1
Received: by mail-wr1-f70.google.com with SMTP id e14so4264414wrr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wi8mm7gHwd6vIQMzZEoFyCS7pwa2saGRLGk8mEsioFE=;
        b=WtKNlGXSqu83zhT0q0XJ0FwLGoVgo4P35wdQ08jbuCp+PSUBqCuEYGM7CIwz/kySnG
         FK9MVDNU/Zgg551XEgjnJNYJ89u4nZ6Km3d0QMQ3n4YX6/cl+HekPuOAGNG9lT3KrCDu
         InBgdECd3LHgrnzFpCEDc7kO3kiYfsQGIkR+uLSCG/Kgi91FigDzSCAs3R3LNs//lZsA
         sAgNVIf1UPYOX7IkbTM+qxBvUYXAwYZsCb1R8dCx08HK5Oqlxq5j4qbrqlDS8mUZz8Cu
         uiJ+RvDtJiXTouGdtUB+s2aPfbeQw8gVQt9p6kvLcycCDY+7U5bgRuAP/42YPcvsdxQX
         mxnw==
X-Gm-Message-State: AOAM531DZ6DeC9EbVqDqLr+U8G1Rxipabbo3aUvLSa99rUx0TUAxRu01
        LAVn1d5IS0Ysx9x46KzqfRKIVd8UesVEdDPef7+nWQWTOjMdoVFyoOQ0tkyKwILRzU/dPomb/+R
        SpKoYZnmM0D4rsjA1LGzQToGo
X-Received: by 2002:adf:f785:: with SMTP id q5mr2030712wrp.298.1596102420879;
        Thu, 30 Jul 2020 02:47:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+YJ2bh7Sc5tNgal10W4is8YYs6UmHJwjekbGeVeGUKG+wn7vp4t1fdKUC7gO+J8QX3MU1+w==
X-Received: by 2002:adf:f785:: with SMTP id q5mr2030693wrp.298.1596102420618;
        Thu, 30 Jul 2020 02:47:00 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:47:00 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 4/9] objtool: Abstract alternative special case handling
Date:   Thu, 30 Jul 2020 10:46:47 +0100
Message-Id: <20200730094652.28297-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
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
 tools/objtool/arch/x86/Build          |  1 +
 tools/objtool/arch/x86/arch_special.c | 37 +++++++++++++++++++++++++++
 tools/objtool/objtool.h               |  2 ++
 tools/objtool/special.c               | 32 ++++-------------------
 tools/objtool/special.h               |  2 ++
 tools/objtool/weak.c                  |  2 --
 6 files changed, 47 insertions(+), 29 deletions(-)
 create mode 100644 tools/objtool/arch/x86/arch_special.c

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 7c5004008e97..2c3ac13cfa8b 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += arch_special.o
 objtool-y += decode.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
new file mode 100644
index 000000000000..823561e4015c
--- /dev/null
+++ b/tools/objtool/arch/x86/arch_special.c
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
index e61b486d4c05..1f85409a57f9 100644
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

