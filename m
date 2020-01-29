Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7440C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6420678
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA2N4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:56:13 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:49025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2N4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:56:13 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQNAv-1j9oUt3FD7-00MMtj for <linux-kernel@vger.kernel.org>; Wed, 29 Jan
 2020 14:56:11 +0100
Received: by mail-qk1-f180.google.com with SMTP id g195so17007747qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:56:10 -0800 (PST)
X-Gm-Message-State: APjAAAVBdGSK0sSblBmNqVur0enShaaGwNKIZWhQREJkj4lUJbrH6PXg
        A9/qcB5u4eM4EQbWlOw4sQeBvAsfODyEOEip5bs=
X-Google-Smtp-Source: APXvYqxFzL3SEIsoHK/TVAK3Pf8SLbOj5zKY4UTHIqzsgz3QPz/7Soj/WBXG3jiYzlthB0DII9kNCq+EBMrZZ8TMMz8=
X-Received: by 2002:a37:94d:: with SMTP id 74mr23509538qkj.352.1580306169569;
 Wed, 29 Jan 2020 05:56:09 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jan 2020 14:55:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2iZyA1VSFqvcEc9o59F76GgzLBiOAmEuHKD81FErPLDQ@mail.gmail.com>
Message-ID: <CAK8P3a2iZyA1VSFqvcEc9o59F76GgzLBiOAmEuHKD81FErPLDQ@mail.gmail.com>
Subject: [GIT PULL] y2038: core, driver and file system changes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/fW95xeJPDfaCgxumMoFY6VpWl08frmjvVPjNgpCFuMVAovKdq1
 Mr8T8gUZRpyN0FnS2arz/qMc7xKqsaCsXDHfGnHUcC7vDzTK1SRagD5NOOe0eQPlV3NnfYe
 xbG89DTxhoVj2mdxHuSt4kX9o5qN8anRMsxJ5dzeMO83uUTVC/PYgsR/mtV50YPToQykpAu
 hLCw9sxuUUGDJLrxGOxEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TBMO/eZ+TeM=:Hcy5cITGfzYiICTexfK4ax
 lzR/8mhkttaS+LOmBmxQNQBGiX9x3a1NFTDglmN4fyt+zQhFYuLBW6QPwVMHSgx+1su0eGQNq
 QfJushKuOXZarV7oG2I1v2N4lm8GmI9G8sGlfAYH/yjE6AEZC30nLSo+nKKGGPElkL+Rn7lwi
 TLJwWfmKP856ouQWO3T47+WofCnLZhEgAI12UfPuTBe4C8r5BchlaSJrWUbnqbptt/UV9HKLL
 88+TdTG76to3GZJncec8aTGj2gf26y71y0i/a/fdugZ1zx51P0liKppAt6RT7i06eF9NT4nUJ
 fQXa0E/HqCTBFoS0PF8XVKoo6ejlLGu0m+TnJqWmi/pT6D1Ly3q30OUCxs+5v8/n4JniEa+7y
 l9AP1RzukSJbb1gJD8Fz+tqZCK1UYtFFYV47Zcvxc4RSJkedC82cEU7z2D4dYT0DI126Yunmx
 1LMta4BswsEVa5Y/knpd84Lq8oI/BFKL6ZLkzqztVC5RlfNeHg4YvCEZIErNcSg+wE5Ps2dVV
 gRJONkIO24cXS1X2++q/KerO+w20rHNnQyMBz7O7kDFw19W8rRQ7pC3+XVTg6lGDqA6Lx3hE2
 8klgMWF9sCPn7fOKGH7EbJkadTH6d7lMxo74D5kkwkJBfQQJl6fYscHJuOofVMGd+5bXe7uc6
 CZB97Eu374YXoZfOKtkWZvJ3A5OOjxaB9gvITKmoxiicGmrtBNIKDAEYXrHwaH4qG4B4sK1yC
 dd5qh40CIyT5CWoMsPiL+rxoJhBF8HJiYENMTbT2QbaBt7Yv8nx/6MM1SvdM1T4Ykio9Wfosj
 MJ0Em5NPYNrRxIgAPg7z3y/9LO+bbQdkNu/OM7lEdMF3Y7aZ7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-drivers-for-v5.6-signed

for you to fetch changes up to c4e71212a245017d2ab05f322f7722f0b87a55da:

  Revert "drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC"
(2020-01-28 23:24:23 +0100)

----------------------------------------------------------------
y2038: core, driver and file system changes

These are updates to device drivers and file systems that for some reason
or another were not included in the kernel in the previous y2038 series.

I've gone through all users of time_t again to make sure the kernel is
in a long-term maintainable state, replacing all remaining references
to time_t with safe alternatives.

Some related parts of the series were picked up into the nfsd, xfs,
alsa and v4l2 trees. A final set of patches in linux-mm removes the now
unused time_t/timeval/timespec types and helper functions after all five
branches are merged for linux-5.6, ensuring that no new users get merged.

As a result, linux-5.6, or my backport of the patches to 5.4 [1], should
be the first release that can serve as a base for a 32-bit system designed
to run beyond year 2038, with a few remaining caveats:

- All user space must be compiled with a 64-bit time_t, which will be
  supported in the coming musl-1.2 and glibc-2.32 releases, along with
  installed kernel headers from linux-5.6 or higher.

- Applications that use the system call interfaces directly need to be
  ported to use the time64 syscalls added in linux-5.1 in place of the
  existing system calls. This impacts most users of futex() and seccomp()
  as well as programming languages that have their own runtime environment
  not based on libc.

- Applications that use a private copy of kernel uapi header files or
  their contents may need to update to the linux-5.6 version, in
  particular for sound/asound.h, xfs/xfs_fs.h, linux/input.h,
  linux/elfcore.h, linux/sockios.h, linux/timex.h and linux/can/bcm.h.

- A few remaining interfaces cannot be changed to pass a 64-bit time_t
  in a compatible way, so they must be configured to use CLOCK_MONOTONIC
  times or (with a y2106 problem) unsigned 32-bit timestamps. Most
  importantly this impacts all users of 'struct input_event'.

- All y2038 problems that are present on 64-bit machines also apply to
  32-bit machines. In particular this affects file systems with on-disk
  timestamps using signed 32-bit seconds: ext4 with ext3-style small
  inodes, ext2, xfs (to be fixed soon) and ufs.

Changes since v1 [2]:

- Add Acks I received
- Rebase to v5.5-rc1, dropping patches that got merged already
- Add NFS, XFS and the final three patches from another series
- Rewrite etnaviv patches
- Add one late revert to avoid an etnaviv regression

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-endgame
[2] https://lore.kernel.org/lkml/20191108213257.3097633-1-arnd@arndb.de/

----------------------------------------------------------------
Arnd Bergmann (21):
      fat: use prandom_u32() for i_generation
      dlm: use SO_SNDTIMEO_NEW instead of SO_SNDTIMEO_OLD
      xtensa: ISS: avoid struct timeval
      um: ubd: use 64-bit time_t where possible
      acct: stop using get_seconds()
      tsacct: add 64-bit btime field
      packet: clarify timestamp overflow
      hostfs: pass 64-bit timestamps to/from user space
      hfs/hfsplus: use 64-bit inode timestamps
      drm/msm: avoid using 'timespec'
      drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC
      drm/etnaviv: avoid deprecated timespec
      sunrpc: convert to time64_t for expiry
      nfs: use time64_t internally
      nfs: fix timstamp debug prints
      nfs: fscache: use timespec64 in inode auxdata
      y2038: remove obsolete jiffies conversion functions
      y2038: rename itimerval to __kernel_old_itimerval
      y2038: sparc: remove use of struct timex
      y2038: sh: remove timeval/timespec usage from headers
      Revert "drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC"

 arch/sh/include/uapi/asm/sockios.h                 |  4 +-
 arch/sparc/kernel/sys_sparc_64.c                   | 33 ++++++------
 arch/um/drivers/cow.h                              |  2 +-
 arch/um/drivers/cow_user.c                         |  7 +--
 arch/um/drivers/ubd_kern.c                         | 10 ++--
 arch/um/include/shared/os.h                        |  2 +-
 arch/um/os-Linux/file.c                            |  2 +-
 .../platforms/iss/include/platform/simcall.h       |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              | 11 ++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              | 11 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |  5 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |  5 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  3 +-
 fs/dlm/lowcomms.c                                  |  6 +--
 fs/fat/inode.c                                     |  3 +-
 fs/hfs/hfs_fs.h                                    | 28 ++++++++---
 fs/hfs/inode.c                                     |  4 +-
 fs/hfsplus/hfsplus_fs.h                            | 28 +++++++++--
 fs/hfsplus/inode.c                                 | 12 ++---
 fs/hostfs/hostfs.h                                 | 22 ++++----
 fs/hostfs/hostfs_kern.c                            | 15 +++---
 fs/nfs/fscache-index.c                             |  6 ++-
 fs/nfs/fscache.c                                   | 18 ++++---
 fs/nfs/fscache.h                                   |  8 +--
 fs/nfs/nfs4xdr.c                                   | 10 ++--
 include/linux/jiffies.h                            | 20 --------
 include/linux/sunrpc/cache.h                       | 42 +++++++++-------
 include/linux/sunrpc/gss_api.h                     |  4 +-
 include/linux/sunrpc/gss_krb5.h                    |  2 +-
 include/linux/syscalls.h                           |  9 ++--
 include/uapi/linux/acct.h                          |  2 +
 include/uapi/linux/taskstats.h                     |  6 ++-
 include/uapi/linux/time_types.h                    |  5 ++
 include/uapi/linux/timex.h                         |  2 +
 kernel/acct.c                                      |  4 +-
 kernel/time/itimer.c                               | 18 +++----
 kernel/time/time.c                                 | 58 ++--------------------
 kernel/tsacct.c                                    |  9 ++--
 net/packet/af_packet.c                             | 27 ++++++----
 net/sunrpc/auth_gss/gss_krb5_mech.c                | 12 +++--
 net/sunrpc/auth_gss/gss_krb5_seal.c                |  8 +--
 net/sunrpc/auth_gss/gss_krb5_unseal.c              |  6 +--
 net/sunrpc/auth_gss/gss_krb5_wrap.c                | 16 +++---
 net/sunrpc/auth_gss/gss_mech_switch.c              |  2 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |  6 +--
 net/sunrpc/cache.c                                 | 16 +++---
 net/sunrpc/svcauth_unix.c                          | 10 ++--
 49 files changed, 283 insertions(+), 266 deletions(-)
