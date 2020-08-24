Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FD5206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgHXJRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgHXIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7EFC061796;
        Mon, 24 Aug 2020 01:55:58 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id DBE965B2;
        Mon, 24 Aug 2020 10:55:49 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 07/76] x86/insn: Make inat-tables.c suitable for pre-decompression code
Date:   Mon, 24 Aug 2020 10:54:02 +0200
Message-Id: <20200824085511.7553-8-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The inat-tables.c file has some arrays in it that contain pointers to
other arrays. These pointers need to be relocated when the kernel
image is moved to a different location.

The pre-decompression boot-code has no support for applying ELF
relocations, so initialize these arrays at runtime in the
pre-decompression code to make sure all pointers are correctly
initialized.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20200724160336.5435-7-joro@8bytes.org
---
 arch/x86/tools/gen-insn-attr-x86.awk       | 50 +++++++++++++++++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 50 +++++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..af38469afd14 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 END {
 	if (awkchecked != "")
 		exit 1
+
+	print "#ifndef __BOOT_COMPRESSED\n"
+
 	# print escape opcode map's array
 	print "/* Escape opcode map array */"
 	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
@@ -388,6 +391,51 @@ END {
 		for (j = 0; j < max_lprefix; j++)
 			if (atable[i,j])
 				print "	["i"]["j"] = "atable[i,j]","
-	print "};"
+	print "};\n"
+
+	print "#else /* !__BOOT_COMPRESSED */\n"
+
+	print "/* Escape opcode map array */"
+	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* Group opcode map array */"
+	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* AVX opcode map array */"
+	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "static void inat_init_tables(void)"
+	print "{"
+
+	# print escape opcode map's array
+	print "\t/* Print Escape opcode map array */"
+	for (i = 0; i < geid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (etable[i,j])
+				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
+	print ""
+
+	# print group opcode map's array
+	print "\t/* Print Group opcode map array */"
+	for (i = 0; i < ggid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (gtable[i,j])
+				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
+	print ""
+	# print AVX opcode map's array
+	print "\t/* Print AVX opcode map array */"
+	for (i = 0; i < gaid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (atable[i,j])
+				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
+
+	print "}"
+	print "#endif"
 }
 
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..af38469afd14 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 END {
 	if (awkchecked != "")
 		exit 1
+
+	print "#ifndef __BOOT_COMPRESSED\n"
+
 	# print escape opcode map's array
 	print "/* Escape opcode map array */"
 	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
@@ -388,6 +391,51 @@ END {
 		for (j = 0; j < max_lprefix; j++)
 			if (atable[i,j])
 				print "	["i"]["j"] = "atable[i,j]","
-	print "};"
+	print "};\n"
+
+	print "#else /* !__BOOT_COMPRESSED */\n"
+
+	print "/* Escape opcode map array */"
+	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* Group opcode map array */"
+	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "/* AVX opcode map array */"
+	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1];"
+	print ""
+
+	print "static void inat_init_tables(void)"
+	print "{"
+
+	# print escape opcode map's array
+	print "\t/* Print Escape opcode map array */"
+	for (i = 0; i < geid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (etable[i,j])
+				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
+	print ""
+
+	# print group opcode map's array
+	print "\t/* Print Group opcode map array */"
+	for (i = 0; i < ggid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (gtable[i,j])
+				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
+	print ""
+	# print AVX opcode map's array
+	print "\t/* Print AVX opcode map array */"
+	for (i = 0; i < gaid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (atable[i,j])
+				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
+
+	print "}"
+	print "#endif"
 }
 
-- 
2.28.0

