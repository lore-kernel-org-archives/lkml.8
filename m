Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB61C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80120724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCVQkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:40:05 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:51762 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgCVQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:40:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3CD3D837F253;
        Sun, 22 Mar 2020 16:40:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tramp02_1da0cf8f3de29
X-Filterd-Recvd-Size: 1709
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Mar 2020 16:40:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-nilfs@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nilfs2: Logging style changes
Date:   Sun, 22 Mar 2020 09:38:09 -0700
Message-Id: <cover.1584894497.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce object size and use more common kernel logging styles.

Joe Perches (2):
  nilfs2: Convert __nilfs_msg to integrate the level and format
  nilfs2: Use a more common logging style

 fs/nilfs2/alloc.c     | 38 +++++++++----------
 fs/nilfs2/btree.c     | 42 ++++++++++-----------
 fs/nilfs2/cpfile.c    | 10 ++---
 fs/nilfs2/dat.c       | 14 +++----
 fs/nilfs2/direct.c    | 14 ++++---
 fs/nilfs2/gcinode.c   |  2 +-
 fs/nilfs2/ifile.c     |  4 +-
 fs/nilfs2/inode.c     | 29 +++++++--------
 fs/nilfs2/ioctl.c     | 37 +++++++++----------
 fs/nilfs2/mdt.c       |  2 +-
 fs/nilfs2/namei.c     |  6 +--
 fs/nilfs2/nilfs.h     | 18 ++++++---
 fs/nilfs2/page.c      | 11 +++---
 fs/nilfs2/recovery.c  | 32 +++++++---------
 fs/nilfs2/segbuf.c    |  2 +-
 fs/nilfs2/segment.c   | 38 +++++++++----------
 fs/nilfs2/sufile.c    | 29 +++++++--------
 fs/nilfs2/super.c     | 73 +++++++++++++++++++------------------
 fs/nilfs2/sysfs.c     | 29 +++++++--------
 fs/nilfs2/the_nilfs.c | 85 ++++++++++++++++++++-----------------------
 20 files changed, 254 insertions(+), 261 deletions(-)

-- 
2.24.0

