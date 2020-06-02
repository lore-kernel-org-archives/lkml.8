Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC74206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBMUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:20:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33583 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:20:02 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jg5tg-0003e2-En; Tue, 02 Jun 2020 12:20:00 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.8
Date:   Tue,  2 Jun 2020 14:19:21 +0200
Message-Id: <20200602121919.33831-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the changes for v5.8:

/* Summary */
We have been discussing using pidfds to attach to namespaces for quite a while and the patches have
in one form or another already existed for about a year. But I wanted to wait to see how the general
api would be received and adopted.
This pr contains the changes to make it possible to use pidfds to attach to the namespaces of a
process, i.e. they can be passed as the first argument to the setns() syscall. When only a single
namespace type is specified the semantics are equivalent to passing an nsfd. That means
setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However, when a pidfd is passed,
multiple namespace flags can be specified in the second setns() argument and setns() will attach the
caller to all the specified namespaces all at once or to none of them.  Specifying 0 is not valid
together with a pidfd. Here are just two obvious examples:
setns(pidfd, CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET);
setns(pidfd, CLONE_NEWUSER);
Allowing to also attach subsets of namespaces supports various use-cases where callers setns to a
subset of namespaces to retain privilege, perform an action and then re-attach another subset of
namespaces.
Apart from significantly reducing the number of syscalls needed to attach to all currently supported
namespaces (8 * open(/proc/<pid>/ns/<ns>) + 8 * setns(nsfd) vs 1 * setns(pidfd, <ns-flags>) this
also allows atomic setns to a set of namespaces, i.e. either attaching to all namespaces succeeds or
we fail without having changed anything. This is centered around a new internal struct nsset which
holds all information necessary for a task to switch to a new set of namespaces atomically. Fwiw,
with this change a pidfd becomes the only token needed to interact with a container. I'm expecting
this to be picked-up by util-linux for nsenter rather soon. Associated with this change is a shiny
new test-suite dedicated to setns() (for pidfds and nsfds alike).

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.8

for you to fetch changes up to 2b40c5db73e239531ea54991087f4edc07fbb08e:

  selftests/pidfd: add pidfd setns tests (2020-05-13 11:41:22 +0200)

/* Testing */
All patches are based on v5.7-rc4 and have been sitting in linux-next. No build failures or
warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from linux-next and no merge
conflicts showed up doing a test-merge with current mainline 359287765c04 ("Merge branch
'from-miklos' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.

Please consider pulling these changes from the signed threads-v5.8 tag.

Thanks!
Christian

----------------------------------------------------------------
threads-v5.8

----------------------------------------------------------------
Christian Brauner (3):
      nsproxy: add struct nsset
      nsproxy: attach to namespaces via pidfds
      selftests/pidfd: add pidfd setns tests

 fs/namespace.c                                   |  15 +-
 fs/nsfs.c                                        |   5 +
 include/linux/mnt_namespace.h                    |   2 +
 include/linux/nsproxy.h                          |  24 ++
 include/linux/proc_fs.h                          |   2 +
 include/linux/proc_ns.h                          |   4 +-
 ipc/namespace.c                                  |   7 +-
 kernel/cgroup/namespace.c                        |   5 +-
 kernel/nsproxy.c                                 | 305 +++++++++++++--
 kernel/pid_namespace.c                           |   5 +-
 kernel/time/namespace.c                          |   5 +-
 kernel/user_namespace.c                          |   8 +-
 kernel/utsname.c                                 |   5 +-
 net/core/net_namespace.c                         |   5 +-
 tools/testing/selftests/pidfd/.gitignore         |   1 +
 tools/testing/selftests/pidfd/Makefile           |   3 +-
 tools/testing/selftests/pidfd/config             |   6 +
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 473 +++++++++++++++++++++++
 18 files changed, 833 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/config
 create mode 100644 tools/testing/selftests/pidfd/pidfd_setns_test.c
