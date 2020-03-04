Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84CBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571752072A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgCDOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:10:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgCDOKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:10:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0000A31B;
        Wed,  4 Mar 2020 06:10:51 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDD503F6CF;
        Wed,  4 Mar 2020 06:10:44 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: [PATCH V2 0/2] arm64: Enable vmemmap mapping from device memory
Date:   Wed,  4 Mar 2020 19:40:28 +0530
Message-Id: <1583331030-7335-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables vmemmap backing memory allocation from device memory
ranges on arm64. But before that, it enables vmemmap_populate_basepages()
to accommodate struct vmem_altmap based requests.

This series applies after latest (v14) arm64 memory hot remove series
(https://lkml.org/lkml/2020/3/3/1746) on Linux 5.6-rc4.

Changes in V2:

- Rebased on latest hot-remove series (v14) adding P4D page table support

Changes in V1: (https://lkml.org/lkml/2020/1/23/12)

- Added an WARN_ON() in unmap_hotplug_range() when altmap is
  provided without the page table backing memory being freed

Changes in RFC V2: (https://lkml.org/lkml/2019/10/21/11)

- Changed the commit message on 1/2 patch per Will
- Changed the commit message on 2/2 patch as well
- Rebased on arm64 memory hot remove series (v10)

RFC V1: (https://lkml.org/lkml/2019/6/28/32)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  mm/sparsemem: Enable vmem_altmap support in vmemmap_populate_basepages()
  arm64/mm: Enable vmem_altmap support for vmemmap mappings

 arch/arm64/mm/mmu.c      | 71 +++++++++++++++++++++++++++++-----------
 arch/ia64/mm/discontig.c |  2 +-
 arch/riscv/mm/init.c     |  2 +-
 arch/x86/mm/init_64.c    |  6 ++--
 include/linux/mm.h       |  5 +--
 mm/sparse-vmemmap.c      | 16 ++++++---
 6 files changed, 70 insertions(+), 32 deletions(-)

-- 
2.20.1

