Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7297BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5448920672
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGBUvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:51:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58061 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGBUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:51:08 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jr6Ak-0005ov-C1; Thu, 02 Jul 2020 20:51:06 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] fixes for v5.8-rc4
Date:   Thu,  2 Jul 2020 22:47:33 +0200
Message-Id: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains an annotation patch for a data race in copy_process() reported by
KCSAN when reading and writing nr_threads. The data race is intentional and
benign. This is obvious from the comment above the relevant code and based on
general consensus when discussing this issue. So simply using data_race() to
annotate this as an intentional race seems the best option.

A few comments on this since doing a grep data_race() reveals that currently
only kernel/rcu/* is making use of this new annotation and this seems to be the
first annotation in core kernel: when this was first sent to me I was obviously
aware of the existence of KCSAN but not whether we had established a consenus
around annotating places in the (core) kernel where we currently have benign
data races that KCSAN complains about. I don't know whether we have reached a
consensus in general yet or we're just doing this subsystem specific. We had a
bit of a back and forth on this topic related to this patch here. Most people
argued that because this is an intentional and benign data race that we should
simply annotate it. Now, we're obviously doing this for the sake of KCSAN and
given that KCSAN is now upstream and starting to report data races I guess
doing this is sensible. The linux-next tree contains various mm/* patches that
push in the same direction of annotating benign data races. So it seems going
forward we'll just funnel such patches upstream where they make sense.

/* Testing */
All patches have seen exposure in linux-next and are based on v5.8-rc1.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported.
Fyi, I applied this patch right on top of the previous fixes before -rc2 was
out and hence didn't rebase my fixes tree on top of -rc3 because of that.

The following changes since commit 86f56395feb2b106b125c47e72192e37da5dd088:

  tests: test for setns() EINVAL regression (2020-06-17 00:48:54 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-07-02

for you to fetch changes up to c17d1a3a8ee4dac7539d5c976b45d9300f6f10bc:

  fork: annotate data race in copy_process() (2020-06-26 01:05:29 +0200)

Please consider pulling these changes from the signed for-linus-2020-07-02 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-07-02

----------------------------------------------------------------
Weilong Chen (1):
      fork: annotate data race in copy_process()

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
