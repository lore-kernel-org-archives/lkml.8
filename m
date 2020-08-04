Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19677C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B2F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgHDLeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:34:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDLeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:34:10 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2vCp-0002ML-JD; Tue, 04 Aug 2020 11:34:07 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] close_range for v5.9
Date:   Tue,  4 Aug 2020 13:33:58 +0200
Message-Id: <20200804113358.72985-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the pull request for close_range() for v5.9.

/* Summary */
This adds the close_range() syscall. It allows to efficiently close a range of
file descriptors up to all file descriptors of a calling task.

This is coordinated with the FreeBSD folks which have copied our version of
this syscall and in the meantime have already merged it in April 2019:
https://reviews.freebsd.org/D21627
https://svnweb.freebsd.org/base?view=revision&revision=359836

The syscall originally came up in a discussion around the new mount API and
making new file descriptor types cloexec by default. During this discussion, Al
suggested the close_range() syscall.

First, it helps to close all file descriptors of an exec()ing task. This
can be done safely via (quoting Al's example from [1] verbatim):

        /* that exec is sensitive */
        unshare(CLONE_FILES);
        /* we don't want anything past stderr here */
        close_range(3, ~0U);
        execve(....);

The code snippet above is one way of working around the problem that file
descriptors are not cloexec by default. This is aggravated by the fact that
we can't just switch them over without massively regressing userspace. For
a whole class of programs having an in-kernel method of closing all file
descriptors is very helpful (e.g. demons, service managers, programming
language standard libraries, container managers etc.).

Second, it allows userspace to avoid implementing closing all file descriptors
by parsing through /proc/<pid>/fd/* and calling close() on each file
descriptor and other hacks. From looking at various large(ish) userspace code
bases this or similar patterns are very common in service managers, container
runtimes, and programming language runtimes/standard libraries such as Python
or Rust. In addition, the syscall will also work for tasks that do not have
procfs mounted and on kernels that do not have procfs support compiled in. In
such situations the only way to make sure that all file descriptors are closed
is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
OPEN_MAX trickery.

Based on Linus suggestion close_range() also comes with a new flag
CLOSE_RANGE_UNSHARE to more elegantly handle file descriptor dropping right
before exec. This would usually be expressed in the sequence:
	unshare(CLONE_FILES);
	close_range(3, ~0U);
as pointed out by Linus it might be desirable to have this be a part of
close_range() itself under a new flag CLOSE_RANGE_UNSHARE which gets especially
handy when we're closing all file descriptors above a certain threshold.

Test-suite as always included.

/* Testing */
All patches are based on v5.8-rc1 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
There was no merge conflict doing a test-merge with current mainline at
bcf876870b95 ("Linux 5.8"). However, I expect that there's a chance of
conflicts as soon as any other syscall lands. close_range() might be lucky
though since it had its syscall number 436 effectively reserved since 2019.

There's a trivial merge conflict with the seccomp tree reported by Stephen at
https://lore.kernel.org/lkml/20200710161806.28d8c856@canb.auug.org.au . The
relevant seccomp pr is at
https://lore.kernel.org/lkml/202008031231.0D9CBD0FD@keescook
Stephen's suggested fix seems correct:

diff --cc fs/file.c
index 4fb111735d1d,340bc9569f9d..000000000000
--- a/fs/file.c
+++ b/fs/file.c
@@@ -18,7 -19,7 +19,8 @@@
  #include <linux/bitops.h>
  #include <linux/spinlock.h>
  #include <linux/rcupdate.h>
 +#include <net/sock.h>
+ #include <linux/close_range.h>

  unsigned int sysctl_nr_open __read_mostly = 1024*1024;
  unsigned int sysctl_nr_open_min = BITS_PER_LONG;

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-v5.9

for you to fetch changes up to a5161eeef97cb0cdc4de966005926db2f5894af4:

  tests: add CLOSE_RANGE_UNSHARE tests (2020-06-17 00:07:38 +0200)

Please consider pulling these changes from the signed close-range-v5.9 tag.

Thanks!
Christian

----------------------------------------------------------------
close-range-v5.9

----------------------------------------------------------------
Christian Brauner (5):
      open: add close_range()
      arch: wire-up close_range()
      tests: add close_range() tests
      close_range: add CLOSE_RANGE_UNSHARE
      tests: add CLOSE_RANGE_UNSHARE tests

 arch/alpha/kernel/syscalls/syscall.tbl          |   1 +
 arch/arm/tools/syscall.tbl                      |   1 +
 arch/arm64/include/asm/unistd32.h               |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl           |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl           |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl       |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl       |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl       |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl         |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl        |   1 +
 arch/s390/kernel/syscalls/syscall.tbl           |   1 +
 arch/sh/kernel/syscalls/syscall.tbl             |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl          |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl          |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl          |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl         |   1 +
 fs/file.c                                       | 121 +++++++++++--
 fs/open.c                                       |  17 ++
 include/linux/fdtable.h                         |   6 +-
 include/linux/syscalls.h                        |   2 +
 include/uapi/asm-generic/unistd.h               |   2 +
 include/uapi/linux/close_range.h                |   9 +
 kernel/fork.c                                   |  11 +-
 tools/testing/selftests/Makefile                |   1 +
 tools/testing/selftests/core/.gitignore         |   1 +
 tools/testing/selftests/core/Makefile           |   7 +
 tools/testing/selftests/core/close_range_test.c | 227 ++++++++++++++++++++++++
 28 files changed, 405 insertions(+), 17 deletions(-)
 create mode 100644 include/uapi/linux/close_range.h
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c
