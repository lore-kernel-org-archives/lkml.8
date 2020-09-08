Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A89C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B8624178
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599580161;
	bh=syTCNfCCZiG/PsV581E461naabaxAdynx+wq1YAum4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfclI4qGWaS1w0O22fqgs5FJufh2w7R/exQgW5eoKe458m/AxxdmIJK7blAYR4t7x
	 UoOOVBNoc43+E7P5fRhxnLyhHxXjw8ncO4ATxJJChbBx+w8oOAUl0s5getCVZatOAn
	 bwlg5Qws+nDF8OG4X1uULQHDnXiSunV+Wmv62IPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgIHPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbgIHPsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:48:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654AE24827;
        Tue,  8 Sep 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579862;
        bh=syTCNfCCZiG/PsV581E461naabaxAdynx+wq1YAum4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezGF9EYRDPaucIGIrQeKxbEOnvVXWkqnAjsVqP7RDvTzMiPfm9NTdknyGQ8IIH3Hf
         qGEQ6yNq0RZZ+EJjKZ+y02TGE2g1/YjZythqX6yM7PwNQUjj/oJrlQC/cpnuI29Tl0
         K81KVgq5ruVwSs36S1CYS9kZi0X/NK7tWnLFUJUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/129] xfs: fix xfs_bmap_validate_extent_raw when checking attr fork of rt files
Date:   Tue,  8 Sep 2020 17:25:04 +0200
Message-Id: <20200908152232.849039488@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

[ Upstream commit d0c20d38af135b2b4b90aa59df7878ef0c8fbef4 ]

The realtime flag only applies to the data fork, so don't use the
realtime block number checks on the attr fork of a realtime file.

Fixes: 30b0984d9117 ("xfs: refactor bmap record validation")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 3f76da11197c4..19a600443b9ee 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -6179,7 +6179,7 @@ xfs_bmap_validate_extent(
 
 	isrt = XFS_IS_REALTIME_INODE(ip);
 	endfsb = irec->br_startblock + irec->br_blockcount - 1;
-	if (isrt) {
+	if (isrt && whichfork == XFS_DATA_FORK) {
 		if (!xfs_verify_rtbno(mp, irec->br_startblock))
 			return __this_address;
 		if (!xfs_verify_rtbno(mp, endfsb))
-- 
2.25.1



