Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FC12074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFCILL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:11:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56089 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCILL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:11:11 -0400
Received: from debian.home (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 096D024000F;
        Wed,  3 Jun 2020 08:11:05 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 0/8] Introduce sv48 support
Date:   Wed,  3 Jun 2020 04:10:56 -0400
Message-Id: <20200603081104.14004-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements sv48 support at runtime. The kernel will try to         
boot with 4-level page table and will fallback to 3-level if the HW does not     
support it.                                                                      
                                                                                 
The biggest advantage is that we only have one kernel for 64bit, which           
is way easier to maintain.                                                       
                                                                                 
Folding the 4th level into a 3-level page table has almost no cost at            
runtime. But as mentioned Palmer, the relocatable code generated is less         
performant.                                                                      
                                                                                 
At the moment, there is no way to build a 3-level page table non-relocatable     
64bit kernel. We agreed that distributions will use this runtime configuration   
anyway, but Palmer proposed to introduce a new Kconfig, which I will do later    
as sv48 support was asked for 5.8.                                               
                                                                                 
Finally, the user can now ask for sv39 explicitly by using the device-tree       
which will reduce memory footprint and reduce the number of memory accesses      
in case of TLB miss.

Changes in v2:
  * Move variable declarations to pgtable.h in patch 5/7 as suggested by Anup
  * Restore mmu-type properties in patch 6 as suggested by Anup
  * Fix unused variable in patch 5 that was used in patch 6
  * Fix SPARSEMEM build (patch 2 was modified so I dropped the Reviewed-by)
  * Applied various Reviewed-by

Alexandre Ghiti (8):
  riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
  riscv: Allow to dynamically define VA_BITS
  riscv: Simplify MAXPHYSMEM config
  riscv: Prepare ptdump for vm layout dynamic addresses
  riscv: Implement sv48 support
  riscv: Allow user to downgrade to sv39 when hw supports sv48
  riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
  riscv: Explicit comment about user virtual address space size

 arch/riscv/Kconfig                  |  34 ++---
 arch/riscv/include/asm/csr.h        |   3 +-
 arch/riscv/include/asm/fixmap.h     |   1 +
 arch/riscv/include/asm/page.h       |  15 +++
 arch/riscv/include/asm/pgalloc.h    |  36 ++++++
 arch/riscv/include/asm/pgtable-64.h |  97 +++++++++++++-
 arch/riscv/include/asm/pgtable.h    |  31 ++++-
 arch/riscv/include/asm/sparsemem.h  |   6 +-
 arch/riscv/kernel/cpu.c             |  23 ++--
 arch/riscv/kernel/head.S            |   3 +-
 arch/riscv/mm/context.c             |   2 +-
 arch/riscv/mm/init.c                | 194 ++++++++++++++++++++++++----
 arch/riscv/mm/ptdump.c              |  49 +++++--
 13 files changed, 412 insertions(+), 82 deletions(-)

-- 
2.20.1

