Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EFF20719
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHAVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 17:05:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43443 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 17:05:59 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k1yhZ-0000Nm-La; Sat, 01 Aug 2020 21:05:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fix v5.8-rc8
Date:   Sat,  1 Aug 2020 23:05:52 +0200
Message-Id: <20200801210552.2150271-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a simple spelling fix for dequeue_synchronous_signal().

/* Testing */
All patches have seen exposure in linux-next and are based on v5.8-rc7.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported.

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-08-01

for you to fetch changes up to 7665a47f70b3f64bf09c233cc7df73fde9e506f1:

  signal: fix typo in dequeue_synchronous_signal() (2020-07-26 23:57:52 +0200)

Please consider pulling these changes from the signed for-linus-2020-08-01 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2020-08-01

----------------------------------------------------------------
Pavel Machek (1):
      signal: fix typo in dequeue_synchronous_signal()

 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
