Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AEDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CEC206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiMnpCDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgHDEt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgHDEt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596516596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ak+fSHfefvAxQ/nHPyXk5IBYTBnKo1tDluySqwrf2ww=;
        b=RiMnpCDtfNpnhfoB8jBxZpbOF1WzLm6KL5KRs4+ttNHoKR02AjumM84bzxtF6wvR9wrhlo
        pHyFAxDESKiOCQKIn8QBPw02NSYlVhz1JkoH221tvKoqWvfv6s7ZLcx4xttPR9tM3LKOYG
        ELRuHQliROyfPqsJ0VHVE9aG3rmrEMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-MVmX6EPAOXauYqYFyoPCcQ-1; Tue, 04 Aug 2020 00:49:55 -0400
X-MC-Unique: MVmX6EPAOXauYqYFyoPCcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68A5101C8A0;
        Tue,  4 Aug 2020 04:49:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FE7310013D7;
        Tue,  4 Aug 2020 04:49:47 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, dyoung@redhat.com,
        bhe@redhat.com, k-hagio@ab.jp.nec.com
Subject: [PATCH 2/3] kexec: Improve the crash_exclude_mem_range() to handle the overlapping ranges
Date:   Tue,  4 Aug 2020 12:49:32 +0800
Message-Id: <20200804044933.1973-3-lijiang@redhat.com>
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash_exclude_mem_range() can only handle one memory region one time.
It will fail the case in which the passed in area covers several memory
regions. In the case, it will only exclude the first region, then return,
but leave the later regions unsolved.

E.g in a NEC system with two usable RAM regions inside the low 1M:
...
BIOS-e820: [mem 0x0000000000000000-0x000000000003efff] usable
BIOS-e820: [mem 0x000000000003f000-0x000000000003ffff] reserved
BIOS-e820: [mem 0x0000000000040000-0x000000000009ffff] usable

It will only exclude the memory region [0, 0x3efff], the memory region
[0x40000, 0x9ffff] will still be added into /proc/vmcore, which may cause
the following failure when dumping the vmcore:

ioremap on RAM at 0x0000000000040000 - 0x0000000000040fff
WARNING: CPU: 0 PID: 665 at arch/x86/mm/ioremap.c:186 __ioremap_caller+0x2c7/0x2e0
...
RIP: 0010:__ioremap_caller+0x2c7/0x2e0
Code: 05 20 47 1c 01 48 09 c5 e9 93 fe ff ff 48 8d 54 24 28 48 8d 74 24 18 48 c7
      c7 85 e7 09 82 c6 05 b4 10 36 01 01 e8 32 91 04 00 <0f> 0b 45 31 ff e9 f3
      fe ff ff e8 2a 8e 04 00 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc9000071fd60 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000040000 RCX: 0000000000000000
RDX: ffff8880620268c0 RSI: ffff888062016a08 RDI: ffff888062016a08
RBP: 0000000000000000 R08: 0000000000000441 R09: 0000000000000048
R10: 0000000000000000 R11: ffffc9000071fc08 R12: 00007f794c343000
R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f794c352800(0000) GS:ffff888062000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f794c350000 CR3: 000000005df9c005 CR4: 00000000001606b0
Call Trace:
? __copy_oldmem_page.part.0+0x9c/0xb0
__copy_oldmem_page.part.0+0x9c/0xb0
read_from_oldmem.part.2+0xe2/0x140
read_vmcore+0xd8/0x2f0
proc_reg_read+0x39/0x60
vfs_read+0x91/0x140
ksys_read+0x4f/0xb0
do_syscall_64+0x5b/0x1a0
entry_SYSCALL_64_after_hwframe+0x65/0xca
cp: error reading '/proc/vmcore': Cannot allocate memory
kdump: saving vmcore failed

In order to solve this issue, let's extend the crash_exclude_mem_range()
to handle the overlapping ranges.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_file.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78df53c6..41616b6a80ad 100644
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
 
-- 
2.17.1

