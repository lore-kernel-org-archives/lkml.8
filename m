Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C162C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772B206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585131064;
	bh=NYYdjwUkYxYwxWpUfSnho1V7dgi9c6jNsMeBGtNgooc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gnEkVJZ4dY3RrfrRAOWP8YeB1kw13u0bQl7KykXaFk3OUTKxGoZfXxfDv1Wx094Y/
	 KoWky69frX6pMCyebdcgdTBtEwY+DEFcWJ2iKg9nynSfNyf83fYrNDdHCq5pxjQbCK
	 yS5Y6gPfF86TElz54N9yI4FRKuFm6ulS/u4UpBVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCYKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:11:02 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:52874 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:11:01 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02PAAf3B009111;
        Wed, 25 Mar 2020 19:10:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02PAAf3B009111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585131043;
        bh=FL6Dns6ImsVCL5P+xGionYanaDZka1Sn2IGCu0P1JLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KOHK8yZboSHLWxZHsnqJWJRYCWooSSKy7seiWqk1BW43flYNOvXdKckiEk+I7Ff09
         91HrQ0KimelbX7Eid78Sk31fgxpTv+6FrSDa//hP9iUsmUys5MeC99HJYHXpfFLStS
         c6fF1Y+bLSxodpmHiSvwDQaWoDIof2okcvVALiPy9k9Kvgeacc8hIAoHIB7tLlX1iT
         yNTJbP0XfkwQ+/61xJIvNGbb+PCYwQ8wejliZqmJyAPfchfnmhkNqA10B7C9EiLG4Y
         Pbd96b1MOqm+oLsoUP48fGfwJ2K1xKADRqejpNzGIdXKvP10NcwlflXyGEGhifnxTE
         daZ9SLIyBpSJw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id j128so1120980vsd.6;
        Wed, 25 Mar 2020 03:10:42 -0700 (PDT)
X-Gm-Message-State: ANhLgQ17CBJwh6To7y1cEkswYOpg9OhJSTb7XmUNu+QAZLU50YapoSxm
        13Ed15erPkGyVdr1Do4kQnxdjditxwcsuV+ZEFw=
X-Google-Smtp-Source: ADFU+vsAzsvdqiOikXzis+OzNA98ck1iNTgaDAEkwkSyALLusJEqIMXAgWKwe8Qv0OQ6X83Jqi/or6w21Ek3EBAMDPo=
X-Received: by 2002:a67:eb91:: with SMTP id e17mr1833909vso.179.1585131040037;
 Wed, 25 Mar 2020 03:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200303133600.9263-1-masahiroy@kernel.org> <20200303133600.9263-2-masahiroy@kernel.org>
In-Reply-To: <20200303133600.9263-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Mar 2020 19:10:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com>
Message-ID: <CAK7LNARZUpDKXpniNZ+_=G5Gskebc0HEHT5TKbaz2Xs_Ni6u4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] .gitignore: add SPDX License Identifier
To:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 10:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Add SPDX License Identifier to all .gitignore files.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Ping?


> ---
>
>  .gitignore                                                       | 1 +
>  Documentation/.gitignore                                         | 1 +
>  Documentation/devicetree/bindings/.gitignore                     | 1 +
>  Documentation/vm/.gitignore                                      | 1 +
>  arch/.gitignore                                                  | 1 +
>  arch/alpha/kernel/.gitignore                                     | 1 +
>  arch/arc/boot/.gitignore                                         | 1 +
>  arch/arc/kernel/.gitignore                                       | 1 +
>  arch/arm/boot/.gitignore                                         | 1 +
>  arch/arm/boot/compressed/.gitignore                              | 1 +
>  arch/arm/crypto/.gitignore                                       | 1 +
>  arch/arm/kernel/.gitignore                                       | 1 +
>  arch/arm/mach-at91/.gitignore                                    | 1 +
>  arch/arm/mach-omap2/.gitignore                                   | 1 +
>  arch/arm/vdso/.gitignore                                         | 1 +
>  arch/arm64/boot/.gitignore                                       | 1 +
>  arch/arm64/crypto/.gitignore                                     | 1 +
>  arch/arm64/kernel/.gitignore                                     | 1 +
>  arch/arm64/kernel/vdso/.gitignore                                | 1 +
>  arch/arm64/kernel/vdso32/.gitignore                              | 1 +
>  arch/ia64/kernel/.gitignore                                      | 1 +
>  arch/m68k/kernel/.gitignore                                      | 1 +
>  arch/microblaze/boot/.gitignore                                  | 1 +
>  arch/microblaze/kernel/.gitignore                                | 1 +
>  arch/mips/boot/.gitignore                                        | 1 +
>  arch/mips/boot/compressed/.gitignore                             | 1 +
>  arch/mips/boot/tools/.gitignore                                  | 1 +
>  arch/mips/kernel/.gitignore                                      | 1 +
>  arch/mips/tools/.gitignore                                       | 1 +
>  arch/mips/vdso/.gitignore                                        | 1 +
>  arch/nds32/kernel/.gitignore                                     | 1 +
>  arch/nds32/kernel/vdso/.gitignore                                | 1 +
>  arch/nios2/boot/.gitignore                                       | 1 +
>  arch/nios2/kernel/.gitignore                                     | 1 +
>  arch/openrisc/kernel/.gitignore                                  | 1 +
>  arch/parisc/boot/.gitignore                                      | 1 +
>  arch/parisc/boot/compressed/.gitignore                           | 1 +
>  arch/parisc/kernel/.gitignore                                    | 1 +
>  arch/powerpc/boot/.gitignore                                     | 1 +
>  arch/powerpc/kernel/.gitignore                                   | 1 +
>  arch/powerpc/kernel/vdso32/.gitignore                            | 1 +
>  arch/powerpc/kernel/vdso64/.gitignore                            | 1 +
>  arch/powerpc/platforms/cell/spufs/.gitignore                     | 1 +
>  arch/powerpc/purgatory/.gitignore                                | 1 +
>  arch/riscv/boot/.gitignore                                       | 1 +
>  arch/riscv/kernel/.gitignore                                     | 1 +
>  arch/riscv/kernel/vdso/.gitignore                                | 1 +
>  arch/s390/boot/.gitignore                                        | 1 +
>  arch/s390/boot/compressed/.gitignore                             | 1 +
>  arch/s390/kernel/.gitignore                                      | 1 +
>  arch/s390/kernel/vdso64/.gitignore                               | 1 +
>  arch/s390/purgatory/.gitignore                                   | 1 +
>  arch/s390/tools/.gitignore                                       | 1 +
>  arch/sh/boot/.gitignore                                          | 1 +
>  arch/sh/boot/compressed/.gitignore                               | 1 +
>  arch/sh/kernel/.gitignore                                        | 1 +
>  arch/sh/kernel/vsyscall/.gitignore                               | 1 +
>  arch/sparc/boot/.gitignore                                       | 1 +
>  arch/sparc/kernel/.gitignore                                     | 1 +
>  arch/sparc/vdso/.gitignore                                       | 1 +
>  arch/sparc/vdso/vdso32/.gitignore                                | 1 +
>  arch/um/.gitignore                                               | 1 +
>  arch/unicore32/.gitignore                                        | 1 +
>  arch/x86/.gitignore                                              | 1 +
>  arch/x86/boot/.gitignore                                         | 1 +
>  arch/x86/boot/compressed/.gitignore                              | 1 +
>  arch/x86/boot/tools/.gitignore                                   | 1 +
>  arch/x86/crypto/.gitignore                                       | 1 +
>  arch/x86/entry/vdso/.gitignore                                   | 1 +
>  arch/x86/entry/vdso/vdso32/.gitignore                            | 1 +
>  arch/x86/kernel/.gitignore                                       | 1 +
>  arch/x86/kernel/cpu/.gitignore                                   | 1 +
>  arch/x86/lib/.gitignore                                          | 1 +
>  arch/x86/realmode/rm/.gitignore                                  | 1 +
>  arch/x86/tools/.gitignore                                        | 1 +
>  arch/x86/um/vdso/.gitignore                                      | 1 +
>  arch/xtensa/boot/.gitignore                                      | 1 +
>  arch/xtensa/boot/boot-elf/.gitignore                             | 1 +
>  arch/xtensa/boot/lib/.gitignore                                  | 1 +
>  arch/xtensa/kernel/.gitignore                                    | 1 +
>  certs/.gitignore                                                 | 1 +
>  drivers/atm/.gitignore                                           | 1 +
>  drivers/crypto/vmx/.gitignore                                    | 1 +
>  drivers/eisa/.gitignore                                          | 1 +
>  drivers/gpu/drm/i915/.gitignore                                  | 1 +
>  drivers/gpu/drm/radeon/.gitignore                                | 1 +
>  drivers/memory/.gitignore                                        | 1 +
>  drivers/net/wan/.gitignore                                       | 1 +
>  drivers/scsi/.gitignore                                          | 1 +
>  drivers/scsi/aic7xxx/.gitignore                                  | 1 +
>  drivers/staging/comedi/drivers/ni_routing/tools/.gitignore       | 1 +
>  drivers/staging/greybus/tools/.gitignore                         | 1 +
>  drivers/video/logo/.gitignore                                    | 1 +
>  drivers/zorro/.gitignore                                         | 1 +
>  fs/unicode/.gitignore                                            | 1 +
>  kernel/.gitignore                                                | 1 +
>  kernel/debug/kdb/.gitignore                                      | 1 +
>  lib/.gitignore                                                   | 1 +
>  lib/raid6/.gitignore                                             | 1 +
>  net/bpfilter/.gitignore                                          | 1 +
>  net/wireless/.gitignore                                          | 1 +
>  samples/auxdisplay/.gitignore                                    | 1 +
>  samples/bpf/.gitignore                                           | 1 +
>  samples/connector/.gitignore                                     | 1 +
>  samples/hidraw/.gitignore                                        | 1 +
>  samples/mei/.gitignore                                           | 1 +
>  samples/mic/mpssd/.gitignore                                     | 1 +
>  samples/pidfd/.gitignore                                         | 1 +
>  samples/seccomp/.gitignore                                       | 1 +
>  samples/timers/.gitignore                                        | 1 +
>  samples/vfs/.gitignore                                           | 1 +
>  samples/watchdog/.gitignore                                      | 1 +
>  scripts/.gitignore                                               | 1 +
>  scripts/basic/.gitignore                                         | 1 +
>  scripts/dtc/.gitignore                                           | 1 +
>  scripts/gcc-plugins/.gitignore                                   | 1 +
>  scripts/gdb/linux/.gitignore                                     | 1 +
>  scripts/genksyms/.gitignore                                      | 1 +
>  scripts/kconfig/.gitignore                                       | 1 +
>  scripts/mod/.gitignore                                           | 1 +
>  scripts/selinux/genheaders/.gitignore                            | 1 +
>  scripts/selinux/mdp/.gitignore                                   | 1 +
>  security/apparmor/.gitignore                                     | 1 +
>  security/selinux/.gitignore                                      | 1 +
>  security/tomoyo/.gitignore                                       | 1 +
>  sound/oss/.gitignore                                             | 1 +
>  tools/accounting/.gitignore                                      | 1 +
>  tools/bootconfig/.gitignore                                      | 1 +
>  tools/bpf/.gitignore                                             | 1 +
>  tools/bpf/bpftool/.gitignore                                     | 1 +
>  tools/bpf/runqslower/.gitignore                                  | 1 +
>  tools/build/.gitignore                                           | 1 +
>  tools/build/feature/.gitignore                                   | 1 +
>  tools/cgroup/.gitignore                                          | 1 +
>  tools/gpio/.gitignore                                            | 1 +
>  tools/iio/.gitignore                                             | 1 +
>  tools/laptop/dslm/.gitignore                                     | 1 +
>  tools/leds/.gitignore                                            | 1 +
>  tools/lib/bpf/.gitignore                                         | 1 +
>  tools/lib/lockdep/.gitignore                                     | 1 +
>  tools/lib/traceevent/.gitignore                                  | 1 +
>  tools/memory-model/.gitignore                                    | 1 +
>  tools/memory-model/litmus-tests/.gitignore                       | 1 +
>  tools/objtool/.gitignore                                         | 1 +
>  tools/pcmcia/.gitignore                                          | 1 +
>  tools/perf/.gitignore                                            | 1 +
>  tools/perf/tests/.gitignore                                      | 1 +
>  tools/power/acpi/.gitignore                                      | 1 +
>  tools/power/cpupower/.gitignore                                  | 1 +
>  tools/power/x86/intel-speed-select/.gitignore                    | 1 +
>  tools/power/x86/turbostat/.gitignore                             | 1 +
>  tools/spi/.gitignore                                             | 1 +
>  tools/testing/kunit/.gitignore                                   | 1 +
>  tools/testing/radix-tree/.gitignore                              | 1 +
>  tools/testing/selftests/.gitignore                               | 1 +
>  tools/testing/selftests/android/ion/.gitignore                   | 1 +
>  tools/testing/selftests/arm64/signal/.gitignore                  | 1 +
>  tools/testing/selftests/arm64/tags/.gitignore                    | 1 +
>  tools/testing/selftests/bpf/.gitignore                           | 1 +
>  tools/testing/selftests/bpf/map_tests/.gitignore                 | 1 +
>  tools/testing/selftests/bpf/prog_tests/.gitignore                | 1 +
>  tools/testing/selftests/bpf/verifier/.gitignore                  | 1 +
>  tools/testing/selftests/breakpoints/.gitignore                   | 1 +
>  tools/testing/selftests/capabilities/.gitignore                  | 1 +
>  tools/testing/selftests/cgroup/.gitignore                        | 1 +
>  tools/testing/selftests/clone3/.gitignore                        | 1 +
>  tools/testing/selftests/drivers/.gitignore                       | 1 +
>  tools/testing/selftests/efivarfs/.gitignore                      | 1 +
>  tools/testing/selftests/exec/.gitignore                          | 1 +
>  tools/testing/selftests/filesystems/.gitignore                   | 1 +
>  tools/testing/selftests/filesystems/binderfs/.gitignore          | 1 +
>  tools/testing/selftests/filesystems/epoll/.gitignore             | 1 +
>  tools/testing/selftests/ftrace/.gitignore                        | 1 +
>  tools/testing/selftests/futex/functional/.gitignore              | 1 +
>  tools/testing/selftests/gpio/.gitignore                          | 1 +
>  tools/testing/selftests/ia64/.gitignore                          | 1 +
>  tools/testing/selftests/intel_pstate/.gitignore                  | 1 +
>  tools/testing/selftests/ipc/.gitignore                           | 1 +
>  tools/testing/selftests/ir/.gitignore                            | 1 +
>  tools/testing/selftests/kcmp/.gitignore                          | 1 +
>  tools/testing/selftests/kvm/.gitignore                           | 1 +
>  tools/testing/selftests/media_tests/.gitignore                   | 1 +
>  tools/testing/selftests/membarrier/.gitignore                    | 1 +
>  tools/testing/selftests/memfd/.gitignore                         | 1 +
>  tools/testing/selftests/mount/.gitignore                         | 1 +
>  tools/testing/selftests/mqueue/.gitignore                        | 1 +
>  tools/testing/selftests/net/.gitignore                           | 1 +
>  tools/testing/selftests/net/forwarding/.gitignore                | 1 +
>  tools/testing/selftests/net/mptcp/.gitignore                     | 1 +
>  tools/testing/selftests/networking/timestamping/.gitignore       | 1 +
>  tools/testing/selftests/nsfs/.gitignore                          | 1 +
>  tools/testing/selftests/openat2/.gitignore                       | 1 +
>  tools/testing/selftests/pidfd/.gitignore                         | 1 +
>  tools/testing/selftests/powerpc/alignment/.gitignore             | 1 +
>  tools/testing/selftests/powerpc/benchmarks/.gitignore            | 1 +
>  tools/testing/selftests/powerpc/cache_shape/.gitignore           | 1 +
>  tools/testing/selftests/powerpc/copyloops/.gitignore             | 1 +
>  tools/testing/selftests/powerpc/dscr/.gitignore                  | 1 +
>  tools/testing/selftests/powerpc/math/.gitignore                  | 1 +
>  tools/testing/selftests/powerpc/mm/.gitignore                    | 1 +
>  tools/testing/selftests/powerpc/pmu/.gitignore                   | 1 +
>  tools/testing/selftests/powerpc/pmu/ebb/.gitignore               | 1 +
>  tools/testing/selftests/powerpc/primitives/.gitignore            | 1 +
>  tools/testing/selftests/powerpc/ptrace/.gitignore                | 1 +
>  tools/testing/selftests/powerpc/security/.gitignore              | 1 +
>  tools/testing/selftests/powerpc/signal/.gitignore                | 1 +
>  tools/testing/selftests/powerpc/stringloops/.gitignore           | 1 +
>  tools/testing/selftests/powerpc/switch_endian/.gitignore         | 1 +
>  tools/testing/selftests/powerpc/syscalls/.gitignore              | 1 +
>  tools/testing/selftests/powerpc/tm/.gitignore                    | 1 +
>  tools/testing/selftests/powerpc/vphn/.gitignore                  | 1 +
>  tools/testing/selftests/prctl/.gitignore                         | 1 +
>  tools/testing/selftests/proc/.gitignore                          | 1 +
>  tools/testing/selftests/pstore/.gitignore                        | 1 +
>  tools/testing/selftests/ptp/.gitignore                           | 1 +
>  tools/testing/selftests/ptrace/.gitignore                        | 1 +
>  tools/testing/selftests/rcutorture/.gitignore                    | 1 +
>  tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore   | 1 +
>  .../rcutorture/formal/srcu-cbmc/include/linux/.gitignore         | 1 +
>  .../rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore | 1 +
>  tools/testing/selftests/rseq/.gitignore                          | 1 +
>  tools/testing/selftests/rtc/.gitignore                           | 1 +
>  tools/testing/selftests/safesetid/.gitignore                     | 1 +
>  tools/testing/selftests/seccomp/.gitignore                       | 1 +
>  tools/testing/selftests/sigaltstack/.gitignore                   | 1 +
>  tools/testing/selftests/size/.gitignore                          | 1 +
>  tools/testing/selftests/sparc64/drivers/.gitignore               | 1 +
>  tools/testing/selftests/splice/.gitignore                        | 1 +
>  tools/testing/selftests/sync/.gitignore                          | 1 +
>  tools/testing/selftests/tc-testing/.gitignore                    | 1 +
>  tools/testing/selftests/timens/.gitignore                        | 1 +
>  tools/testing/selftests/timers/.gitignore                        | 1 +
>  tools/testing/selftests/tmpfs/.gitignore                         | 1 +
>  tools/testing/selftests/vDSO/.gitignore                          | 1 +
>  tools/testing/selftests/vm/.gitignore                            | 1 +
>  tools/testing/selftests/watchdog/.gitignore                      | 1 +
>  tools/testing/selftests/wireguard/qemu/.gitignore                | 1 +
>  tools/testing/selftests/x86/.gitignore                           | 1 +
>  tools/testing/vsock/.gitignore                                   | 1 +
>  tools/thermal/tmon/.gitignore                                    | 1 +
>  tools/usb/.gitignore                                             | 1 +
>  tools/usb/usbip/.gitignore                                       | 1 +
>  tools/virtio/.gitignore                                          | 1 +
>  tools/vm/.gitignore                                              | 1 +
>  usr/.gitignore                                                   | 1 +
>  usr/include/.gitignore                                           | 1 +
>  246 files changed, 246 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 2763fce8766c..059e0257482d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  #
>  # NOTE! Don't add files that are generated in specific
>  # subdirectories here. Add them in the ".gitignore" file
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index e74fec8693b2..d6dc7c9b8e25 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  output
>  *.pyc
> diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> index 57afa1533a5f..5c6d8ea1a09c 100644
> --- a/Documentation/devicetree/bindings/.gitignore
> +++ b/Documentation/devicetree/bindings/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.example.dts
>  processed-schema*.yaml
> diff --git a/Documentation/vm/.gitignore b/Documentation/vm/.gitignore
> index 09b164a5700f..bc74f5643008 100644
> --- a/Documentation/vm/.gitignore
> +++ b/Documentation/vm/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  page-types
>  slabinfo
> diff --git a/arch/.gitignore b/arch/.gitignore
> index 741468920320..4191da401dbb 100644
> --- a/arch/.gitignore
> +++ b/arch/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  i386
>  x86_64
> diff --git a/arch/alpha/kernel/.gitignore b/arch/alpha/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/alpha/kernel/.gitignore
> +++ b/arch/alpha/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/arc/boot/.gitignore b/arch/arc/boot/.gitignore
> index c4c5fd529c25..675db1494028 100644
> --- a/arch/arc/boot/.gitignore
> +++ b/arch/arc/boot/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  uImage
> diff --git a/arch/arc/kernel/.gitignore b/arch/arc/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/arc/kernel/.gitignore
> +++ b/arch/arc/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> index ce1c5ff746e7..8c759326baf4 100644
> --- a/arch/arm/boot/.gitignore
> +++ b/arch/arm/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  Image
>  zImage
>  xipImage
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index 2fdb4885846b..60606b0f378d 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ashldi3.S
>  bswapsdi2.S
>  font.c
> diff --git a/arch/arm/crypto/.gitignore b/arch/arm/crypto/.gitignore
> index 31e1f538df7d..790e204050ba 100644
> --- a/arch/arm/crypto/.gitignore
> +++ b/arch/arm/crypto/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  aesbs-core.S
>  sha256-core.S
>  sha512-core.S
> diff --git a/arch/arm/kernel/.gitignore b/arch/arm/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/arm/kernel/.gitignore
> +++ b/arch/arm/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/arm/mach-at91/.gitignore b/arch/arm/mach-at91/.gitignore
> index 2ecd6f51c8a9..f6d47389675e 100644
> --- a/arch/arm/mach-at91/.gitignore
> +++ b/arch/arm/mach-at91/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pm_data-offsets.h
> diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
> index 79a8d6ea7152..dc7be7556736 100644
> --- a/arch/arm/mach-omap2/.gitignore
> +++ b/arch/arm/mach-omap2/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pm-asm-offsets.h
> diff --git a/arch/arm/vdso/.gitignore b/arch/arm/vdso/.gitignore
> index 6b47f6e0b032..dfa06f5365cf 100644
> --- a/arch/arm/vdso/.gitignore
> +++ b/arch/arm/vdso/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
>  vdso.so.raw
>  vdsomunge
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index 8dab0bb6ae66..9a7a9009d43a 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  Image
>  Image.gz
> diff --git a/arch/arm64/crypto/.gitignore b/arch/arm64/crypto/.gitignore
> index 879df8781ed5..a11a86217ffb 100644
> --- a/arch/arm64/crypto/.gitignore
> +++ b/arch/arm64/crypto/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  sha256-core.S
>  sha512-core.S
> diff --git a/arch/arm64/kernel/.gitignore b/arch/arm64/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/arm64/kernel/.gitignore
> +++ b/arch/arm64/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/arm64/kernel/vdso/.gitignore b/arch/arm64/kernel/vdso/.gitignore
> index f8b69d84238e..652e31d82582 100644
> --- a/arch/arm64/kernel/vdso/.gitignore
> +++ b/arch/arm64/kernel/vdso/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
> diff --git a/arch/arm64/kernel/vdso32/.gitignore b/arch/arm64/kernel/vdso32/.gitignore
> index 4fea950fa5ed..3542fa24e26b 100644
> --- a/arch/arm64/kernel/vdso32/.gitignore
> +++ b/arch/arm64/kernel/vdso32/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
>  vdso.so.raw
> diff --git a/arch/ia64/kernel/.gitignore b/arch/ia64/kernel/.gitignore
> index 21cb0da5ded8..0374827206e7 100644
> --- a/arch/ia64/kernel/.gitignore
> +++ b/arch/ia64/kernel/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gate.lds
>  vmlinux.lds
> diff --git a/arch/m68k/kernel/.gitignore b/arch/m68k/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/m68k/kernel/.gitignore
> +++ b/arch/m68k/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/microblaze/boot/.gitignore b/arch/microblaze/boot/.gitignore
> index 679502d64a97..11a9e229f3c0 100644
> --- a/arch/microblaze/boot/.gitignore
> +++ b/arch/microblaze/boot/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  linux.bin*
>  simpleImage.*
> diff --git a/arch/microblaze/kernel/.gitignore b/arch/microblaze/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/microblaze/kernel/.gitignore
> +++ b/arch/microblaze/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
> index a73d6e2c4f64..2adc8581a175 100644
> --- a/arch/mips/boot/.gitignore
> +++ b/arch/mips/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mkboot
>  elf2ecoff
>  vmlinux.*
> diff --git a/arch/mips/boot/compressed/.gitignore b/arch/mips/boot/compressed/.gitignore
> index ebae133f1d00..d358395614c9 100644
> --- a/arch/mips/boot/compressed/.gitignore
> +++ b/arch/mips/boot/compressed/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ashldi3.c
>  bswapsi.c
> diff --git a/arch/mips/boot/tools/.gitignore b/arch/mips/boot/tools/.gitignore
> index be0ed065249b..d36dc7cf9115 100644
> --- a/arch/mips/boot/tools/.gitignore
> +++ b/arch/mips/boot/tools/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  relocs
> diff --git a/arch/mips/kernel/.gitignore b/arch/mips/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/mips/kernel/.gitignore
> +++ b/arch/mips/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/mips/tools/.gitignore b/arch/mips/tools/.gitignore
> index b0209450d9ff..794817dfb389 100644
> --- a/arch/mips/tools/.gitignore
> +++ b/arch/mips/tools/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  elf-entry
>  loongson3-llsc-check
> diff --git a/arch/mips/vdso/.gitignore b/arch/mips/vdso/.gitignore
> index 5286a7d73d79..1f43f6dd8142 100644
> --- a/arch/mips/vdso/.gitignore
> +++ b/arch/mips/vdso/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.so*
>  vdso-*image.c
>  genvdso
> diff --git a/arch/nds32/kernel/.gitignore b/arch/nds32/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/nds32/kernel/.gitignore
> +++ b/arch/nds32/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/nds32/kernel/vdso/.gitignore b/arch/nds32/kernel/vdso/.gitignore
> index f8b69d84238e..652e31d82582 100644
> --- a/arch/nds32/kernel/vdso/.gitignore
> +++ b/arch/nds32/kernel/vdso/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
> diff --git a/arch/nios2/boot/.gitignore b/arch/nios2/boot/.gitignore
> index 64386a8dedd8..ef37cac5bcc0 100644
> --- a/arch/nios2/boot/.gitignore
> +++ b/arch/nios2/boot/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmImage
> diff --git a/arch/nios2/kernel/.gitignore b/arch/nios2/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/nios2/kernel/.gitignore
> +++ b/arch/nios2/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/openrisc/kernel/.gitignore b/arch/openrisc/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/openrisc/kernel/.gitignore
> +++ b/arch/openrisc/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/parisc/boot/.gitignore b/arch/parisc/boot/.gitignore
> index 017d5912ad2d..adf2ae0e7eda 100644
> --- a/arch/parisc/boot/.gitignore
> +++ b/arch/parisc/boot/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  image
>  bzImage
> diff --git a/arch/parisc/boot/compressed/.gitignore b/arch/parisc/boot/compressed/.gitignore
> index 926cd41c1069..b9853a356ab2 100644
> --- a/arch/parisc/boot/compressed/.gitignore
> +++ b/arch/parisc/boot/compressed/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  firmware.c
>  real2.S
>  sizes.h
> diff --git a/arch/parisc/kernel/.gitignore b/arch/parisc/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/parisc/kernel/.gitignore
> +++ b/arch/parisc/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 6610665fcf5e..1eee61b82341 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  addnote
>  decompress_inflate.c
>  empty.c
> diff --git a/arch/powerpc/kernel/.gitignore b/arch/powerpc/kernel/.gitignore
> index 67ebd3003c05..d71179d3ffe9 100644
> --- a/arch/powerpc/kernel/.gitignore
> +++ b/arch/powerpc/kernel/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  prom_init_check
>  vmlinux.lds
> diff --git a/arch/powerpc/kernel/vdso32/.gitignore b/arch/powerpc/kernel/vdso32/.gitignore
> index fea5809857a5..824b863ec6bd 100644
> --- a/arch/powerpc/kernel/vdso32/.gitignore
> +++ b/arch/powerpc/kernel/vdso32/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso32.lds
>  vdso32.so.dbg
> diff --git a/arch/powerpc/kernel/vdso64/.gitignore b/arch/powerpc/kernel/vdso64/.gitignore
> index 77a0b423642c..84151a7ba31d 100644
> --- a/arch/powerpc/kernel/vdso64/.gitignore
> +++ b/arch/powerpc/kernel/vdso64/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso64.lds
>  vdso64.so.dbg
> diff --git a/arch/powerpc/platforms/cell/spufs/.gitignore b/arch/powerpc/platforms/cell/spufs/.gitignore
> index a09ee8d84d6c..5f3eb224f653 100644
> --- a/arch/powerpc/platforms/cell/spufs/.gitignore
> +++ b/arch/powerpc/platforms/cell/spufs/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  spu_save_dump.h
>  spu_restore_dump.h
> diff --git a/arch/powerpc/purgatory/.gitignore b/arch/powerpc/purgatory/.gitignore
> index e9e66f178a6d..b8dc6ff34254 100644
> --- a/arch/powerpc/purgatory/.gitignore
> +++ b/arch/powerpc/purgatory/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  kexec-purgatory.c
>  purgatory.ro
> diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
> index 8a45a37d2af4..574c10f8ff68 100644
> --- a/arch/riscv/boot/.gitignore
> +++ b/arch/riscv/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  Image
>  Image.gz
>  loader
> diff --git a/arch/riscv/kernel/.gitignore b/arch/riscv/kernel/.gitignore
> index b51634f6a7cd..e052ed331cc1 100644
> --- a/arch/riscv/kernel/.gitignore
> +++ b/arch/riscv/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /vmlinux.lds
> diff --git a/arch/riscv/kernel/vdso/.gitignore b/arch/riscv/kernel/vdso/.gitignore
> index 97c2d69d0289..11ebee9e4c1d 100644
> --- a/arch/riscv/kernel/vdso/.gitignore
> +++ b/arch/riscv/kernel/vdso/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
>  *.tmp
> diff --git a/arch/s390/boot/.gitignore b/arch/s390/boot/.gitignore
> index 16ff906e4610..b265bfede188 100644
> --- a/arch/s390/boot/.gitignore
> +++ b/arch/s390/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  image
>  bzImage
>  section_cmp.*
> diff --git a/arch/s390/boot/compressed/.gitignore b/arch/s390/boot/compressed/.gitignore
> index e72fcd7ecebb..765a08f1bd77 100644
> --- a/arch/s390/boot/compressed/.gitignore
> +++ b/arch/s390/boot/compressed/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux
>  vmlinux.lds
> diff --git a/arch/s390/kernel/.gitignore b/arch/s390/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/s390/kernel/.gitignore
> +++ b/arch/s390/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/s390/kernel/vdso64/.gitignore b/arch/s390/kernel/vdso64/.gitignore
> index 3fd18cf9fec2..4ec80685fecc 100644
> --- a/arch/s390/kernel/vdso64/.gitignore
> +++ b/arch/s390/kernel/vdso64/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso64.lds
> diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
> index c82157f46b18..97ca52779457 100644
> --- a/arch/s390/purgatory/.gitignore
> +++ b/arch/s390/purgatory/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  purgatory
>  purgatory.chk
>  purgatory.lds
> diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
> index 71bd6f8eebaf..ea62f37b79ef 100644
> --- a/arch/s390/tools/.gitignore
> +++ b/arch/s390/tools/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gen_facilities
>  gen_opcode_table
> diff --git a/arch/sh/boot/.gitignore b/arch/sh/boot/.gitignore
> index f50fdd9975c5..6603bbbc917d 100644
> --- a/arch/sh/boot/.gitignore
> +++ b/arch/sh/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  zImage
>  vmlinux*
>  uImage*
> diff --git a/arch/sh/boot/compressed/.gitignore b/arch/sh/boot/compressed/.gitignore
> index edff113f1b85..37aa53057369 100644
> --- a/arch/sh/boot/compressed/.gitignore
> +++ b/arch/sh/boot/compressed/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ashiftrt.S
>  ashldi3.c
>  ashlsi3.S
> diff --git a/arch/sh/kernel/.gitignore b/arch/sh/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/sh/kernel/.gitignore
> +++ b/arch/sh/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/sh/kernel/vsyscall/.gitignore b/arch/sh/kernel/vsyscall/.gitignore
> index 40836ad9079c..530a3031a88d 100644
> --- a/arch/sh/kernel/vsyscall/.gitignore
> +++ b/arch/sh/kernel/vsyscall/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vsyscall.lds
> diff --git a/arch/sparc/boot/.gitignore b/arch/sparc/boot/.gitignore
> index fc6f3986c76c..f3d8569a21d1 100644
> --- a/arch/sparc/boot/.gitignore
> +++ b/arch/sparc/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  btfix.S
>  btfixupprep
>  image
> diff --git a/arch/sparc/kernel/.gitignore b/arch/sparc/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/sparc/kernel/.gitignore
> +++ b/arch/sparc/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/arch/sparc/vdso/.gitignore b/arch/sparc/vdso/.gitignore
> index ef925b998222..8d4ebc990bf3 100644
> --- a/arch/sparc/vdso/.gitignore
> +++ b/arch/sparc/vdso/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
>  vdso-image-*.c
>  vdso2c
> diff --git a/arch/sparc/vdso/vdso32/.gitignore b/arch/sparc/vdso/vdso32/.gitignore
> index e45fba9d0ced..5167384843b9 100644
> --- a/arch/sparc/vdso/vdso32/.gitignore
> +++ b/arch/sparc/vdso/vdso32/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso32.lds
> diff --git a/arch/um/.gitignore b/arch/um/.gitignore
> index a73d3a1cc746..6323e5571887 100644
> --- a/arch/um/.gitignore
> +++ b/arch/um/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  kernel/config.c
>  kernel/config.tmp
>  kernel/vmlinux.lds
> diff --git a/arch/unicore32/.gitignore b/arch/unicore32/.gitignore
> index 947e99c2a957..e82f3fb57ba0 100644
> --- a/arch/unicore32/.gitignore
> +++ b/arch/unicore32/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  #
>  # Generated include files
>  #
> diff --git a/arch/x86/.gitignore b/arch/x86/.gitignore
> index 5a82bac5e0bc..677111acbaa3 100644
> --- a/arch/x86/.gitignore
> +++ b/arch/x86/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  boot/compressed/vmlinux
>  tools/test_get_len
>  tools/insn_sanity
> diff --git a/arch/x86/boot/.gitignore b/arch/x86/boot/.gitignore
> index 09d25dd09307..9cc7f1357b9b 100644
> --- a/arch/x86/boot/.gitignore
> +++ b/arch/x86/boot/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  bootsect
>  bzImage
>  cpustr.h
> diff --git a/arch/x86/boot/compressed/.gitignore b/arch/x86/boot/compressed/.gitignore
> index 4a46fab7162e..25805199a506 100644
> --- a/arch/x86/boot/compressed/.gitignore
> +++ b/arch/x86/boot/compressed/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  relocs
>  vmlinux.bin.all
>  vmlinux.relocs
> diff --git a/arch/x86/boot/tools/.gitignore b/arch/x86/boot/tools/.gitignore
> index 378eac25d311..ae91f4d0d78b 100644
> --- a/arch/x86/boot/tools/.gitignore
> +++ b/arch/x86/boot/tools/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  build
> diff --git a/arch/x86/crypto/.gitignore b/arch/x86/crypto/.gitignore
> index 30be0400a439..580c839bb177 100644
> --- a/arch/x86/crypto/.gitignore
> +++ b/arch/x86/crypto/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  poly1305-x86_64-cryptogams.S
> diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
> index aae8ffdd5880..37a6129d597b 100644
> --- a/arch/x86/entry/vdso/.gitignore
> +++ b/arch/x86/entry/vdso/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
>  vdsox32.lds
>  vdso32-syscall-syms.lds
> diff --git a/arch/x86/entry/vdso/vdso32/.gitignore b/arch/x86/entry/vdso/vdso32/.gitignore
> index e45fba9d0ced..5167384843b9 100644
> --- a/arch/x86/entry/vdso/vdso32/.gitignore
> +++ b/arch/x86/entry/vdso/vdso32/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso32.lds
> diff --git a/arch/x86/kernel/.gitignore b/arch/x86/kernel/.gitignore
> index 08f4fd731469..ef66569e7e22 100644
> --- a/arch/x86/kernel/.gitignore
> +++ b/arch/x86/kernel/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vsyscall.lds
>  vsyscall_32.lds
>  vmlinux.lds
> diff --git a/arch/x86/kernel/cpu/.gitignore b/arch/x86/kernel/cpu/.gitignore
> index 667df55a4399..0bca7ef7426a 100644
> --- a/arch/x86/kernel/cpu/.gitignore
> +++ b/arch/x86/kernel/cpu/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  capflags.c
> diff --git a/arch/x86/lib/.gitignore b/arch/x86/lib/.gitignore
> index 8df89f0a3fe6..8ae0f93ecbfd 100644
> --- a/arch/x86/lib/.gitignore
> +++ b/arch/x86/lib/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  inat-tables.c
> diff --git a/arch/x86/realmode/rm/.gitignore b/arch/x86/realmode/rm/.gitignore
> index b6ed3a2555cb..6c3464f46166 100644
> --- a/arch/x86/realmode/rm/.gitignore
> +++ b/arch/x86/realmode/rm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pasyms.h
>  realmode.lds
>  realmode.relocs
> diff --git a/arch/x86/tools/.gitignore b/arch/x86/tools/.gitignore
> index be0ed065249b..d36dc7cf9115 100644
> --- a/arch/x86/tools/.gitignore
> +++ b/arch/x86/tools/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  relocs
> diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
> index f8b69d84238e..652e31d82582 100644
> --- a/arch/x86/um/vdso/.gitignore
> +++ b/arch/x86/um/vdso/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso.lds
> diff --git a/arch/xtensa/boot/.gitignore b/arch/xtensa/boot/.gitignore
> index 38177c7ebcab..615f1f741a03 100644
> --- a/arch/xtensa/boot/.gitignore
> +++ b/arch/xtensa/boot/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  uImage
>  zImage.redboot
> diff --git a/arch/xtensa/boot/boot-elf/.gitignore b/arch/xtensa/boot/boot-elf/.gitignore
> index 5ff8fbb8561b..7473404500cc 100644
> --- a/arch/xtensa/boot/boot-elf/.gitignore
> +++ b/arch/xtensa/boot/boot-elf/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  boot.lds
> diff --git a/arch/xtensa/boot/lib/.gitignore b/arch/xtensa/boot/lib/.gitignore
> index 1629a6167755..805a8249252a 100644
> --- a/arch/xtensa/boot/lib/.gitignore
> +++ b/arch/xtensa/boot/lib/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  inffast.c
>  inflate.c
>  inftrees.c
> diff --git a/arch/xtensa/kernel/.gitignore b/arch/xtensa/kernel/.gitignore
> index c5f676c3c224..bbb90f92d051 100644
> --- a/arch/xtensa/kernel/.gitignore
> +++ b/arch/xtensa/kernel/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vmlinux.lds
> diff --git a/certs/.gitignore b/certs/.gitignore
> index 4d58ba042b37..2a2483990686 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  x509_certificate_list
> diff --git a/drivers/atm/.gitignore b/drivers/atm/.gitignore
> index 19f3ffbd1d65..ddd374e91965 100644
> --- a/drivers/atm/.gitignore
> +++ b/drivers/atm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  fore200e_mkfirm
>  fore200e_pca_fw.c
>  pca200e.bin
> diff --git a/drivers/crypto/vmx/.gitignore b/drivers/crypto/vmx/.gitignore
> index af4a7ce4738d..7aa71d83f739 100644
> --- a/drivers/crypto/vmx/.gitignore
> +++ b/drivers/crypto/vmx/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  aesp8-ppc.S
>  ghashp8-ppc.S
> diff --git a/drivers/eisa/.gitignore b/drivers/eisa/.gitignore
> index 4b335c0aedb0..7d0a2ad5abe2 100644
> --- a/drivers/eisa/.gitignore
> +++ b/drivers/eisa/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  devlist.h
> diff --git a/drivers/gpu/drm/i915/.gitignore b/drivers/gpu/drm/i915/.gitignore
> index d9a77f3b59b2..81972dce1aff 100644
> --- a/drivers/gpu/drm/i915/.gitignore
> +++ b/drivers/gpu/drm/i915/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.hdrtest
> diff --git a/drivers/gpu/drm/radeon/.gitignore b/drivers/gpu/drm/radeon/.gitignore
> index 403eb3a5891f..9c1a94153983 100644
> --- a/drivers/gpu/drm/radeon/.gitignore
> +++ b/drivers/gpu/drm/radeon/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mkregtable
>  *_reg_safe.h
>
> diff --git a/drivers/memory/.gitignore b/drivers/memory/.gitignore
> index cbca8b028437..caedc4c7d2db 100644
> --- a/drivers/memory/.gitignore
> +++ b/drivers/memory/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ti-emif-asm-offsets.h
> diff --git a/drivers/net/wan/.gitignore b/drivers/net/wan/.gitignore
> index dae3ea6bb18c..247bfbf10912 100644
> --- a/drivers/net/wan/.gitignore
> +++ b/drivers/net/wan/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  wanxlfw.inc
> diff --git a/drivers/scsi/.gitignore b/drivers/scsi/.gitignore
> index e2956741fbd1..5f65cb75f534 100644
> --- a/drivers/scsi/.gitignore
> +++ b/drivers/scsi/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  53c700_d.h
>  scsi_devinfo_tbl.c
> diff --git a/drivers/scsi/aic7xxx/.gitignore b/drivers/scsi/aic7xxx/.gitignore
> index b8ee24d5748a..9aa780221718 100644
> --- a/drivers/scsi/aic7xxx/.gitignore
> +++ b/drivers/scsi/aic7xxx/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  aic79xx_reg.h
>  aic79xx_reg_print.c
>  aic79xx_seq.h
> diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/.gitignore b/drivers/staging/comedi/drivers/ni_routing/tools/.gitignore
> index ef38008280a9..e3ebffcd900e 100644
> --- a/drivers/staging/comedi/drivers/ni_routing/tools/.gitignore
> +++ b/drivers/staging/comedi/drivers/ni_routing/tools/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  comedi_h.py
>  *.pyc
>  ni_values.py
> diff --git a/drivers/staging/greybus/tools/.gitignore b/drivers/staging/greybus/tools/.gitignore
> index 023654c83068..1fd364aba774 100644
> --- a/drivers/staging/greybus/tools/.gitignore
> +++ b/drivers/staging/greybus/tools/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  loopback_test
> diff --git a/drivers/video/logo/.gitignore b/drivers/video/logo/.gitignore
> index 1551a75afdbd..5311d207c0b9 100644
> --- a/drivers/video/logo/.gitignore
> +++ b/drivers/video/logo/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *_mono.c
>  *_vga16.c
>  *_clut224.c
> diff --git a/drivers/zorro/.gitignore b/drivers/zorro/.gitignore
> index 34f980bd8ff6..acd6ffb8d77d 100644
> --- a/drivers/zorro/.gitignore
> +++ b/drivers/zorro/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  devlist.h
>  gen-devlist
> diff --git a/fs/unicode/.gitignore b/fs/unicode/.gitignore
> index 0381e2221480..9b2467e77b2d 100644
> --- a/fs/unicode/.gitignore
> +++ b/fs/unicode/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mkutf8data
>  utf8data.h
> diff --git a/kernel/.gitignore b/kernel/.gitignore
> index 0a423a3ca2e1..78701ea37c97 100644
> --- a/kernel/.gitignore
> +++ b/kernel/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  kheaders.md5
>  timeconst.h
>  hz.bc
> diff --git a/kernel/debug/kdb/.gitignore b/kernel/debug/kdb/.gitignore
> index 396d12eda9e8..df259542a236 100644
> --- a/kernel/debug/kdb/.gitignore
> +++ b/kernel/debug/kdb/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gen-kdb_cmds.c
> diff --git a/lib/.gitignore b/lib/.gitignore
> index 9af73655a239..327cb2c7f2c9 100644
> --- a/lib/.gitignore
> +++ b/lib/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gen_crc32table
>  gen_crc64table
>  crc32table.h
> diff --git a/lib/raid6/.gitignore b/lib/raid6/.gitignore
> index 3de0d8921286..6be57745afd1 100644
> --- a/lib/raid6/.gitignore
> +++ b/lib/raid6/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mktables
>  altivec*.c
>  int*.c
> diff --git a/net/bpfilter/.gitignore b/net/bpfilter/.gitignore
> index e97084e3eea2..f34e85ee8204 100644
> --- a/net/bpfilter/.gitignore
> +++ b/net/bpfilter/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  bpfilter_umh
> diff --git a/net/wireless/.gitignore b/net/wireless/.gitignore
> index 61cbc304a3d3..1a29cd69d6cf 100644
> --- a/net/wireless/.gitignore
> +++ b/net/wireless/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  shipped-certs.c
>  extra-certs.c
> diff --git a/samples/auxdisplay/.gitignore b/samples/auxdisplay/.gitignore
> index 7af222860a96..2ed744c0e741 100644
> --- a/samples/auxdisplay/.gitignore
> +++ b/samples/auxdisplay/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  cfag12864b-example
> diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
> index 74d31fd3c99c..23837f2ed458 100644
> --- a/samples/bpf/.gitignore
> +++ b/samples/bpf/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  cpustat
>  fds_example
>  hbm
> diff --git a/samples/connector/.gitignore b/samples/connector/.gitignore
> index d2b9c32accd4..d86f2ff9c947 100644
> --- a/samples/connector/.gitignore
> +++ b/samples/connector/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ucon
> diff --git a/samples/hidraw/.gitignore b/samples/hidraw/.gitignore
> index 05e51a685242..d7a6074ebcf9 100644
> --- a/samples/hidraw/.gitignore
> +++ b/samples/hidraw/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  hid-example
> diff --git a/samples/mei/.gitignore b/samples/mei/.gitignore
> index f356b81ca1ec..db5e802f041e 100644
> --- a/samples/mei/.gitignore
> +++ b/samples/mei/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mei-amt-version
> diff --git a/samples/mic/mpssd/.gitignore b/samples/mic/mpssd/.gitignore
> index 8b7c72f07c92..aa03f1eb37a0 100644
> --- a/samples/mic/mpssd/.gitignore
> +++ b/samples/mic/mpssd/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mpssd
> diff --git a/samples/pidfd/.gitignore b/samples/pidfd/.gitignore
> index be52b3ba6e4b..eea857fca736 100644
> --- a/samples/pidfd/.gitignore
> +++ b/samples/pidfd/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pidfd-metadata
> diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
> index d1e2e817d556..4a5a5b7db30b 100644
> --- a/samples/seccomp/.gitignore
> +++ b/samples/seccomp/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  bpf-direct
>  bpf-fancy
>  dropper
> diff --git a/samples/timers/.gitignore b/samples/timers/.gitignore
> index c5c45d7ec0df..40510c33cf08 100644
> --- a/samples/timers/.gitignore
> +++ b/samples/timers/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  hpet_example
> diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
> index 0806eb0be62d..8fdabf7e5373 100644
> --- a/samples/vfs/.gitignore
> +++ b/samples/vfs/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  test-fsmount
>  test-statx
> diff --git a/samples/watchdog/.gitignore b/samples/watchdog/.gitignore
> index ff0ebb540333..74153b831244 100644
> --- a/samples/watchdog/.gitignore
> +++ b/samples/watchdog/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  watchdog-simple
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 9fe29efbcb95..0d1c8e217cd7 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  bin2c
>  kallsyms
>  unifdef
> diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
> index a776371a3502..98ae1f509592 100644
> --- a/scripts/basic/.gitignore
> +++ b/scripts/basic/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  fixdep
> diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
> index 2e6e60d64ede..b814e6076bdb 100644
> --- a/scripts/dtc/.gitignore
> +++ b/scripts/dtc/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  dtc
> diff --git a/scripts/gcc-plugins/.gitignore b/scripts/gcc-plugins/.gitignore
> index de92ed9e3d83..b04e0f0f033e 100644
> --- a/scripts/gcc-plugins/.gitignore
> +++ b/scripts/gcc-plugins/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  randomize_layout_seed.h
> diff --git a/scripts/gdb/linux/.gitignore b/scripts/gdb/linux/.gitignore
> index 2573543842d0..43234cbcb529 100644
> --- a/scripts/gdb/linux/.gitignore
> +++ b/scripts/gdb/linux/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.pyc
>  *.pyo
>  constants.py
> diff --git a/scripts/genksyms/.gitignore b/scripts/genksyms/.gitignore
> index b119c7da2863..999af710f83d 100644
> --- a/scripts/genksyms/.gitignore
> +++ b/scripts/genksyms/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  genksyms
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index 588988711e07..12a67fdab541 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.moc
>  *conf-cfg
>
> diff --git a/scripts/mod/.gitignore b/scripts/mod/.gitignore
> index 3bd11b603173..07e4a39f90a6 100644
> --- a/scripts/mod/.gitignore
> +++ b/scripts/mod/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  elfconfig.h
>  mk_elfconfig
>  modpost
> diff --git a/scripts/selinux/genheaders/.gitignore b/scripts/selinux/genheaders/.gitignore
> index 4c0b646ff8d5..5fcadd307908 100644
> --- a/scripts/selinux/genheaders/.gitignore
> +++ b/scripts/selinux/genheaders/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  genheaders
> diff --git a/scripts/selinux/mdp/.gitignore b/scripts/selinux/mdp/.gitignore
> index 0d9f827dc14b..a7482287e77f 100644
> --- a/scripts/selinux/mdp/.gitignore
> +++ b/scripts/selinux/mdp/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mdp
> diff --git a/security/apparmor/.gitignore b/security/apparmor/.gitignore
> index 0ace1d1dec44..6d1eb1c15c18 100644
> --- a/security/apparmor/.gitignore
> +++ b/security/apparmor/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  net_names.h
>  capability_names.h
>  rlim_names.h
> diff --git a/security/selinux/.gitignore b/security/selinux/.gitignore
> index 2e5040a3d48b..168fae13ca5a 100644
> --- a/security/selinux/.gitignore
> +++ b/security/selinux/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  av_permissions.h
>  flask.h
> diff --git a/security/tomoyo/.gitignore b/security/tomoyo/.gitignore
> index dc0f220a210b..9f300cdce362 100644
> --- a/security/tomoyo/.gitignore
> +++ b/security/tomoyo/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  builtin-policy.h
>  policy/*.conf
> diff --git a/sound/oss/.gitignore b/sound/oss/.gitignore
> index 8fd8fd3eff62..ac678430408b 100644
> --- a/sound/oss/.gitignore
> +++ b/sound/oss/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pss_boot.h
>  trix_boot.h
> diff --git a/tools/accounting/.gitignore b/tools/accounting/.gitignore
> index 86485203c4ae..c45fb4ed4309 100644
> --- a/tools/accounting/.gitignore
> +++ b/tools/accounting/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  getdelays
> diff --git a/tools/bootconfig/.gitignore b/tools/bootconfig/.gitignore
> index e7644dfaa4a7..b77513cae685 100644
> --- a/tools/bootconfig/.gitignore
> +++ b/tools/bootconfig/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  bootconfig
> diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
> index 59024197e71d..cf53342175e7 100644
> --- a/tools/bpf/.gitignore
> +++ b/tools/bpf/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  FEATURE-DUMP.bpf
>  feature
>  bpf_asm
> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
> index b13926432b84..5c232659a98b 100644
> --- a/tools/bpf/bpftool/.gitignore
> +++ b/tools/bpf/bpftool/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  /bpftool
>  bpftool*.8
> diff --git a/tools/bpf/runqslower/.gitignore b/tools/bpf/runqslower/.gitignore
> index 90a456a2a72f..ffdb70230c8b 100644
> --- a/tools/bpf/runqslower/.gitignore
> +++ b/tools/bpf/runqslower/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /.output
> diff --git a/tools/build/.gitignore b/tools/build/.gitignore
> index a776371a3502..98ae1f509592 100644
> --- a/tools/build/.gitignore
> +++ b/tools/build/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  fixdep
> diff --git a/tools/build/feature/.gitignore b/tools/build/feature/.gitignore
> index 09b335b98842..15fcd34acdb9 100644
> --- a/tools/build/feature/.gitignore
> +++ b/tools/build/feature/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  *.bin
>  *.output
> diff --git a/tools/cgroup/.gitignore b/tools/cgroup/.gitignore
> index 633cd9b874f9..46a82775f2ca 100644
> --- a/tools/cgroup/.gitignore
> +++ b/tools/cgroup/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  cgroup_event_listener
> diff --git a/tools/gpio/.gitignore b/tools/gpio/.gitignore
> index a94c0e83b209..d0a66c48865c 100644
> --- a/tools/gpio/.gitignore
> +++ b/tools/gpio/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gpio-event-mon
>  gpio-hammer
>  lsgpio
> diff --git a/tools/iio/.gitignore b/tools/iio/.gitignore
> index 3758202618bd..5bd6f4df98b7 100644
> --- a/tools/iio/.gitignore
> +++ b/tools/iio/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  iio_event_monitor
>  iio_generic_buffer
>  lsiio
> diff --git a/tools/laptop/dslm/.gitignore b/tools/laptop/dslm/.gitignore
> index 9fc984e64386..f7f1296b96ae 100644
> --- a/tools/laptop/dslm/.gitignore
> +++ b/tools/laptop/dslm/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  dslm
> diff --git a/tools/leds/.gitignore b/tools/leds/.gitignore
> index ac96d9f53dfc..06bd3ee1b7c9 100644
> --- a/tools/leds/.gitignore
> +++ b/tools/leds/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  uledmon
> diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
> index e97c2ebcf447..8a81b3679d2b 100644
> --- a/tools/lib/bpf/.gitignore
> +++ b/tools/lib/bpf/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  libbpf_version.h
>  libbpf.pc
>  FEATURE-DUMP.libbpf
> diff --git a/tools/lib/lockdep/.gitignore b/tools/lib/lockdep/.gitignore
> index cc0e7a9f99e3..6c308ac4388c 100644
> --- a/tools/lib/lockdep/.gitignore
> +++ b/tools/lib/lockdep/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  liblockdep.so.*
> diff --git a/tools/lib/traceevent/.gitignore b/tools/lib/traceevent/.gitignore
> index 9e9f25fb1922..7123c70b9ebc 100644
> --- a/tools/lib/traceevent/.gitignore
> +++ b/tools/lib/traceevent/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  TRACEEVENT-CFLAGS
>  libtraceevent-dynamic-list
>  libtraceevent.so.*
> diff --git a/tools/memory-model/.gitignore b/tools/memory-model/.gitignore
> index b1d34c52f3c3..cf4cd66d8fbf 100644
> --- a/tools/memory-model/.gitignore
> +++ b/tools/memory-model/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  litmus
> diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
> index 6e2ddc54152f..c492a1ddad91 100644
> --- a/tools/memory-model/litmus-tests/.gitignore
> +++ b/tools/memory-model/litmus-tests/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.litmus.out
> diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
> index 914cff12899b..45cefda24c7b 100644
> --- a/tools/objtool/.gitignore
> +++ b/tools/objtool/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  arch/x86/lib/inat-tables.c
>  objtool
>  fixdep
> diff --git a/tools/pcmcia/.gitignore b/tools/pcmcia/.gitignore
> index 53d081336757..94cb97b77f06 100644
> --- a/tools/pcmcia/.gitignore
> +++ b/tools/pcmcia/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  crc32hash
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index bf1252dc2cb0..f3f84781fd74 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  PERF-CFLAGS
>  PERF-GUI-VARS
>  PERF-VERSION-FILE
> diff --git a/tools/perf/tests/.gitignore b/tools/perf/tests/.gitignore
> index 8cc30e731c73..d053b325f728 100644
> --- a/tools/perf/tests/.gitignore
> +++ b/tools/perf/tests/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  llvm-src-base.c
>  llvm-src-kbuild.c
>  llvm-src-prologue.c
> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> index f698a0e5bfa6..0b319fc8bb17 100644
> --- a/tools/power/acpi/.gitignore
> +++ b/tools/power/acpi/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /acpidbg
>  /acpidump
>  /ec
> diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
> index 1f9977cc609c..7677329c42a6 100644
> --- a/tools/power/cpupower/.gitignore
> +++ b/tools/power/cpupower/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  .libs
>  libcpupower.so
>  libcpupower.so.*
> diff --git a/tools/power/x86/intel-speed-select/.gitignore b/tools/power/x86/intel-speed-select/.gitignore
> index f61145925ce9..a814f89fe75f 100644
> --- a/tools/power/x86/intel-speed-select/.gitignore
> +++ b/tools/power/x86/intel-speed-select/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  include/
>  intel-speed-select
> diff --git a/tools/power/x86/turbostat/.gitignore b/tools/power/x86/turbostat/.gitignore
> index 7521370d3568..e13109b43cd1 100644
> --- a/tools/power/x86/turbostat/.gitignore
> +++ b/tools/power/x86/turbostat/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  turbostat
> diff --git a/tools/spi/.gitignore b/tools/spi/.gitignore
> index 4280576397e8..14ddba3d2195 100644
> --- a/tools/spi/.gitignore
> +++ b/tools/spi/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  spidev_fdx
>  spidev_test
> diff --git a/tools/testing/kunit/.gitignore b/tools/testing/kunit/.gitignore
> index c791ff59a37a..1c63e31f7edf 100644
> --- a/tools/testing/kunit/.gitignore
> +++ b/tools/testing/kunit/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  # Byte-compiled / optimized / DLL files
>  __pycache__/
>  *.py[cod]
> \ No newline at end of file
> diff --git a/tools/testing/radix-tree/.gitignore b/tools/testing/radix-tree/.gitignore
> index 3834899b6693..d971516401e6 100644
> --- a/tools/testing/radix-tree/.gitignore
> +++ b/tools/testing/radix-tree/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  generated/map-shift.h
>  idr.c
>  idr-test
> diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
> index 61df01cdf0b2..ac0505cef4ae 100644
> --- a/tools/testing/selftests/.gitignore
> +++ b/tools/testing/selftests/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gpiogpio-event-mon
>  gpiogpio-hammer
>  gpioinclude/
> diff --git a/tools/testing/selftests/android/ion/.gitignore b/tools/testing/selftests/android/ion/.gitignore
> index 95e8f4561474..78eae9972bb1 100644
> --- a/tools/testing/selftests/android/ion/.gitignore
> +++ b/tools/testing/selftests/android/ion/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ionapp_export
>  ionapp_import
>  ionmap_test
> diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
> index 3c5b4e8ff894..78c902045ca7 100644
> --- a/tools/testing/selftests/arm64/signal/.gitignore
> +++ b/tools/testing/selftests/arm64/signal/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mangle_*
>  fake_sigreturn_*
>  !*.[ch]
> diff --git a/tools/testing/selftests/arm64/tags/.gitignore b/tools/testing/selftests/arm64/tags/.gitignore
> index e8fae8d61ed6..f4f6c5112463 100644
> --- a/tools/testing/selftests/arm64/tags/.gitignore
> +++ b/tools/testing/selftests/arm64/tags/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  tags_test
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index ec464859c6b6..e759d7eb1297 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  test_verifier
>  test_maps
>  test_lru_map
> diff --git a/tools/testing/selftests/bpf/map_tests/.gitignore b/tools/testing/selftests/bpf/map_tests/.gitignore
> index 45984a364647..89c4a3d37544 100644
> --- a/tools/testing/selftests/bpf/map_tests/.gitignore
> +++ b/tools/testing/selftests/bpf/map_tests/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  tests.h
> diff --git a/tools/testing/selftests/bpf/prog_tests/.gitignore b/tools/testing/selftests/bpf/prog_tests/.gitignore
> index 45984a364647..89c4a3d37544 100644
> --- a/tools/testing/selftests/bpf/prog_tests/.gitignore
> +++ b/tools/testing/selftests/bpf/prog_tests/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  tests.h
> diff --git a/tools/testing/selftests/bpf/verifier/.gitignore b/tools/testing/selftests/bpf/verifier/.gitignore
> index 45984a364647..89c4a3d37544 100644
> --- a/tools/testing/selftests/bpf/verifier/.gitignore
> +++ b/tools/testing/selftests/bpf/verifier/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  tests.h
> diff --git a/tools/testing/selftests/breakpoints/.gitignore b/tools/testing/selftests/breakpoints/.gitignore
> index a23bb4a6f06c..def2e97dab9a 100644
> --- a/tools/testing/selftests/breakpoints/.gitignore
> +++ b/tools/testing/selftests/breakpoints/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  breakpoint_test
>  step_after_suspend_test
> diff --git a/tools/testing/selftests/capabilities/.gitignore b/tools/testing/selftests/capabilities/.gitignore
> index b732dd0d4738..426d9adca67c 100644
> --- a/tools/testing/selftests/capabilities/.gitignore
> +++ b/tools/testing/selftests/capabilities/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  test_execve
>  validate_cap
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> index 7f9835624793..aa6de65b0838 100644
> --- a/tools/testing/selftests/cgroup/.gitignore
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  test_memcontrol
>  test_core
>  test_freezer
> diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
> index 0dc4f32c6cb8..a81085742d40 100644
> --- a/tools/testing/selftests/clone3/.gitignore
> +++ b/tools/testing/selftests/clone3/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  clone3
>  clone3_clear_sighand
>  clone3_set_tid
> diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> index f6aebcc27b76..ca74f2e1c719 100644
> --- a/tools/testing/selftests/drivers/.gitignore
> +++ b/tools/testing/selftests/drivers/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /dma-buf/udmabuf
> diff --git a/tools/testing/selftests/efivarfs/.gitignore b/tools/testing/selftests/efivarfs/.gitignore
> index 33618493562b..807407f7f58b 100644
> --- a/tools/testing/selftests/efivarfs/.gitignore
> +++ b/tools/testing/selftests/efivarfs/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  create-read
>  open-unlink
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index b02279da6fa1..c078ece12ff0 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  subdir*
>  script*
>  execveat
> diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
> index 8449cf6716ce..f0c0ff20d6cf 100644
> --- a/tools/testing/selftests/filesystems/.gitignore
> +++ b/tools/testing/selftests/filesystems/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  dnotify_test
>  devpts_pts
> diff --git a/tools/testing/selftests/filesystems/binderfs/.gitignore b/tools/testing/selftests/filesystems/binderfs/.gitignore
> index 8a5d9bf63dd4..8e5cf9084894 100644
> --- a/tools/testing/selftests/filesystems/binderfs/.gitignore
> +++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  binderfs_test
> diff --git a/tools/testing/selftests/filesystems/epoll/.gitignore b/tools/testing/selftests/filesystems/epoll/.gitignore
> index 9ae8db44ec14..9090157258b1 100644
> --- a/tools/testing/selftests/filesystems/epoll/.gitignore
> +++ b/tools/testing/selftests/filesystems/epoll/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  epoll_wakeup_test
> diff --git a/tools/testing/selftests/ftrace/.gitignore b/tools/testing/selftests/ftrace/.gitignore
> index 98d8a5a63049..2659417cb2c7 100644
> --- a/tools/testing/selftests/ftrace/.gitignore
> +++ b/tools/testing/selftests/ftrace/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  logs
> diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
> index a09f57061902..0efcd494daab 100644
> --- a/tools/testing/selftests/futex/functional/.gitignore
> +++ b/tools/testing/selftests/futex/functional/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  futex_requeue_pi
>  futex_requeue_pi_mismatched_ops
>  futex_requeue_pi_signal_restart
> diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
> index 7d14f743d1a4..4c69408f3e84 100644
> --- a/tools/testing/selftests/gpio/.gitignore
> +++ b/tools/testing/selftests/gpio/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gpio-mockup-chardev
> diff --git a/tools/testing/selftests/ia64/.gitignore b/tools/testing/selftests/ia64/.gitignore
> index ab806edc8732..e962fb2a08d5 100644
> --- a/tools/testing/selftests/ia64/.gitignore
> +++ b/tools/testing/selftests/ia64/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  aliasing-test
> diff --git a/tools/testing/selftests/intel_pstate/.gitignore b/tools/testing/selftests/intel_pstate/.gitignore
> index 3bfcbae5fa13..862de222a3f3 100644
> --- a/tools/testing/selftests/intel_pstate/.gitignore
> +++ b/tools/testing/selftests/intel_pstate/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  aperf
>  msr
> diff --git a/tools/testing/selftests/ipc/.gitignore b/tools/testing/selftests/ipc/.gitignore
> index 9af04c9353c0..9ed280e4c704 100644
> --- a/tools/testing/selftests/ipc/.gitignore
> +++ b/tools/testing/selftests/ipc/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  msgque_test
>  msgque
> diff --git a/tools/testing/selftests/ir/.gitignore b/tools/testing/selftests/ir/.gitignore
> index 070ea0c75fb8..0bbada8c1811 100644
> --- a/tools/testing/selftests/ir/.gitignore
> +++ b/tools/testing/selftests/ir/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ir_loopback
> diff --git a/tools/testing/selftests/kcmp/.gitignore b/tools/testing/selftests/kcmp/.gitignore
> index 5a9b3732b2de..38ccdfe80ef7 100644
> --- a/tools/testing/selftests/kcmp/.gitignore
> +++ b/tools/testing/selftests/kcmp/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  kcmp_test
>  kcmp-test-file
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 30072c3f52fb..2f85dc944fbd 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /s390x/sync_regs_test
>  /s390x/memop
>  /x86_64/cr4_cpuid_sync_test
> diff --git a/tools/testing/selftests/media_tests/.gitignore b/tools/testing/selftests/media_tests/.gitignore
> index 8745eba39012..da438e780ffe 100644
> --- a/tools/testing/selftests/media_tests/.gitignore
> +++ b/tools/testing/selftests/media_tests/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  media_device_test
>  media_device_open
>  video_device_test
> diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
> index f2f7ec0a99b4..f2fbba178601 100644
> --- a/tools/testing/selftests/membarrier/.gitignore
> +++ b/tools/testing/selftests/membarrier/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  membarrier_test_multi_thread
>  membarrier_test_single_thread
> diff --git a/tools/testing/selftests/memfd/.gitignore b/tools/testing/selftests/memfd/.gitignore
> index afe87c40ac80..dd9a051f608e 100644
> --- a/tools/testing/selftests/memfd/.gitignore
> +++ b/tools/testing/selftests/memfd/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  fuse_mnt
>  fuse_test
>  memfd_test
> diff --git a/tools/testing/selftests/mount/.gitignore b/tools/testing/selftests/mount/.gitignore
> index 856ad4107eb3..0bc64a6d4c18 100644
> --- a/tools/testing/selftests/mount/.gitignore
> +++ b/tools/testing/selftests/mount/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  unprivileged-remount-test
> diff --git a/tools/testing/selftests/mqueue/.gitignore b/tools/testing/selftests/mqueue/.gitignore
> index d8d42377205a..72ad8ca691c9 100644
> --- a/tools/testing/selftests/mqueue/.gitignore
> +++ b/tools/testing/selftests/mqueue/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mq_open_tests
>  mq_perf_tests
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index ecc52d4c034d..08ad1a7109e2 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  msg_zerocopy
>  socket
>  psock_fanout
> diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
> index a793eef5b876..2dea317f12e7 100644
> --- a/tools/testing/selftests/net/forwarding/.gitignore
> +++ b/tools/testing/selftests/net/forwarding/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  forwarding.config
> diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
> index d72f07642738..beea6541fb21 100644
> --- a/tools/testing/selftests/net/mptcp/.gitignore
> +++ b/tools/testing/selftests/net/mptcp/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  mptcp_connect
>  *.pcap
> diff --git a/tools/testing/selftests/networking/timestamping/.gitignore b/tools/testing/selftests/networking/timestamping/.gitignore
> index d9355035e746..f4f031db8bbf 100644
> --- a/tools/testing/selftests/networking/timestamping/.gitignore
> +++ b/tools/testing/selftests/networking/timestamping/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  timestamping
>  rxtimestamp
>  txtimestamp
> diff --git a/tools/testing/selftests/nsfs/.gitignore b/tools/testing/selftests/nsfs/.gitignore
> index 2ab2c824ce86..ed79ebdf286e 100644
> --- a/tools/testing/selftests/nsfs/.gitignore
> +++ b/tools/testing/selftests/nsfs/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  owner
>  pidns
> diff --git a/tools/testing/selftests/openat2/.gitignore b/tools/testing/selftests/openat2/.gitignore
> index bd68f6c3fd07..82a4846cbc4b 100644
> --- a/tools/testing/selftests/openat2/.gitignore
> +++ b/tools/testing/selftests/openat2/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /*_test
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index 3a779c084d96..7fff87984006 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  pidfd_open_test
>  pidfd_poll_test
>  pidfd_test
> diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
> index 6d4fd014511c..28bc6ca13cc6 100644
> --- a/tools/testing/selftests/powerpc/alignment/.gitignore
> +++ b/tools/testing/selftests/powerpc/alignment/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  copy_first_unaligned
>  alignment_handler
> diff --git a/tools/testing/selftests/powerpc/benchmarks/.gitignore b/tools/testing/selftests/powerpc/benchmarks/.gitignore
> index 9161679b1e1a..c9ce13983c99 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/.gitignore
> +++ b/tools/testing/selftests/powerpc/benchmarks/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gettimeofday
>  context_switch
>  fork
> diff --git a/tools/testing/selftests/powerpc/cache_shape/.gitignore b/tools/testing/selftests/powerpc/cache_shape/.gitignore
> index ec1848434be5..b385eee3012c 100644
> --- a/tools/testing/selftests/powerpc/cache_shape/.gitignore
> +++ b/tools/testing/selftests/powerpc/cache_shape/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  cache_shape
> diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
> index 12ef5b031974..ddaf140b8255 100644
> --- a/tools/testing/selftests/powerpc/copyloops/.gitignore
> +++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  copyuser_64_t0
>  copyuser_64_t1
>  copyuser_64_t2
> diff --git a/tools/testing/selftests/powerpc/dscr/.gitignore b/tools/testing/selftests/powerpc/dscr/.gitignore
> index b585c6c1564a..1d08b15af697 100644
> --- a/tools/testing/selftests/powerpc/dscr/.gitignore
> +++ b/tools/testing/selftests/powerpc/dscr/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  dscr_default_test
>  dscr_explicit_test
>  dscr_inherit_exec_test
> diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
> index 50ded63e25b7..e31ca6f453ed 100644
> --- a/tools/testing/selftests/powerpc/math/.gitignore
> +++ b/tools/testing/selftests/powerpc/math/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  fpu_syscall
>  vmx_syscall
>  fpu_preempt
> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> index 0ebeaea22641..7cf7ad261d02 100644
> --- a/tools/testing/selftests/powerpc/mm/.gitignore
> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  hugetlb_vs_thp_test
>  subpage_prot
>  tempfile
> diff --git a/tools/testing/selftests/powerpc/pmu/.gitignore b/tools/testing/selftests/powerpc/pmu/.gitignore
> index e748f336eed3..ff7896903d7b 100644
> --- a/tools/testing/selftests/powerpc/pmu/.gitignore
> +++ b/tools/testing/selftests/powerpc/pmu/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  count_instructions
>  l3_bank_test
>  per_event_excludes
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
> index 42bddbed8b64..2920fb39439b 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  reg_access_test
>  event_attributes_test
>  cycles_test
> diff --git a/tools/testing/selftests/powerpc/primitives/.gitignore b/tools/testing/selftests/powerpc/primitives/.gitignore
> index 4cc4e31bed1d..1e5c04e24254 100644
> --- a/tools/testing/selftests/powerpc/primitives/.gitignore
> +++ b/tools/testing/selftests/powerpc/primitives/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  load_unaligned_zeropad
> diff --git a/tools/testing/selftests/powerpc/ptrace/.gitignore b/tools/testing/selftests/powerpc/ptrace/.gitignore
> index dce19f221c46..0e96150b7c7e 100644
> --- a/tools/testing/selftests/powerpc/ptrace/.gitignore
> +++ b/tools/testing/selftests/powerpc/ptrace/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ptrace-gpr
>  ptrace-tm-gpr
>  ptrace-tm-spd-gpr
> diff --git a/tools/testing/selftests/powerpc/security/.gitignore b/tools/testing/selftests/powerpc/security/.gitignore
> index 0b969fba3beb..f795e06f5ae3 100644
> --- a/tools/testing/selftests/powerpc/security/.gitignore
> +++ b/tools/testing/selftests/powerpc/security/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  rfi_flush
> diff --git a/tools/testing/selftests/powerpc/signal/.gitignore b/tools/testing/selftests/powerpc/signal/.gitignore
> index dca5852a1546..f897b55a44dd 100644
> --- a/tools/testing/selftests/powerpc/signal/.gitignore
> +++ b/tools/testing/selftests/powerpc/signal/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  signal
>  signal_tm
>  sigfuz
> diff --git a/tools/testing/selftests/powerpc/stringloops/.gitignore b/tools/testing/selftests/powerpc/stringloops/.gitignore
> index 31a17e0ba884..b0dfc74aa57e 100644
> --- a/tools/testing/selftests/powerpc/stringloops/.gitignore
> +++ b/tools/testing/selftests/powerpc/stringloops/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  memcmp_64
>  memcmp_32
>  strlen
> diff --git a/tools/testing/selftests/powerpc/switch_endian/.gitignore b/tools/testing/selftests/powerpc/switch_endian/.gitignore
> index 89e762eab676..30e962cf84d1 100644
> --- a/tools/testing/selftests/powerpc/switch_endian/.gitignore
> +++ b/tools/testing/selftests/powerpc/switch_endian/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  switch_endian_test
>  check-reversed.S
> diff --git a/tools/testing/selftests/powerpc/syscalls/.gitignore b/tools/testing/selftests/powerpc/syscalls/.gitignore
> index f0f3fcc9d802..b00cab225476 100644
> --- a/tools/testing/selftests/powerpc/syscalls/.gitignore
> +++ b/tools/testing/selftests/powerpc/syscalls/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ipc_unmuxed
> diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
> index 98f2708d86cc..7baf2a46002f 100644
> --- a/tools/testing/selftests/powerpc/tm/.gitignore
> +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  tm-resched-dscr
>  tm-syscall
>  tm-signal-msr-resv
> diff --git a/tools/testing/selftests/powerpc/vphn/.gitignore b/tools/testing/selftests/powerpc/vphn/.gitignore
> index 7c04395010cb..b744aedfd1f2 100644
> --- a/tools/testing/selftests/powerpc/vphn/.gitignore
> +++ b/tools/testing/selftests/powerpc/vphn/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  test-vphn
> diff --git a/tools/testing/selftests/prctl/.gitignore b/tools/testing/selftests/prctl/.gitignore
> index 0b5c27447bf6..91af2b631bc9 100644
> --- a/tools/testing/selftests/prctl/.gitignore
> +++ b/tools/testing/selftests/prctl/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  disable-tsc-ctxt-sw-stress-test
>  disable-tsc-on-off-stress-test
>  disable-tsc-test
> diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
> index 66fab4c58ed4..4bca5a9327a4 100644
> --- a/tools/testing/selftests/proc/.gitignore
> +++ b/tools/testing/selftests/proc/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /fd-001-lookup
>  /fd-002-posix-eq
>  /fd-003-kthread
> diff --git a/tools/testing/selftests/pstore/.gitignore b/tools/testing/selftests/pstore/.gitignore
> index 5a4a26e5464b..9938fb406389 100644
> --- a/tools/testing/selftests/pstore/.gitignore
> +++ b/tools/testing/selftests/pstore/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  logs
>  *uuid
> diff --git a/tools/testing/selftests/ptp/.gitignore b/tools/testing/selftests/ptp/.gitignore
> index f562e49d6917..534ca26eee48 100644
> --- a/tools/testing/selftests/ptp/.gitignore
> +++ b/tools/testing/selftests/ptp/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  testptp
> diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
> index cfcc49a7def7..7bebf9534a86 100644
> --- a/tools/testing/selftests/ptrace/.gitignore
> +++ b/tools/testing/selftests/ptrace/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  get_syscall_info
>  peeksiginfo
> diff --git a/tools/testing/selftests/rcutorture/.gitignore b/tools/testing/selftests/rcutorture/.gitignore
> index ccc240275d1c..f6cbce77460b 100644
> --- a/tools/testing/selftests/rcutorture/.gitignore
> +++ b/tools/testing/selftests/rcutorture/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  initrd
>  b[0-9]*
>  res
> diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
> index 712a3d41a325..24e27957efcc 100644
> --- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
> +++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  srcu.c
> diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
> index 1d016e66980a..57d296341304 100644
> --- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
> +++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  srcu.h
> diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
> index f47cb2045f13..d65462d64816 100644
> --- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
> +++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.out
> diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
> index cc610da7e369..5910888ebfe1 100644
> --- a/tools/testing/selftests/rseq/.gitignore
> +++ b/tools/testing/selftests/rseq/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  basic_percpu_ops_test
>  basic_test
>  basic_rseq_op_test
> diff --git a/tools/testing/selftests/rtc/.gitignore b/tools/testing/selftests/rtc/.gitignore
> index d0ad44f6294a..fb2d533aa575 100644
> --- a/tools/testing/selftests/rtc/.gitignore
> +++ b/tools/testing/selftests/rtc/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  rtctest
>  setdate
> diff --git a/tools/testing/selftests/safesetid/.gitignore b/tools/testing/selftests/safesetid/.gitignore
> index 9c1a629bca01..25d3db172907 100644
> --- a/tools/testing/selftests/safesetid/.gitignore
> +++ b/tools/testing/selftests/safesetid/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  safesetid-test
> diff --git a/tools/testing/selftests/seccomp/.gitignore b/tools/testing/selftests/seccomp/.gitignore
> index 5af29d3a1b0a..dec678577f9c 100644
> --- a/tools/testing/selftests/seccomp/.gitignore
> +++ b/tools/testing/selftests/seccomp/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  seccomp_bpf
>  seccomp_benchmark
> diff --git a/tools/testing/selftests/sigaltstack/.gitignore b/tools/testing/selftests/sigaltstack/.gitignore
> index 35897b0a3f44..50a19a8888ce 100644
> --- a/tools/testing/selftests/sigaltstack/.gitignore
> +++ b/tools/testing/selftests/sigaltstack/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  sas
> diff --git a/tools/testing/selftests/size/.gitignore b/tools/testing/selftests/size/.gitignore
> index 189b7818de34..923e18eed1a0 100644
> --- a/tools/testing/selftests/size/.gitignore
> +++ b/tools/testing/selftests/size/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  get_size
> diff --git a/tools/testing/selftests/sparc64/drivers/.gitignore b/tools/testing/selftests/sparc64/drivers/.gitignore
> index 90e835ed74e6..0331f77373b5 100644
> --- a/tools/testing/selftests/sparc64/drivers/.gitignore
> +++ b/tools/testing/selftests/sparc64/drivers/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  adi-test
> diff --git a/tools/testing/selftests/splice/.gitignore b/tools/testing/selftests/splice/.gitignore
> index 1e23fefd68e8..d5a2da428752 100644
> --- a/tools/testing/selftests/splice/.gitignore
> +++ b/tools/testing/selftests/splice/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  default_file_splice_read
> diff --git a/tools/testing/selftests/sync/.gitignore b/tools/testing/selftests/sync/.gitignore
> index f5091e7792f2..f1152357712f 100644
> --- a/tools/testing/selftests/sync/.gitignore
> +++ b/tools/testing/selftests/sync/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  sync_test
> diff --git a/tools/testing/selftests/tc-testing/.gitignore b/tools/testing/selftests/tc-testing/.gitignore
> index c26d72e0166f..d52f65de23b4 100644
> --- a/tools/testing/selftests/tc-testing/.gitignore
> +++ b/tools/testing/selftests/tc-testing/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  __pycache__/
>  *.pyc
>  plugins/
> diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
> index 789f21e81028..2e43851b47c1 100644
> --- a/tools/testing/selftests/timens/.gitignore
> +++ b/tools/testing/selftests/timens/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  clock_nanosleep
>  exec
>  gettime_perf
> diff --git a/tools/testing/selftests/timers/.gitignore b/tools/testing/selftests/timers/.gitignore
> index 32a9eadb2d4e..bb5326ff900b 100644
> --- a/tools/testing/selftests/timers/.gitignore
> +++ b/tools/testing/selftests/timers/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  alarmtimer-suspend
>  change_skew
>  clocksource-switch
> diff --git a/tools/testing/selftests/tmpfs/.gitignore b/tools/testing/selftests/tmpfs/.gitignore
> index a96838fad74d..b1afaa925905 100644
> --- a/tools/testing/selftests/tmpfs/.gitignore
> +++ b/tools/testing/selftests/tmpfs/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /bug-link-o-tmpfile
> diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
> index 133bf9ee986c..382cfb39a1a3 100644
> --- a/tools/testing/selftests/vDSO/.gitignore
> +++ b/tools/testing/selftests/vDSO/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  vdso_test
>  vdso_standalone_test_x86
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 31b3c98b6d34..876c48d7f41d 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  hugepage-mmap
>  hugepage-shm
>  map_hugetlb
> diff --git a/tools/testing/selftests/watchdog/.gitignore b/tools/testing/selftests/watchdog/.gitignore
> index 5aac51575c7e..61d7b89cdbca 100644
> --- a/tools/testing/selftests/watchdog/.gitignore
> +++ b/tools/testing/selftests/watchdog/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  watchdog-test
> diff --git a/tools/testing/selftests/wireguard/qemu/.gitignore b/tools/testing/selftests/wireguard/qemu/.gitignore
> index 415b542a9d59..bfa15e6feb2f 100644
> --- a/tools/testing/selftests/wireguard/qemu/.gitignore
> +++ b/tools/testing/selftests/wireguard/qemu/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  build/
>  distfiles/
> diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
> index 7757f73ff9a3..022a1f3b64ef 100644
> --- a/tools/testing/selftests/x86/.gitignore
> +++ b/tools/testing/selftests/x86/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *_32
>  *_64
>  single_step_syscall
> diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
> index 7f7a2ccc30c4..87ca2731cff9 100644
> --- a/tools/testing/vsock/.gitignore
> +++ b/tools/testing/vsock/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  vsock_test
>  vsock_diag_test
> diff --git a/tools/thermal/tmon/.gitignore b/tools/thermal/tmon/.gitignore
> index 06e96be65276..d9e97a0308f5 100644
> --- a/tools/thermal/tmon/.gitignore
> +++ b/tools/thermal/tmon/.gitignore
> @@ -1 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  /tmon
> diff --git a/tools/usb/.gitignore b/tools/usb/.gitignore
> index 1b7448981435..fce1ef5a9267 100644
> --- a/tools/usb/.gitignore
> +++ b/tools/usb/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  ffs-test
>  testusb
> diff --git a/tools/usb/usbip/.gitignore b/tools/usb/usbip/.gitignore
> index 03b892c8bd8c..597361a96dbb 100644
> --- a/tools/usb/usbip/.gitignore
> +++ b/tools/usb/usbip/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  Makefile
>  Makefile.in
>  aclocal.m4
> diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
> index 1cfbb0157a46..075588c4da08 100644
> --- a/tools/virtio/.gitignore
> +++ b/tools/virtio/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  virtio_test
>  vringh_test
> diff --git a/tools/vm/.gitignore b/tools/vm/.gitignore
> index 44f095fa2604..79bb92ae1bb3 100644
> --- a/tools/vm/.gitignore
> +++ b/tools/vm/.gitignore
> @@ -1,2 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  slabinfo
>  page-types
> diff --git a/usr/.gitignore b/usr/.gitignore
> index 610de736b75e..935442ed1eb2 100644
> --- a/usr/.gitignore
> +++ b/usr/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  gen_init_cpio
>  initramfs_data.cpio
>  /initramfs_inc_data
> diff --git a/usr/include/.gitignore b/usr/include/.gitignore
> index a0991ff4402b..d2fab782cb7d 100644
> --- a/usr/include/.gitignore
> +++ b/usr/include/.gitignore
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  *
>  !.gitignore
>  !Makefile
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
