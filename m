Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8400C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497762311B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBkk2GYL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azH0o9MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgHFRL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:11:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbgHFRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Date:   Thu, 06 Aug 2020 17:10:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR/Ebw0TqrcppD6Z47kh84qypzshyc9lcKZ+o+8oKHw=;
        b=nBkk2GYLc99v98lBfLaONS1H+aEWgeC2CfnHRxKo3USagd2I7FNgqsOQ4Qb4HiWBB7YaHt
        gr1pRywAJXewAGVWd481f0HR+pYwukfeSO3pcqrp2rBwrdITM4Oh65klnmZoDgqKgkwC6d
        up0jfVvmmnvbAYyfPUq1y/6Cgs/5k+iEJLsGyAp/olfg2DxUrJB/H5uZGm4cRvYHqDs1XF
        HIwb44A+/k4IS2v9ui6Nlbzg6QhkpqxNkZAQuPAmv3U5O/C+/TVsOZvFxCgBJbRQcXJ9j5
        8BoDZ2lKaH8OtuH0xrq/aCr///ZdUDQO0Y6M8Uz35YTX8/hqEKgiin7zQfeBHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR/Ebw0TqrcppD6Z47kh84qypzshyc9lcKZ+o+8oKHw=;
        b=azH0o9MFxsOk1/5gejD9Ez8ATUaAsqatNGTU9JosjknCTs11ZzhoNObZNHzCPekpbFOhP6
        eMIJ3JUQCx4YG8Cw==
From:   "tip-bot2 for Lianbo Jiang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] kexec_file: Correctly output debugging information
 for the PT_LOAD ELF header
Cc:     Lianbo Jiang <lijiang@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Young <dyoung@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804044933.1973-4-lijiang@redhat.com>
References: <20200804044933.1973-4-lijiang@redhat.com>
MIME-Version: 1.0
Message-ID: <159673380619.3192.11473438230376411789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8ca346039f70cf92dbada6c06048efde165b191f
Gitweb:        https://git.kernel.org/tip/8ca346039f70cf92dbada6c06048efde165b191f
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:33 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:26:09 +02:00

kexec_file: Correctly output debugging information for the PT_LOAD ELF header

Currently, when we enable the debugging switch to debug kexec_file,
we always get the following incorrect results:

  kexec_file: Crash PT_LOAD elf header. phdr=00000000c988639b vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=51 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=000000003cca69a0 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=52 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000c584cb9f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=53 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000cf85d57f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=54 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000a4a8f847 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=55 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000272ec49f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=56 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000ea0b65de vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=57 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=000000001f5e490c vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=58 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000dfe4109e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=59 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000480ed2b6 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=60 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=0000000080b65151 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=61 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=0000000024e31c5e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=62 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000332e0385 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=63 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=000000002754d5da vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=64 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=00000000783320dd vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=65 p_offset=0x0
  kexec_file: Crash PT_LOAD elf header. phdr=0000000076fe5b64 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=66 p_offset=0x0

The reason is that kernel always prints the values of the next PT_LOAD
instead of the current PT_LOAD. Change it to ensure that we can get the
correct debugging information.

[ mingo: Amended changelog, capitalized "ELF". ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200804044933.1973-4-lijiang@redhat.com
---
 kernel/kexec_file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 5cc2c47..f1f4009 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1246,7 +1246,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	unsigned long long notes_addr;
 	unsigned long mstart, mend;
 
-	/* extra phdr for vmcoreinfo elf note */
+	/* extra phdr for vmcoreinfo ELF note */
 	nr_phdr = nr_cpus + 1;
 	nr_phdr += mem->nr_ranges;
 
@@ -1254,7 +1254,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
 	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
 	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two elf  headers. One will contain kernel
+	 * memory will be mapped in two ELF headers. One will contain kernel
 	 * text virtual addresses and other will have __va(physical) addresses.
 	 */
 
@@ -1323,10 +1323,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		phdr++;
-		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
 	}
 
 	*addr = buf;
