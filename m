Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EECC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D582469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 11:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgB2LtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 06:49:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39028 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2LtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 06:49:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j80cN-0007dg-8J; Sat, 29 Feb 2020 12:49:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9593D1C219A;
        Sat, 29 Feb 2020 12:49:13 +0100 (CET)
Date:   Sat, 29 Feb 2020 11:49:13 -0000
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix dump_pagetables with Xen PV
Cc:     Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221103851.7855-1-jgross@suse.com>
References: <20200221103851.7855-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <158297695326.28353.10741733297553166672.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bba42affa732d6fd5bd5c9678e6deacde2de1547
Gitweb:        https://git.kernel.org/tip/bba42affa732d6fd5bd5c9678e6deacde2de1547
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 21 Feb 2020 11:38:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 29 Feb 2020 12:43:10 +01:00

x86/mm: Fix dump_pagetables with Xen PV

Commit 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use
walk_page_range") broke Xen PV guests as the hypervisor reserved hole in
the memory map was not taken into account.

Fix that by starting the kernel range only at GUARD_HOLE_END_ADDR.

Fixes: 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use walk_page_range")
Reported-by: Julien Grall <julien@xen.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Julien Grall <julien@xen.org>
Link: https://lkml.kernel.org/r/20200221103851.7855-1-jgross@suse.com

---
 arch/x86/mm/dump_pagetables.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 64229da..69309cd 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -363,13 +363,8 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m,
 {
 	const struct ptdump_range ptdump_ranges[] = {
 #ifdef CONFIG_X86_64
-
-#define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
-#define normalize_addr(u) ((signed long)((u) << normalize_addr_shift) >> \
-			   normalize_addr_shift)
-
 	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
-	{normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
+	{GUARD_HOLE_END_ADDR, ~0UL},
 #else
 	{0, ~0UL},
 #endif
