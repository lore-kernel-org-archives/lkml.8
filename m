Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5239FC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EC620737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415721AbgDOQXJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:23:09 -0400
Received: from h1.fbrelay.privateemail.com ([131.153.2.42]:58912 "EHLO
        h1.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1415627AbgDOQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:23:03 -0400
Received: from MTA-12-3.privateemail.com (mta-12.privateemail.com [198.54.127.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id AAF8F80930
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:23:00 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id AAAC280050;
        Wed, 15 Apr 2020 12:22:56 -0400 (EDT)
Received: from APP-02 (unknown [10.20.147.152])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 888B28005C;
        Wed, 15 Apr 2020 16:22:56 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:22:56 -0500 (CDT)
From:   Christopher M Riedl <cmr@informatik.wtf>
Reply-To: Christopher M Riedl <cmr@informatik.wtf>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <1418874364.198277.1586967776509@privateemail.com>
In-Reply-To: <badfcf58-9fcb-6189-c9db-e8429f88799e@c-s.fr>
References: <c88b13ede49744d81fdab32e037a7ae10f0b241f.1585233657.git.christophe.leroy@c-s.fr>
 <581069710.188209.1586927814880@privateemail.com>
 <badfcf58-9fcb-6189-c9db-e8429f88799e@c-s.fr>
Subject: Re: [RFC PATCH] powerpc/lib: Fixing use a temporary mm for code
 patching
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev24
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On April 15, 2020 4:12 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>  
> Le 15/04/2020 à 07:16, Christopher M Riedl a écrit :
> >> On March 26, 2020 9:42 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>
> >>   
> >> This patch fixes the RFC series identified below.
> >> It fixes three points:
> >> - Failure with CONFIG_PPC_KUAP
> >> - Failure to write do to lack of DIRTY bit set on the 8xx
> >> - Inadequaly complex WARN post verification
> >>
> >> However, it has an impact on the CPU load. Here is the time
> >> needed on an 8xx to run the ftrace selftests without and
> >> with this series:
> >> - Without CONFIG_STRICT_KERNEL_RWX		==> 38 seconds
> >> - With CONFIG_STRICT_KERNEL_RWX			==> 40 seconds
> >> - With CONFIG_STRICT_KERNEL_RWX + this series	==> 43 seconds
> >>
> >> Link: https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=166003
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >>   arch/powerpc/lib/code-patching.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> >> index f156132e8975..4ccff427592e 100644
> >> --- a/arch/powerpc/lib/code-patching.c
> >> +++ b/arch/powerpc/lib/code-patching.c
> >> @@ -97,6 +97,7 @@ static int map_patch(const void *addr, struct patch_mapping *patch_mapping)
> >>   	}
> >>   
> >>   	pte = mk_pte(page, pgprot);
> >> +	pte = pte_mkdirty(pte);
> >>   	set_pte_at(patching_mm, patching_addr, ptep, pte);
> >>   
> >>   	init_temp_mm(&patch_mapping->temp_mm, patching_mm);
> >> @@ -168,7 +169,9 @@ static int do_patch_instruction(unsigned int *addr, unsigned int instr)
> >>   			(offset_in_page((unsigned long)addr) /
> >>   				sizeof(unsigned int));
> >>   
> >> +	allow_write_to_user(patch_addr, sizeof(instr));
> >>   	__patch_instruction(addr, instr, patch_addr);
> >> +	prevent_write_to_user(patch_addr, sizeof(instr));
> >>
> > 
> > On radix we can map the page with PAGE_KERNEL protection which ends up
> > setting EAA[0] in the radix PTE. This means the KUAP (AMR) protection is
> > ignored (ISA v3.0b Fig. 35) since we are accessing the page from MSR[PR]=0.
> > 
> > Can we employ a similar approach on the 8xx? I would prefer *not* to wrap
> > the __patch_instruction() with the allow_/prevent_write_to_user() KUAP things
> > because this is a temporary kernel mapping which really isn't userspace in
> > the usual sense.
> 
> On the 8xx, that's pretty different.
> 
> The PTE doesn't control whether a page is user page or a kernel page. 
> The only thing that is set in the PTE is whether a page is linked to a 
> given PID or not.
> PAGE_KERNEL tells that the page can be addressed with any PID.
> 
> The user access right is given by a kind of zone, which is in the PGD 
> entry. Every pages above PAGE_OFFSET are defined as belonging to zone 0. 
> Every pages below PAGE_OFFSET are defined as belonging to zone 1.
> 
> By default, zone 0 can only be accessed by kernel, and zone 1 can only 
> be accessed by user. When kernel wants to access zone 1, it temporarily 
> changes properties of zone 1 to allow both kernel and user accesses.
> 
> So, if your mapping is below PAGE_OFFSET, it is in zone 1 and kernel 
> must unlock it to access it.
> 
> 
> And this is more or less the same on hash/32. This is managed by segment 
> registers. One segment register corresponds to a 256Mbytes area. Every 
> pages below PAGE_OFFSET can only be read by default by kernel. Only user 
> can write if the PTE allows it. When the kernel needs to write at an 
> address below PAGE_OFFSET, it must change the segment properties in the 
> corresponding segment register.
> 
> So, for both cases, if we want to have it local to a task while still 
> allowing kernel access, it means we have to define a new special area 
> between TASK_SIZE and PAGE_OFFSET which belongs to kernel zone.
> 
> That looks complex to me for a small benefit, especially as 8xx is not 
> SMP and neither are most of the hash/32 targets.
> 

Agreed. So I guess the solution is to differentiate between radix/non-radix
and use PAGE_SHARED for non-radix along with the KUAP functions when KUAP
is enabled. Hmm, I need to think about this some more, especially if it's
acceptable to temporarily map kernel text as PAGE_SHARED for patching. Do
you see any obvious problems on 8xx and hash/32 w/ using PAGE_SHARED?

I don't necessarily want to drop the local mm patching idea for non-radix
platforms since that means we would have to maintain two implementations.

> Christophe
