Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0563EC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC67424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AUcRv6kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgBUAo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:44:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17964 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBUAot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245907; x=1613781907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mkH3jLLtkTicXkgvXT4tQe8W1GcI/fSzczfYIAf9uBI=;
  b=AUcRv6kl5fYjGm8CUUmn3wu/cjKSnoNH4ZMDOTm7FbjN/E8GgrUXYJfz
   M9/LzXHUtwnf5t9fbUAxKRbx//W9s5oyQ/IzmwWkok5fzpVuNxYkYzuj2
   WWQ9C2SxOwZrLM8Pv/55Q/9lt2ZA5Qzh+oJu6YmP8aS911EJUh4ePIIZM
   UwiMc1OSd4wo+ajnpkKA/lesZztvZ+jydZco82BchEE3KrUsdJDGC/1rC
   MK21Aq/F4qcAPNOjmKSYDXgmHS3VpzAytLLosI//5ythlGqBQxrNKw+dK
   aEUYRgeQeSVIK8VB3pbvivrpeRCZbxbCjXN6WI+CAe/SMvQmSGxxTyIyd
   A==;
IronPort-SDR: P13bopKmF/xsblGBvpw8xMf3pD4DMbydASg1Ndmf8/qHP9a3UGPrfh5cEu3jRFQsK+qwgrORKG
 tPvtmsXpuj580R57YI/tW/kE/sVoqDUdU+tzJEB9gyJVTctwXNXqKpd6A6vQCrH6eX2m+eOpE+
 /BrBI6XnuvtvoQl43Dh6RnC1XvaQlWu9/cMOo4zP+jCLeu2K0FV3RYnwXpFus7joPMoWhDsGpf
 arpnYk2bOBc5rel96zTue1vre6k8iZ0faeT5pZz6e5/p8f6cxjmQLlMzWYARxMlV1XFnF0Sf9m
 46I=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="232211042"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:45:00 +0800
IronPort-SDR: 0F2sqiDQBVKBZ7nVuQrOUFIrL02hboAGqY2aQ8gNVRcLLol4YDnZGCrR34pgeZ8gSPKlPu6a8o
 bvn8DH2WYcqIGwbX1v80KcICuD4Rj0GZzhrp4UyUrheH1E6hQd8WZhHygNnqd0d+kGP+7UbbSy
 ZI/UNv2HAVzW0l1Y9W6A4w4Bo5dpX7rL4iEkDn6/3Dfutyd/vAALkQ7qu9lAnlGKjJkIitDvJ6
 dOH7r9CkMCgqKkyfNCF6T//w8H7gq/365Jq0GCj2FFzRSMJ5mqlY1AfGKJ+wXUsgjRSp5VY3NR
 4fE9w1ZgMi8sQOaxjoXLvwm8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:20 -0800
IronPort-SDR: G5zwEfdYQvKlhSAbse4AV5OdYGtseAfJTPnF5rorr3ir/WzPC6RyWAaIHIPvPNTP7S9tHaFh5g
 eTUKT9dGTuYZ6EiM6AgwggDkQFaaPOi8Ou7COIf+26oIrvh7UE1ZDWNygCkSXyXVbitD5r3MYC
 8ZfY5jUvETdPwSbpVAI6/gJ6T0gNQ7vrZd5KuN5DfbtSut2fd4Ssg3hT2Rsd16x3fESrhxAaDg
 wgmEhs7xzfsAo3Y7Gg60YVyErb8geddvKhO64HgBkcso/IIvhqbdoQwmH+Fb0LZBuf60PUL9j8
 d4M=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:44 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 00/12] Add support for SBI v0.2 and CPU hotplug
Date:   Thu, 20 Feb 2020 16:44:01 -0800
Message-Id: <20200221004413.12869-1-atish.patra@wdc.com>
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
The base support for SBI v0.2 is already available in OpenSBI v0.5.
It also adds SBI HSM extension and cpu-hotplug support for RISC-V
which requires additional patches[3] in OpenSBI.

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[3] http://lists.infradead.org/pipermail/opensbi/2020-January/001050.html

The patches are also available in following github repositery.

OpenSBI     : https://github.com/atishp04/opensbi/tree/sbi_hsm_v1
Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v9

Patches 1-5 implements the SBI v0.2 and unified calling convention.
Patches 6-7 adds a cpu_ops method that allows different booting protocols
dynamically.
Patches 9-10 adds HSM extension and ordered hart booting support.
Patche  11 adds cpu hotplug support.

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

