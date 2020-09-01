Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A5EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1395207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980771;
	bh=fjmDARNuO3p8EyzzMXvS56Vf8PfN9ySp3dmgUpJE0JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLTf2D/sRk0WiouS8bWrbeqysj9CL1m3EnAt9Gk3uC8NDoGudxlfaTAd6HJWGh9pT
	 s9w4tr7qsEGsJy1Unqv83zYbxX9tS5qKOpSBl78gFgPhCFlvBVKYUEV5Hf0XwcRWFs
	 diqdLCYUTHh9Pe3yJE4i9ZXa2JWKZGANy7k3s7I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgIART3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgIAPNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:13:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 944012078B;
        Tue,  1 Sep 2020 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973222;
        bh=fjmDARNuO3p8EyzzMXvS56Vf8PfN9ySp3dmgUpJE0JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plhGvfKXxQR8UontRaPPHBxp8tyTEMq/L6DqB/vbnUgEJbzLC47wICx0JIgPpVH6h
         7vrAGIMkCL/PVunJ1dxEPOVLW+FhzbVtcVfubMqbm/YRKY4kCzuydrXW/vesUvGMy6
         9pXhAr3EI0FBT0e4F1GYj6bixsOmSakuUfM2h7S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 26/62] ceph: fix potential mdsc use-after-free crash
Date:   Tue,  1 Sep 2020 17:10:09 +0200
Message-Id: <20200901150922.039102547@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit fa9967734227b44acb1b6918033f9122dc7825b9 ]

Make sure the delayed work stopped before releasing the resources.

cancel_delayed_work_sync() will only guarantee that the work finishes
executing if the work is already in the ->worklist.  That means after
the cancel_delayed_work_sync() returns, it will leave the work requeued
if it was rearmed at the end. That can lead to a use after free once the
work struct is freed.

Fix it by flushing the delayed work instead of trying to cancel it, and
ensure that the work doesn't rearm if the mdsc is stopping.

URL: https://tracker.ceph.com/issues/46293
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a5de8e22629ba..b7fd7d69be075 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3428,6 +3428,9 @@ static void delayed_work(struct work_struct *work)
 	dout("mdsc delayed_work\n");
 	ceph_check_delayed_caps(mdsc);
 
+	if (mdsc->stopping)
+		return;
+
 	mutex_lock(&mdsc->mutex);
 	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
 	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
@@ -3752,7 +3755,16 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
 	dout("stop\n");
-	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
+	/*
+	 * Make sure the delayed work stopped before releasing
+	 * the resources.
+	 *
+	 * Because the cancel_delayed_work_sync() will only
+	 * guarantee that the work finishes executing. But the
+	 * delayed work will re-arm itself again after that.
+	 */
+	flush_delayed_work(&mdsc->delayed_work);
+
 	if (mdsc->mdsmap)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
-- 
2.25.1



