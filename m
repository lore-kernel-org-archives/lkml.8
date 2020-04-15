Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3BC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A52076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405076AbgDOFY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:24:58 -0400
Received: from h1.fbrelay.privateemail.com ([131.153.2.42]:45201 "EHLO
        h1.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389364AbgDOFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:24:45 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 01:24:44 EDT
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com [68.65.122.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id E865680684
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:16:56 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id 0DD256003F;
        Wed, 15 Apr 2020 01:16:55 -0400 (EDT)
Received: from APP-05 (unknown [10.20.147.155])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id DFD0F6003D;
        Wed, 15 Apr 2020 05:16:54 +0000 (UTC)
Date:   Wed, 15 Apr 2020 00:16:54 -0500 (CDT)
From:   Christopher M Riedl <cmr@informatik.wtf>
Reply-To: Christopher M Riedl <cmr@informatik.wtf>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <581069710.188209.1586927814880@privateemail.com>
In-Reply-To: <c88b13ede49744d81fdab32e037a7ae10f0b241f.1585233657.git.christophe.leroy@c-s.fr>
References: <c88b13ede49744d81fdab32e037a7ae10f0b241f.1585233657.git.christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH] powerpc/lib: Fixing use a temporary mm for code
 patching
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev24
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On March 26, 2020 9:42 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>  
> This patch fixes the RFC series identified below.
> It fixes three points:
> - Failure with CONFIG_PPC_KUAP
> - Failure to write do to lack of DIRTY bit set on the 8xx
> - Inadequaly complex WARN post verification
> 
> However, it has an impact on the CPU load. Here is the time
> needed on an 8xx to run the ftrace selftests without and
> with this series:
> - Without CONFIG_STRICT_KERNEL_RWX		==> 38 seconds
> - With CONFIG_STRICT_KERNEL_RWX			==> 40 seconds
> - With CONFIG_STRICT_KERNEL_RWX + this series	==> 43 seconds
> 
> Link: https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=166003
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/lib/code-patching.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f156132e8975..4ccff427592e 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -97,6 +97,7 @@ static int map_patch(const void *addr, struct patch_mapping *patch_mapping)
>  	}
>  
>  	pte = mk_pte(page, pgprot);
> +	pte = pte_mkdirty(pte);
>  	set_pte_at(patching_mm, patching_addr, ptep, pte);
>  
>  	init_temp_mm(&patch_mapping->temp_mm, patching_mm);
> @@ -168,7 +169,9 @@ static int do_patch_instruction(unsigned int *addr, unsigned int instr)
>  			(offset_in_page((unsigned long)addr) /
>  				sizeof(unsigned int));
>  
> +	allow_write_to_user(patch_addr, sizeof(instr));
>  	__patch_instruction(addr, instr, patch_addr);
> +	prevent_write_to_user(patch_addr, sizeof(instr));
> 

On radix we can map the page with PAGE_KERNEL protection which ends up
setting EAA[0] in the radix PTE. This means the KUAP (AMR) protection is
ignored (ISA v3.0b Fig. 35) since we are accessing the page from MSR[PR]=0.

Can we employ a similar approach on the 8xx? I would prefer *not* to wrap
the __patch_instruction() with the allow_/prevent_write_to_user() KUAP things
because this is a temporary kernel mapping which really isn't userspace in
the usual sense.
 
>  	err = unmap_patch(&patch_mapping);
>  	if (err)
> @@ -179,7 +182,7 @@ static int do_patch_instruction(unsigned int *addr, unsigned int instr)
>  	 * think we just wrote.
>  	 * XXX: BUG_ON() instead?
>  	 */
> -	WARN_ON(memcmp(addr, &instr, sizeof(instr)));
> +	WARN_ON(*addr != instr);
>  
>  out:
>  	local_irq_restore(flags);
> -- 
> 2.25.0
