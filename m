Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2682C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CDD2074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591211129;
	bh=Q/m5m0oN16XVkE9B8qyre3sjNLjlsvtMr3faOM5/GEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bg5MWQEpmYWgSrezB7aCvClpqfD/uczDzvBx0cHKl6HvRwEvZKwf/45r9zgwv3lT7
	 Gxl5UvHH/cMFf4WuxSvzmS71/O8G0Effb8gAy3x19lUX6iYEPKjtRp+SQSfcFaE533
	 NiChgCu8c+hADBBSVjmLejbXmbZSqdddDKZcxbyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCTF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:05:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BA820663;
        Wed,  3 Jun 2020 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591211124;
        bh=Q/m5m0oN16XVkE9B8qyre3sjNLjlsvtMr3faOM5/GEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r0JH+r6+eneNzPkKh10OQRnG/QlntwU5Ile5RdgUbb4S95xZcMJwqqczR44dEoW5/
         dXJbJhSARnLrJiGeqA21ANe/57CLpUdIlqiMBG6WT4nQbXPfCWGsOTxjBMHqOIWaG6
         YrNwC3X4+y9pXx6gFBNVV3K2D741HNKSuj4FGwes=
Date:   Wed, 3 Jun 2020 12:05:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 08/14] powerpc: add support for folded p4d page
 tables
Message-Id: <20200603120522.7646d56a23088416a7d3fc1a@linux-foundation.org>
In-Reply-To: <20200414153455.21744-9-rppt@kernel.org>
References: <20200414153455.21744-1-rppt@kernel.org>
        <20200414153455.21744-9-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 18:34:49 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.

A bunch of new material just landed in linux-next/powerpc.

The timing is awkward!  I trust this will be going into mainline during
this merge window?  If not, please drop it and repull after -rc1.

arch/powerpc/mm/ptdump/ptdump.c:walk_pagetables() was a problem. 
Here's what I ended up with - please check.

static void walk_pagetables(struct pg_state *st)
{
	unsigned int i;
	unsigned long addr = st->start_address & PGDIR_MASK;
	pgd_t *pgd = pgd_offset_k(addr);

	/*
	 * Traverse the linux pagetable structure and dump pages that are in
	 * the hash pagetable.
	 */
	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
		p4d_t *p4d = p4d_offset(pgd, 0);

		if (pgd_none(*pgd) || pgd_is_leaf(*pgd))
			note_page(st, addr, 1, p4d_val(*p4d), PGDIR_SIZE);
		else if (is_hugepd(__hugepd(p4d_val(*p4d))))
			walk_hugepd(st, (hugepd_t *)pgd, addr, PGDIR_SHIFT, 1);
		else
			/* pgd exists */
			walk_pud(st, p4d, addr);
	}
}

Mike's series "mm: consolidate definitions of page table accessors"
took quite a lot of damage as well.  Patches which needed rework as a
result of this were:

powerpc-add-support-for-folded-p4d-page-tables-fix.patch
mm-introduce-include-linux-pgtableh.patch
mm-reorder-includes-after-introduction-of-linux-pgtableh.patch
mm-pgtable-add-shortcuts-for-accessing-kernel-pmd-and-pte.patch
mm-pgtable-add-shortcuts-for-accessing-kernel-pmd-and-pte-fix-2.patch
mm-consolidate-pte_index-and-pte_offset_-definitions.patch
mm-consolidate-pmd_index-and-pmd_offset-definitions.patch
mm-consolidate-pud_index-and-pud_offset-definitions.patch
mm-consolidate-pgd_index-and-pgd_offset_k-definitions.patch

