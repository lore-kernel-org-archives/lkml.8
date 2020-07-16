Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229092074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgGPTbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:31:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgGPTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:31:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 750E12A5A2D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 0/2] Syscall User Redirection
Date:   Thu, 16 Jul 2020 15:31:39 -0400
Message-Id: <20200716193141.4068476-1-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of Syscall User Redirection.  The implementation itself is
not modified from v3, it only applies the latest round of reviews to the
selftests.

__NR_syscalls is not really exported in header files other than
asm-generic for every architecture, so it felt safer to optionally
expose it with a fallback to a high value.

Also, I didn't expose tests for PR_GET as that is not currently
implemented.  If possible, I'd have it supported by a future patchset,
since it is not immediately necessary to support this feature.

Finally, one question: Which tree would this go through?

Gabriel Krisman Bertazi (2):
  kernel: Implement selective syscall userspace redirection
  selftests: Add kselftest for syscall user dispatch

 arch/Kconfig                                  |  20 ++
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/common.c                       |   5 +
 arch/x86/include/asm/thread_info.h            |   4 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/exec.c                                     |   2 +
 include/linux/sched.h                         |   3 +
 include/linux/syscall_user_dispatch.h         |  50 ++++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/prctl.h                    |   5 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |   1 +
 kernel/sys.c                                  |   5 +
 kernel/syscall_user_dispatch.c                |  92 +++++++
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   2 +
 .../selftests/syscall_user_dispatch/Makefile  |   9 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch.c                   | 256 ++++++++++++++++++
 19 files changed, 460 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c

-- 
2.27.0

