Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF37EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F248207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eREfi5RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHCTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHCTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:39:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E442C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:39:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p1so21423963pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iV0ix59tHBiHlPppAf98OhjAhUR5NVxce2jt2QOLu0A=;
        b=eREfi5RAVfmhcj2ir2mWLs5RxA2c8emjnX3r1YEhI33kQfenMJ/uz9gVIuurB4NwsT
         lwI/ZN5yhZ4OCMOFn4zJTRwuifWjXIWxXfevLocUgHOe2GEVK0DT/8jO26jYNKTjszVz
         /nM1h382iFtn5cDsCfctF2rW8iJl7e6FRrcTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iV0ix59tHBiHlPppAf98OhjAhUR5NVxce2jt2QOLu0A=;
        b=Zq5y9I03+LZMjGBc/4Nio3OBL9qSZ4Bx5UJdDmHwbTY8tiTEIlXoMrx8y6yZR/Q2eH
         HHFda5Ko118ZODoQBWVwS6PgK9jk5cA/F1yu4PaXqVa085+EazLqdsV7O9lpvLwVU/sV
         rxGn0Mz++TRptRZ2xmtKBgxu1LDjkTEe+12EhprruoRZXShLnMt0c30PABXQKKVr/mnY
         4cz9kScdH/5c7QVP4C4jK8lrn/Nd4bsPwuQo768kffo/tUUa2mkBi1CedUz3+cSsSY3C
         Xnu7EMumVpc2aWEC27mHCTyXvs6FYJDraXmX5IEZ+alHg7sM7FXbdYT0IN2Ym+LnjFMN
         M+Fg==
X-Gm-Message-State: AOAM532FYgJkZMWsuG59/APZU0yj4xyhuexm3b4QnK60ehrEh930MIq1
        unbw1sVYbrycm1R7KhzsUqbyew==
X-Google-Smtp-Source: ABdhPJzE+qq1OoPlykLp7XJQgAhu4z2vHydfwOE295y+6i6vAiil+dqqcrXTT4+OmKuOZC9eg2cIWg==
X-Received: by 2002:a17:90b:3597:: with SMTP id mm23mr796375pjb.3.1596483572117;
        Mon, 03 Aug 2020 12:39:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y128sm6693148pfy.74.2020.08.03.12.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:39:31 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:39:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: [GIT PULL] seccomp updates for v5.9-rc1
Message-ID: <202008031231.0D9CBD0FD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.9-rc1. There are a bunch of
clean ups and selftest improvements along with two major updates to the
SECCOMP_RET_USER_NOTIF filter return: EPOLLHUP support to more easily
detect the death of a monitored process, and being able to inject fds when
intercepting syscalls that expect an fd-opening side-effect (needed by
both container folks and Chrome). The latter continued the refactoring
of __scm_install_fd() started by Christoph, and in the process found
and fixed a handful of bugs in various callers.

Thanks!

-Kees

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc1

for you to fetch changes up to c97aedc52dce4c87d4c44de4e6af941cd102600c:

  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD (2020-07-14 16:30:22 -0700)

----------------------------------------------------------------
seccomp updates for v5.9-rc1

- Improved selftest coverage, timeouts, and reporting
- Add EPOLLHUP support for SECCOMP_RET_USER_NOTIF (Christian Brauner)
- Refactor __scm_install_fd() into __receive_fd() and fix buggy callers
- Introduce "addfd" command for SECCOMP_RET_USER_NOTIF (Sargun Dhillon)

----------------------------------------------------------------
Christian Brauner (5):
      seccomp: rename "usage" to "refs" and document
      seccomp: release filter after task is fully dead
      seccomp: Lift wait_queue into struct seccomp_filter
      seccomp: notify about unused filter
      selftests/seccomp: Check for EPOLLHUP for user_notif

Kees Cook (21):
      selftests/seccomp: Rename XFAIL to SKIP
      selftests/seccomp: Add SKIPs for failed unshare()
      selftests/seccomp: Set NNP for TSYNC ESRCH flag test
      seccomp: Report number of loaded filters in /proc/$pid/status
      selftests/seccomp: Expand benchmark to per-filter measurements
      selftests/seccomp: Improve calibration loop
      seccomp: Use pr_fmt
      selftests/seccomp: Make kcmp() less required
      selftests/seccomp: Rename user_trap_syscall() to user_notif_syscall()
      seccomp: Fix ioctl number for SECCOMP_IOCTL_NOTIF_ID_VALID
      seccomp: Use -1 marker for end of mode 1 syscall list
      selftests/harness: Clean up kern-doc for fixtures
      selftests/seccomp: Refactor to use fixture variants
      selftests/seccomp: Check ENOSYS under tracing
      net/compat: Add missing sock updates for SCM_RIGHTS
      pidfd: Add missing sock updates for pidfd_getfd()
      net/scm: Regularize compat handling of scm_detach_fds()
      fs: Move __scm_install_fd() to __receive_fd()
      fs: Add receive_fd() wrapper for __receive_fd()
      pidfd: Replace open-coded receive_fd()
      fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (3):
      seccomp: Add find_notification helper
      seccomp: Introduce addfd ioctl to seccomp user notifier
      selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

Thadeu Lima de Souza Cascardo (1):
      selftests/seccomp: use 90s as timeout

 arch/mips/include/asm/seccomp.h                    |   4 +-
 fs/file.c                                          |  61 ++
 fs/proc/array.c                                    |   2 +
 include/asm-generic/seccomp.h                      |   2 +-
 include/linux/file.h                               |  19 +
 include/linux/seccomp.h                            |  10 +-
 include/net/sock.h                                 |   4 +
 include/uapi/linux/seccomp.h                       |  25 +-
 init/init_task.c                                   |   3 +
 kernel/exit.c                                      |   1 +
 kernel/fork.c                                      |   1 -
 kernel/pid.c                                       |  14 +-
 kernel/seccomp.c                                   | 376 ++++++++---
 net/compat.c                                       |  55 +-
 net/core/scm.c                                     |  50 +-
 net/core/sock.c                                    |  21 +
 tools/testing/selftests/kselftest_harness.h        |  15 +-
 tools/testing/selftests/seccomp/config             |   1 +
 .../testing/selftests/seccomp/seccomp_benchmark.c  |  80 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 708 +++++++++++++++------
 tools/testing/selftests/seccomp/settings           |   1 +
 21 files changed, 1061 insertions(+), 392 deletions(-)
 create mode 100644 tools/testing/selftests/seccomp/settings

-- 
Kees Cook
