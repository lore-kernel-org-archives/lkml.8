Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F37205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340995;
	bh=d9WCOVPH7L+/dPvkYP6Uk/9VEzZL2uz/ct95MRypraM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mym08Rg857b2E7tksOGEKyd1ElDqzmMX9mHveWEFOpQdD4/hRy4hpcb8eTnULNkHV
	 UUFYE/MtngLqfqrDg1Ynb+xUaQReeRTyVdGsL8w7ohUc+/mU9JXm9QUHwXAF94nifO
	 lGlYvQPMv4Xt+dTivO6mDepvgO1cN6IkufrtNcNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgEANty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbgEANku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:40:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823AC205C9;
        Fri,  1 May 2020 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340450;
        bh=d9WCOVPH7L+/dPvkYP6Uk/9VEzZL2uz/ct95MRypraM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0f+vgwrix9fzqc8k7+usH5ovNgz9AabKuidbj+t+GvK74YpjHp0+GR3nwA7wscOD3
         LfdFMJkzFXK65+fwvSWjf8AlufSQMLR7unGRNO++vGvvPCT0RxE38ZBVeGpSCNQbjE
         SNPMNg3MOiFp2cBDFlK3gVdwIGHTxqXy428SyTaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 72/83] ext4: increase wait time needed before reuse of deleted inode numbers
Date:   Fri,  1 May 2020 15:23:51 +0200
Message-Id: <20200501131541.643071096@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit a17a9d935dc4a50acefaf319d58030f1da7f115a ]

Current wait times have proven to be too short to protect against inode
reuses that lead to metadata inconsistencies.

Now that we will retry the inode allocation if we can't find any
recently deleted inodes, it's a lot safer to increase the recently
deleted time from 5 seconds to a minute.

Link: https://lore.kernel.org/r/20200414023925.273867-1-tytso@mit.edu
Google-Bug-Id: 36602237
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index a6288730210e8..64b6549dd9016 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -660,7 +660,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
  * block has been written back to disk.  (Yes, these values are
  * somewhat arbitrary...)
  */
-#define RECENTCY_MIN	5
+#define RECENTCY_MIN	60
 #define RECENTCY_DIRTY	300
 
 static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
-- 
2.20.1



