Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4B20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265241;
	bh=jfT/vt+aedy9qZ+p0lGN1nj1vzPO6uDTNZJwx++fvUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9zRCsGv7Ht0xaJy0lIH7MGgo9MmlumzP90gBjNbL8Uqaw+VuutP8yrYOefWeJLTq
	 hjE8v505fO40zGaWNWAfu0yW9V9NzyId16hXXzX0hiw4lS3MD62z0JlyMIur05goKP
	 A5FoGQWqVtXumcF0AqRVb0hro1dhZX9rCpHY6wqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgCZXY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgCZXYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF7D2083E;
        Thu, 26 Mar 2020 23:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265093;
        bh=jfT/vt+aedy9qZ+p0lGN1nj1vzPO6uDTNZJwx++fvUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMycbxlHsSAYM8jLUf6+ENf0EJ2yvf87HTg2kRKjlDhhvUVD/loT8exg49KkFuJdO
         Ur8jZggT0GYrFq+vxztdvn5LKBWCbcbhj6KzTpKucDCGalOngkFBuTuCcaJ2MkqE2v
         QaR9kFd+r1zKzw//yfV8tt+Cc6NvykHLlv1qjvcU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 19/19] drm/lease: fix WARNING in idr_destroy
Date:   Thu, 26 Mar 2020 19:24:31 -0400
Message-Id: <20200326232431.7816-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit b216a8e7908cd750550c0480cf7d2b3a37f06954 ]

drm_lease_create takes ownership of leases. And leases will be released
by drm_master_put.

drm_master_put
    ->drm_master_destroy
            ->idr_destroy

So we needn't call idr_destroy again.

Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1584518030-4173-1-git-send-email-hqjagain@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_lease.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index b481cafdde280..825abe38201ac 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -542,10 +542,12 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	}
 
 	DRM_DEBUG_LEASE("Creating lease\n");
+	/* lessee will take the ownership of leases */
 	lessee = drm_lease_create(lessor, &leases);
 
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
+		idr_destroy(&leases);
 		goto out_leases;
 	}
 
@@ -580,7 +582,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 out_leases:
 	put_unused_fd(fd);
-	idr_destroy(&leases);
 
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;
-- 
2.20.1

