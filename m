Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB29C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA320784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442270AbgDOVIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:08:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:64181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442242AbgDOVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:06:00 -0400
IronPort-SDR: qvys6GKRLvYsrDhWLB5SMBFTGumEQD4zNtmFu/+wteOnOXvIZrjoZ/9a/Ere2FGW27bChaHRFP
 VIJeRMq6J4Cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 14:05:40 -0700
IronPort-SDR: 5NmaIRolpxwZ7///i8EhtVYQNaOyMjZP7JSXEUZoz/Lyy4pJxaGbfCCQFe9qXmggsANzKLJMBN
 6Bu3/2RDxV1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="455035629"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.116.191])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 14:05:37 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jessica Yu <jeyu@kernel.org>
Cc:     arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecomb@intel.com
Subject: [PATCH 9/9] module: Reorder functions
Date:   Wed, 15 Apr 2020 14:04:51 -0700
Message-Id: <20200415210452.27436-10-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415210452.27436-1-kristen@linux.intel.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a module has functions split out into separate text sections
(i.e. compiled with the -ffunction-sections flag), reorder the
functions to provide some code diversification to modules.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2330d2..e432ec5f6df4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -53,6 +53,8 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/random.h>
+#include <asm/setup.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2370,6 +2372,83 @@ static long get_offset(struct module *mod, unsigned int *size,
 	return ret;
 }
 
+/*
+ * shuffle_text_list()
+ * Use a Fisher Yates algorithm to shuffle a list of text sections.
+ */
+static void shuffle_text_list(Elf_Shdr **list, int size)
+{
+	int i;
+	unsigned int j;
+	Elf_Shdr *temp;
+
+	for (i = size - 1; i > 0; i--) {
+		/*
+		 * pick a random index from 0 to i
+		 */
+		get_random_bytes(&j, sizeof(j));
+		j = j % (i + 1);
+
+		temp = list[i];
+		list[i] = list[j];
+		list[j] = temp;
+	}
+}
+
+/*
+ * randomize_text()
+ * Look through the core section looking for executable code sections.
+ * Store sections in an array and then shuffle the sections
+ * to reorder the functions.
+ */
+static void randomize_text(struct module *mod, struct load_info *info)
+{
+	int i;
+	int num_text_sections = 0;
+	Elf_Shdr **text_list;
+	int size = 0;
+	int max_sections = info->hdr->e_shnum;
+	unsigned int sec = find_sec(info, ".text");
+
+	if (sec == 0)
+		return;
+
+	text_list = kmalloc_array(max_sections, sizeof(*text_list), GFP_KERNEL);
+	if (text_list == NULL)
+		return;
+
+	for (i = 0; i < max_sections; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		const char *sname = info->secstrings + shdr->sh_name;
+
+		if (!(shdr->sh_flags & SHF_ALLOC) ||
+		    !(shdr->sh_flags & SHF_EXECINSTR) ||
+		    strstarts(sname, ".init"))
+			continue;
+
+		text_list[num_text_sections] = shdr;
+		num_text_sections++;
+	}
+
+	shuffle_text_list(text_list, num_text_sections);
+
+	for (i = 0; i < num_text_sections; i++) {
+		Elf_Shdr *shdr = text_list[i];
+
+		/*
+		 * get_offset has a section index for it's last
+		 * argument, that is only used by arch_mod_section_prepend(),
+		 * which is only defined by parisc. Since this this type
+		 * of randomization isn't supported on parisc, we can
+		 * safely pass in zero as the last argument, as it is
+		 * ignored.
+		 */
+		shdr->sh_entsize = get_offset(mod, &size, shdr, 0);
+	}
+
+	kfree(text_list);
+}
+
 /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
    might -- code, read-only data, read-write data, small data.  Tally
    sizes, and place the offsets into sh_entsize fields: high bit means it
@@ -2460,6 +2539,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			break;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_FG_KASLR) && kaslr_enabled())
+		randomize_text(mod, info);
 }
 
 static void set_license(struct module *mod, const char *license)
-- 
2.20.1

