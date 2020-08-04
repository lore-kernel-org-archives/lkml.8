Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4131C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FA6206D4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgHDL2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:28:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46098 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:28:11 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2v72-0001zq-Ed; Tue, 04 Aug 2020 11:28:08 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] fork cleanup for v5.9
Date:   Tue,  4 Aug 2020 13:28:01 +0200
Message-Id: <20200804112801.72380-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This is a series announced some time back (cf. [2]) when we reworked a chunk of
the process creation paths in the kernel and switched to struct
{kernel_}clone_args.

High-level this does two main things:
1. Remove the double export of both do_fork() and _do_fork() where do_fork()
   used the incosistent legacy clone calling convention. Now we only export
   _do_fork() which is based on struct kernel_clone_args.
2. Remove the copy_thread_tls()/copy_thread() split making the
   architecture specific HAVE_COYP_THREAD_TLS config option obsolete.

This switches all remaining architectures to select HAVE_COPY_THREAD_TLS and
thus to the copy_thread_tls() calling convention. The current split makes the
process creation codepaths more convoluted than they need to be. Each
architecture has their own copy_thread() function unless it selects
HAVE_COPY_THREAD_TLS then it has a copy_thread_tls() function. The split is not
needed anymore nowadays, all architectures support CLONE_SETTLS but quite a few
of them never bothered to select HAVE_COPY_THREAD_TLS and instead simply
continued to use copy_thread() and use the old calling convention.
Removing this split cleans up the process creation codepaths and paves the way
for implementing clone3() on such architectures since it requires the
copy_thread_tls() calling convention.
After having made each architectures support copy_thread_tls() this series
simply renames that function back to copy_thread().
It also switches all architectures that call do_fork() directly over to
_do_fork() and the struct kernel_clone_args calling convention. This is a
corollary of switching the architectures that did not yet support it over to
copy_thread_tls() since do_fork() is conditional on not supporting
copy_thread_tls() (Mostly because it lacks a separate argument for tls which is
trivial to fix but there's no need for this function to exist.).

The do_fork() removal is in itself already useful as it allows to to remove the
export of both do_fork() and _do_fork() we currently have in favor of only
_do_fork(). This has already been discussed back when we added clone3(). The
legacy clone() calling convention is - as is probably well-known - somewhat odd
or as Al once put it in arch/Kconfig (cf. [1]):

  #
  # ABI hall of shame
  #
  config CLONE_BACKWARDS
  config CLONE_BACKWARDS2
  config CLONE_BACKWARDS3

that is aggravated by the fact that some architectures such as sparc follow the
CLONE_BACKWARDSx calling convention but don't really select the corresponding
config option since they call do_fork() directly.
So do_fork() enforces a somewhat arbitrary calling convention in the first place
that doesn't really help the individual architectures that deviate from it. They
can thus simply be switched to _do_fork() enforcing a single calling convention.
(I really hope that any new architectures will __not__ try to implement their
 own calling conventions...) Most architectures already have made a similar
switch (m68k comes to mind).

Overall this removes more code then it adds even with a good portion of added
comments. It simplifies a chunk of arch specific assembly either by moving the
code into C or by simply rewriting the assembly.

Architectures that have been touched in non-trivial ways have all been actually
boot and stress tested: sparc and ia64 have been tested with Debian 9 images.
They are the two architectures which have been touched the most. All non-trivial
changes to architectures have seen acks from the relevant maintainers.
nios2 with a custom built buildroot image. h8300 I couldn't get something
bootable to test on but the changes have been fairly automatic and I'm sure
we'll hear people yell if I broke something there. All other architectures that
have been touched in trivial ways have been compile tested for each single patch
of the series via git rebase -x "make ..." v5.8-rc2. arm{64} and x86{_64} have
been boot tested even though they have just been trivially touched (removal of
the HAVE_COPY_THREAD_TLS macro from their Kconfig) because well they are
basically "core architectures" and since it is trivial to get your hands on a
useable image.

/* Testing */
All patches are based on v5.8-rc2 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests of relevant
test-suites are passing.

/* Conflicts */
There are a few smaller conflicts that linux-next reported:

1. csky tree: https://lore.kernel.org/lkml/20200803182550.4c7df8ae@canb.auug.org.au
   Stephen's suggestion to fix it seems correct:

diff --cc arch/csky/Kconfig
index af238739811e,902f1142d550..000000000000
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@@ -39,11 -38,6 +39,10 @@@ config CSK
        select GX6605S_TIMER if CPU_CK610
        select HAVE_ARCH_TRACEHOOK
        select HAVE_ARCH_AUDITSYSCALL
 +      select HAVE_ARCH_MMAP_RND_BITS
 +      select HAVE_ARCH_SECCOMP_FILTER
-       select HAVE_COPY_THREAD_TLS
 +      select HAVE_CONTEXT_TRACKING
 +      select HAVE_VIRT_CPU_ACCOUNTING_GEN
        select HAVE_DEBUG_BUGVERBOSE
        select HAVE_DYNAMIC_FTRACE
        select HAVE_DYNAMIC_FTRACE_WITH_REGS

2. sh tree: https://lore.kernel.org/lkml/20200722203812.6ca23e0d@canb.auug.org.au
   Stephen's suggestion to fix it seems correct:

diff --cc arch/um/Kconfig
index 32c1d1945033,ef69be17ff70..000000000000
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@@ -14,8 -14,6 +14,7 @@@ config UM
        select HAVE_FUTEX_CMPXCHG if FUTEX
        select HAVE_DEBUG_KMEMLEAK
        select HAVE_DEBUG_BUGVERBOSE
-       select HAVE_COPY_THREAD_TLS
 +      select NO_DMA
        select GENERIC_IRQ_SHOW
        select GENERIC_CPU_DEVICES
        select GENERIC_CLOCKEVENTS

3. riscv tree: https://lore.kernel.org/lkml/20200713165846.5166ff82@canb.auug.org.au
   Stephen's suggestion to fix it seems correct:

diff --cc arch/riscv/Kconfig
index 76a0cfad3367,f6a3a2bea3d8..000000000000
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -57,9 -52,6 +57,8 @@@ config RISC
        select HAVE_ARCH_SECCOMP_FILTER
        select HAVE_ARCH_TRACEHOOK
        select HAVE_ASM_MODVERSIONS
 +      select HAVE_CONTEXT_TRACKING
-       select HAVE_COPY_THREAD_TLS
 +      select HAVE_DEBUG_KMEMLEAK
        select HAVE_DMA_CONTIGUOUS if MMU
        select HAVE_EBPF_JIT if MMU
        select HAVE_FUTEX_CMPXCHG if FUTEX

4. memlock tree: https://lore.kernel.org/lkml/20200706155811.7928b30d@canb.auug.org.au
   The conflict is in arch/unicore32/kernel/process.c and it seems that the
   unicore32 port is about to be removed. So if that tree lands than the changes
   in 8496da092a53 ("unicore: switch to copy_thread_tls()") can just be dropped
   similar to what Stephen did for linux-next.

Fwiw, doing a test-merge with current mainline bcf876870b95 ("Linux 5.8") shows me:

brauner@wittgenstein|~/src/git/linux/linux|master $%=
> git pull git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fork-v5.9
From gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 * tag                         fork-v5.9  -> FETCH_HEAD
Auto-merging kernel/fork.c
Auto-merging arch/x86/kernel/process.c
Auto-merging arch/x86/Kconfig
Auto-merging arch/riscv/Kconfig
Auto-merging arch/arm64/Kconfig
Auto-merging arch/arc/Kconfig
Merge made by the 'recursive' strategy.

And nothing looks suspicious afterwards.

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fork-v5.9

for you to fetch changes up to 714acdbd1c94e7e3ab90f6b6938f1ccb27b662f0:

  arch: rename copy_thread_tls() back to copy_thread() (2020-07-04 23:41:37 +0200)

Please consider pulling these changes from the signed fork-v5.9 tag.

Thanks!
Christian

----------------------------------------------------------------
fork-v5.9

----------------------------------------------------------------
Christian Brauner (17):
      fork: fold legacy_clone_args_valid() into _do_fork()
      sparc64: enable HAVE_COPY_THREAD_TLS
      sparc: share process creation helpers between sparc and sparc64
      sparc: unconditionally enable HAVE_COPY_THREAD_TLS
      ia64: enable HAVE_COPY_THREAD_TLS, switch to kernel_clone_args
      nios2: enable HAVE_COPY_THREAD_TLS, switch to kernel_clone_args
      h8300: select HAVE_COPY_THREAD_TLS, switch to kernel_clone_args
      fork: remove do_fork()
      alpha: switch to copy_thread_tls()
      c6x: switch to copy_thread_tls()
      hexagon: switch to copy_thread_tls()
      microblaze: switch to copy_thread_tls()
      nds32: switch to copy_thread_tls()
      sh: switch to copy_thread_tls()
      unicore: switch to copy_thread_tls()
      arch: remove HAVE_COPY_THREAD_TLS
      arch: rename copy_thread_tls() back to copy_thread()

 arch/Kconfig                      |   7 ---
 arch/alpha/kernel/process.c       |   9 ++--
 arch/arc/Kconfig                  |   1 -
 arch/arc/kernel/process.c         |   5 +-
 arch/arm/Kconfig                  |   1 -
 arch/arm/kernel/process.c         |   5 +-
 arch/arm64/Kconfig                |   1 -
 arch/arm64/kernel/process.c       |   2 +-
 arch/c6x/kernel/process.c         |   4 +-
 arch/csky/Kconfig                 |   1 -
 arch/csky/kernel/process.c        |   2 +-
 arch/h8300/kernel/process.c       |  17 ++++--
 arch/hexagon/kernel/process.c     |   6 +--
 arch/ia64/kernel/entry.S          |  32 +++++------
 arch/ia64/kernel/process.c        |  29 +++++++---
 arch/m68k/Kconfig                 |   1 -
 arch/m68k/kernel/process.c        |   8 +--
 arch/microblaze/kernel/process.c  |   6 +--
 arch/mips/Kconfig                 |   1 -
 arch/mips/kernel/process.c        |   5 +-
 arch/nds32/kernel/process.c       |   4 +-
 arch/nios2/kernel/entry.S         |   7 +--
 arch/nios2/kernel/process.c       |  23 ++++++--
 arch/openrisc/Kconfig             |   1 -
 arch/openrisc/kernel/process.c    |   6 +--
 arch/parisc/Kconfig               |   1 -
 arch/parisc/kernel/process.c      |   2 +-
 arch/powerpc/Kconfig              |   1 -
 arch/powerpc/kernel/process.c     |   2 +-
 arch/riscv/Kconfig                |   1 -
 arch/riscv/kernel/process.c       |   4 +-
 arch/s390/Kconfig                 |   1 -
 arch/s390/kernel/process.c        |   4 +-
 arch/sh/kernel/process_32.c       |   6 +--
 arch/sparc/include/asm/syscalls.h |   7 ++-
 arch/sparc/kernel/Makefile        |   1 +
 arch/sparc/kernel/entry.S         |  29 +++-------
 arch/sparc/kernel/kernel.h        |  11 ++--
 arch/sparc/kernel/process.c       | 110 ++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c    |  33 ++----------
 arch/sparc/kernel/process_64.c    |  40 ++------------
 arch/sparc/kernel/syscalls.S      |  23 ++++----
 arch/um/Kconfig                   |   1 -
 arch/um/kernel/process.c          |   2 +-
 arch/unicore32/kernel/process.c   |   7 ++-
 arch/x86/Kconfig                  |   1 -
 arch/x86/kernel/process.c         |   4 +-
 arch/x86/kernel/sys_ia32.c        |   3 --
 arch/x86/kernel/unwind_frame.c    |   2 +-
 arch/xtensa/Kconfig               |   1 -
 arch/xtensa/kernel/process.c      |   2 +-
 include/linux/sched/task.h        |  17 +-----
 kernel/fork.c                     |  67 ++++++-----------------
 53 files changed, 277 insertions(+), 290 deletions(-)
 create mode 100644 arch/sparc/kernel/process.c
