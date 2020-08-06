Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD77C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C839E20748
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHFW4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:56:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHFW4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:56:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFE0CB1B1;
        Thu,  6 Aug 2020 22:57:10 +0000 (UTC)
Date:   Fri, 7 Aug 2020 00:56:51 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806225651.GC24304@suse.de>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805110348.GA108872@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 01:03:48PM +0200, Jason A. Donenfeld wrote:
> BUG: unable to handle page fault for address: ffffe8ffffd00608

Okay, looks like my usage of the page-table macros is bogus, seems I
don't understand their usage as good as I thought. The p?d_none checks
in the allocation path are wrong and led to the bug. In fact it caused
only the first PUD entry to be allocated and in the later iterations of
the loop it always ended up on the same PUD entry.

I still don't fully understand why, but its late here and my head spins.
So I take another look tomorrow in the hope to understand it better.
Please remind me to not take vacation again during merge windows :)

Anyway...

Jason, does the attached diff fix the issue in your testing? For me it
makes all PUD pages correctly allocated.

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c7a47603537f..e4abf73167d0 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -696,6 +696,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 static void __init init_trampoline(void)
 {
 #ifdef CONFIG_X86_64
+
 	if (!kaslr_memory_enabled())
 		trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 	else
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e65b96f381a7..351fac590b02 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1248,27 +1248,23 @@ static void __init preallocate_vmalloc_pages(void)
 		p4d_t *p4d;
 		pud_t *pud;
 
-		p4d = p4d_offset(pgd, addr);
-		if (p4d_none(*p4d)) {
-			/* Can only happen with 5-level paging */
-			p4d = p4d_alloc(&init_mm, pgd, addr);
-			if (!p4d) {
-				lvl = "p4d";
-				goto failed;
-			}
+		p4d = p4d_alloc(&init_mm, pgd, addr);
+		if (!p4d) {
+			lvl = "p4d";
+			goto failed;
 		}
 
 		if (pgtable_l5_enabled())
 			continue;
 
-		pud = pud_offset(p4d, addr);
-		if (pud_none(*pud)) {
-			/* Ends up here only with 4-level paging */
-			pud = pud_alloc(&init_mm, p4d, addr);
-			if (!pud) {
-				lvl = "pud";
-				goto failed;
-			}
+		/*
+		 * With 4-level paging the P4D is folded, so allocate a
+		 * PUD to have one level below PGD present.
+		 */
+		pud = pud_alloc(&init_mm, p4d, addr);
+		if (!pud) {
+			lvl = "pud";
+			goto failed;
 		}
 	}
 
