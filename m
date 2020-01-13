Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E81C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6D521569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578914012;
	bh=2dNo0A03VcIFSZvSVz5n249R91p3bkLWCwPae+CNXW0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QUYSw1zJCUmu8iDar7QBgZsWt3LHjFBfxNAs+6+irJ4WdAiCaokgW5CLabRAkoTBM
	 2kprb+mM9HbGZaUy/1cozy7qkm/IRy2KWx7xCYZLJaztbQha5gBvBi5U5meN0cY5ZW
	 4LxjqByb0X7+22ZFShAU1I/3hl0LoxhZKZjMG4EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMLNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:13:31 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F4B207E0;
        Mon, 13 Jan 2020 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578914010;
        bh=2dNo0A03VcIFSZvSVz5n249R91p3bkLWCwPae+CNXW0=;
        h=From:To:Cc:Subject:Date:From;
        b=IX+5b6/zaFTN4DBWq29kUL2XqxChB0YlXW59APXI9VbSvWpxMI2golVWfmN/xTNmw
         Gkv83m0zbhQ9eU2BPnGjQS2cDCExIFz4OeE/q2lCt70MQii1SemUn7XwSlV3Rr6HSs
         gJ1ol+7k77BtPl5GR2FLBxueLQnjS+tB6XbfrcLg=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
Date:   Mon, 13 Jan 2020 13:13:22 +0200
Message-Id: <20200113111323.10463-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a part of clean up of the page table manipulation code that aims to
remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h

There is a single patch for both arm and arm64 because doing the conversion
separately would mean breaking the shared mmu bits in virt/kvm/arm.

v2:
* fix build error for arch/arm64/mm/dump.c
* simplify p4d unfolding in arch/arm64/mm/kasan_init.c

Mike Rapoport (1):
  arm/arm64: add support for folded p4d page tables

 arch/arm/include/asm/kvm_mmu.h          |   5 +-
 arch/arm/include/asm/pgtable.h          |   1 -
 arch/arm/include/asm/stage2_pgtable.h   |  15 +-
 arch/arm/lib/uaccess_with_memcpy.c      |   9 +-
 arch/arm/mach-sa1100/assabet.c          |   2 +-
 arch/arm/mm/dump.c                      |  29 +++-
 arch/arm/mm/fault-armv.c                |   7 +-
 arch/arm/mm/fault.c                     |  28 +++-
 arch/arm/mm/idmap.c                     |   3 +-
 arch/arm/mm/init.c                      |   2 +-
 arch/arm/mm/ioremap.c                   |  12 +-
 arch/arm/mm/mm.h                        |   2 +-
 arch/arm/mm/mmu.c                       |  35 +++-
 arch/arm/mm/pgd.c                       |  40 ++++-
 arch/arm64/include/asm/kvm_mmu.h        |  10 +-
 arch/arm64/include/asm/pgalloc.h        |  10 +-
 arch/arm64/include/asm/pgtable-types.h  |   5 +-
 arch/arm64/include/asm/pgtable.h        |  37 +++--
 arch/arm64/include/asm/stage2_pgtable.h |  48 ++++--
 arch/arm64/kernel/hibernate.c           |  46 +++++-
 arch/arm64/mm/dump.c                    |  29 +++-
 arch/arm64/mm/fault.c                   |   9 +-
 arch/arm64/mm/hugetlbpage.c             |  15 +-
 arch/arm64/mm/kasan_init.c              |  26 ++-
 arch/arm64/mm/mmu.c                     |  52 ++++--
 arch/arm64/mm/pageattr.c                |   7 +-
 virt/kvm/arm/mmu.c                      | 209 ++++++++++++++++++++----
 27 files changed, 550 insertions(+), 143 deletions(-)

-- 
2.24.0

