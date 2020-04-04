Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B65C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5AE20769
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDDLoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 07:44:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDDLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 07:44:13 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jKhDf-0004L2-39; Sat, 04 Apr 2020 11:44:11 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.7
Date:   Sat,  4 Apr 2020 13:43:57 +0200
Message-Id: <20200404114357.1359783-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a simple change for this cycle. The rest being routed through another
tree but see below for that.

/* Summary */
The main changes for this cycle is the extension for clone3() to support
spawning processes directly into cgroups via CLONE_INTO_CGROUP now in mainline
as ef2c41cf38a7 ("clone3: allow spawning processes into cgroups"). Since I had
to touch kernel/cgroup/ quite a bit I had Tejun route it through his tree this
time to make it easier for him to handle other changes and I see that you've
pulled already. So here are just unexciting leftovers.

As promised in addcb1d0ee31 here's a regression test for the ENOMEM regression
we fixed in b26ebfe12f34 ("pid: Fix error return value in some cases")
verifying that we report ENOMEM when trying to create a new process in a pid
namespace whose init process/subreaper has already exited.

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.7

for you to fetch changes up to 6952a4f646446fde9e190b62c5e45f84c6cf91aa:

  selftests: add pid namespace ENOMEM regression test (2020-03-25 13:50:34 +0100)

/* Testing */
All patches are based on v5.6-rc6 and have been sitting in linux-next for a
while. (Full disclosure, I had these patches sitting in my tree locally for
quite longer but missed to merge them into my for-next branch so they have
only been in linux-next for about 10 days but without any issues.)

/* Conflicts */
At the time of creating this PR no merge conflicts were observed in
linux-next.

Please consider pulling these changes from the signed threads-v5.7 tag.

Thanks!
Christian

----------------------------------------------------------------
threads-v5.7

----------------------------------------------------------------
Christian Brauner (1):
      selftests: add pid namespace ENOMEM regression test

 MAINTAINERS                                        |  1 +
 tools/testing/selftests/Makefile                   |  1 +
 tools/testing/selftests/pid_namespace/.gitignore   |  1 +
 tools/testing/selftests/pid_namespace/Makefile     |  8 ++++
 tools/testing/selftests/pid_namespace/config       |  2 +
 .../selftests/pid_namespace/regression_enomem.c    | 45 ++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd.h              |  2 +
 7 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/pid_namespace/.gitignore
 create mode 100644 tools/testing/selftests/pid_namespace/Makefile
 create mode 100644 tools/testing/selftests/pid_namespace/config
 create mode 100644 tools/testing/selftests/pid_namespace/regression_enomem.c
