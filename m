Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0962074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWlcsr3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgFHP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730221AbgFHP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8tgehvgsXhlf6vQT+Av9FgdAYyP8CTr3Lu8z7Ma5tk=;
        b=AWlcsr3mpMHQJV499h0QQOMATqC9lpaDusE/EnMa3N4wZSNJusCmKAA9uAU0nVXTSMXe42
        X2G9tLJUFSIHffgUfNYPOReq/khnq+we2l6Q9dOcnnftc4/Cv76cm+vkuVkKVTpqmgkib5
        jxdH6F39jdjBun2Geo+SnmTyA9F/5u4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-tITEqot_O7Sv1dvFZD8vAg-1; Mon, 08 Jun 2020 11:28:03 -0400
X-MC-Unique: tITEqot_O7Sv1dvFZD8vAg-1
Received: by mail-wr1-f71.google.com with SMTP id s7so7320270wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8tgehvgsXhlf6vQT+Av9FgdAYyP8CTr3Lu8z7Ma5tk=;
        b=eFnRehkYPnpOPyP1P6AoaZV7Zf61lWFRfw4H/JLMVToREDvy6XAiZhlEqWccglyiOF
         Xj8rpB01lwppgulJ2KFkR9tVnctNiLXdBrQFKyquUBHuc2U+gII1S5RvDbzRQUXOHMUl
         M2c+Zz9iLK+9bGxdpDHuBEOckNTi2oBX/UotaK0DUuG4GeZgxABjNFdzTJSUOcSp1akX
         VRVACCXT1HGbkajq/X2L23TtqlCEJeN1zMk8HBJlgzYUcqsbDZGS0oHtDFilBGTYt0Eh
         zbDidHtWmHZSqS7L/EjOAdq/h/fXwxlMIYkcGhjCt5kqpZqgy5loDXNqVT4nIKydrYGM
         7HGQ==
X-Gm-Message-State: AOAM532zf+gGm5y5mX14RUlk70QuCC7ggQKqBelavHTp7UoS4fg195Y0
        KssBCB5AWgwrEDyNrQOnXwV803coUdxjU/dZnwKYYUJdLHg6UNkaXUhFjZi2AFbdprMpHt+6Exs
        PRV46GCtdvhV8MnjqlNonU4Vx
X-Received: by 2002:a1c:b703:: with SMTP id h3mr16471081wmf.81.1591630081557;
        Mon, 08 Jun 2020 08:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT0XBolmpC462zCe+enRlod0vfE5xwofFtbve5ujQUvtgr2FtvOSrQz3Ly2JVp8ywrAbwxsg==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr16471057wmf.81.1591630081316;
        Mon, 08 Jun 2020 08:28:01 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:28:00 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 4/7] objtool: Abstract alternative special case handling
Date:   Mon,  8 Jun 2020 16:27:51 +0100
Message-Id: <20200608152754.2483-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
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
index e782c4206cb2..46c19a99d71f 100644
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
index 2bd57db0881f..1b065d19666e 100644
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
 
 	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
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
2.21.1

