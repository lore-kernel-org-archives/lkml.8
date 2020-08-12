Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F33C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A02078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLR5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:57:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:26216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgHLR5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:57:40 -0400
IronPort-SDR: +oJdrqhFuEDCDMhamysOFNL8q4gji2cCGT38C5lLCHBnNIAoxgxXWqm1zTK9DhCzoYVnxBCnqY
 1rGrj7ucNl7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="153246798"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="153246798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 10:57:39 -0700
IronPort-SDR: xTwv1iZ79CTx+SFvA7fplLSaDcfHXYgp4Pk2hKuzjbS7gH+Hwac/c7TR2r1bbHXyT2ELcTVSMK
 de6WDfiV0l9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439468014"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.13.108])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2020 10:57:37 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: support symtab_shndx during dump
Date:   Wed, 12 Aug 2020 10:57:11 -0700
Message-Id: <20200812175712.9462-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting the symbol index number, make sure to use the
extended symbol table information in order to support symbol
index's greater than 64K.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 tools/objtool/orc_dump.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index fca46e006fc2..cf835069724a 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -74,7 +74,8 @@ int orc_dump(const char *_objname)
 	GElf_Rela rela;
 	GElf_Sym sym;
 	Elf_Data *data, *symtab = NULL, *rela_orc_ip = NULL;
-
+	Elf_Data *xsymtab = NULL;
+	Elf32_Word shndx;
 
 	objname = _objname;
 
@@ -138,6 +139,8 @@ int orc_dump(const char *_objname)
 			orc_ip_addr = sh.sh_addr;
 		} else if (!strcmp(name, ".rela.orc_unwind_ip")) {
 			rela_orc_ip = data;
+		} else if (!strcmp(name, ".symtab_shndx")) {
+			xsymtab = data;
 		}
 	}
 
@@ -157,13 +160,22 @@ int orc_dump(const char *_objname)
 				return -1;
 			}
 
-			if (!gelf_getsym(symtab, GELF_R_SYM(rela.r_info), &sym)) {
-				WARN_ELF("gelf_getsym");
+			if (!gelf_getsymshndx(symtab, xsymtab,
+					      GELF_R_SYM(rela.r_info),
+					      &sym, &shndx)) {
+				WARN_ELF("gelf_getsymshndx");
 				return -1;
 			}
 
 			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
-				scn = elf_getscn(elf, sym.st_shndx);
+				if ((sym.st_shndx > SHN_UNDEF &&
+				     sym.st_shndx < SHN_LORESERVE) ||
+				    (xsymtab && sym.st_shndx == SHN_XINDEX)) {
+					if (sym.st_shndx != SHN_XINDEX)
+						shndx = sym.st_shndx;
+				}
+
+				scn = elf_getscn(elf, shndx);
 				if (!scn) {
 					WARN_ELF("elf_getscn");
 					return -1;
-- 
2.20.1

