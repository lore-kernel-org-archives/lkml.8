Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694B220679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFCPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:36:18 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34971 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:36:18 -0400
X-Originating-IP: 90.112.45.105
Received: from debian.home (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CE2A5FF811;
        Wed,  3 Jun 2020 15:36:14 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/2] PUD/PGDIR entries for linear mapping 
Date:   Wed,  3 Jun 2020 11:36:06 -0400
Message-Id: <20200603153608.30056-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset intends to use PUD/PGDIR entries for linear mapping
in order to better utilize TLB.

At the moment, only PMD entries can be used since on common platforms
(qemu/unleashed), the kernel is loaded at DRAM + 2MB which dealigns virtual
and physical addresses and then prevents the use of PUD/PGDIR entries.
So the kernel must be able to get those 2MB for PAGE_OFFSET to map the
beginning of the DRAM: this is achieved in patch 1.

But furthermore, at the moment, the firmware (opensbi) explicitly asks the
kernel not to map the region it occupies, which is on those common
platforms at the very beginning of the DRAM and then it also dealigns
virtual and physical addresses. I proposed a patch here:

https://github.com/riscv/opensbi/pull/167

that removes this 'constraint' but *not* all the time as it offers some
kind of protection in case PMP is not available. So sometimes, we may
have a part of the memory below the kernel that is removed creating a
misalignment between virtual and physical addresses. So for performance
reasons, we must at least make sure that PMD entries can be used: that
is guaranteed by patch 1 too.

Finally the second patch simply improves best_map_size so that whenever
possible, PUD/PGDIR entries are used. 

Below is the kernel page table without this patch on a 6G platform:

---[ Linear mapping ]---
0xffffc00000000000-0xffffc00176e00000    0x0000000080200000 5998M PMD     D A . . . W R V 

And with this patchset + opensbi patch:

---[ Linear mapping ]---
0xffffc00000000000-0xffffc00140000000 0x0000000080000000         5G PUD     D A . . . W R V
0xffffc00140000000-0xffffc00177000000    0x00000001c0000000 880M PMD     D A . . . W R V

Alexandre Ghiti (2):
  riscv: Get memory below load_pa while ensuring linear mapping is PMD
    aligned
  riscv: Use PUD/PGDIR entries for linear mapping when possible

 arch/riscv/include/asm/page.h |  8 ++++
 arch/riscv/mm/init.c          | 69 +++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 12 deletions(-)

-- 
2.20.1

