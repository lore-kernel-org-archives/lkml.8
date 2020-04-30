Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB95C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D52173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588235379;
	bh=onr2ezsqhSwSBf7Quz0lL5N9zMZKFWEXv6ZeY7ZIb9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M557/VQuFweQ9pg8rVSC229x7O4s5XsoicEJ494+qhQy7/wRldVgdHzn1vo47A2Ca
	 zEXoHaPDZHrXIEQATKiS/tBoiMeeywVqiKL74vd3rQzn569DInamO7wv0ggab63b6I
	 4ezvZXpVg4RMmpgC1vOGOjHuTUxGusUI8cTSWr44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD3I3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgD3I3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:29:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E058E20838;
        Thu, 30 Apr 2020 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588235377;
        bh=onr2ezsqhSwSBf7Quz0lL5N9zMZKFWEXv6ZeY7ZIb9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhXeMJ0oWGKxPahGSs7koYRzrkGLBxK5K/sKeQboCc/b2p8n6cwbTf9Sr+GZ+pIk4
         rRFVN73kuf10XTpXGBpLiLU72SuPb6wk4Vyk5xKIbm3q+QpEFT1iFr1dKbuKvsXP1y
         peJMk6/zFG8MHlDUDNC8wuM3+aZvQ2rUXtsSN08g=
Date:   Thu, 30 Apr 2020 09:29:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: fix gcc-10 shift warning
Message-ID: <20200430082927.GA18615@willie-the-truck>
References: <20200429185657.4085975-1-arnd@arndb.de>
 <20200430090251.715f6bf0@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430090251.715f6bf0@why>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 09:02:51AM +0100, Marc Zyngier wrote:
> On Wed, 29 Apr 2020 20:56:20 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > gcc-10 warns that the 32-bit zero cannot be shifted more than
> > 32 bits to the right:
> > 
> > arch/arm64/kvm/../../../virt/kvm/arm/mmu.c: In function 'clear_hyp_p4d_entry':
> > arch/arm64/include/asm/pgtable.h:630:35: error: right shift count >= width of type [-Werror=shift-count-overflow]
> >   630 | #define pud_index(addr)  (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> >       |                                   ^~
> > arch/arm64/include/asm/memory.h:271:45: note: in definition of macro '__phys_to_virt'
> >   271 | #define __phys_to_virt(x) ((unsigned long)((x) - physvirt_offset))
> >       |                                             ^
> > arch/arm64/include/asm/pgtable.h:633:42: note: in expansion of macro '__va'
> >   633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
> >       |                                          ^~~~
> > arch/arm64/include/asm/pgtable.h:632:73: note: in expansion of macro 'pud_index'
> >   632 | #define pud_offset_phys(dir, addr) (p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
> >       |                                                                         ^~~~~~~~~
> > arch/arm64/include/asm/pgtable.h:633:47: note: in expansion of macro 'pud_offset_phys'
> >   633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
> >       |                                               ^~~~~~~~~~~~~~~
> > arch/arm64/kvm/../../../virt/kvm/arm/mmu.c:510:36: note: in expansion of macro 'pud_offset'
> >   510 |  pud_t *pud_table __maybe_unused = pud_offset(p4d, 0);
> >       |                                    ^~~~~~~~~~
> > 
> > This is harmless, and the warning is a little bit silly for
> > a zero constant, but it's trivial to fix by making it an
> > unsigned long, so do that.
> > 
> > Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  virt/kvm/arm/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > index 48d4288c5f1b..534d9798c3cb 100644
> > --- a/virt/kvm/arm/mmu.c
> > +++ b/virt/kvm/arm/mmu.c
> > @@ -507,7 +507,7 @@ static void clear_hyp_pgd_entry(pgd_t *pgd)
> >  
> >  static void clear_hyp_p4d_entry(p4d_t *p4d)
> >  {
> > -	pud_t *pud_table __maybe_unused = pud_offset(p4d, 0);
> > +	pud_t *pud_table __maybe_unused = pud_offset(p4d, 0UL);
> >  	VM_BUG_ON(p4d_huge(*p4d));
> >  	p4d_clear(p4d);
> >  	pud_free(NULL, pud_table);
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Happy to queue via arm64 for 5.8. Does that work for you, Arnd, or were you
planning to get this in sooner than that?

Cheers,

Will
