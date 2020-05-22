Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23775C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFCC2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159190;
	bh=WFV9FyCjkInEb5OHKvtcQ60D6GXHMa7bdHtkAceNB6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MXdBch3nuyDYqGJ6u21v5/RClCpWGVIuSf3ri8GW+reSD+3T6dqMOZ6+rKSGDPhH3
	 lHFYbnPghhkg0uc/0gPqah8uTjXuhepzVRbsh5Gvltg+ZYlMEjImqfEabSdcWIi0Ii
	 yWk+S3DES2BY0vP6sOk91SjIE72wwiqR2r17iKLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEVOxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbgEVOwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:52:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC35522B3F;
        Fri, 22 May 2020 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159122;
        bh=WFV9FyCjkInEb5OHKvtcQ60D6GXHMa7bdHtkAceNB6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qibGMlhaYTrYwcbKMgu0Ye8fe12gc8hDPmEnblFon0xkbZBm23FOUpUO1SUyWdtkF
         uhuO6jfBx0mw71b6TUSVNCmB/n1oE+Ywt7ITiT1MBWS6O365vCBVYdUlaV833ClMx3
         OJWXrXEDJncbUslRSwORq4H5G2kYBu76aE0iIAAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.9 4/8] gfs2: don't call quota_unhold if quotas are not locked
Date:   Fri, 22 May 2020 10:51:53 -0400
Message-Id: <20200522145157.435215-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145157.435215-1-sashal@kernel.org>
References: <20200522145157.435215-1-sashal@kernel.org>
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
index fb9b1d702351..fb2e0ad945bf 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1112,7 +1112,7 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	int found;
 
 	if (!test_and_clear_bit(GIF_QD_LOCKED, &ip->i_flags))
-		goto out;
+		return;
 
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		struct gfs2_quota_data *qd;
@@ -1149,7 +1149,6 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 			qd_unlock(qda[x]);
 	}
 
-out:
 	gfs2_quota_unhold(ip);
 }
 
-- 
2.25.1

