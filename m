Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F05206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPywCG4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFEWXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgFEWXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:23:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74BC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:23:01 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y25so9812477qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g8wUYzJxwqEdeLQuYq3Z4wuiM6LmXBTk7eDuhBcuoac=;
        b=MPywCG4zD6BzkmLVmLLJbxmgBjhtMsvoEptj4ECwrStlopTOnR4b+2tWAG2RV2sQ0d
         ZCOgi0a9f5LL9+JEDvPOPKZP/uV1l7em3zpKvbPy37vET3XY8Bt5IzHg2bVSfBlsccd+
         z6aOc8cHkaUViwK7hiQRlfcW0DJIIas8fDhnFlLaPLvSSgH2GdnAoS8waehku2aX0XHg
         xxg0nJBiuQNSN3ZoHEQgdoa298Tp6SpR3lrqvaBMO29iBuxQ/J8ruGbrDG/bZ272exQF
         17G/oXy/OoYhU0r3ZSFoi7dhvFuXMQz3t6S9Stn6hELyRWz7HIwRze3pszKCL/Vz9nQS
         k5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g8wUYzJxwqEdeLQuYq3Z4wuiM6LmXBTk7eDuhBcuoac=;
        b=qiAWWhopm/1pupUWnGWdf191p3eXQKy/v2JoT7FjG2OmPJyPg23ovFnbcMjKcGrQ9N
         oz6TxFEzBSjQHpZ07HpqKRY31eaczRnsJeU6UD4wxfBBuBMnoPWcn4aH5sTZc2rFdKln
         +vqaWOQN4xlwqSpa85Tb5c1d1miEhUJoRdesbrbgmadifHhCz0JZ+bXXTWl8I7WgGp9N
         kUW3e+9HqsQANhb6G5W0IdbE/hUBVa8grRQXKPzuKlw+wkY0Rb9qNKMi/f7IDE6BbvdB
         bpNmCdBl6UG4ww9LapyowrbzLMy2x8O2u9bxbTW29aFkhJ9ectmoxbV98MwsZUq2K+tm
         Lh6Q==
X-Gm-Message-State: AOAM533knWHog1FCjbvLUHcBZHFbReZrVhH4sdxERgN8+UUEQBkrSvg7
        KeZpIAPNA2D7kb3M0IMcHDhhCYxvK4GcDgQ=
X-Google-Smtp-Source: ABdhPJy9xsGvQ3FcFyxdc4urjtdmOuNSTDFHGQNV7/WnosCyTKQoBghmNEBxUWK13LyaED521Di4YE/HyfxXlYg=
X-Received: by 2002:a0c:dd8e:: with SMTP id v14mr11491437qvk.169.1591395781085;
 Fri, 05 Jun 2020 15:23:01 -0700 (PDT)
Date:   Fri,  5 Jun 2020 15:22:57 -0700
Message-Id: <20200605222257.44882-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v1] arm64/module: Optimize module load time by optimizing PLT counting
From:   Saravana Kannan <saravanak@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading a module, module_frob_arch_sections() tries to figure out
the number of PLTs that'll be needed to handle all the RELAs. While
doing this, it tries to dedupe PLT allocations for multiple
R_AARCH64_CALL26 relocations to the same symbol. It does the same for
R_AARCH64_JUMP26 relocations too.

To make checks for duplicates easier/faster, it sorts the relocation
list by type, symbol and addend. That way, to check for a duplicate
relocation, it just needs to compare with the previous entry.

However, sorting the entire relocation array is unnecessary and
expensive (O(n log n)) because there are a lot of other relocation types
that don't need deduping or can't be deduped.

So this commit partitions the array into entries that need deduping and
those that don't. And then sorts just the part that needs deduping. And
when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
if it's disabled.

This gives significant reduction in module load time for modules with
large number of relocations with no measurable impact on modules with a
small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
enabled, the load time for one module went down from 268ms to 100ms.
Another module went down from 143ms to 83ms.

This commit also disables the sorting if CONFIG_RANDOMIZE_BASE is
disabled because it looks like PLTs are not allocated for
R_AARCH64_CALL26 and R_AARCH64_JUMP26 if it's disabled.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 arch/arm64/kernel/module-plts.c | 37 ++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 65b08a74aec6..bf5118b3b828 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -253,6 +253,36 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 	return ret;
 }
 
+static bool rela_needs_dedup(Elf64_Rela *rela)
+{
+	return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26
+	       || ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
+}
+
+/* Group the CALL26/JUMP26 relas toward the beginning of the array. */
+static int partition_dedup_relas(Elf64_Rela *rela, int numrels)
+{
+	int i = 0, j = numrels - 1;
+	Elf64_Rela t;
+
+	while (i < j) {
+		while (rela_needs_dedup(rela + i) && i < j)
+			i++;
+		while (!rela_needs_dedup(rela + j) && i < j)
+			j--;
+		if (i < j) {
+			t = *(rela + j);
+			*(rela + j) = *(rela + i);
+			*(rela + i) = t;
+		}
+	}
+	/* If the entire array needs dedup, make sure i == numrels */
+	if (rela_needs_dedup(rela + i))
+		i++;
+
+	return i;
+}
+
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
@@ -291,6 +321,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
 		int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+		int num_dedup_rels = 0;
 		Elf64_Shdr *dstsec = sechdrs + sechdrs[i].sh_info;
 
 		if (sechdrs[i].sh_type != SHT_RELA)
@@ -300,8 +331,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (!(dstsec->sh_flags & SHF_EXECINSTR))
 			continue;
 
+		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+			num_dedup_rels = partition_dedup_relas(rels, numrels);
 		/* sort by type, symbol index and addend */
-		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
+		if (num_dedup_rels)
+			sort(rels, num_dedup_rels, sizeof(Elf64_Rela),
+			     cmp_rela, NULL);
 
 		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
 			core_plts += count_plts(syms, rels, numrels,
-- 
2.27.0.278.ge193c7cf3a9-goog

