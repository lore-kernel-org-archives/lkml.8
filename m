Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9746BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD742072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159278;
	bh=vvAn8EDpPr9ZfwBzIstG1rQ4gCyXCXUholFYEgR/AA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6aGqgLChEJbvEDuo3ZPO1KPt49W3SwKvxVQV76AWp8RjtJnaptg/sZsHhPHa7L7w
	 hAyeIoYPoBCBzgbJUXXg1MSGHiOYUEv4fx5noF2ILVtJ0XloH/7rA1hfw1FJy6UCP5
	 +xC22EU+m9OUluSwEr5kGE0pF/aU7KLMkLzOueW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgEVOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbgEVOvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0D222259;
        Fri, 22 May 2020 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159091;
        bh=vvAn8EDpPr9ZfwBzIstG1rQ4gCyXCXUholFYEgR/AA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1xkLJxlheho1YRLiYUdpVv5DIoesF5GMHdjTU5EuVAvYWXu3Pgv0nWL0gydKVHdOo
         8ZH4mQ6eQRg7d5tACs3wzYzRdSLXHGi52yzZbkPRHeyAGL3sFlkSYnXZ6s1xz2/duO
         w2M4TYpBQdfIDnvrcnvGB1ScFTCe5vRrc6duIacA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.19 09/19] gfs2: move privileged user check to gfs2_quota_lock_check
Date:   Fri, 22 May 2020 10:51:10 -0400
Message-Id: <20200522145120.434921-9-sashal@kernel.org>
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

[ Upstream commit 4ed0c30811cb4d30ef89850b787a53a84d5d2bcb ]

Before this patch, function gfs2_quota_lock checked if it was called
from a privileged user, and if so, it bypassed the quota check:
superuser can operate outside the quotas.
That's the wrong place for the check because the lock/unlock functions
are separate from the lock_check function, and you can do lock and
unlock without actually checking the quotas.

This patch moves the check to gfs2_quota_lock_check.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 3 +--
 fs/gfs2/quota.h | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 0efae7a0ee80..dd0f9bc13164 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1043,8 +1043,7 @@ int gfs2_quota_lock(struct gfs2_inode *ip, kuid_t uid, kgid_t gid)
 	u32 x;
 	int error = 0;
 
-	if (capable(CAP_SYS_RESOURCE) ||
-	    sdp->sd_args.ar_quota != GFS2_QUOTA_ON)
+	if (sdp->sd_args.ar_quota != GFS2_QUOTA_ON)
 		return 0;
 
 	error = gfs2_quota_hold(ip, uid, gid);
diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
index 836f29480be6..e3a6e2404d11 100644
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -47,7 +47,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
 	int ret;
 
 	ap->allowed = UINT_MAX; /* Assume we are permitted a whole lot */
-	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
+	if (capable(CAP_SYS_RESOURCE) ||
+	    sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
 		return 0;
 	ret = gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
 	if (ret)
-- 
2.25.1

