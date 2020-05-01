Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97EEC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951662051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341054;
	bh=p262YZn7SlOJ9SdgjgOh7lUmTweP6tiBeMxeDpl8gu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAXgtdZFAdwJBvKnSNtb4N1SDvs1Ut0R711HhvC2WMJlbEPVokFJRHsNBYka6UOMX
	 jmCJ5o+JlLb6xdBKheS9SBDc/L/RRj5kzvgTwJPIaacTTgF6Kly3co0rZ9woHBwcXL
	 1CT9FxFINbOgtBaQnGBdrJBvrm4Cq1yuOMOooaMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgEANuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbgEANjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:39:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60158205C9;
        Fri,  1 May 2020 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340363;
        bh=p262YZn7SlOJ9SdgjgOh7lUmTweP6tiBeMxeDpl8gu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsj576hEoQes6wKvS/cvdA9nuWhb5tyj684d8SuYn7oyd9f0qFCvaYcnIxr6l55jm
         7MxcCkzEdqxMRp05howhJEL8JJSBmBtrO25Y2BIm4ZXq4R5VNH2wZyXmyaW4bqaxmG
         96HzMJJskgPvxCJbOXEwl81s5XBtDo2Ipe2+FddI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Furtado <paulfurtado91@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Chandan Rajendra <chandanrlinux@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Allison Collins <allison.henderson@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 5.4 25/83] xfs: acquire superblock freeze protection on eofblocks scans
Date:   Fri,  1 May 2020 15:23:04 +0200
Message-Id: <20200501131530.318495482@linuxfoundation.org>
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

From: Brian Foster <bfoster@redhat.com>

commit 4b674b9ac852937af1f8c62f730c325fb6eadcdb upstream.

The filesystem freeze sequence in XFS waits on any background
eofblocks or cowblocks scans to complete before the filesystem is
quiesced. At this point, the freezer has already stopped the
transaction subsystem, however, which means a truncate or cowblock
cancellation in progress is likely blocked in transaction
allocation. This results in a deadlock between freeze and the
associated scanner.

Fix this problem by holding superblock write protection across calls
into the block reapers. Since protection for background scans is
acquired from the workqueue task context, trylock to avoid a similar
deadlock between freeze and blocking on the write lock.

Fixes: d6b636ebb1c9f ("xfs: halt auto-reclamation activities while rebuilding rmap")
Reported-by: Paul Furtado <paulfurtado91@gmail.com>
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Chandan Rajendra <chandanrlinux@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_icache.c |   10 ++++++++++
 fs/xfs/xfs_ioctl.c  |    5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -907,7 +907,12 @@ xfs_eofblocks_worker(
 {
 	struct xfs_mount *mp = container_of(to_delayed_work(work),
 				struct xfs_mount, m_eofblocks_work);
+
+	if (!sb_start_write_trylock(mp->m_super))
+		return;
 	xfs_icache_free_eofblocks(mp, NULL);
+	sb_end_write(mp->m_super);
+
 	xfs_queue_eofblocks(mp);
 }
 
@@ -934,7 +939,12 @@ xfs_cowblocks_worker(
 {
 	struct xfs_mount *mp = container_of(to_delayed_work(work),
 				struct xfs_mount, m_cowblocks_work);
+
+	if (!sb_start_write_trylock(mp->m_super))
+		return;
 	xfs_icache_free_cowblocks(mp, NULL);
+	sb_end_write(mp->m_super);
+
 	xfs_queue_cowblocks(mp);
 }
 
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -2401,7 +2401,10 @@ xfs_file_ioctl(
 		if (error)
 			return error;
 
-		return xfs_icache_free_eofblocks(mp, &keofb);
+		sb_start_write(mp->m_super);
+		error = xfs_icache_free_eofblocks(mp, &keofb);
+		sb_end_write(mp->m_super);
+		return error;
 	}
 
 	default:


