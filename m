Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259AF2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaWehOqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgFHQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:33:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726042AbgFHQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591634021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CETIjDgGDpjjFlSZ8hriJ5JQ/wPNDNhmAqik9r4TPeA=;
        b=UaWehOqzAfgfZKI06N0mEiqFCoNDTC7Aajp0n24uxfyAKa84QDyhwmzjEficS+qBUajjFZ
        PP1DRTF16apn31622F+7CrW0GHu9DNJe/jZ306PawdaM+NNTkwYQS6AVOe4m8nJdfUFo25
        gbWBqGPkDCr2N9VV58NEsaSTie+eYqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-5Ahi2WMVNyGF_uUO-hqyrw-1; Mon, 08 Jun 2020 12:33:39 -0400
X-MC-Unique: 5Ahi2WMVNyGF_uUO-hqyrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1F0510CE788;
        Mon,  8 Jun 2020 16:32:55 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD6865D9C9;
        Mon,  8 Jun 2020 16:32:51 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.8
Date:   Mon,  8 Jun 2020 18:32:50 +0200
Message-Id: <20200608163250.550547-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.8.

Thanks a lot,
Andreas

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.8

for you to fetch changes up to 300e549b6e53025ea69550f009451f7a13bfc3eb:

  Merge branch 'gfs2-iopen' into for-next (2020-06-05 21:25:36 +0200)

----------------------------------------------------------------
Changes in gfs2:

- An iopen glock locking scheme rework that speeds up deletes of
  inodes accessed from multiple nodes.
- Various bug fixes and debugging improvements.
- Convert gfs2-glocks.txt to ReST.

----------------------------------------------------------------
Andreas Gruenbacher (10):
      gfs2: Keep track of deleted inode generations in LVBs
      gfs2: Turn gl_delete into a delayed work
      gfs2: Give up the iopen glock on contention
      gfs2: Try harder to delete inodes locally
      gfs2: Minor gfs2_lookup_by_inum cleanup
      gfs2: Move inode generation number check into gfs2_inode_lookup
      gfs2: Check inode generation number in delete_work_func
      gfs2: Wake up when setting GLF_DEMOTE
      gfs2: Smarter iopen glock waiting
      Merge branch 'gfs2-iopen' into for-next

Bob Peterson (10):
      gfs2: Don't ignore inode write errors during inode_go_sync
      gfs2: Allow lock_nolock mount to specify jid=X
      gfs2: Only do glock put in gfs2_create_inode for free inodes
      gfs2: print mapping->nrpages in glock dump for address space glocks
      gfs2: introduce new gfs2_glock_assert_withdraw
      gfs2: instrumentation wrt log_flush stuck
      gfs2: Allow ASPACE glocks to also have an lvb
      gfs2: initialize transaction tr_ailX_lists earlier
      gfs2: new slab for transactions
      gfs2: fix use-after-free on transaction ail lists

Mauro Carvalho Chehab (1):
      docs: filesystems: convert gfs2-glocks.txt to ReST

 .../{gfs2-glocks.txt => gfs2-glocks.rst}           | 149 ++++++++-------
 Documentation/filesystems/index.rst                |   1 +
 MAINTAINERS                                        |   2 +-
 fs/gfs2/export.c                                   |   4 +-
 fs/gfs2/glock.c                                    | 208 ++++++++++++++++++---
 fs/gfs2/glock.h                                    |  16 ++
 fs/gfs2/glops.c                                    |  21 ++-
 fs/gfs2/incore.h                                   |   9 +-
 fs/gfs2/inode.c                                    |  47 +++--
 fs/gfs2/inode.h                                    |   2 +-
 fs/gfs2/log.c                                      |  56 ++++--
 fs/gfs2/main.c                                     |   9 +
 fs/gfs2/ops_fstype.c                               |   2 +-
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/gfs2/super.c                                    |  72 ++++++-
 fs/gfs2/trans.c                                    |  21 ++-
 fs/gfs2/trans.h                                    |   1 +
 fs/gfs2/util.c                                     |   1 +
 fs/gfs2/util.h                                     |   1 +
 include/uapi/linux/gfs2_ondisk.h                   |   6 +
 20 files changed, 489 insertions(+), 141 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.txt => gfs2-glocks.rst} (63%)

