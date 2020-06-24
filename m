Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF86C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A0620706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbgFXNHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:07:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgFXNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:07:22 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jo57Z-0007Cw-4F; Wed, 24 Jun 2020 13:07:21 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.8-rc3
Date:   Wed, 24 Jun 2020 15:07:12 +0200
Message-Id: <20200624130712.1080689-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

This fixes a regression introduced with 303cc571d107 ("nsproxy: attach to
namespaces via pidfds"). The LTP testsuite reported a regression where users
would now see EBADF returned instead of EINVAL when an fd was passed that
referred to an open file but the file was not a namespace file. Fix this by
continuing to report EINVAL and add a regression test.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.8-rc1.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-06-24

for you to fetch changes up to 86f56395feb2b106b125c47e72192e37da5dd088:

  tests: test for setns() EINVAL regression (2020-06-17 00:48:54 +0200)

Please consider pulling these changes from the signed for-linus-2020-06-24 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-06-24

----------------------------------------------------------------
Christian Brauner (2):
      nsproxy: restore EINVAL for non-namespace file descriptor
      tests: test for setns() EINVAL regression

 kernel/nsproxy.c                                 |  2 +-
 tools/testing/selftests/pidfd/pidfd.h            |  5 +++++
 tools/testing/selftests/pidfd/pidfd_getfd_test.c |  5 -----
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 12 ++++++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)
