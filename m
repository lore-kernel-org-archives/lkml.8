Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC50420890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgGBOEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBOEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:04:02 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341F920772;
        Thu,  2 Jul 2020 14:03:58 +0000 (UTC)
Date:   Thu, 2 Jul 2020 15:03:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 (RESEND) 1/3] mm/sparsemem: Enable vmem_altmap support
 in vmemmap_populate_basepages()
Message-ID: <20200702140355.GE22241@gaia>
References: <1592442930-9380-1-git-send-email-anshuman.khandual@arm.com>
 <1592442930-9380-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592442930-9380-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 06:45:28AM +0530, Anshuman Khandual wrote:
> vmemmap_populate_basepages() is used across platforms to allocate backing
> memory for vmemmap mapping. This is used as a standard default choice or
> as a fallback when intended huge pages allocation fails. This just creates
> entire vmemmap mapping with base pages (PAGE_SIZE).
> 
> On arm64 platforms, vmemmap_populate_basepages() is called instead of the
> platform specific vmemmap_populate() when ARM64_SWAPPER_USES_SECTION_MAPS
> is not enabled as in case for ARM64_16K_PAGES and ARM64_64K_PAGES configs.
> 
> At present vmemmap_populate_basepages() does not support allocating from
> driver defined struct vmem_altmap while trying to create vmemmap mapping
> for a device memory range. It prevents ARM64_16K_PAGES and ARM64_64K_PAGES
> configs on arm64 from supporting device memory with vmemap_altmap request.
> 
> This enables vmem_altmap support in vmemmap_populate_basepages() unlocking
> device memory allocation for vmemap mapping on arm64 platforms with 16K or
> 64K base page configs.
> 
> Each architecture should evaluate and decide on subscribing device memory
> based base page allocation through vmemmap_populate_basepages(). Hence lets
> keep it disabled on all archs in order to preserve the existing semantics.
> A subsequent patch enables it on arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: Jia He <justin.he@arm.com>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
