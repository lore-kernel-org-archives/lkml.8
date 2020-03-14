Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3007C5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61820637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t585HK57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCOBal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:30:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42911 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCOBaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:30:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so11016920lfe.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fG43TRcFX02CHpl1ju0p1hH2hHWyQ0E0bWwnw/Nir1U=;
        b=t585HK579iJodlziT0sq5icnn297c5/BmagqT578c0bsng8NpAfETty0BDZvJmCoOf
         GujiHKTZvwz6GIeTh7ovIZ2OQyDU7VTvNQt8+i5ay7OjqmSco8v7ELoknfURUVw6AZQ4
         DQZTcB+T7fq1eKeKEoAa6sQoHw1FOIE7MtQNQ/p0ZjSY8HbjWvwoU7VkBmvNFdCg+eyq
         Dxwn0Tni5VNNGXOn9H7cErqmhi7srHq6hdxLCXUoOUqrsx1FkHBicyBK74rPBZjJeUSN
         ewFZCOrqpy/PBcfV215eE2cUUO6oyb0+DWI1pvQGfGu2o/6o5F5mCyQgpmRjWUIDrztI
         ohwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fG43TRcFX02CHpl1ju0p1hH2hHWyQ0E0bWwnw/Nir1U=;
        b=uO4YZ/xeeLwQR8VsIvhpZ5P3m3t7kS60M2nJsL0Y6zgMYnyoR5pLbUzzFbSaQwaQsr
         y3BE9JVIrncAsjGsSEUrkwHO1kWo/EH1csR06zMqXPHcHEG1uPg174Z1cjVUrvedKax8
         smHFhDPtJMsk9Fp3MVRwyyUZpDb6BTIHnJeZhFpVyJ6x+i4RiFJBLLjBq5RyMXcVF/pQ
         hISihGZmLyECjEq+7x00Piqxw/IiWUnZmWJQ7qMaC/zmzSMuSdV18CqxmJbb7UXFwALP
         a58qiF8Jh10dhR5VGQ777ybEXxUJ7xfahK4yv9N45KGarOjjr/7pU9UicdwoQNmjYlI7
         McJw==
X-Gm-Message-State: ANhLgQ3NdcPA/aPBmUS8YTb0NZVyY7SYKhVAPQuD++kETUHF/rBn6JD0
        uoWzKIbBGN0y/SsYB4cYKnnq/hV8gIsFJw==
X-Google-Smtp-Source: ADFU+vu4VNNdNZOKSRjqN04kRvn9eQGaPZRdN/74s/CnmaGXujaf9w/G6XDBIc/lm1vV3UMAuRO9EA==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr26199173wrh.121.1584221806858;
        Sat, 14 Mar 2020 14:36:46 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-79-184.inter.net.il. [80.230.79.184])
        by smtp.gmail.com with ESMTPSA id 9sm22785043wmx.32.2020.03.14.14.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 14:36:46 -0700 (PDT)
From:   Gilad Wharton Kleinman <dkgs1998@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Gilad Wharton Kleinman <dkgs1998@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/module: Fixed bug allowing invalid relocation addresses.
Date:   Sat, 14 Mar 2020 23:36:26 +0200
Message-Id: <20200314213626.30936-1-dkgs1998@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a kernel module with a bad relocation offset is loaded to a x86 kernel,
the kernel will apply the relocation to a address not inside the module
(resulting in memory in the kernel being overridden).

Signed-off-by: Gilad Wharton Kleinman <dkgs1998@gmail.com>
---
 arch/x86/kernel/module.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index d5c72cb877b3..0929b614b62a 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -96,10 +96,19 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf32_Sym *sym;
 	uint32_t *location;
+	Elf32_Word section_size;
 
 	DEBUGP("Applying relocate section %u to %u\n",
 	       relsec, sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+
+		section_size = sechdrs[sechdrs[relsec].sh_info].sh_size;
+		if (section_size < rel[i].r_offset + sizeof(u32)) {
+			pr_err("%s: Relocation offset %u is not in section (section len %u)\n",
+				me->name, rel[i].r_offset, section_size);
+			return -ENOEXEC;
+		}
+
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
@@ -126,6 +135,47 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
+
+bool is_reloc_addr_valid(Elf64_Shdr *sechdrs,
+			unsigned int relsec,
+			Elf64_Rela rel,
+			struct module *me)
+{
+	unsigned int rel_size;
+	Elf64_Xword section_size = sechdrs[sechdrs[relsec].sh_info].sh_size;
+
+	switch (ELF64_R_TYPE(rel.r_info)) {
+	case R_X86_64_NONE:
+		return true;
+
+	case R_X86_64_64:
+	case R_X86_64_PC64:
+		rel_size = sizeof(u64);
+		break;
+
+	case R_X86_64_32:
+	case R_X86_64_32S:
+	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
+		rel_size = sizeof(u32);
+		break;
+
+	default:
+		pr_err("%s: Unknown rela relocation: %llu\n",
+				me->name, ELF64_R_TYPE(rel.r_info));
+		return false;
+	}
+
+	if (section_size < rel.r_offset + rel_size) {
+		pr_err("%s: Relocation offset %llu and of length %u, is not in section (section len %llu)\n",
+			me->name, rel.r_offset,
+			rel_size, section_size);
+		return false;
+	}
+
+	return true;
+}
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
@@ -141,6 +191,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	DEBUGP("Applying relocate section %u to %u\n",
 	       relsec, sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		if (!is_reloc_addr_valid(sechdrs, relsec, rel[i], me))
+			return -ENOEXEC;
+
 		/* This is where to make the change */
 		loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
@@ -195,10 +248,6 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			*(u64 *)loc = val;
 			break;
-		default:
-			pr_err("%s: Unknown rela relocation: %llu\n",
-			       me->name, ELF64_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
 		}
 	}
 	return 0;
-- 
2.17.1

