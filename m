Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A55C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766CE21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qEkMgnnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBZWCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45025 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBZWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754540; x=1614290540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rBJ3vXikl+0s9E0hdVoZ5Lyza+72c1dZ4ILKvVNCaIQ=;
  b=qEkMgnnO6K+BGvQCoqPMiTxS8q8mKLSq+xXs5rRl1Kv0urrfVXehvJtu
   D6xx3xduvafZo7HoIv2C3WIpnmpRgHRC2gPVXZefdXhrWIa6vUYM/woVT
   JqcslUSteqDtP+DtoQiUplIOEzdGSs1Qpn+8zYafsx4b0LLEaV0K61kxR
   gxaPCBB6O7oUraGQ/k0ToSLK/tlFkGVlYkZrUNp03gLlLwJ1ARpnmC8hr
   gaGo+MW5j47bX7mm21xlxGXvtouWP1dcIHf2DAzBenjWK8r93cmLHgRaE
   /WXK5rxXbIpBtDhKmj8yr3mY7tM5EED485ka4FOa9MvRg2KeeKszL2ftm
   A==;
IronPort-SDR: S/UqNsNe7gR7VE/TM9wA/gnk0o6oob5yLABVVBfaZxith1djiWGzmP4gIb6Hlbb6VuwMZmqJVc
 KbyCVPfERW0jNj/0zt8tJ7L86Oo/Rr0quQgUDZg57AaP+mFnnqz/4T14OolZe/zTyZfmUbwBlv
 0dcjLYP0yjHP9TMaDVSCrfU5Sd+ebNN7a9nadD3IQt1XdgHoW8eqdy679yumgpch1x4z5W8hX2
 rEM29ug6PqDJUQfDk0AWH+RKWDs3TVuuwt5VqKy5fxXGuTQIoKppr3PybW5HimL3MHlJfkAWds
 vYo=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290704"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:20 +0800
IronPort-SDR: Ddi31C5GDdbW8HTQtdhhF9hNEd4ldf/yAcv2Ca+x0mQCu1+uySr7K4kqxObuSTrhVkpqkYuRAG
 Ampd0/RhEQTYVS6ILkno5IW22VEF71eswFEtp3viMlXF98NCFVfKnqYxOkRm9wtxkW6YW2IZTG
 z1doMuSHnZLJuSTt51D/J18jAgtM+VsP2nAg7yfi+0eHWvyRX5/DO0czkFWjjM4oc5UYzUWRTO
 AnT6oVLGI/R1/rnshWz1EudT+cjWEvYSqeRRRGXirKfe6UHeduXOoUhQcvvIO+BnECvisw7rLA
 kpJgTZ1BzpmhwElIXfBATM2w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:44 -0800
IronPort-SDR: oFMV2Ddv2uH2253aACgS6/RJkJtsdSPO4ESG8vf4uSdEJkhNvZ2rMNL4Z2VJvS8H9FMtjnkJHv
 Sfv4+307mEfNwhlpXsh0Vav1KKzhWZbZHy2Kwj88kBulZT5krAM5u6MXV3SM/T1Tjaoebh3ohy
 0wUekIkf6wXxW8Rk22NNdAIkr/+bj9aajG8GKDkDU8NOcTYUcj71iqVCsB4XiJNg3+WjKTwg3K
 0wYOwQHBX6GAV2CsZ6fygqeWYnntGmQofvBhN+uk5DojEJA4n8uuHSl8KlfHg9ByTYkww6QKQF
 xGs=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:19 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 00/12] Add support for SBI v0.2 and CPU hotplug
Date:   Wed, 26 Feb 2020 14:02:01 -0800
Message-Id: <20200226220213.27423-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
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

This series adds following features to RISC-V Linux.
1. Adds support for SBI v0.2
2. A Unified calling convention implementation between 0.1 and 0.2. 
3. SBI Hart state management extension (HSM)
4. Ordered booting of harts
4. CPU hotplug 

Dependencies:
The support for SBI v0.2 and HSM extension is already available in OpenSBI
master.

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc

The patches are also available in following github repositery.

Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v10

Patches 1-5 implements the SBI v0.2 and unified calling convention.
Patches 6-7 adds a cpu_ops method that allows different booting protocols
dynamically.
Patches 9-10 adds HSM extension and ordered hart booting support.
Patche  11 adds cpu hotplug support.

Changes from v9->10:
1. Minor copyright fixes.
2. Renaming of HSM extension definitions to match the spec.
 
Changes from v8->v9:
1. Added a sliding window hart base method to support larger hart masks.
2. Added a callback to disable interrupts when cpu go offline.
3. Made the HSM extension series more modular.

Changes from v7-v8:
1. Refactored to code to have modular cpu_ops calls.
2. Refactored HSM extension from sbi.c to cpu_ops_sbi.c.
3. Fix plic driver to handle cpu hotplug.

Changes from v6-v7:
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

Atish Patra (12):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Add SBI v0.2 extension definitions
RISC-V: Introduce a new config for SBI v0.1
RISC-V: Implement new SBI v0.2 extensions
RISC-V: Move relocate and few other functions out of __init
RISC-V: Add cpu_ops and modify default booting method
RISC-V: Export SBI error to linux error mapping function
RISC-V: Add SBI HSM extension definitions
RISC-V: Add supported for ordered booting method using HSM
RISC-V: Support cpu hotplug
irqchip/sifive-plic: Initialize the plic handler when cpu comes online

arch/riscv/Kconfig                   |  19 +-
arch/riscv/include/asm/cpu_ops.h     |  46 +++
arch/riscv/include/asm/sbi.h         | 194 +++++----
arch/riscv/include/asm/smp.h         |  24 ++
arch/riscv/kernel/Makefile           |   6 +
arch/riscv/kernel/cpu-hotplug.c      |  87 ++++
arch/riscv/kernel/cpu_ops.c          |  46 +++
arch/riscv/kernel/cpu_ops_sbi.c      | 115 ++++++
arch/riscv/kernel/cpu_ops_spinwait.c |  42 ++
arch/riscv/kernel/head.S             | 179 +++++----
arch/riscv/kernel/sbi.c              | 567 ++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c            |  24 +-
arch/riscv/kernel/smpboot.c          |  53 +--
arch/riscv/kernel/traps.c            |   4 +-
arch/riscv/kernel/vmlinux.lds.S      |   5 +-
drivers/irqchip/irq-sifive-plic.c    |  38 +-
include/linux/cpuhotplug.h           |   1 +
17 files changed, 1275 insertions(+), 175 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops.h
create mode 100644 arch/riscv/kernel/cpu-hotplug.c
create mode 100644 arch/riscv/kernel/cpu_ops.c
create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c

--
2.25.0

