Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF712072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159279;
	bh=dvNwFUQLA7XkqwikiPeWnYFINmZeMemPe3n7Hv43UeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W67EF/p0pMnGZiiC/DxaHuduUhU1ydduDk3cY4g5aB15lPBK7Z5jsvClJCJLH6PU0
	 1x2Cl+yEUbPbUbrkhiUAGLtzFAecAbECgIaSv6r+/UIjzDGyUMJg/2d7VCuRTZXiyk
	 EAgsi4Si4FRUMz9mfVManMk7zUHu7tNjMe8Bdzlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgEVOyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbgEVOvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4FE22256;
        Fri, 22 May 2020 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159092;
        bh=dvNwFUQLA7XkqwikiPeWnYFINmZeMemPe3n7Hv43UeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7IDNVRaw32huLDdF1+tzn4L3eqEdRY7BLp94WOWLlUUpXr76X6ghQP5dyQ8sq/fC
         GK8E94VgNGwILqAhKlRWQclJarqpy2YJVB2XTlUxC5p2/q+YE8F7UjoMSZqJ/JcJfT
         dP1oNSj0cv0boHI70NTdhKftO8Z/PtAox39yKslw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.19 10/19] gfs2: don't call quota_unhold if quotas are not locked
Date:   Fri, 22 May 2020 10:51:11 -0400
Message-Id: <20200522145120.434921-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145120.434921-1-sashal@kernel.org>
References: <20200522145120.434921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit c9cb9e381985bbbe8acd2695bbe6bd24bf06b81c ]

Before this patch, function gfs2_quota_unlock checked if quotas are
turned off, and if so, it branched to label out, which called
gfs2_quota_unhold. With the new system of gfs2_qa_get and put, we
no longer want to call gfs2_quota_unhold or we won't balance our
gets and puts.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index dd0f9bc13164..ce47c8233612 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1116,7 +1116,7 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	int found;
 
 	if (!test_and_clear_bit(GIF_QD_LOCKED, &ip->i_flags))
-		goto out;
+		return;
 
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		struct gfs2_quota_data *qd;
@@ -1153,7 +1153,6 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 			qd_unlock(qda[x]);
 	}
 
-out:
 	gfs2_quota_unhold(ip);
 }
 
-- 
2.25.1

