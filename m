Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C6C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BDA20842
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4uZ8dpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBLBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:51:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60368 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBLBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472313; x=1613008313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5fLxqpGfQmcjZB4SEqPkjidgJg4T+I5OvAtf/YXSDv0=;
  b=F4uZ8dpL682gj9k/2p8/GkTqZLpSGK1sELH7n8SalOVmNh+yQW/X3iqF
   Ed16pOUE6IFrlZyFV15axhTw2MFAz4XSMfCeZ7YAXFgPUutG7wW/6GIaz
   2c2caxclqK1VWcbXIQEQvnTA6Dc8GA2aGHN+Kar4lO8zqe/dE1xzha+kk
   kfnYP2THLdzhht0PV9+IUnVsBEcIrvz3QOOsCVY0W9v8soC5w9Pf2JRht
   77Q9k/kEej7U9fHfAxsB6eP7TIuHlb1bBLbvcZw24zAXjFmt5otBDRmpW
   I95Lnq+IjTcomVBxA4K88XlzNiyhD6//t6LXzQIjoi1GrDxo1WeGZwZi1
   Q==;
IronPort-SDR: Eqzso6pqOpfTDCHBo2rFBGzjul7TmWfkvFuZXfq+zHIlwfjx6UIc905cn4cxA27OzO7Bt0ROlK
 0D9QV+baBZIlG/oUtBYou4E/JGw5/cFEAfxUDpU477R5ZgsdBaonKWseX4/ZayQLHQjVmUebY0
 dbzJP2unvtM4DKPJ5mJA2gUCkICuOoZV7u4K1HRyjCUIsRAfWFb8o4pCtPDMrQ0CjdzaWB0Q8u
 fVV9bzTrUF/26gccZiyWY16m5oWjGZGbxYcHadvr9vT7lKZxCxlczRz1qX1D+XhZAk5L6ZJNwx
 9s8=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648926"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:53 +0800
IronPort-SDR: tnP9ntnSUG1z8obWdjX3FryblJZ9M9rWAncnR/mucLgAAVd8iRuN/7YVE+RoUuNjwWPBBDqAQE
 i1I8KjFo2hugxnPKWQUfY1F1as/E/LzhQgIWdllX53FThvwO8dYzl7+7yx3LVNIUju3yXx7ZdC
 G9NMNiJIb2G+j9/Ja2RhYTjcxlzuk/GImFOWStJAucjtsDOU35nSnFQpwtpI6S/0ausoFanv3g
 PZiCHyKju+p+EupGRcQwHBpGi3n13oj9OHmqEXh7W/dBUIdm/bsZd3XTMTdUSOtuQfatPq/38J
 N+FtMgNDtPBUpt9StpdwUe30
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:42 -0800
IronPort-SDR: Hy31uM001YTf70zkpyhY/6R96UZXmMSb9FmdW2iFY4jmZ/u3/bhslOXYMXH9BQokfwmfTvZIw+
 jdcokz2i7Kc6c0uZ6MYDa546OYxV92tnUXxnjGygFSCyaZoLB1F2R6FUAubfb+y8j1YgI8AUVP
 y/jV9R4yQdYnoYrDKIu4kwuzgqa0mNHtZ3WF/+Mj3fc0ggpm9GxAXQ8Indfr8h5H4QyAXfKzDu
 j4Og1gWpPVkspMqzBlkQhvxxdCuOCXWtNzFsGzo73PyBQwqNeT5blSASykqraIONqn59XLQXC1
 yks=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:52 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v8 00/11] Add support for SBI v0.2 and CPU hotplug
Date:   Tue, 11 Feb 2020 17:48:11 -0800
Message-Id: <20200212014822.28684-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supervisor Binary Interface(SBI) specification[1] now defines a
base extension that provides extendability to add future extensions
while maintaining backward compatibility with previous versions.
The new version is defined as 0.2 and older version is marked as 0.1.

This series adds support v0.2 and a unified calling convention
implementation between 0.1 and 0.2. It also add other SBI v0.2
functionality defined in [2]. The base support for SBI v0.2 is already
available in OpenSBI v0.5. It also adds SBI HSM extension and cpu-hotplug
support for RISC-V which requires additional patches[3] in OpenSBI.

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://github.com/riscv/riscv-sbi-doc/pull/27
[3] http://lists.infradead.org/pipermail/opensbi/2020-January/001050.html

The patches are also available in following github repositery.

OpenSBI     : https://github.com/atishp04/opensbi/tree/sbi_hsm_v1
Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v8

Changes from v7->v8:
1. Refactored to code to have modular cpu_ops calls.
2. Refactored HSM extension from sbi.c to cpu_ops_sbi.c.
3. Fix plic driver to handle cpu hotplug.

Changes from v6->v7:
1. Rebased on v5.5
2. Fixed few compilation issues for !CONFIG_SMP and !CONFIG_RISCV_SBI
3. Added SBI HSM extension
4. Add CPU hotplug support

Changes from v5->v6
1. Fixed few compilation issues around config.
2. Fixed hart mask generation issues for RFENCE & IPI extensions.

Changes from v4->v5
1. Fixed few minor comments related to static & inline.
2. Make sure that every patch is boot tested individually.

Changes from v3->v4.
1. Rebased on for-next.
2. Fixed issuses with checkpatch --strict.
3. Unfied all IPI/fence related functions.
4. Added Hfence related SBI calls.

Changes from v2->v3.
1. Moved v0.1 extensions to a new config.
2. Added support for relacement extensions of v0.1 extensions.

Changes from v1->v2
1. Removed the legacy calling convention.
2. Moved all SBI related calls to sbi.c.
3. Moved all SBI related macros to uapi.

Atish Patra (11):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Add SBI v0.2 extension definitions
RISC-V: Introduce a new config for SBI v0.1
RISC-V: Implement new SBI v0.2 extensions
RISC-V: Move relocate and few other functions out of __init
RISC-V: Add cpu_ops and modify default booting method
RISC-V: Add SBI HSM extension
RISC-V: Add supported for ordered booting method using HSM
irqchip/sifive-plic: Initialize the plic handler when cpu comes online
RISC-V: Support cpu hotplug

arch/riscv/Kconfig                   |  19 +-
arch/riscv/include/asm/cpu_ops.h     |  46 +++
arch/riscv/include/asm/sbi.h         | 194 ++++++----
arch/riscv/include/asm/smp.h         |  24 ++
arch/riscv/kernel/Makefile           |   6 +
arch/riscv/kernel/cpu-hotplug.c      |  87 +++++
arch/riscv/kernel/cpu_ops.c          |  48 +++
arch/riscv/kernel/cpu_ops_sbi.c      | 113 ++++++
arch/riscv/kernel/cpu_ops_spinwait.c |  42 +++
arch/riscv/kernel/head.S             | 179 +++++----
arch/riscv/kernel/sbi.c              | 524 ++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c            |  24 +-
arch/riscv/kernel/smpboot.c          |  56 +--
arch/riscv/kernel/traps.c            |   2 +-
arch/riscv/kernel/vmlinux.lds.S      |   5 +-
drivers/irqchip/irq-sifive-plic.c    |  34 +-
include/linux/cpuhotplug.h           |   1 +
17 files changed, 1227 insertions(+), 177 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops.h
create mode 100644 arch/riscv/kernel/cpu-hotplug.c
create mode 100644 arch/riscv/kernel/cpu_ops.c
create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c

--
2.24.0

