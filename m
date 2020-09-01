Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946FC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C87E2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977862;
	bh=qljIfblDmxfPfpZWUyqSWGukl0rsSKmZDe1KNFHD8Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfik7GMnYmAG80s8bXVr3Wi6N5GZG1qnT8JjcQExGNv4AqmRhMUol8CbdOs7i+oxK
	 oJERe3JU+kSSvQbnPQpeOihjPj5jgUem+YZ7v2Yb/L7W30EDazZ+SbCKZXumz2hnA7
	 8SzghLhoSlnZCVnP6rr83dKDwldKOj3QlGt+tiNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgIAPbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbgIAP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38043206C0;
        Tue,  1 Sep 2020 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974129;
        bh=qljIfblDmxfPfpZWUyqSWGukl0rsSKmZDe1KNFHD8Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLCUILFWm42zekQRlDfw2xmZ9px9hujtXuhwxWf709uBn9xhSWosNaLFX95kR1NOV
         ylzmGIL4ImoxKKur64G2lyer6V5empWndGh1Y3/Wm/NAuPgU3G/H13B/JeQQGF63Su
         2zASwZK+X2zKfeA5GEf8SyqswR/aMSKAyIgEnpI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 055/214] ceph: fix potential mdsc use-after-free crash
Date:   Tue,  1 Sep 2020 17:08:55 +0200
Message-Id: <20200901150955.617884908@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
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
index b0077f5a31688..0f21073a51a1b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4068,6 +4068,9 @@ static void delayed_work(struct work_struct *work)
 
 	dout("mdsc delayed_work\n");
 
+	if (mdsc->stopping)
+		return;
+
 	mutex_lock(&mdsc->mutex);
 	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
 	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
@@ -4433,7 +4436,16 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
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



