Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6829D2311B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWJ7blUf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8BPkqJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgHFRKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgHFRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF9C061574;
        Thu,  6 Aug 2020 10:10:09 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:10:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86mczRWqEs3jdentO74wVd8eG11njrwgMiO5ym6RDSo=;
        b=yWJ7blUfakNJChOlS7S+NMPzx89Opw8aiCjTycbxt3Or0tg883CZ536WsTkNPMfJUCKtwR
        0gm56xu/chI0hcIxBHcEMM6il3qX65YKQfyE4xMPoI+ttkui2g5c7N3O8tWovyyGLHF8n0
        QmSBelUbcoyYSTQ5M1XpeJmdKx1HJQrRgRwviJBoQy1SNlgIl68Gq/dB6HqsCbaqooDS/v
        w33SkGWpLDL2vCGn08xPCPRXXBJISVV5p++hFy+Zim8VNTVPs1crLWJmL1bWTt8l5U6T7m
        eE07W1buuQPZNhertQU/if9VBwS1FU2g4ftNVzM3vwIo18S3Nm9keWvYILl9AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86mczRWqEs3jdentO74wVd8eG11njrwgMiO5ym6RDSo=;
        b=i8BPkqJpWYMyMJv+JvWIV6hZegrmcff66znzk2VqL5WVQKeXaFPbsjlvVr15bc3dKF9OWQ
        1x5DPk7r+5TOwXAg==
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
Message-ID: <159673380690.3192.7724116309741101054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     12e4e432ac4d65020ba85037da06f2c886188e4f
Gitweb:        https://git.kernel.org/tip/12e4e432ac4d65020ba85037da06f2c886188e4f
Author:        Lianbo Jiang <lijiang@redhat.com>
AuthorDate:    Tue, 04 Aug 2020 12:49:32 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:25:58 +02:00

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
index 09cc78d..5cc2c47 100644
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
