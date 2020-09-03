Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D392C20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgICPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgICMbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:31:00 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABA520639;
        Thu,  3 Sep 2020 12:06:00 +0000 (UTC)
Date:   Thu, 3 Sep 2020 13:05:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Wei Li <liwei213@huawei.com>, will@kernel.org,
        saberlily.xia@hisilicon.com, puck.chen@hisilicon.com,
        butao@hisilicon.com, fengbaopeng2@hisilicon.com,
        nsaenzjulienne@suse.de, steve.capper@arm.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sujunfei2@hisilicon.com
Subject: Re: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200903120558.GB31409@gaia>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817080405.GL969206@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:04:05AM +0300, Mike Rapoport wrote:
> On Wed, Aug 12, 2020 at 09:06:55AM +0800, Wei Li wrote:
> > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > do not free the reserved memory for the page map, this patch do it.
> 
> I've been thinking about it a bit more and it seems that instead of
> freeing unused memory map it would be better to allocate the exact
> memory map from the beginning.
> 
> In sparse_init_nid() we can replace PAGES_PER_SECTION parameter to
> __populate_section_memmap() with the calculated value for architectures
> that define HAVE_ARCH_PFN_VALID.

Or just use a smaller PAGES_PER_SECTION and reduce the waste ;).

Just to be clear, are you suggesting that we should use pfn_valid() on
the pages within a section to calculate the actual range? The
pfn_valid() implementation on arm64 checks for the validity of a sparse
section, so this would be called from within the sparse_init() code
path. I hope there's no dependency but I haven't checked. If it works,
it's fine by me, it solves the FLATMEM mem_map freeing as well.

With 4KB pages on arm64, vmemmap_populate() stops at the pmd level, so
it always allocates PMD_SIZE. Wei's patch also only frees in PMD_SIZE
amounts. So, with a sizeof(struct page) of 64 (2^6), a PMD_SIZE mem_map
section would cover 2^(21-6) pages, so that's equivalent to a
SECTION_SIZE_BITS of 21-6+12 = 27.

If we reduce SECTION_SIZE_BITS to 27 or less, this patch is a no-op.

-- 
Catalin
