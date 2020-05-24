Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDCE20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgEXIxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 04:53:22 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53393 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgEXIxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:53:21 -0400
Received: from localhost.localdomain (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5C8BB200006;
        Sun, 24 May 2020 08:53:08 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 0/3] vmalloc kernel mapping and relocatable kernel
Date:   Sun, 24 May 2020 04:52:56 -0400
Message-Id: <20200524085259.24784-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset originally implemented relocatable kernel support but now
also moves the kernel mapping into the vmalloc zone.

The first patch explains why we need to move the kernel into vmalloc
zone (instead of memcpying it around). That patch should ease KASLR
implementation a lot.

The second patch allows to build relocatable kernels but is not selected
by default.

The third patch takes advantage of an already existing powerpc script
that checks relocations at compile-time, and uses it for riscv.

Alexandre Ghiti (3):
  riscv: Move kernel mapping to vmalloc zone
  riscv: Introduce CONFIG_RELOCATABLE
  arch, scripts: Add script to check relocations at compile time

 arch/powerpc/tools/relocs_check.sh |  18 +----
 arch/riscv/Kconfig                 |  12 +++
 arch/riscv/Makefile                |   5 +-
 arch/riscv/Makefile.postlink       |  36 +++++++++
 arch/riscv/boot/loader.lds.S       |   3 +-
 arch/riscv/include/asm/page.h      |  10 ++-
 arch/riscv/include/asm/pgtable.h   |  37 ++++++---
 arch/riscv/kernel/head.S           |   3 +-
 arch/riscv/kernel/module.c         |   4 +-
 arch/riscv/kernel/vmlinux.lds.S    |   9 ++-
 arch/riscv/mm/Makefile             |   4 +
 arch/riscv/mm/init.c               | 121 +++++++++++++++++++++++++----
 arch/riscv/mm/physaddr.c           |   2 +-
 arch/riscv/tools/relocs_check.sh   |  26 +++++++
 scripts/relocs_check.sh            |  20 +++++
 15 files changed, 258 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh

-- 
2.20.1

