Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55377C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D444F20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgDGMiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:38:05 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48860 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:38:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE750607BD9A;
        Tue,  7 Apr 2020 14:38:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mfUTYiUMQWeO; Tue,  7 Apr 2020 14:38:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4DF6C607BDBD;
        Tue,  7 Apr 2020 14:38:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bQr49hM-qh4C; Tue,  7 Apr 2020 14:38:01 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 30DC2607BD9A;
        Tue,  7 Apr 2020 14:38:01 +0200 (CEST)
Date:   Tue, 7 Apr 2020 14:38:01 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <793490269.91815.1586263081165.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI/UBIFS fixes for v5.7-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: VK/uz/K9Ve0lIe+2IoztTTPv430b3g==
Thread-Topic: UBI/UBIFS fixes for v5.7-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.7-rc1

for you to fetch changes up to 3676f32a98cd6ed4481c21bceb8b4829d4b6d1cf:

  ubi: ubi-media.h: Replace zero-length array with flexible-array member (2020-03-30 23:02:37 +0200)

----------------------------------------------------------------
This pull request contains fixes for UBI and UBIFS:

- Fix for memory leaks around UBIFS orphan handling
- Fix for memory leaks around UBI fastmap
- Remove zero-length array from ubi-media.h
- Fix for TNC lookup in UBIFS orphan code

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ubi: ubi-media.h: Replace zero-length array with flexible-array member

Hou Tao (2):
      ubi: fastmap: Free unused fastmap anchor peb during detach
      ubi: fastmap: Only produce the initial anchor PEB when fastmap is used

Liu Song (1):
      ubifs: Fix out-of-bounds memory access caused by abnormal value of node_len

Richard Weinberger (1):
      ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans()

Zhihao Cheng (2):
      ubifs: ubifs_jnl_write_inode: Fix a memory leak bug
      ubifs: ubifs_add_orphan: Fix a memory leak bug

 drivers/mtd/ubi/fastmap-wl.c | 15 +++++++++++++--
 drivers/mtd/ubi/ubi-media.h  |  2 +-
 drivers/mtd/ubi/wl.c         |  3 ++-
 fs/ubifs/io.c                | 16 ++++++++++++++--
 fs/ubifs/journal.c           |  1 +
 fs/ubifs/orphan.c            | 13 +++++++++----
 6 files changed, 40 insertions(+), 10 deletions(-)
