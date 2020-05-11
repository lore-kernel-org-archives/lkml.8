Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EF7C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0562E20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEKL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:28:41 -0400
Received: from foss.arm.com ([217.140.110.172]:58216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbgEKL2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B5D1FB;
        Mon, 11 May 2020 04:28:37 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B2A3F305;
        Mon, 11 May 2020 04:28:36 -0700 (PDT)
Date:   Mon, 11 May 2020 12:28:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, paulus@ozlabs.org, benh@kernel.crashing.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: silence kmemleak false positives
Message-ID: <20200511112829.GB19176@gaia>
References: <20200509015538.3183-1-cai@lca.pw>
 <87y2pybu38.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pybu38.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:15:55PM +1000, Michael Ellerman wrote:
> Qian Cai <cai@lca.pw> writes:
> > kvmppc_pmd_alloc() and kvmppc_pte_alloc() allocate some memory but then
> > pud_populate() and pmd_populate() will use __pa() to reference the newly
> > allocated memory. The same is in xive_native_provision_pages().
> >
> > Since kmemleak is unable to track the physical memory resulting in false
> > positives, silence those by using kmemleak_ignore().
> 
> There is kmemleak_alloc_phys(), which according to the docs can be used
> for tracking a phys address.

This won't help. While kmemleak_alloc_phys() allows passing a physical
address, it doesn't track physical address references to this object. It
still expects VA pointing to it, otherwise the object would be reported
as a leak.

We currently only call this from the memblock code with a min_count of
0, meaning it will not be reported as a leak if no references are found.

We don't have this issue with page tables on other architectures since
most of them use whole page allocations which aren't tracked by
kmemleak. These powerpc functions use kmem_cache_alloc() which would be
tracked automatically by kmemleak. While we could add a phys alias to
kmemleak (another search tree), I think the easiest is as per Qian's
patch, just ignore those objects.

-- 
Catalin
