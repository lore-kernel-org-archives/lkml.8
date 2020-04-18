Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A3FC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEEB21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221227;
	bh=+7j9GFWXunKNP2Ttv6Fhq8oqYAqAHsbaixIo/ARYwLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E4Y0BbBbomUacv2MOtMhdTw8ucRqwPscQ7cm8s4+46TtFSYAudQmXqh0A8Ew0hhBR
	 myyU3+zbyPp8lIWUUjPoNcIDWT7OTvf4mxx7KJXTT6dqB/Tolibxcfrb9c5a/1rue5
	 +R5GZA8StIg9+DxVfMwNHbCyS3kQLJtmKFBxOimg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgDROoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgDROoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DE92224F;
        Sat, 18 Apr 2020 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221050;
        bh=+7j9GFWXunKNP2Ttv6Fhq8oqYAqAHsbaixIo/ARYwLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDVxQdwzHcz/TdVf35Di5J4/uhqCBF8SuLL9bSQCzuzL2JrCypTdYGSj5hFURiWkG
         iliISZd27f/0BotmLhH+fpFXc9BFm0hG6YFjIqq2FYWeECoGdq1ewDpPIiJwI1cH8P
         tmehKzcxYEqilxxWkZ7iNmIbyCGoAkPwwH5oqdJ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 04/23] ceph: return ceph_mdsc_do_request() errors from __get_parent()
Date:   Sat, 18 Apr 2020 10:43:46 -0400
Message-Id: <20200418144405.10565-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144405.10565-1-sashal@kernel.org>
References: <20200418144405.10565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit c6d50296032f0b97473eb2e274dc7cc5d0173847 ]

Return the error returned by ceph_mdsc_do_request(). Otherwise,
r_target_inode ends up being NULL this ends up returning ENOENT
regardless of the error.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 1780218a48f08..f8e1f31e46439 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -157,6 +157,11 @@ static struct dentry *__get_parent(struct super_block *sb,
 
 	req->r_num_caps = 1;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (err) {
+		ceph_mdsc_put_request(req);
+		return ERR_PTR(err);
+	}
+
 	inode = req->r_target_inode;
 	if (inode)
 		ihold(inode);
-- 
2.20.1

