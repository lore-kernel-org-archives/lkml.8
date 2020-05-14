Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40655C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D75206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgENVDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:03:12 -0400
Received: from [66.170.99.2] ([66.170.99.2]:28072 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgENVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:03:11 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 17:03:10 EDT
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id F3E21BA20C5; Fri, 15 May 2020 02:26:04 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     gregkh@linuxfoundation.org
Cc:     srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, csiddharth@vmware.com,
        siddharth@embedjournal.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Date:   Fri, 15 May 2020 02:25:20 +0530
Message-Id: <cover.1589486724.git.csiddharth@vmware.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of proper validation that cached inodes are free during allocation,
causes a crash (refer to CVE-2018-13093 for more details). To address this
issue, I'm backporting upstream commit [1] to 4.4 and 4.9 stable trees
(a backport of [1] to 4.14 already exists).

Also, commit [1] references another commit [2] which added checks only to
xfs_iget_cache_miss(). In this patch, those checks have been moved into a
dedicated checker method and both xfs_iget_cache_miss() and
xfs_iget_cache_hit() are made to call that method. This code reorg in commit
[1], makes commit [2] redundant in the history of the 4.9 and 4.4 stable
trees. So commit [2] is not being backported.

-- Sid

[1]: afca6c5b2595f ("xfs: validate cached inodes are free when allocated")
[2]: ee457001ed6c ("xfs: catch inode allocation state mismatch corruption")

[v4.9]
Dave Chinner (1):
  xfs: More robust inode extent count validation

 fs/xfs/libxfs/xfs_format.h    |   3 ++
 fs/xfs/libxfs/xfs_inode_buf.c | 112 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 3 deletions(-)

[v.4.4]
Dave Chinner (1):
  xfs: validate cached inodes are free when allocated

 fs/xfs/xfs_icache.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

-- 
2.7.4

