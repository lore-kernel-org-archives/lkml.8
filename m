Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C4C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303AF2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCGKXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:23:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgCGKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:23:48 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jAWcU-0000Qe-W1; Sat, 07 Mar 2020 10:23:47 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.6-rc5
Date:   Sat,  7 Mar 2020 11:22:14 +0100
Message-Id: <20200307102213.2999137-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
Here are a few hopefully uncontroversial fixes:

- Use RCU_INIT_POINTER() when initializing some rcu protected members in
  task_struct to fix some sparse warnings.
- Add pidfd_fdinfo_test binary to .gitignore file

/* Testing */
All patches have seen exposure in linux-next and are based on v5.6-rc1.
No regressions or build warning have been reported to me. Another test-compile
I did just now with current mainline did not produce build warnings either.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-03-07

for you to fetch changes up to 186e28a18aeb0fec99cc586fda337e6b23190791:

  selftests: pidfd: Add pidfd_fdinfo_test in .gitignore (2020-02-28 13:35:05 +0100)

Please consider pulling these changes from the signed for-linus-2020-03-07 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-03-07

----------------------------------------------------------------
Christophe Leroy (1):
      selftests: pidfd: Add pidfd_fdinfo_test in .gitignore

Madhuparna Bhowmik (2):
      fork: Use RCU_INIT_POINTER() instead of rcu_access_pointer()
      exit: Fix Sparse errors and warnings

 kernel/exit.c                            | 4 ++--
 kernel/fork.c                            | 2 +-
 tools/testing/selftests/pidfd/.gitignore | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)
