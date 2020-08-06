Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E93C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15762173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xalOR3qj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWKnFpe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHFXiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHFXis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0288C061575;
        Thu,  6 Aug 2020 16:38:47 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Ue43woZ8D4rqkM2savDZbJ72Y/T7d229UG6PhY8aY=;
        b=xalOR3qjDzjU+60DE5Ncb/hcpCmycT0hCQBYUiylwKqYf4oYOL/3pNNStaHtJzkgbwADhb
        rdt4BW049AYzFOKW9Q+/s5i9wSh03ukVAlS7Vq6mXkztvn0hSiCyu+ellF6Ym/1d+akVGR
        cQP5F69uD6CA741/m1Nttcchd/AV+m8SIzBXL6OFQQLB+MHS6/aN+6xp3/t8OVBpqs7cOz
        cN/kCz4WKseh6dNwPDJD+mN4LkeumVY5UneUaw6sKIyhuv921D2SCxjDCDePi6h1PjOybV
        7VgzbkN5l7IVedCvMnYEwpCmuQh9SNkQ9tbJcXKH9sDXy/I29Xuk0j9pS04w0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Ue43woZ8D4rqkM2savDZbJ72Y/T7d229UG6PhY8aY=;
        b=KWKnFpe0c1kiJbTDbX2ofVQQa9mtcGVmTTPgz2iMEBGUwd/UQupCYYg5AaaWLwurM5hm03
        L5EffIyKZqqa2UCQ==
From:   "tip-bot2 for Lianbo Jiang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] kexec: Improve & fix crash_exclude_mem_range() to
 handle overlapping ranges
Cc:     Lianbo Jiang <lijiang@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Young <dyoung@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804044933.1973-3-lijiang@redhat.com>
References: <20200804044933.1973-3-lijiang@redhat.com>
MIME-Version: 1.0
Message-ID: <159675712551.3192.12580323295700287639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a2e9a95d2190ef55bf0724ecdf8a466d393a86b6
Gitweb:        https://git.kernel.org/tip/a2e9a95d2190ef55bf0724ecdf8a466d393a86b6
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:32 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

kexec: Improve & fix crash_exclude_mem_range() to handle overlapping ranges

The crash_exclude_mem_range() function can only handle one memory region a time.

It will fail in the case in which the passed in area covers several memory
regions. In this case, it will only exclude the first region, then return,
but leave the later regions unsolved.

E.g in a NEC system with two usable RAM regions inside the low 1M:

  ...
  BIOS-e820: [mem 0x0000000000000000-0x000000000003efff] usable
  BIOS-e820: [mem 0x000000000003f000-0x000000000003ffff] reserved
  BIOS-e820: [mem 0x0000000000040000-0x000000000009ffff] usable

It will only exclude the memory region [0, 0x3efff], the memory region
[0x40000, 0x9ffff] will still be added into /proc/vmcore, which may cause
the following failure when dumping vmcore:

 ioremap on RAM at 0x0000000000040000 - 0x0000000000040fff
 WARNING: CPU: 0 PID: 665 at arch/x86/mm/ioremap.c:186 __ioremap_caller+0x2c7/0x2e0
 ...
 RIP: 0010:__ioremap_caller+0x2c7/0x2e0
 ...
 cp: error reading '/proc/vmcore': Cannot allocate memory
 kdump: saving vmcore failed

In order to fix this bug, let's extend the crash_exclude_mem_range()
to handle the overlapping ranges.

[ mingo: Amended the changelog. ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200804044933.1973-3-lijiang@redhat.com
---
 kernel/kexec_file.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 94661d2..97fa682 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1157,24 +1157,26 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
 	int i, j;
-	unsigned long long start, end;
+	unsigned long long start, end, p_start, p_end;
 	struct crash_mem_range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
 		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
 
 		if (mstart > end || mend < start)
 			continue;
 
 		/* Truncate any area outside of range */
 		if (mstart < start)
-			mstart = start;
+			p_start = start;
 		if (mend > end)
-			mend = end;
+			p_end = end;
 
 		/* Found completely overlapping range */
-		if (mstart == start && mend == end) {
+		if (p_start == start && p_end == end) {
 			mem->ranges[i].start = 0;
 			mem->ranges[i].end = 0;
 			if (i < mem->nr_ranges - 1) {
@@ -1185,20 +1187,29 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 					mem->ranges[j].end =
 							mem->ranges[j+1].end;
 				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
 			}
 			mem->nr_ranges--;
 			return 0;
 		}
 
-		if (mstart > start && mend < end) {
+		if (p_start > start && p_end < end) {
 			/* Split original range */
-			mem->ranges[i].end = mstart - 1;
-			temp_range.start = mend + 1;
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
 			temp_range.end = end;
-		} else if (mstart != start)
-			mem->ranges[i].end = mstart - 1;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
 		else
-			mem->ranges[i].start = mend + 1;
+			mem->ranges[i].start = p_end + 1;
 		break;
 	}
 
@@ -1243,7 +1254,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
 	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
 	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two elf headers. One will contain kernel
+	 * memory will be mapped in two elf  headers. One will contain kernel
 	 * text virtual addresses and other will have __va(physical) addresses.
 	 */
 
@@ -1270,7 +1281,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present cpu */
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
