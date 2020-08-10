Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD055207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgHJS1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:27:37 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56814 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHJS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:27:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CA06161D8ABB;
        Mon, 10 Aug 2020 20:27:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zb-VI0CWQOcx; Mon, 10 Aug 2020 20:27:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 48A7261D8ABC;
        Mon, 10 Aug 2020 20:27:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Nb3mRZ3V-BmY; Mon, 10 Aug 2020 20:27:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F347161D8ABB;
        Mon, 10 Aug 2020 20:27:32 +0200 (CEST)
Date:   Mon, 10 Aug 2020 20:27:32 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1956790813.229084.1597084052878.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.9-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: mNdKbqCSj6uMvkVJNBiccwZGdeEXuw==
Thread-Topic: JFFS2, UBI and UBIFS changes for 5.9-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.9-rc1

for you to fetch changes up to 798b7347e4f29553db4b996393caf12f5b233daf:

  jffs2: fix UAF problem (2020-08-02 23:56:13 +0200)

----------------------------------------------------------------
This pull request contains changes for JFFS2, UBI and UBIFS

JFFS2:
        - Fix for a corner case while mounting
        - Fix for an use-after-free issue

UBI:
        - Fix for a memory load while attaching
        - Don't produce an anchor PEB with fastmap being disabled

UBIFS:
        - Fix for orphan inode logic
        - Spelling fixes
        - New mount option to specify filesystem version

----------------------------------------------------------------
Martin Kaistra (1):
      ubifs: add option to specify version for new file systems

Randy Dunlap (1):
      ubifs: misc.h: delete a duplicated word

Zhe Li (2):
      jffs2: fix jffs2 mounting failure
      jffs2: fix UAF problem

Zhihao Cheng (3):
      ubi: fastmap: Don't produce the initial next anchor PEB when fastmap is disabled
      ubi: fastmap: Free fastmap next anchor peb during detach
      ubifs: Fix wrong orphan node deletion in ubifs_jnl_update|rename

 drivers/mtd/ubi/fastmap-wl.c |  5 +++++
 drivers/mtd/ubi/wl.c         |  3 ++-
 fs/jffs2/dir.c               |  6 +++++-
 fs/jffs2/scan.c              |  3 ++-
 fs/ubifs/journal.c           | 10 ++++++----
 fs/ubifs/misc.h              |  2 +-
 fs/ubifs/sb.c                |  5 +++--
 fs/ubifs/super.c             | 18 ++++++++++++++++++
 fs/ubifs/ubifs.h             |  1 +
 9 files changed, 43 insertions(+), 10 deletions(-)
