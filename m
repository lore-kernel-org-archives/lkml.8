Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CEE2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgDHPMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:12:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:56749 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgDHPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:12:31 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D04B4C009; Wed,  8 Apr 2020 17:12:29 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:12:14 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] 9p update for 5.7
Message-ID: <20200408151214.GA30977@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406110702.GA13469@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

v2 of monday's pull request. The commit date is just now, but that is
just the documentation patch I applied, there is no code change since
the last version.

Thanks,
Dominique

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.7-2

for you to fetch changes up to c6f141412d24c8d8a9d98ef45303c0235829044b:

  9p: document short read behaviour with O_NONBLOCK (2020-04-08 17:05:28 +0200)

----------------------------------------------------------------
9p pull request for inclusion in 5.7 (take 2)

- Change read with O_NONBLOCK to allow incomplete read and return immediately
(and document it)
- Rest is just cleanup (indent, unused field in struct, extra semicolon)

----------------------------------------------------------------
Dominique Martinet (2):
      net/9p: remove unused p9_req_t aux field
      9p: document short read behaviour with O_NONBLOCK

Krzysztof Kozlowski (1):
      9p: Fix Kconfig indentation

Sergey Alirzaev (2):
      9pnet: allow making incomplete read requests
      9p: read only once on O_NONBLOCK

zhengbin (1):
      9p: Remove unneeded semicolon

 Documentation/filesystems/9p.txt |  10 +++++++++
 fs/9p/Kconfig                    |  18 ++++++++--------
 fs/9p/vfs_file.c                 |   5 ++++-
 fs/9p/vfs_inode.c                |   2 +-
 include/net/9p/client.h          |   4 ++--
 net/9p/client.c                  | 144  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------
 6 files changed, 104 insertions(+), 79 deletions(-)
