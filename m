Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7686E207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHUWQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:16:45 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:53246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726747AbgHUWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:16:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B8B091802A392;
        Fri, 21 Aug 2020 22:16:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk63_4906fc22703c
X-Filterd-Recvd-Size: 1349
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 22:16:42 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] ntfs3: Update logging
Date:   Fri, 21 Aug 2020 15:16:37 -0700
Message-Id: <cover.1598047822.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more typical kernel logging styles.
These changes also trivially reduce overall object size.

btw: ntfs_fs_error/__ntfs_fs_error were and are left unused

Joe Perches (3):
  ntfs3: Use more common logging function names and style
  ntfs3: Rename logging macros and uses
  ntfs3: Rename ntfs_trace to ntfs_notice

 fs/ntfs3/debug.h   | 30 ++++++++------
 fs/ntfs3/dir.c     | 22 +++++------
 fs/ntfs3/file.c    | 27 ++++++-------
 fs/ntfs3/frecord.c |  2 +-
 fs/ntfs3/fslog.c   |  4 +-
 fs/ntfs3/fsntfs.c  | 39 +++++++++---------
 fs/ntfs3/index.c   |  4 +-
 fs/ntfs3/inode.c   | 14 +++----
 fs/ntfs3/ntfs_fs.h |  4 +-
 fs/ntfs3/super.c   | 99 ++++++++++++++++++++++++----------------------
 10 files changed, 121 insertions(+), 124 deletions(-)

-- 
2.26.0

