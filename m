Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A16C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6134520720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bh/pq5ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgFWB1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgFWB1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:27:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:27:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so9211376ybz.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UOuwZGpgzJVvH8pfpeZ0keyZ//465N3FyB2wMRomwb4=;
        b=bh/pq5kaM7FeIrZzypeLaSXBK8XSC14fuFLe/P1qXyWg+kQu1XaweHivg01izyhyNv
         KUEJxy18Swjm/dSQUSLHPF9Ynx3QLuDv5s583y4DNnPzqokVzRDZKlw1vn6WiUmgXXc0
         2fNIUm3lp/PBoOcdzuZ40pvye6m70igqfwh5dTnW1v1iXpi4NXZbQkAxsvnHidnt4kge
         KsGge2QOVw/LfGXppAqseniFpv3LNhDaXew+vz+y5aSShHGcpqjJ2HUCYMYWXaqSFauh
         j8IsRzTJWkjmu7AJcGBM4JVRlbOUgpL1/SgMksiHkfieb7sBFdnkSEYf2aJYmg4Htwo1
         5Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UOuwZGpgzJVvH8pfpeZ0keyZ//465N3FyB2wMRomwb4=;
        b=h/QErQdbazrY9dws6FlRtXXRFuQNXm0TltUZgpkUJaKLBUUJ0y21HbqKEYp6pYOR+S
         bq1nGzW/HO+tHM5mfIVpoK/h1suzn6z4dtaApj6qaKHmsYUm9+SVnogNhe0yKB2KkcI/
         4uIZXJWXXfHOFYYNfYdBuHUHEe/PBnhkIDcImRgAZGWpcCh5yWTAJREq/Y0nCosLVQzu
         3y9GmBPVJCzJbxnOuYQhBrWcHoRwOvNpy+o9giOGYixT2w+zqVmmbUv8bHmxrEYbKzyr
         SN1oQTiHOClAPoWOe15ZptdV4poaT9D4ASmmxRaXU1XeyTyYYS0a4sseWw2CJoV2kDfQ
         qafg==
X-Gm-Message-State: AOAM531bWBIaqFMfET/bmP/Kk0vKC1St81lDaNh3sw9datx8hBQFZHzk
        SHIrE8kvTptH28qw3NpNKFeowaLi2XXEHns=
X-Google-Smtp-Source: ABdhPJy7qcpSVpegKx4QAc5kw2vXm64fXjkxcVFY9F2PveOYLJCjOmFJR5k3dfbz5KVZc3jVoAnglPgHZolq4+g=
X-Received: by 2002:a25:2488:: with SMTP id k130mr31280767ybk.241.1592875635446;
 Mon, 22 Jun 2020 18:27:15 -0700 (PDT)
Date:   Mon, 22 Jun 2020 18:18:02 -0700
Message-Id: <20200623011803.91232-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2] arm64/module: Optimize module load time by optimizing PLT counting
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
R_AARCH64_JUMP26 relocations.

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
enabled, these were the results for a few downstream modules:

Module		Size (MB)
wlan		14
video codec	3.8
drm		1.8
IPA		2.5
audio		1.2
gpu		1.8

Without this patch:
Module		Number of entries sorted	Module load time (ms)
wlan		243739				283
video codec	74029				138
drm		53837				67
IPA		42800				90
audio		21326				27
gpu		20967				32

Total time to load all these module: 637 ms

With this patch:
Module		Number of entries sorted	Module load time (ms)
wlan		22454				61
video codec	10150				47
drm		13014				40
IPA		8097				63
audio		4606				16
gpu		6527				20

Total time to load all these modules: 247

Time saved during boot for just these 6 modules: 390 ms

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

v1 -> v2:
- Provided more details in the commit text
- Pulled in Will's comments on the coding style
- Pulled in Ard's suggestion about skipping jumps with the same section
  index (parts of Will's suggested code)

 arch/arm64/kernel/module-plts.c | 46 ++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 65b08a74aec6..0ce3a28e3347 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -253,6 +253,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 	return ret;
 }
 
+static bool branch_rela_needs_plt(Elf64_Sym *syms, Elf64_Rela *rela,
+				  Elf64_Word dstidx)
+{
+
+	Elf64_Sym *s = syms + ELF64_R_SYM(rela->r_info);
+
+	if (s->st_shndx == dstidx)
+		return false;
+
+	return ELF64_R_TYPE(rela->r_info) == R_AARCH64_JUMP26 ||
+	       ELF64_R_TYPE(rela->r_info) == R_AARCH64_CALL26;
+}
+
+/* Group branch PLT relas at the front end of the array. */
+static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
+				      int numrels, Elf64_Word dstidx)
+{
+	int i = 0, j = numrels - 1;
+
+	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		return 0;
+
+	while (i < j) {
+		if (branch_rela_needs_plt(syms, &rela[i], dstidx))
+			i++;
+		else if (branch_rela_needs_plt(syms, &rela[j], dstidx))
+			swap(rela[i], rela[j]);
+		else
+			j--;
+	}
+
+	return i;
+}
+
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
@@ -290,7 +324,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
-		int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+		int nents, numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
 		Elf64_Shdr *dstsec = sechdrs + sechdrs[i].sh_info;
 
 		if (sechdrs[i].sh_type != SHT_RELA)
@@ -300,8 +334,14 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (!(dstsec->sh_flags & SHF_EXECINSTR))
 			continue;
 
-		/* sort by type, symbol index and addend */
-		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
+		/*
+		 * sort branch relocations requiring a PLT by type, symbol index
+		 * and addend
+		 */
+		nents = partition_branch_plt_relas(syms, rels, numrels,
+						   sechdrs[i].sh_info);
+		if (nents)
+			sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
 
 		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
 			core_plts += count_plts(syms, rels, numrels,
-- 
2.27.0.111.gc72c7da667-goog

