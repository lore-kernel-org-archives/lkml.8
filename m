Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E33C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7BF208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgCaJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:49:56 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:14590 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730131AbgCaJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:49:55 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 02V9XJJ1065696
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:33:19 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 02V9W6MH065446;
        Tue, 31 Mar 2020 17:32:06 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 31 Mar 2020
 17:32:58 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <green.hu@gmail.com>, <Anup.Patel@wdc.com>,
        <akpm@linux-foundation.org>, <logang@deltatee.com>,
        <david.abdurachmanov@gmail.com>, <atish.patra@wdc.com>,
        <tglx@linutronix.de>, <bp@suse.de>, <yash.shah@sifive.com>,
        <alex@ghiti.fr>, <zong.li@sifive.com>, <gary@garyguo.net>,
        <rppt@linux.ibm.com>, <steven.price@arm.com>,
        Eric Lin <tesheng@andestech.com>
Subject: [PATCH 0/3] Highmem support for 32-bit RISC-V
Date:   Tue, 31 Mar 2020 17:32:38 +0800
Message-ID: <20200331093241.3728-1-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 02V9W6MH065446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Highmem support, the kernel can map more than 1GB physical memory.

This patchset implements Highmem for RV32, referencing to mostly nds32
and others like arm and mips, and it has been tested on Andes A25MP platform.

Eric Lin (3):
  riscv/mm: Add pkmap region and CONFIG_HIGHMEM
  riscv/mm: Implement kmap() and kmap_atomic()
  riscv/mm: Add pkmap in print_vm_layout()

 arch/riscv/Kconfig               | 18 +++++++
 arch/riscv/include/asm/fixmap.h  |  9 +++-
 arch/riscv/include/asm/highmem.h | 49 +++++++++++++++++
 arch/riscv/include/asm/pgtable.h | 27 ++++++++++
 arch/riscv/mm/Makefile           |  1 +
 arch/riscv/mm/highmem.c          | 74 +++++++++++++++++++++++++
 arch/riscv/mm/init.c             | 92 ++++++++++++++++++++++++++++++--
 7 files changed, 266 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/highmem.h
 create mode 100644 arch/riscv/mm/highmem.c

-- 
2.17.0

