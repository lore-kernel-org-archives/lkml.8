Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE9C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D254220722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBUKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:38:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:53760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:38:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A868AC66;
        Fri, 21 Feb 2020 10:38:54 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: fix dump_pagetables with Xen PV
Date:   Fri, 21 Feb 2020 11:38:51 +0100
Message-Id: <20200221103851.7855-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use
walk_page_range") broke Xen PV guests as the hypervisor reserved hole
in the memory map was not taken into account.

Fix that by starting the kernel range only at GUARD_HOLE_END_ADDR.

Fixes: 2ae27137b2db89 ("x86: mm: convert dump_pagetables to use walk_page_range")
Reported-by: Julien Grall <julien@xen.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/dump_pagetables.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 64229dad7eab..69309cd56fdf 100644
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
-- 
2.16.4

