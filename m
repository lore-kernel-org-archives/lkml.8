Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AE5206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a7s+1C/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCRBL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:11:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45899 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCRBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493916; x=1616029916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8pxP/BuUx1Cb/JJqnsQKZD4DVP0eHuvECuwKFXk3e00=;
  b=a7s+1C/olaVDONozaP6uMvWKVmdTzPD2RsEqzEjM8BWZtQi1eMzc92UF
   jiiLPrwoLd9xQmOEPOUMadNxKhs6Ki6lniJrA6zC5Mnhkbp06M79mD47b
   J0HP9b9HUOctsqwgFIPcsInRY1SGAAhwZVkXRZvxbN17Yo1CTCr9zoh67
   p++yzP4496BHF3mJmOeCQl0+IZ/eixkykBacBpdtlplSnr9bK7aPRWc4g
   p/QtvyJ+3QcijDyNW5vcWiEfrKXUkh0HLlniisCYGlCDb9u1mQuu3e5JY
   1IwKtk/u8V054bDTdaNNtyIOMMk2mjCZWIYHBOKLH/5QU8L5VzIg+etGn
   g==;
IronPort-SDR: bLAjP1+DV2OX5Z9Evn0BuzIjnWvlpVnYzVgjo7p5eKfgvELrfpPE5mcryM5hs83UND8mZbY3lo
 rPX2WeXN5uBreWKPsHgHspvUWkRHLuySNc7qN4ZCCCffGH6Gb7vglzkwYNCbKvRJaNNxZZWFPG
 95YXJZNsZ2W12jUiLfk0MUW7bPjKhJR4JP3V+qtfOXU5GQe2qjM4+9n9lHF4Zsa5ccmH1M2vo/
 /r/fr6K8IU4zg1YsbwQTi2lzatvST4v75rjtosmuz5SiPc2f2AsXs4zsqUYFmq2yq58/LKWB4W
 ePI=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241493"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:11:55 +0800
IronPort-SDR: mSlco6lckVu8/0KAAxChx9/rtvy9HwRsOZwDshw9VDRwmgL6+SEjdAu4ld52n+9xOMYniX8gTK
 /dXMcia8K6qcCvss+nG17OIpNkovXBDadWQKRpIXPrGOj8+F4TfHhvj9fTIq3289zPcpi5SOWw
 DLeBT18SgbmLXQ9Z1nubc0Pgs4m/erTc9o6UE/rEUoe1xL1o0d/8vp10f+KRbbF/r5p1nzbUUg
 j7UKk+fg0SVVQsjhzOiLx1umzsBUMjk2oLH7tqO/lKaQJSUEevg1BU4LfkJBHuDxOqHmck7iss
 WYMj/QxlhVFCPIZwZPLG3j9Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:45 -0700
IronPort-SDR: N8pvCLGlTe2Hbx22znWWdyj0AV5CalyBuj//ERe+jv+gA/SelJsqIBgzHogpcNoShp/tHzsBH8
 qvBB+KqZvmuJN7fikypjll8SsqTW1wGtqx/oIqB75hxSJHgoxe2S6N4rSWd38QP6dGoVHaxzjb
 ALlAlOT2T27Eli3cVdEzwPxOMxiTThPaP9sYZVb/pdE6+M6JWKHx+DoYiMwEDsER1QDdcWRqeo
 44fSbIfl3X4JjD/HfqxoyAQ/7MEPjZnuOKZMvoSTAaTp8IyDWL9eAybiFmYV7DQf6x3nkPX+RJ
 VTs=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:11:55 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 00/11] Add support for SBI v0.2 and CPU hotplug
Date:   Tue, 17 Mar 2020 18:11:33 -0700
Message-Id: <20200318011144.91532-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
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

Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v11

Patches 1-5 implements the SBI v0.2 and unified calling convention.
Patches 6-7 adds a cpu_ops method that allows different booting protocols
dynamically.
Patches 9-10 adds HSM extension and ordered hart booting support.
Patche  11 adds cpu hotplug support.

Changes v10->v11:
1. Addressed few nitpick comments.
2. Dropped plic patch as it is taken through IRQ tree.

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

Atish Patra (11):
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

arch/riscv/Kconfig                   |  19 +-
arch/riscv/include/asm/cpu_ops.h     |  46 +++
arch/riscv/include/asm/sbi.h         | 195 +++++----
arch/riscv/include/asm/smp.h         |  24 ++
arch/riscv/kernel/Makefile           |   6 +
arch/riscv/kernel/cpu-hotplug.c      |  87 ++++
arch/riscv/kernel/cpu_ops.c          |  46 +++
arch/riscv/kernel/cpu_ops_sbi.c      | 115 ++++++
arch/riscv/kernel/cpu_ops_spinwait.c |  43 ++
arch/riscv/kernel/head.S             | 179 +++++----
arch/riscv/kernel/sbi.c              | 575 ++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c            |  24 +-
arch/riscv/kernel/smpboot.c          |  53 ++-
arch/riscv/kernel/traps.c            |   2 +-
arch/riscv/kernel/vmlinux.lds.S      |   5 +-
15 files changed, 1249 insertions(+), 170 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops.h
create mode 100644 arch/riscv/kernel/cpu-hotplug.c
create mode 100644 arch/riscv/kernel/cpu_ops.c
create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c

--
2.25.1

