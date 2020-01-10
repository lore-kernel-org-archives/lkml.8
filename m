Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50301C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8924677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAJR7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59280 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgAJR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ8-0002BL-Hm; Fri, 10 Jan 2020 18:59:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1CDFF1C2D6A;
        Fri, 10 Jan 2020 18:59:21 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:20 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Create fixed width output in
 /sys/kernel/debug/x86/pat_memtype_list, similar to the E820 debug printouts
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867916094.30329.2512076581126082469.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ef35b0fcee23d7636daa4bed62bceeaba4eed918
Gitweb:        https://git.kernel.org/tip/ef35b0fcee23d7636daa4bed62bceeaba4eed918
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Nov 2019 09:38:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Create fixed width output in /sys/kernel/debug/x86/pat_memtype_list, similar to the E820 debug printouts

Before:

  write-back @ 0xbdfa9000-0xbdfaa000
  write-back @ 0xbdfaa000-0xbdfab000
  write-back @ 0xbdfab000-0xbdfac000
  uncached-minus @ 0xc0000000-0xd0000000
  uncached-minus @ 0xd0900000-0xd0920000
  uncached-minus @ 0xd0920000-0xd0940000
  uncached-minus @ 0xd0940000-0xd0960000
  uncached-minus @ 0xd0960000-0xd0980000
  uncached-minus @ 0xd0980000-0xd0981000
  uncached-minus @ 0xd0990000-0xd0991000
  uncached-minus @ 0xd09a0000-0xd09a1000
  uncached-minus @ 0xd09b0000-0xd09b1000
  uncached-minus @ 0xd0d00000-0xd0d01000
  uncached-minus @ 0xd0d10000-0xd0d11000
  uncached-minus @ 0xd0d20000-0xd0d21000
  uncached-minus @ 0xd0d40000-0xd0d41000
  uncached-minus @ 0xfed00000-0xfed01000
  uncached-minus @ 0xfed1f000-0xfed20000
  uncached-minus @ 0xfed40000-0xfed41000

After:

  PAT: [mem 0x00000000bdf8e000-0x00000000bdfa8000] write-back
  PAT: [mem 0x00000000bdfa9000-0x00000000bdfaa000] write-back
  PAT: [mem 0x00000000bdfaa000-0x00000000bdfab000] write-back
  PAT: [mem 0x00000000bdfab000-0x00000000bdfac000] write-back
  PAT: [mem 0x00000000c0000000-0x00000000d0000000] uncached-minus
  PAT: [mem 0x00000000d0900000-0x00000000d0920000] uncached-minus
  PAT: [mem 0x00000000d0920000-0x00000000d0940000] uncached-minus
  PAT: [mem 0x00000000d0940000-0x00000000d0960000] uncached-minus
  PAT: [mem 0x00000000d0960000-0x00000000d0980000] uncached-minus
  PAT: [mem 0x00000000d0980000-0x00000000d0981000] uncached-minus
  PAT: [mem 0x00000000d0990000-0x00000000d0991000] uncached-minus
  PAT: [mem 0x00000000d09a0000-0x00000000d09a1000] uncached-minus
  PAT: [mem 0x00000000d09b0000-0x00000000d09b1000] uncached-minus
  PAT: [mem 0x00000000fed1f000-0x00000000fed20000] uncached-minus
  PAT: [mem 0x00000000fed40000-0x00000000fed41000] uncached-minus

The advantage is that it's easier to parse at a glance - and the tree is ordered
by start address, which is now reflected in putting the start address in the first
column.

This is also now similar to how we print e820 entries:

  BIOS-e820: [mem 0x00000000bafda000-0x00000000bb3d3fff] usable
  BIOS-e820: [mem 0x00000000bb3d4000-0x00000000bdd2efff] reserved
  BIOS-e820: [mem 0x00000000bdd2f000-0x00000000bddccfff] ACPI NVS
  BIOS-e820: [mem 0x00000000bddcd000-0x00000000bdea0fff] ACPI data
  BIOS-e820: [mem 0x00000000bdea1000-0x00000000bdf2efff] ACPI NVS

Since this is a debugfs file not used by tools there's no known ABI dependencies.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index e26b81c..ea7da7e 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -1179,10 +1179,10 @@ static int memtype_seq_show(struct seq_file *seq, void *v)
 {
 	struct memtype *print_entry = (struct memtype *)v;
 
-	seq_printf(seq, "%s @ 0x%Lx-0x%Lx\n",
-			cattr_name(print_entry->type),
+	seq_printf(seq, "PAT: [mem 0x%016Lx-0x%016Lx] %s\n",
 			print_entry->start,
-			print_entry->end);
+			print_entry->end,
+			cattr_name(print_entry->type));
 
 	kfree(print_entry);
 
