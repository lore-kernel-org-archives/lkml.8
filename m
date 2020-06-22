Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5649C20720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgFVXqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgFVXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:06 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8E-0005DO-Qk; Mon, 22 Jun 2020 23:46:02 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 00/17] arch: remove do_fork() and HAVE_COPY_THREAD_TLS
Date:   Tue, 23 Jun 2020 01:43:09 +0200
Message-Id: <20200622234326.906346-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is a series I had announced some time back (cf. [2]) when we
reworked a chunk of the process creation paths in the kernel and
switched to struct {kernel_}clone_args. I've been sitting on this for a
while due to lack of time and because testing on all architectures that
are non-trivially impacted proved to be interesting. So first, I have to
give a big thank you to Arnd (Bergmann) and Adrian (Glaubitz).
Arnd for the gcc crosstools builds which made it possible to compile for
nearly all supported arches with gcc 10. Adrian for providing me with a
ia64 rack server (that sure made summer in my workspace come a little
earlier) to test the ia64 specific changes, alpha, and other stuff.

This patch series switches all remaining architectures to select
HAVE_COPY_THREAD_TLS and thus to the copy_thread_tls() calling
convention. This split makes the process creation codepaths a bit
convoluted to read. Each architecture has their own copy_thread()
function unless it selects HAVE_COPY_THREAD_TLS then it has a
copy_thread_tls() function. Removing this split cleans up the process
creation codepaths and paves the way for implementing clone3() on those
architectures since it requires the copy_thread_tls() calling
convention. After having made each architectures support
copy_thread_tls() this series simply renames that function back to
copy_thread(). It also switches all architectures that call do_fork()
directly over to _do_fork() and the struct kernel_clone_args calling
convention. This is a corollary of switching the architectures that did
not yet support it over to copy_thread_tls() since do_fork() is
conditional on not supporting copy_thread_tls() (since it lacks an
argument for tls).  But the do_fork() removal is in itself already
useful as it allows to to remove the export of both do_fork() and
_do_fork() we currently have in favor of only _do_fork().  This has
already been discussed back when we added clone3(). The legacy clone()
calling convention is - as most know - somewhat odd or as arch/Kconfig
(cf. [1]) phrases it:

  #
  # ABI hall of shame
  #
  config CLONE_BACKWARDS
  config CLONE_BACKWARDS2
  config CLONE_BACKWARDS3

that is aggravated by the fact that some architectures such as sparc
follow the CLONE_BACKWARDSx calling convention but don't really select
the corresponding config option since thy call do_fork() directly. So
do_fork() enforces a somewhat arbitrary ordering in the first place that
doesn't really help the individual architectures that deviate from it.
They can thus simply be switched to _do_fork() enforcing a single
calling convention. Most architectures have made a similar switch
already (m68k comes to mind). Removing do_fork() is also a corollary of
switching all architectures over to the copy_thread_tls() calling
convention.

Overall this series removes more code then it adds even with a chunk of
added comments (268(+)/274(-)). It simplifies a chunk of arch specific
assembly either by moving the code into C or by simply rewriting the
assembly.

I've done my best to test this. Architectures that have been touched in
non-trivial ways have all been actually boot and stress tested: sparc
and ia64 have been tested with Debian 9 images. nios2 with a custom
build buildroot image. h8300 I couldn't get something bootable but the
changes have been fairly automatic and I'm sure we'll hear people yell
if I broke something there. All other architectures that have been
touched in trivial ways have been compile tested for each single patch
of the series via git rebase -x "make ..." v5.8-rc2. arm and x86 have
been boot tested even though they have just been trivially touched
(removal of the HAVE_COPY_THREAD_TLS macro from their Kconfig) because
well they are basically "core architectures" and since it is trivial to
get your hands on a useable image.

The series is available at:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=do_fork_removal
https://gitlab.com/brauner/linux/-/tree/do_fork_removal
https://github.com/brauner/linux/tree/do_fork_removal
if anyone with access to weirder architectures wants to test them.

Thanks!
Christian

[1]: d2125043aebf ("generic sys_fork / sys_vfork / sys_clone")
[2]: 606e9ad20094

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

 arch/Kconfig                      |   7 --
 arch/alpha/kernel/process.c       |   9 ++-
 arch/arc/Kconfig                  |   1 -
 arch/arc/kernel/process.c         |   2 +-
 arch/arm/Kconfig                  |   1 -
 arch/arm/kernel/process.c         |   2 +-
 arch/arm64/Kconfig                |   1 -
 arch/arm64/kernel/process.c       |   2 +-
 arch/c6x/kernel/process.c         |   4 +-
 arch/csky/Kconfig                 |   1 -
 arch/csky/kernel/process.c        |   2 +-
 arch/h8300/kernel/process.c       |  18 +++--
 arch/hexagon/kernel/process.c     |   4 +-
 arch/ia64/kernel/entry.S          |  32 ++++-----
 arch/ia64/kernel/process.c        |  30 ++++++--
 arch/m68k/Kconfig                 |   1 -
 arch/m68k/kernel/process.c        |   5 +-
 arch/microblaze/kernel/process.c  |   4 +-
 arch/mips/Kconfig                 |   1 -
 arch/mips/kernel/process.c        |   2 +-
 arch/nds32/kernel/process.c       |   5 +-
 arch/nios2/kernel/entry.S         |   7 +-
 arch/nios2/kernel/process.c       |  23 ++++++-
 arch/openrisc/Kconfig             |   1 -
 arch/openrisc/kernel/process.c    |   4 +-
 arch/parisc/Kconfig               |   1 -
 arch/parisc/kernel/process.c      |   2 +-
 arch/powerpc/Kconfig              |   1 -
 arch/powerpc/kernel/process.c     |   2 +-
 arch/riscv/Kconfig                |   1 -
 arch/riscv/kernel/process.c       |   2 +-
 arch/s390/Kconfig                 |   1 -
 arch/s390/kernel/process.c        |   2 +-
 arch/sh/kernel/process_32.c       |   4 +-
 arch/sparc/include/asm/syscalls.h |   7 +-
 arch/sparc/kernel/Makefile        |   1 +
 arch/sparc/kernel/entry.S         |  29 ++------
 arch/sparc/kernel/kernel.h        |  11 ++-
 arch/sparc/kernel/process.c       | 110 ++++++++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c    |  32 +--------
 arch/sparc/kernel/process_64.c    |  39 +----------
 arch/sparc/kernel/syscalls.S      |  23 ++++---
 arch/um/Kconfig                   |   1 -
 arch/um/kernel/process.c          |   2 +-
 arch/unicore32/kernel/process.c   |   8 +--
 arch/x86/Kconfig                  |   1 -
 arch/x86/kernel/process.c         |   2 +-
 arch/x86/kernel/sys_ia32.c        |   3 -
 arch/x86/kernel/unwind_frame.c    |   2 +-
 arch/xtensa/Kconfig               |   1 -
 arch/xtensa/kernel/process.c      |   2 +-
 include/linux/sched/task.h        |  17 +----
 kernel/fork.c                     |  66 +++++-------------
 53 files changed, 268 insertions(+), 274 deletions(-)
 create mode 100644 arch/sparc/kernel/process.c


base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.27.0

