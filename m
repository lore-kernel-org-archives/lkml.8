Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 04:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013E82072D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 04:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGLEp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 00:45:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLEp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 00:45:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C7A3527DF85
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 0/2] Syscall user redirection
Date:   Sun, 12 Jul 2020 00:45:14 -0400
Message-Id: <20200712044516.2347844-1-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v3 of the syscall user redirection patch, applying the
suggestions from Matthew and Kees.  In particular, it modifies the ABI
to allow passing a range of allowed addresses and introduces kselftests
for the feature.

RFC/v1: https://lkml.org/lkml/2020/7/8/96
v2: https://lkml.org/lkml/2020/7/9/17

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
 .../syscall_user_dispatch/.gitignore          |   1 +
 .../selftests/syscall_user_dispatch/Makefile  |   5 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch.c                   | 259 ++++++++++++++++++
 19 files changed, 458 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/syscall_user_dispatch.c
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/syscall_user_dispatch.c

-- 
2.27.0

