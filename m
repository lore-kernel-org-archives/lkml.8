Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BF32067C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgHDLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:25:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:25:01 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2v3y-0001pP-AD; Tue, 04 Aug 2020 11:24:58 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.9
Date:   Tue,  4 Aug 2020 13:24:45 +0200
Message-Id: <20200804112445.72138-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the changes for v5.9:

/* Summary */
This contains the changes to add the missing support for attaching to time
namespaces via pidfds. Last cycle setns() was changed to support attaching to
multiple namespaces atomically. This requires all namespaces to have a point of
no return where they can't fail anymore. Specifically,
<namespace-type>_install() is allowed to perform permission checks and install
the namespace into the new struct nsset that it has been given but it is not
allowed to make visible changes to the affected task. Once
<namespace-type>_install() returns, anything that the given namespace type
additionally requires to be setup needs to ideally be done in a function that
can't fail or if it fails the failure must be non-fatal. For time namespaces
the relevant functions that fell into this category were timens_set_vvar_page()
and vdso_join_timens(). The latter could still fail although it didn't had to.
This function is only implemented for vdso_join_timens() in current mainline.
As discussed on-list (cf. [1]), in order to make setns() support time
namespaces when attaching to multiple namespaces at once properly we changed
vdso_join_timens() to always succeed. So vdso_join_timens() replaces the
mmap_write_lock_killable() with mmap_read_lock().

Please note that arm is about to grow vdso support for time namespaces
(possibly this merge window). We've synced on this change and arm64 also uses
mmap_read_locK(), i.e. makes vdso_join_timens() a function that can't fail.
Once the changes here and the arm64 changes have landed, vdso_join_timens()
should be turned into a void function so it's obvious to callers and
implementers on other architectures that the expectation is that it can't fail.
We didn't do this right away because it would've introduced unnecessary merge
conflicts between the two trees for no major gain.

As always, tests included.

[1]: https://lore.kernel.org/lkml/20200611110221.pgd3r5qkjrjmfqa2@wittgenstein

/* Testing */
All patches are based on v5.8-rc4 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline bcf876870b95 ("Linux 5.8").

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.9

for you to fetch changes up to 55d9ad97e417cc2604654913e902d26f942bde00:

  tests: add CLONE_NEWTIME setns tests (2020-07-08 11:14:22 +0200)

Please consider pulling these changes from the signed threads-v5.9 tag.

Thanks!
Christian

----------------------------------------------------------------
threads-v5.9

----------------------------------------------------------------
Christian Brauner (4):
      timens: make vdso_join_timens() always succeed
      timens: add timens_commit() helper
      nsproxy: support CLONE_NEWTIME with setns()
      tests: add CLONE_NEWTIME setns tests

 arch/x86/entry/vdso/vma.c                        |  5 +-
 include/linux/time_namespace.h                   |  6 ++
 kernel/nsproxy.c                                 | 21 ++++++-
 kernel/time/namespace.c                          | 22 +++----
 tools/testing/selftests/pidfd/pidfd.h            |  4 ++
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 76 ++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 19 deletions(-)
