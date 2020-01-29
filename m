Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51586C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149802070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgA2Ra1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:30:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Ra0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:30:26 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iwrAV-0005bk-4C; Wed, 29 Jan 2020 17:30:23 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.6
Date:   Wed, 29 Jan 2020 18:26:44 +0100
Message-Id: <20200129172641.941614-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the thread management changes for v5.6.

/* Summary */
Sargun Dhillon over the last cycle has worked on the pidfd_getfd() syscall.
This syscall allows for the retrieval of file descriptors of a process
based on its pidfd. A task needs to have ptrace_may_access() permissions 
with PTRACE_MODE_ATTACH_REALCREDS (suggested by Oleg and Andy) on the target.
One of the main use-cases is in combination with seccomp's user notification
feature. As a reminder, seccomp's user notification feature was made available
in v5.0. It allows a task to retrieve a file descriptor for its seccomp filter.
The file descriptor is usually handed of to a more privileged supervising
process. The supervisor can then listen for syscall events caught by the
seccomp filter of the supervisee and perform actions in lieu of the supervisee,
usually emulating syscalls. pidfd_getfd() is needed to expand its uses.
There are currently two major users that wait on pidfd_getfd() and one future
user:
- Netflix, Sargun said, is working on a service mesh where users should be able
  to connect to a dns-based VIP. When a user connects to e.g. 1.2.3.4:80 that
  runs e.g.  service "foo" they will be redirected to an envoy process. This
  service mesh uses seccomp user notifications and pidfd to intercept all
  connect calls and instead of connecting them to 1.2.3.4:80 connects them to
  e.g. 127.0.0.1:8080.
- LXD uses the seccomp notifier heavily to intercept and emulate mknod()
  and mount() syscalls for unprivileged containers/processes. With
  pidfd_getfd() more uses-cases e.g. bridging socket connections will be
  possible.
- The patchset has also seen some interest from the browser corner. Right now,
  Firefox is using a SECCOMP_RET_TRAP sandbox managed by a broker process. In
  the future glibc will start blocking all signals during dlopen() rendering
  this type of sandbox impossible. Hence, in the future Firefox will switch to
  a seccomp-user-nofication based sandbox which also makes use of file
  descriptor retrieval. The thread for this can be found at
  https://sourceware.org/ml/libc-alpha/2019-12/msg00079.html
With pidfd_getfd() it is e.g. possible to bridge socket connections for the
supervisee (binding to a privileged port) and taking actions on file
descriptors on behalf of the supervisee in general.
Sargun's first version was using an ioctl on pidfds but various people pushed
for it to be a proper syscall which he duely implemented as well over various
review cycles. Selftests are of course included. I've also added instructions
how to deal with merge conflicts below.

There's a small fix coming from the kernel mentee project to correctly annotate
struct sighand_struct with __rcu to fix various sparse warnings. We've received
a few more such fixes and even though they are mostly trivial I've decided to
postpone them until after -rc1 since they came in rather late and I don't want
to risk introducing build warnings.

There's a new prctl() command PR_{G,S}ET_IO_FLUSHER which is needed to avoid
allocation recursions triggerable by storage drivers that have userspace parts
that run in the IO path (e.g. dm-multipath, iscsi, etc.). These allocation
recursions deadlock the device. The new prctl() allows such privileged
userspace components to avoid allocation recursions by setting the
PF_MEMALLOC_NOIO and PF_LESS_THROTTLE flags. The patch carries the necessary
acks from the relevant maintainers and is routed here as part of prctl()
thread-management.

This is the full pull request including Sargun's pidfd_getfd() syscall
patchset. In case you decide not wanting to merge the syscall I've created a
tag without the associated patches:
git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/thread_updates_v5.6
More details below.
(I'll be at FOSDEM over the weekend running a devroom and I'm starting to be
away for that tomorrow before lunch already so there might be some delay in my
responses but I'm keeping an eye out for any questions you might have.)

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.6

for you to fetch changes up to 8d19f1c8e1937baf74e1962aae9f90fa3aeab463:

  prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim (2020-01-28 10:09:51 +0100)

/* Testing */
All patches are based on v5.5-rc5 and have been sitting in linux-next.
No build failures or warnings were observed.
All old and new tests are passing.

/* Conflicts */
With the pidfd_getfd() syscall patches included there is a merge conflict
depending on the order in which you merge with Al's work.openat2 PR he posted
just now:
https://lkml.org/lkml/2020/1/29/378
- Merging openat2() first, pidfd_getfd() second
  There will be a small conflict with m68k since this architecture now
  implements the clone3() syscall. This conflict can be resolved as shown in [3].
  There'll then be a follow up merge conflict when you merge in the openat2()
  syscall through Al's tree. This conflict can be resolved as shown in [4].
- Merging pidfd_getfd() first, openat2() second
  There will be a small conflict with m68k since this architecture now
  implements the clone3() syscall. This conflict can be resolved as shown in [1].
  There'll then be a follow up merge conflict when you merge in the openat2()
  syscall through Al's tree. This conflict can be resolved as shown in [2].

Please consider pulling these changes from the signed threads-v5.6 tag.

Thanks!
Christian

----------------------------------------------------------------
threads-v5.6

----------------------------------------------------------------
Madhuparna Bhowmik (1):
      sched.h: Annotate sighand_struct with __rcu

Mike Christie (1):
      prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim

Sargun Dhillon (4):
      vfs, fdtable: Add fget_task helper
      pid: Implement pidfd_getfd syscall
      arch: wire up pidfd_getfd syscall
      test: Add test for pidfd getfd

 arch/alpha/kernel/syscalls/syscall.tbl           |   1 +
 arch/arm/tools/syscall.tbl                       |   1 +
 arch/arm64/include/asm/unistd.h                  |   2 +-
 arch/arm64/include/asm/unistd32.h                |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl            |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl            |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl      |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl        |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl          |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl         |   1 +
 arch/s390/kernel/syscalls/syscall.tbl            |   1 +
 arch/sh/kernel/syscalls/syscall.tbl              |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl           |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl           |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl           |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl          |   1 +
 fs/file.c                                        |  22 +-
 include/linux/file.h                             |   2 +
 include/linux/sched.h                            |   2 +-
 include/linux/syscalls.h                         |   1 +
 include/uapi/asm-generic/unistd.h                |   4 +-
 include/uapi/linux/capability.h                  |   1 +
 include/uapi/linux/prctl.h                       |   4 +
 kernel/pid.c                                     |  90 ++++++++
 kernel/signal.c                                  |   2 +-
 kernel/sys.c                                     |  25 +++
 tools/testing/selftests/pidfd/.gitignore         |   1 +
 tools/testing/selftests/pidfd/Makefile           |   2 +-
 tools/testing/selftests/pidfd/pidfd.h            |   9 +
 tools/testing/selftests/pidfd/pidfd_getfd_test.c | 249 +++++++++++++++++++++++
 32 files changed, 427 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

----------------------------------------------------------------

[1]: m68k conflict
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index a00a5d0db602,44e879e98459..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -434,4 -434,5 +434,5 @@@
  432   common  fsmount                         sys_fsmount
  433   common  fspick                          sys_fspick
  434   common  pidfd_open                      sys_pidfd_open
 -# 435 reserved for clone3
 +435   common  clone3                          __sys_clone3
+ 438   common  pidfd_getfd                     sys_pidfd_getfd

[2]: merging pidfd_getfd() first, openat2() second:

diff --cc arch/alpha/kernel/syscalls/syscall.tbl
index 82301080f5e7,4d7f2ffa957c..000000000000
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@@ -475,4 -475,4 +475,5 @@@
  543	common	fspick				sys_fspick
  544	common	pidfd_open			sys_pidfd_open
  # 545 reserved for clone3
+ 547	common	openat2				sys_openat2
 +548	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/arm/tools/syscall.tbl
index ba045e2f3a60,4ba54bc7e19a..000000000000
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@@ -449,4 -449,4 +449,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/arm64/include/asm/unistd.h
index 1dd22da1c3a9,8aa00ccb0b96..000000000000
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
diff --cc arch/arm64/include/asm/unistd32.h
index a8da97a2de41,57f6f592d460..000000000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -879,8 -879,8 +879,10 @@@ __SYSCALL(__NR_fspick, sys_fspick
  __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
  #define __NR_clone3 435
  __SYSCALL(__NR_clone3, sys_clone3)
+ #define __NR_openat2 437
+ __SYSCALL(__NR_openat2, sys_openat2)
 +#define __NR_pidfd_getfd 438
 +__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
  
  /*
   * Please add new compat syscalls above this comment and update
diff --cc arch/ia64/kernel/syscalls/syscall.tbl
index 2b11adfc860c,8d36f2e2dc89..000000000000
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@@ -356,4 -356,4 +356,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index f1d40a13ef31,2559925f1924..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -434,5 -434,5 +434,6 @@@
  432	common	fsmount				sys_fsmount
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
 -# 435 reserved for clone3
 +435	common	clone3				__sys_clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/microblaze/kernel/syscalls/syscall.tbl
index 7afa00125cc4,c04385e60833..000000000000
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@@ -441,4 -441,4 +441,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_n32.tbl
index 856d5ba34461,68c9ec06851f..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@@ -374,4 -374,4 +374,5 @@@
  433	n32	fspick				sys_fspick
  434	n32	pidfd_open			sys_pidfd_open
  435	n32	clone3				__sys_clone3
+ 437	n32	openat2				sys_openat2
 +438	n32	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_n64.tbl
index 2db6075352f3,42a72d010050..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@@ -350,4 -350,4 +350,5 @@@
  433	n64	fspick				sys_fspick
  434	n64	pidfd_open			sys_pidfd_open
  435	n64	clone3				__sys_clone3
+ 437	n64	openat2				sys_openat2
 +438	n64	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_o32.tbl
index e9f9d4a9b105,f114c4aed0ed..000000000000
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@@ -423,4 -423,4 +423,5 @@@
  433	o32	fspick				sys_fspick
  434	o32	pidfd_open			sys_pidfd_open
  435	o32	clone3				__sys_clone3
+ 437	o32	openat2				sys_openat2
 +438	o32	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/parisc/kernel/syscalls/syscall.tbl
index c58c7eb144ca,b550ae9a7fea..000000000000
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@@ -433,4 -433,4 +433,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3_wrapper
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/powerpc/kernel/syscalls/syscall.tbl
index 707609bfe3ea,a8b5ecb5b602..000000000000
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@@ -517,4 -517,4 +517,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	nospu	clone3				ppc_clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/s390/kernel/syscalls/syscall.tbl
index 185cd624face,16b571c06161..000000000000
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@@ -438,4 -438,4 +438,5 @@@
  433  common	fspick			sys_fspick			sys_fspick
  434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
  435  common	clone3			sys_clone3			sys_clone3
+ 437  common	openat2			sys_openat2			sys_openat2
 +438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
diff --cc arch/sh/kernel/syscalls/syscall.tbl
index 88f90895aad8,a7185cc18626..000000000000
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@@ -438,4 -438,4 +438,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/sparc/kernel/syscalls/syscall.tbl
index 218df6a2326e,b11c19552022..000000000000
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@@ -481,4 -481,4 +481,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
+ 437	common	openat2			sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index 9c3101b65e0f,d22a8b5c3fab..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -440,4 -440,4 +440,5 @@@
  433	i386	fspick			sys_fspick			__ia32_sys_fspick
  434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
  435	i386	clone3			sys_clone3			__ia32_sys_clone3
+ 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 +438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index cef85db75a62,9035647ef236..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -357,7 -357,7 +357,8 @@@
  433	common	fspick			__x64_sys_fspick
  434	common	pidfd_open		__x64_sys_pidfd_open
  435	common	clone3			__x64_sys_clone3/ptregs
+ 437	common	openat2			__x64_sys_openat2
 +438	common	pidfd_getfd		__x64_sys_pidfd_getfd
  
  #
  # x32-specific system call numbers start at 512 to avoid cache impact
diff --cc arch/xtensa/kernel/syscalls/syscall.tbl
index ae15183def12,f0a68013c038..000000000000
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@@ -406,4 -406,4 +406,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
+ 437	common	openat2				sys_openat2
 +438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc include/uapi/asm-generic/unistd.h
index d36ec3d645bd,d4122c091472..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -850,11 -850,12 +850,14 @@@ __SYSCALL(__NR_pidfd_open, sys_pidfd_op
  #define __NR_clone3 435
  __SYSCALL(__NR_clone3, sys_clone3)
  #endif
 +#define __NR_pidfd_getfd 438
 +__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
  
+ #define __NR_openat2 437
+ __SYSCALL(__NR_openat2, sys_openat2)
+ 
  #undef __NR_syscalls
 -#define __NR_syscalls 438
 +#define __NR_syscalls 439
  
  /*
   * 32 bit systems traditionally used different

[3]: 
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index a00a5d0db602,2559925f1924..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -434,4 -434,5 +434,5 @@@
  432   common  fsmount                         sys_fsmount
  433   common  fspick                          sys_fspick
  434   common  pidfd_open                      sys_pidfd_open
 -# 435 reserved for clone3
 +435   common  clone3                          __sys_clone3
+ 437   common  openat2                         sys_openat2

[4]:
diff --cc arch/alpha/kernel/syscalls/syscall.tbl
index 4d7f2ffa957c,82301080f5e7..000000000000
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@@ -475,4 -475,4 +475,5 @@@
  543	common	fspick				sys_fspick
  544	common	pidfd_open			sys_pidfd_open
  # 545 reserved for clone3
 +547	common	openat2				sys_openat2
+ 548	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/arm/tools/syscall.tbl
index 4ba54bc7e19a,ba045e2f3a60..000000000000
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@@ -449,4 -449,4 +449,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/arm64/include/asm/unistd.h
index 0f255a23733d,b722e47377a5..000000000000
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
diff --cc arch/arm64/include/asm/unistd32.h
index 57f6f592d460,a8da97a2de41..000000000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -879,8 -879,8 +879,10 @@@ __SYSCALL(__NR_fspick, sys_fspick
  __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
  #define __NR_clone3 435
  __SYSCALL(__NR_clone3, sys_clone3)
 +#define __NR_openat2 437
 +__SYSCALL(__NR_openat2, sys_openat2)
+ #define __NR_pidfd_getfd 438
+ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
  
  /*
   * Please add new compat syscalls above this comment and update
diff --cc arch/ia64/kernel/syscalls/syscall.tbl
index 8d36f2e2dc89,2b11adfc860c..000000000000
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@@ -356,4 -356,4 +356,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index b911e0f50a71,44e879e98459..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -434,5 -434,5 +434,6 @@@
  432	common	fsmount				sys_fsmount
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
 -# 435 reserved for clone3
 +435	common	clone3				__sys_clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/microblaze/kernel/syscalls/syscall.tbl
index c04385e60833,7afa00125cc4..000000000000
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@@ -441,4 -441,4 +441,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_n32.tbl
index 68c9ec06851f,856d5ba34461..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@@ -374,4 -374,4 +374,5 @@@
  433	n32	fspick				sys_fspick
  434	n32	pidfd_open			sys_pidfd_open
  435	n32	clone3				__sys_clone3
 +437	n32	openat2				sys_openat2
+ 438	n32	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_n64.tbl
index 42a72d010050,2db6075352f3..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@@ -350,4 -350,4 +350,5 @@@
  433	n64	fspick				sys_fspick
  434	n64	pidfd_open			sys_pidfd_open
  435	n64	clone3				__sys_clone3
 +437	n64	openat2				sys_openat2
+ 438	n64	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/mips/kernel/syscalls/syscall_o32.tbl
index f114c4aed0ed,e9f9d4a9b105..000000000000
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@@ -423,4 -423,4 +423,5 @@@
  433	o32	fspick				sys_fspick
  434	o32	pidfd_open			sys_pidfd_open
  435	o32	clone3				__sys_clone3
 +437	o32	openat2				sys_openat2
+ 438	o32	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/parisc/kernel/syscalls/syscall.tbl
index b550ae9a7fea,c58c7eb144ca..000000000000
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@@ -433,4 -433,4 +433,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3_wrapper
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/powerpc/kernel/syscalls/syscall.tbl
index a8b5ecb5b602,707609bfe3ea..000000000000
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@@ -517,4 -517,4 +517,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	nospu	clone3				ppc_clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/s390/kernel/syscalls/syscall.tbl
index 16b571c06161,185cd624face..000000000000
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@@ -438,4 -438,4 +438,5 @@@
  433  common	fspick			sys_fspick			sys_fspick
  434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
  435  common	clone3			sys_clone3			sys_clone3
 +437  common	openat2			sys_openat2			sys_openat2
+ 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
diff --cc arch/sh/kernel/syscalls/syscall.tbl
index a7185cc18626,88f90895aad8..000000000000
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@@ -438,4 -438,4 +438,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/sparc/kernel/syscalls/syscall.tbl
index b11c19552022,218df6a2326e..000000000000
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@@ -481,4 -481,4 +481,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  # 435 reserved for clone3
 +437	common	openat2			sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index d22a8b5c3fab,9c3101b65e0f..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -440,4 -440,4 +440,5 @@@
  433	i386	fspick			sys_fspick			__ia32_sys_fspick
  434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
  435	i386	clone3			sys_clone3			__ia32_sys_clone3
 +437	i386	openat2			sys_openat2			__ia32_sys_openat2
+ 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 9035647ef236,cef85db75a62..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -357,7 -357,7 +357,8 @@@
  433	common	fspick			__x64_sys_fspick
  434	common	pidfd_open		__x64_sys_pidfd_open
  435	common	clone3			__x64_sys_clone3/ptregs
 +437	common	openat2			__x64_sys_openat2
+ 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
  
  #
  # x32-specific system call numbers start at 512 to avoid cache impact
diff --cc arch/xtensa/kernel/syscalls/syscall.tbl
index f0a68013c038,ae15183def12..000000000000
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@@ -406,4 -406,4 +406,5 @@@
  433	common	fspick				sys_fspick
  434	common	pidfd_open			sys_pidfd_open
  435	common	clone3				sys_clone3
 +437	common	openat2				sys_openat2
+ 438	common	pidfd_getfd			sys_pidfd_getfd
diff --cc include/uapi/asm-generic/unistd.h
index d4122c091472,d36ec3d645bd..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -850,12 -850,11 +850,14 @@@ __SYSCALL(__NR_pidfd_open, sys_pidfd_op
  #define __NR_clone3 435
  __SYSCALL(__NR_clone3, sys_clone3)
  #endif
+ #define __NR_pidfd_getfd 438
+ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
  
 +#define __NR_openat2 437
 +__SYSCALL(__NR_openat2, sys_openat2)
 +
  #undef __NR_syscalls
- #define __NR_syscalls 438
+ #define __NR_syscalls 439
  
  /*
   * 32 bit systems traditionally used different

