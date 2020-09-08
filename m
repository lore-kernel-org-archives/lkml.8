Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3BAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4A721741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592608;
	bh=RoQ2WSTwrddXDMOIrp4crkXftKa5k90TuAtUJGIvRzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eXKhNl+JatBWxUUdzpXuk8Wok0LtQRYLWdH3TFOsCb+7J01RzftDwLsi5CDDkUnU4
	 7jaSw3Dt27vLXVBKqKyq8lLv/6wwcIPXkbkJ40WzheyoBx8lB19kXzXnUBWixJaozM
	 zy4sB0Ffc6fMs9KXZujlUbtFsIoa7OQTwB8YkKcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbgIHTQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbgIHQEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:04:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 873FD224D3;
        Tue,  8 Sep 2020 15:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579430;
        bh=RoQ2WSTwrddXDMOIrp4crkXftKa5k90TuAtUJGIvRzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFMLhduRYKws50DkJnhHE5F/U+ZV0HD4S/8D5WIMW0M5Fh+of9EWTegCuas3kAtPM
         reoWf5+fmMGNMi5l14S0f56AUHu5wKfW0Tl/LNicJmV4Sw6KFXAyECcEzMu6NTy4Yc
         3wlz8YHRcARTP8Y6VoSqvsHWtz2eSpBoAdvqEuBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 073/186] xfs: finish dfops on every insert range shift iteration
Date:   Tue,  8 Sep 2020 17:23:35 +0200
Message-Id: <20200908152245.190903037@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 9c516e0e4554e8f26ab73d46cbc789d7d8db664d ]

The recent change to make insert range an atomic operation used the
incorrect transaction rolling mechanism. The explicit transaction
roll does not finish deferred operations. This means that intents
for rmapbt updates caused by extent shifts are not logged until the
final transaction commits. Thus if a crash occurs during an insert
range, log recovery might leave the rmapbt in an inconsistent state.
This was discovered by repeated runs of generic/455.

Update insert range to finish dfops on every shift iteration. This
is similar to collapse range and ensures that intents are logged
with the transactions that make associated changes.

Fixes: dd87f87d87fa ("xfs: rework insert range into an atomic operation")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index afdc7f8e0e701..feb277874a1fb 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1165,7 +1165,7 @@ xfs_insert_file_space(
 		goto out_trans_cancel;
 
 	do {
-		error = xfs_trans_roll_inode(&tp, ip);
+		error = xfs_defer_finish(&tp);
 		if (error)
 			goto out_trans_cancel;
 
-- 
2.25.1



