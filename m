Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F764C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2E320872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgH1QjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:39:13 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:53070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgH1QjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3353B837F24F;
        Fri, 28 Aug 2020 16:39:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bear07_1f04dee27077
X-Filterd-Recvd-Size: 1642
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 16:39:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 0/3] ntfs3: trivial style cleanups
Date:   Fri, 28 Aug 2020 09:39:02 -0700
Message-Id: <cover.1598632661.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches (3):
  ntfs3: Add and use logging macros
  ntfs3: Use more common brace style
  ntfs3: Rename NTFS_FLAGS_LOG_REPLAING to NTFS_FLAGS_LOG_REPLAYING

 fs/ntfs3/attrib.c   |  7 +++--
 fs/ntfs3/attrlist.c |  4 +--
 fs/ntfs3/bitmap.c   | 43 +++++++++++++++--------------
 fs/ntfs3/debug.h    | 12 ++++++++
 fs/ntfs3/dir.c      | 24 +++++++---------
 fs/ntfs3/file.c     | 62 +++++++++++++++++------------------------
 fs/ntfs3/frecord.c  | 45 +++++++++++++++---------------
 fs/ntfs3/fslog.c    | 24 ++++++++--------
 fs/ntfs3/fsntfs.c   | 60 +++++++++++++++++-----------------------
 fs/ntfs3/index.c    | 18 ++++++------
 fs/ntfs3/inode.c    | 22 ++++++---------
 fs/ntfs3/lznt.c     |  3 +-
 fs/ntfs3/namei.c    |  3 +-
 fs/ntfs3/ntfs_fs.h  |  6 ++--
 fs/ntfs3/record.c   | 13 +++++----
 fs/ntfs3/run.c      |  8 +++---
 fs/ntfs3/super.c    | 67 ++++++++++++++++++---------------------------
 fs/ntfs3/xattr.c    | 24 ++++++++--------
 18 files changed, 207 insertions(+), 238 deletions(-)

-- 
2.26.0

