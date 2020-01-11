Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3EC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6EB2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgAKSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 13:23:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53404 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgAKSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 13:23:45 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iqLQF-0000Rh-51; Sat, 11 Jan 2020 18:23:43 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.5-rc6
Date:   Sat, 11 Jan 2020 19:23:30 +0100
Message-Id: <20200111182330.27309-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This pull request contains a series of patches to fix CLONE_SETTLS when used
with clone3().
The clone3() syscall passes the tls argument through struct clone_args instead
of a register. This means, all architectures that do not implement
copy_thread_tls() but still support CLONE_SETTLS via copy_thread() expecting
the tls to be located in a register argument based on clone() are currently
unfortunately broken. Their tls value will be garbage.
The patch series I got sent fixes this on all architectures that currently
define __ARCH_WANT_SYS_CLONE3. It also adds a compile-time check to ensure that
any architecture that enables clone3() in the future is forced to also
implement copy_thread_tls().

My ultimate goal is to get rid of the copy_thread()/copy_thread_tls() split and
just have copy_thread_tls() at some point in the not too distant future (Maybe
even renaming copy_thread_tls() back to simply copy_thread() once the old
function is ripped from all arches). This is dependent now on all arches
supporting clone3(). While all relevant arches do that now there are still four
missing:
arch/ia64/kernel/syscalls/syscall.tbl:# 435 reserved for clone3
arch/m68k/kernel/syscalls/syscall.tbl:# 435 reserved for clone3
arch/sh/kernel/syscalls/syscall.tbl:# 435 reserved for clone3
arch/sparc/kernel/syscalls/syscall.tbl:# 435 reserved for clone3
Once they all implement clone3() we can get rid of ARCH_WANT_SYS_CLONE3 and
HAVE_COPY_THREAD_TLS.

This series also includes a minor fix for the arm64 uapi headers which caused
__NR_clone3 to be missing from the exported user headers.

Unfortunately the series came in a little late especially given that it touches
a range of architectures. Due to the holidays not all arch maintainers
responded in time probably due to their backlog. Will and Arnd have thankfully
acked the arm specific changes.
Given that the changes are straightforward and rather minimal combined with the
fact the that clone3() with CLONE_SETTLS is broken I decided to send them post
rc3 nonetheless. If you find this to be too late I can resend for the next
merge window but note that this means we need to backport the fixes to 5.5,
5.4, and 5.3 instead of just 5.4 and 5.3.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.5-rc5.
The clone3 selftests passed. We will likely add more tests for CLONE_SETTLS in
the future but since this is highly architecture dependent we first need to
settle on how to test this easily (Some ideas are already discussed.).

/* Conflicts */
There was a minor merge conflict with a change to riscv's Kconfig but doing a
test merge with current mainline I was not able to reproduce it.

Please consider pulling these changes from the signed clone3-tls-v5.5-rc6 tag.

Thanks!
Christian

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/clone3-tls-v5.5-rc6

for you to fetch changes up to 457677c70c7672a4586b0b8abc396cc1ecdd376d:

  um: Implement copy_thread_tls (2020-01-07 13:31:29 +0100)

----------------------------------------------------------------
clone3-tls-v5.5-rc6

----------------------------------------------------------------
Amanieu d'Antras (8):
      arm64: Move __ARCH_WANT_SYS_CLONE3 definition to uapi headers
      arm64: Implement copy_thread_tls
      arm: Implement copy_thread_tls
      parisc: Implement copy_thread_tls
      riscv: Implement copy_thread_tls
      xtensa: Implement copy_thread_tls
      clone3: ensure copy_thread_tls is implemented
      um: Implement copy_thread_tls

 arch/arm/Kconfig                     |  1 +
 arch/arm/kernel/process.c            |  6 +++---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/unistd.h      |  1 -
 arch/arm64/include/uapi/asm/unistd.h |  1 +
 arch/arm64/kernel/process.c          | 10 +++++-----
 arch/parisc/Kconfig                  |  1 +
 arch/parisc/kernel/process.c         |  8 ++++----
 arch/riscv/Kconfig                   |  1 +
 arch/riscv/kernel/process.c          |  6 +++---
 arch/um/Kconfig                      |  1 +
 arch/um/include/asm/ptrace-generic.h |  2 +-
 arch/um/kernel/process.c             |  6 +++---
 arch/x86/um/tls_32.c                 |  6 ++----
 arch/x86/um/tls_64.c                 |  7 +++----
 arch/xtensa/Kconfig                  |  1 +
 arch/xtensa/kernel/process.c         |  8 ++++----
 kernel/fork.c                        | 10 ++++++++++
 18 files changed, 45 insertions(+), 32 deletions(-)
