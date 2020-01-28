Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC51C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11B624656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hIa5Ahvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1C2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43151 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1C2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178488; x=1611714488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2nWGxJNu5AaNrPUR9Ax2z2U4KExulXxbW7We38PzOCE=;
  b=hIa5AhvfGmBeEB8Ljnf7PcTfrPdMZUwV1dmHROxDDzQUokJz03GGqWnk
   oQ4wKvwslWenHyG7coiZ1q9ae8Eh9DafHHbuVcpSCY/pxTsOoiytb99vm
   mAUiWFiIo0q9rrun/sznpvxFMJHspxoYTTCplVRgmz3p//+Qcu3/YjFCT
   5bEEMLn0iWxn1m4FSOFd670ZbG1rJmWDnq0XrE1SPONQ5AHxjk0Q1kxjl
   kypt/DYzXww+Ams5BD0ckSVikrdBEtQb6GEzblUc0pnbrAMa1KJNH7Cfv
   ay1XYMfsUBSbOYoimCEyJi3gTO2y5dIsEk74ny1cB/RGCIseezau9MM9Q
   A==;
IronPort-SDR: CdBLYpEvVbZhbWXdOgESpkOB/uRHq1FdV3gZEZCha4MR83bKi5u/kJBC+l1U3yfq+Q3mKj78+j
 fmQprAkiR8LCOervpsfwfiAT51Acv6+diyQYNjkGorP53ign1Jy8sDf5vAfN7jhz2TL954fbeA
 26A5Gf8bfIPI4dBhBnnrhLlKftHPAJP+JNMV7XM5i1xuXnjIySd0Z5ZllkX7+anrYKh00o8Xoh
 /g9FqnpJo2yrkQsFeY5hftITbQBGenS7qvJlPx1NcC/+fwMV150tHBtIJyCMfSX28Lb7oxDsGE
 QOk=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899358"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:07 +0800
IronPort-SDR: XzwBdj0DuqDhxTv5WzgXqqZ7kouJ1jjjauXCX6WKMVEQfViKoRV6KceSStoAY57ILEKQU708IQ
 kCh5kbRvqBVhMuguE1BxzDnfRINokbAsVkRBSjtI+eeGnXtymn8La9BDRu03VsDpjE7D5MOvjV
 IS8+6TTvjEciu5yh+rUjWKmbq1vqwBVmwAC/Pq3jVD0deqqZ8dO5t4awsGGazi9ItwhlwJQb18
 Km3EBjNgiGofxn1dR6z69u2NRW6WwjRjno/iiEIqlOhnNtK6+/NgI2ImZDyuof5nF5azIjQyuk
 H5+butDMq3aXgFamz5MqqyOM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:22 -0800
IronPort-SDR: 34puJ9SRsX/BV5rJp7+tSp1HSuXrV64X9EzBR/aH2/qxzQo7VHZYIgTjcmYQVPq7DmptsyF5CX
 zyK7biyrpqgd3yx9MAdeQPA7r1KYCciJRAkLxzb4KZZ2NY83A5V6woAC1bj9Pb23frcDLTCCfl
 BkEvKftbbaEdN86TIlmI0fbh+ivOizrvm09IFWYcznEi8CORqANXu0UhJOtSA8yqOFGsd2M9YQ
 GNlI8/0SghWhwwq+2QJR4kKRrMXxFdYOBrO2ROLhwuyap6cCawgS1D2t2G3bsZeDOGJZ1hAKyB
 cFs=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 00/10] Add support for SBI v0.2 and CPU hotplug
Date:   Mon, 27 Jan 2020 18:27:27 -0800
Message-Id: <20200128022737.15371-1-atish.patra@wdc.com>
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
Linux Kernel: https://github.com/atishp04/linux/tree/sbi_v0.2_v7

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

Atish Patra (10):
RISC-V: Mark existing SBI as 0.1 SBI.
RISC-V: Add basic support for SBI v0.2
RISC-V: Add SBI v0.2 extension definitions
RISC-V: Introduce a new config for SBI v0.1
RISC-V: Implement new SBI v0.2 extensions
RISC-V: Add cpu_ops and modify default booting method
RISC-V: Move relocate and few other functions out of __init
RISC-V: Add SBI HSM extension
RISC-V: Add supported for ordered booting method using HSM
RISC-V: Support cpu hotplug

arch/riscv/Kconfig               |  18 +-
arch/riscv/include/asm/cpu_ops.h |  36 ++
arch/riscv/include/asm/sbi.h     | 197 +++++++----
arch/riscv/include/asm/smp.h     |  14 +
arch/riscv/kernel/Makefile       |   2 +
arch/riscv/kernel/cpu-hotplug.c  |  84 +++++
arch/riscv/kernel/cpu_ops.c      | 134 ++++++++
arch/riscv/kernel/head.S         |  98 ++++--
arch/riscv/kernel/sbi.c          | 574 ++++++++++++++++++++++++++++++-
arch/riscv/kernel/setup.c        |  34 +-
arch/riscv/kernel/smpboot.c      |  54 +--
arch/riscv/kernel/traps.c        |   2 +-
arch/riscv/kernel/vmlinux.lds.S  |   9 +-
13 files changed, 1128 insertions(+), 128 deletions(-)
create mode 100644 arch/riscv/include/asm/cpu_ops.h
create mode 100644 arch/riscv/kernel/cpu-hotplug.c
create mode 100644 arch/riscv/kernel/cpu_ops.c

--
2.24.0

