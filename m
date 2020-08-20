Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4472C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2875207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882060;
	bh=0yGrpJu7gFKvvJbC+j+tbevmFHvNI47Gc6ry9YWKlB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMC4Vm4WRjW3Y9T9uuN6STeaGXVg4TnncaPJcfyoBhTFmqnkuvutZryFwBXiYPkY/
	 NAu2NRpvC/csKbIxKRLBoy2no680gZqYIaSCK59n+KjMC+IpcEDZ3V+aq1AJkekx9f
	 5h3MqIila1DImMK2jn5V89KNZGxIJNnXLNO1MXN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgHTAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgHTADS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:03:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434BC21744;
        Thu, 20 Aug 2020 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881797;
        bh=0yGrpJu7gFKvvJbC+j+tbevmFHvNI47Gc6ry9YWKlB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqVKnU5wUwdOtGVNItp4VAq7cZBco2Ol0S6O0NoJQKQU2p0S6W+5LOSSQV5tILjj2
         cDs5wUh0HPPGSFAgkNTrgLpdbiL7X8cxFj4jwj1ez9mO43YRBDr5IeVeoHDsQyzk7G
         JkKYChiLUzyjpGDjviTT6P14DO8t1mtaElVtY7Gs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>,
        syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/18] ceph: fix use-after-free for fsc->mdsc
Date:   Wed, 19 Aug 2020 20:02:54 -0400
Message-Id: <20200820000302.215560-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000302.215560-1-sashal@kernel.org>
References: <20200820000302.215560-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit a7caa88f8b72c136f9a401f498471b8a8e35370d ]

If the ceph_mdsc_init() fails, it will free the mdsc already.

Reported-by: syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a2e903203bf9f..0fa14d8b9c64c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3682,7 +3682,6 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 		return -ENOMEM;
 	}
 
-	fsc->mdsc = mdsc;
 	init_completion(&mdsc->safe_umount_waiters);
 	init_waitqueue_head(&mdsc->session_close_wq);
 	INIT_LIST_HEAD(&mdsc->waiting_for_map);
@@ -3723,6 +3722,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 	strscpy(mdsc->nodename, utsname()->nodename,
 		sizeof(mdsc->nodename));
+
+	fsc->mdsc = mdsc;
 	return 0;
 }
 
-- 
2.25.1

