Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155ADC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD85E2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585930736;
	bh=kGvJtREm3cHkza0Hr19OaPU2B3U1OtBWeYJazFhv210=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QnAf1xwo7pxHVkUmBu3d51L+MTyWsoRQHwjhM101yZgo4K2XSjK5wdJG59tBfZby3
	 Il6MqtSSFzJ6OdaM2XcF6WvP/CuBcFsm6X96nVx5KkV8CL5TxguV+fUjGsJ+STXqTQ
	 qc4WohS/GXVWFTnfRRRaTOZ3tWUU5gES0UjEMsG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbgDCQSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403778AbgDCQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:18:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6DD2073B;
        Fri,  3 Apr 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585930732;
        bh=kGvJtREm3cHkza0Hr19OaPU2B3U1OtBWeYJazFhv210=;
        h=Date:From:To:Cc:Subject:From;
        b=N9A3hogiLnVa35ZMho/gJR1cYeArY81vbJKv2QILGrUazcZebCP6H3KGb/ymFPvDT
         2p/W4vmWQAQ2hE9ubJAgpH9ysNtw2jyYJQrNV+GveHJkANnSxrxw8BefqLRJV0aH9e
         EZ64yfUvIJ3mLmAANgGa4gGcR02AwrRbRcvL1UwI=
Date:   Fri, 3 Apr 2020 18:18:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX patches for 5.7-rc1
Message-ID: <20200403161848.GA4105642@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.7-rc1

for you to fetch changes up to 71db3aa2816da62a2d150ad9fa81168537db4037:

  ASoC: MT6660: make spdxcheck.py happy (2020-03-25 12:24:01 +0100)

----------------------------------------------------------------
SPDX patches for 5.7-rc1.

Here are 3 SPDX patches for 5.7-rc1.

One fixes up the SPDX tag for a single driver, while the other two go
through the tree and add SPDX tags for all of the .gitignore files as
needed.

Nothing too complex, but you will get a merge conflict with your current
tree, that should be trivial to handle (one file modified by two things,
one file deleted.)

All 3 of these have been in linux-next for a while, with no reported
issues other than the merge conflict.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Lukas Bulwahn (1):
      ASoC: MT6660: make spdxcheck.py happy

Masahiro Yamada (2):
      .gitignore: remove too obvious comments
      .gitignore: add SPDX License Identifier

 .gitignore                                                            | 1 +
 Documentation/.gitignore                                              | 1 +
 Documentation/devicetree/bindings/.gitignore                          | 1 +
 Documentation/vm/.gitignore                                           | 1 +
 arch/.gitignore                                                       | 1 +
 arch/alpha/kernel/.gitignore                                          | 1 +
 arch/arc/boot/.gitignore                                              | 1 +
 arch/arc/kernel/.gitignore                                            | 1 +
 arch/arm/boot/.gitignore                                              | 1 +
 arch/arm/boot/compressed/.gitignore                                   | 1 +
 arch/arm/crypto/.gitignore                                            | 1 +
 arch/arm/kernel/.gitignore                                            | 1 +
 arch/arm/mach-at91/.gitignore                                         | 1 +
 arch/arm/mach-omap2/.gitignore                                        | 1 +
 arch/arm/vdso/.gitignore                                              | 1 +
 arch/arm64/boot/.gitignore                                            | 1 +
 arch/arm64/crypto/.gitignore                                          | 1 +
 arch/arm64/kernel/.gitignore                                          | 1 +
 arch/arm64/kernel/vdso/.gitignore                                     | 1 +
 arch/arm64/kernel/vdso32/.gitignore                                   | 1 +
 arch/ia64/kernel/.gitignore                                           | 1 +
 arch/m68k/kernel/.gitignore                                           | 1 +
 arch/microblaze/boot/.gitignore                                       | 1 +
 arch/microblaze/kernel/.gitignore                                     | 1 +
 arch/mips/boot/.gitignore                                             | 1 +
 arch/mips/boot/compressed/.gitignore                                  | 1 +
 arch/mips/boot/tools/.gitignore                                       | 1 +
 arch/mips/kernel/.gitignore                                           | 1 +
 arch/mips/tools/.gitignore                                            | 1 +
 arch/mips/vdso/.gitignore                                             | 1 +
 arch/nds32/kernel/.gitignore                                          | 1 +
 arch/nds32/kernel/vdso/.gitignore                                     | 1 +
 arch/nios2/boot/.gitignore                                            | 1 +
 arch/nios2/kernel/.gitignore                                          | 1 +
 arch/openrisc/kernel/.gitignore                                       | 1 +
 arch/parisc/boot/.gitignore                                           | 1 +
 arch/parisc/boot/compressed/.gitignore                                | 1 +
 arch/parisc/kernel/.gitignore                                         | 1 +
 arch/powerpc/boot/.gitignore                                          | 1 +
 arch/powerpc/kernel/.gitignore                                        | 1 +
 arch/powerpc/kernel/vdso32/.gitignore                                 | 1 +
 arch/powerpc/kernel/vdso64/.gitignore                                 | 1 +
 arch/powerpc/platforms/cell/spufs/.gitignore                          | 1 +
 arch/powerpc/purgatory/.gitignore                                     | 1 +
 arch/riscv/boot/.gitignore                                            | 1 +
 arch/riscv/kernel/.gitignore                                          | 1 +
 arch/riscv/kernel/vdso/.gitignore                                     | 1 +
 arch/s390/boot/.gitignore                                             | 1 +
 arch/s390/boot/compressed/.gitignore                                  | 1 +
 arch/s390/kernel/.gitignore                                           | 1 +
 arch/s390/kernel/vdso64/.gitignore                                    | 1 +
 arch/s390/purgatory/.gitignore                                        | 1 +
 arch/s390/tools/.gitignore                                            | 1 +
 arch/sh/boot/.gitignore                                               | 1 +
 arch/sh/boot/compressed/.gitignore                                    | 1 +
 arch/sh/kernel/.gitignore                                             | 1 +
 arch/sh/kernel/vsyscall/.gitignore                                    | 1 +
 arch/sparc/boot/.gitignore                                            | 1 +
 arch/sparc/kernel/.gitignore                                          | 1 +
 arch/sparc/vdso/.gitignore                                            | 1 +
 arch/sparc/vdso/vdso32/.gitignore                                     | 1 +
 arch/um/.gitignore                                                    | 1 +
 arch/unicore32/.gitignore                                             | 1 +
 arch/x86/.gitignore                                                   | 1 +
 arch/x86/boot/.gitignore                                              | 1 +
 arch/x86/boot/compressed/.gitignore                                   | 1 +
 arch/x86/boot/tools/.gitignore                                        | 1 +
 arch/x86/crypto/.gitignore                                            | 1 +
 arch/x86/entry/vdso/.gitignore                                        | 1 +
 arch/x86/entry/vdso/vdso32/.gitignore                                 | 1 +
 arch/x86/kernel/.gitignore                                            | 1 +
 arch/x86/kernel/cpu/.gitignore                                        | 1 +
 arch/x86/lib/.gitignore                                               | 1 +
 arch/x86/realmode/rm/.gitignore                                       | 1 +
 arch/x86/tools/.gitignore                                             | 1 +
 arch/x86/um/vdso/.gitignore                                           | 1 +
 arch/xtensa/boot/.gitignore                                           | 1 +
 arch/xtensa/boot/boot-elf/.gitignore                                  | 1 +
 arch/xtensa/boot/lib/.gitignore                                       | 1 +
 arch/xtensa/kernel/.gitignore                                         | 1 +
 certs/.gitignore                                                      | 4 +---
 drivers/atm/.gitignore                                                | 2 +-
 drivers/crypto/vmx/.gitignore                                         | 1 +
 drivers/eisa/.gitignore                                               | 1 +
 drivers/gpu/drm/i915/.gitignore                                       | 1 +
 drivers/gpu/drm/radeon/.gitignore                                     | 1 +
 drivers/memory/.gitignore                                             | 1 +
 drivers/net/wan/.gitignore                                            | 1 +
 drivers/scsi/.gitignore                                               | 1 +
 drivers/scsi/aic7xxx/.gitignore                                       | 1 +
 drivers/staging/comedi/drivers/ni_routing/tools/.gitignore            | 1 +
 drivers/staging/greybus/tools/.gitignore                              | 1 +
 drivers/video/logo/.gitignore                                         | 4 +---
 drivers/zorro/.gitignore                                              | 1 +
 fs/unicode/.gitignore                                                 | 1 +
 kernel/.gitignore                                                     | 4 +---
 kernel/debug/kdb/.gitignore                                           | 1 +
 lib/.gitignore                                                        | 4 +---
 lib/raid6/.gitignore                                                  | 1 +
 net/bpfilter/.gitignore                                               | 1 +
 net/wireless/.gitignore                                               | 1 +
 samples/auxdisplay/.gitignore                                         | 1 +
 samples/bpf/.gitignore                                                | 1 +
 samples/connector/.gitignore                                          | 1 +
 samples/hidraw/.gitignore                                             | 1 +
 samples/mei/.gitignore                                                | 1 +
 samples/mic/mpssd/.gitignore                                          | 1 +
 samples/pidfd/.gitignore                                              | 1 +
 samples/seccomp/.gitignore                                            | 1 +
 samples/timers/.gitignore                                             | 1 +
 samples/vfs/.gitignore                                                | 1 +
 samples/watchdog/.gitignore                                           | 1 +
 scripts/.gitignore                                                    | 4 +---
 scripts/basic/.gitignore                                              | 1 +
 scripts/dtc/.gitignore                                                | 1 +
 scripts/gcc-plugins/.gitignore                                        | 1 +
 scripts/gdb/linux/.gitignore                                          | 1 +
 scripts/genksyms/.gitignore                                           | 1 +
 scripts/kconfig/.gitignore                                            | 4 +---
 scripts/mod/.gitignore                                                | 1 +
 scripts/selinux/genheaders/.gitignore                                 | 1 +
 scripts/selinux/mdp/.gitignore                                        | 2 +-
 security/apparmor/.gitignore                                          | 4 +---
 security/selinux/.gitignore                                           | 1 +
 security/tomoyo/.gitignore                                            | 1 +
 sound/oss/.gitignore                                                  | 2 +-
 sound/soc/codecs/mt6660.c                                             | 2 +-
 tools/accounting/.gitignore                                           | 1 +
 tools/bootconfig/.gitignore                                           | 1 +
 tools/bpf/.gitignore                                                  | 1 +
 tools/bpf/bpftool/.gitignore                                          | 1 +
 tools/bpf/runqslower/.gitignore                                       | 1 +
 tools/build/.gitignore                                                | 1 +
 tools/build/feature/.gitignore                                        | 1 +
 tools/cgroup/.gitignore                                               | 1 +
 tools/gpio/.gitignore                                                 | 1 +
 tools/iio/.gitignore                                                  | 1 +
 tools/laptop/dslm/.gitignore                                          | 1 +
 tools/leds/.gitignore                                                 | 1 +
 tools/lib/bpf/.gitignore                                              | 1 +
 tools/lib/lockdep/.gitignore                                          | 1 +
 tools/lib/traceevent/.gitignore                                       | 1 +
 tools/memory-model/.gitignore                                         | 1 +
 tools/memory-model/litmus-tests/.gitignore                            | 1 +
 tools/objtool/.gitignore                                              | 1 +
 tools/pcmcia/.gitignore                                               | 1 +
 tools/perf/.gitignore                                                 | 1 +
 tools/perf/tests/.gitignore                                           | 1 +
 tools/power/acpi/.gitignore                                           | 1 +
 tools/power/cpupower/.gitignore                                       | 1 +
 tools/power/x86/intel-speed-select/.gitignore                         | 1 +
 tools/power/x86/turbostat/.gitignore                                  | 1 +
 tools/spi/.gitignore                                                  | 1 +
 tools/testing/kunit/.gitignore                                        | 1 +
 tools/testing/radix-tree/.gitignore                                   | 1 +
 tools/testing/selftests/.gitignore                                    | 1 +
 tools/testing/selftests/android/ion/.gitignore                        | 1 +
 tools/testing/selftests/arm64/signal/.gitignore                       | 1 +
 tools/testing/selftests/arm64/tags/.gitignore                         | 1 +
 tools/testing/selftests/bpf/.gitignore                                | 1 +
 tools/testing/selftests/bpf/map_tests/.gitignore                      | 1 +
 tools/testing/selftests/bpf/prog_tests/.gitignore                     | 1 +
 tools/testing/selftests/bpf/verifier/.gitignore                       | 1 +
 tools/testing/selftests/breakpoints/.gitignore                        | 1 +
 tools/testing/selftests/capabilities/.gitignore                       | 1 +
 tools/testing/selftests/cgroup/.gitignore                             | 1 +
 tools/testing/selftests/clone3/.gitignore                             | 1 +
 tools/testing/selftests/drivers/.gitignore                            | 1 +
 tools/testing/selftests/efivarfs/.gitignore                           | 1 +
 tools/testing/selftests/exec/.gitignore                               | 1 +
 tools/testing/selftests/filesystems/.gitignore                        | 1 +
 tools/testing/selftests/filesystems/binderfs/.gitignore               | 1 +
 tools/testing/selftests/filesystems/epoll/.gitignore                  | 1 +
 tools/testing/selftests/ftrace/.gitignore                             | 1 +
 tools/testing/selftests/futex/functional/.gitignore                   | 1 +
 tools/testing/selftests/gpio/.gitignore                               | 1 +
 tools/testing/selftests/ia64/.gitignore                               | 1 +
 tools/testing/selftests/intel_pstate/.gitignore                       | 1 +
 tools/testing/selftests/ipc/.gitignore                                | 1 +
 tools/testing/selftests/ir/.gitignore                                 | 1 +
 tools/testing/selftests/kcmp/.gitignore                               | 1 +
 tools/testing/selftests/kvm/.gitignore                                | 1 +
 tools/testing/selftests/media_tests/.gitignore                        | 1 +
 tools/testing/selftests/membarrier/.gitignore                         | 1 +
 tools/testing/selftests/memfd/.gitignore                              | 1 +
 tools/testing/selftests/mount/.gitignore                              | 1 +
 tools/testing/selftests/mqueue/.gitignore                             | 1 +
 tools/testing/selftests/net/.gitignore                                | 1 +
 tools/testing/selftests/net/forwarding/.gitignore                     | 1 +
 tools/testing/selftests/net/mptcp/.gitignore                          | 1 +
 tools/testing/selftests/networking/timestamping/.gitignore            | 1 +
 tools/testing/selftests/nsfs/.gitignore                               | 1 +
 tools/testing/selftests/openat2/.gitignore                            | 1 +
 tools/testing/selftests/pidfd/.gitignore                              | 1 +
 tools/testing/selftests/powerpc/alignment/.gitignore                  | 1 +
 tools/testing/selftests/powerpc/benchmarks/.gitignore                 | 1 +
 tools/testing/selftests/powerpc/cache_shape/.gitignore                | 1 +
 tools/testing/selftests/powerpc/copyloops/.gitignore                  | 1 +
 tools/testing/selftests/powerpc/dscr/.gitignore                       | 1 +
 tools/testing/selftests/powerpc/math/.gitignore                       | 1 +
 tools/testing/selftests/powerpc/mm/.gitignore                         | 1 +
 tools/testing/selftests/powerpc/pmu/.gitignore                        | 1 +
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore                    | 1 +
 tools/testing/selftests/powerpc/primitives/.gitignore                 | 1 +
 tools/testing/selftests/powerpc/ptrace/.gitignore                     | 1 +
 tools/testing/selftests/powerpc/security/.gitignore                   | 1 +
 tools/testing/selftests/powerpc/signal/.gitignore                     | 1 +
 tools/testing/selftests/powerpc/stringloops/.gitignore                | 1 +
 tools/testing/selftests/powerpc/switch_endian/.gitignore              | 1 +
 tools/testing/selftests/powerpc/syscalls/.gitignore                   | 1 +
 tools/testing/selftests/powerpc/tm/.gitignore                         | 1 +
 tools/testing/selftests/powerpc/vphn/.gitignore                       | 1 +
 tools/testing/selftests/prctl/.gitignore                              | 1 +
 tools/testing/selftests/proc/.gitignore                               | 1 +
 tools/testing/selftests/pstore/.gitignore                             | 1 +
 tools/testing/selftests/ptp/.gitignore                                | 1 +
 tools/testing/selftests/ptrace/.gitignore                             | 1 +
 tools/testing/selftests/rcutorture/.gitignore                         | 1 +
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore        | 1 +
 .../selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore    | 1 +
 .../rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore      | 1 +
 tools/testing/selftests/rseq/.gitignore                               | 1 +
 tools/testing/selftests/rtc/.gitignore                                | 1 +
 tools/testing/selftests/safesetid/.gitignore                          | 1 +
 tools/testing/selftests/seccomp/.gitignore                            | 1 +
 tools/testing/selftests/sigaltstack/.gitignore                        | 1 +
 tools/testing/selftests/size/.gitignore                               | 1 +
 tools/testing/selftests/sparc64/drivers/.gitignore                    | 1 +
 tools/testing/selftests/splice/.gitignore                             | 1 +
 tools/testing/selftests/sync/.gitignore                               | 1 +
 tools/testing/selftests/tc-testing/.gitignore                         | 1 +
 tools/testing/selftests/timens/.gitignore                             | 1 +
 tools/testing/selftests/timers/.gitignore                             | 1 +
 tools/testing/selftests/tmpfs/.gitignore                              | 1 +
 tools/testing/selftests/vDSO/.gitignore                               | 1 +
 tools/testing/selftests/vm/.gitignore                                 | 1 +
 tools/testing/selftests/watchdog/.gitignore                           | 1 +
 tools/testing/selftests/wireguard/qemu/.gitignore                     | 1 +
 tools/testing/selftests/x86/.gitignore                                | 1 +
 tools/testing/vsock/.gitignore                                        | 1 +
 tools/thermal/tmon/.gitignore                                         | 1 +
 tools/usb/.gitignore                                                  | 1 +
 tools/usb/usbip/.gitignore                                            | 1 +
 tools/virtio/.gitignore                                               | 1 +
 tools/vm/.gitignore                                                   | 1 +
 usr/.gitignore                                                        | 1 +
 usr/include/.gitignore                                                | 1 +
 247 files changed, 247 insertions(+), 25 deletions(-)
