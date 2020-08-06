Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD282173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kf8WYWyI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KquSmEdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHFXiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:38:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHFXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:48 -0400
Date:   Thu, 06 Aug 2020 23:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euZjanT6kjbBMt9mOI93vtI7+GhGL3QWOcr5yXnKhJE=;
        b=kf8WYWyISqdKVTZ2qXYD+2hk0lxkEAf+0v7bHBofb9N6u/IN9As1dksbij1WiFHTuMHx0i
        JnG6omaFV+bWcpepWA+dbQKGxAWn5kWosViZh5T1vxP9h0mmVrlS9ORuGqW4DzEiY1lpUW
        S0XVHhmES4n7JyBVBjTApCeB3ZFzvMlF3TvmveX5Pf5Nza81UBsd8jOcUypwKTUnJxzpp3
        A3qasIokbrzDO4+LdB3acJof5yrhxDHORRJygcXO4/IhuFWrj6egSOCO0QWjH6FZkmW7Z4
        SeKcZQcpJbHXkeSIyFufSm2h/a+fisK50ku/K/F5nk6mzKDb478nR8SR8xbzCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euZjanT6kjbBMt9mOI93vtI7+GhGL3QWOcr5yXnKhJE=;
        b=KquSmEdCMCevjaYuCZf7g405FtdyyEiKXlwb78NUmQVxW/tl7EznntXVr7GE3yVGKEIOjE
        ZD9n7vsmuZxzyeDw==
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
Message-ID: <159675712489.3192.10936858740810441552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     475f63ae63b5102ae6423d1712333929d04d6ecc
Gitweb:        https://git.kernel.org/tip/475f63ae63b5102ae6423d1712333929d04d6ecc
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:33 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

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
index 97fa682..3f7867c 100644
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
