Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D2C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF57214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBEWkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:40:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:60113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgBEWjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:39:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="225092435"
Received: from unknown (HELO localhost.jf.intel.com) ([10.54.75.26])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2020 14:39:34 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org
Cc:     rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [RFC PATCH 01/11] modpost: Support >64K sections
Date:   Wed,  5 Feb 2020 14:39:40 -0800
Message-Id: <20200205223950.1212394-2-kristen@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205223950.1212394-1-kristen@linux.intel.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ELF specification, if the value of st_shndx
contains SH_XINDEX, the actual section header index is too
large to fit in the st_shndx field and you should use the
value out of the SHT_SYMTAB_SHNDX section instead. This table
was already being parsed and saved into symtab_shndx_start, however
it was not being used, causing segfaults when the number of
sections is greater than 64K. Check the st_shndx field for
SHN_XINDEX prior to using.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 scripts/mod/modpost.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6e892c93d104..5ce7e9dc2f04 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -305,9 +305,23 @@ static const char *sec_name(struct elf_info *elf, int secindex)
 	return sech_name(elf, &elf->sechdrs[secindex]);
 }
 
+static int sym_index(const Elf_Sym *sym, const struct elf_info *info)
+{
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return sym->st_shndx;
+
+	offset = (unsigned long)sym - (unsigned long)info->symtab_start;
+	index = offset/(sizeof(*sym));
+
+	return TO_NATIVE(info->symtab_shndx_start[index]);
+}
+
 static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
 {
-	Elf_Shdr *sechdr = &info->sechdrs[sym->st_shndx];
+	Elf_Shdr *sechdr = &info->sechdrs[sym_index(sym, info)];
 	unsigned long offset;
 
 	offset = sym->st_value;
-- 
2.24.1

