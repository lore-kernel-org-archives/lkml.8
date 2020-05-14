Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AC0207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482628;
	bh=vuzK44KzWkdL+i/AG+y3AzKDLu8c1TW+lmWn/sqUuHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JW4gnbRdhbDUAvuuOU1I6yyuu9F2uC3xJQXHH/AShjbTcdxzK0V1hz+yBZKu3baqh
	 UCHTaNY8Y+4idMYDkEVeJnv3MYGh3J502HrPjh54w9DFATt+7BP0AHqhsBoIMwq85d
	 RkJOV7NBXnVPZw4tg64f+VqDxU0FbrLtWrIk8cxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgENS5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgENS4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF352074A;
        Thu, 14 May 2020 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482597;
        bh=vuzK44KzWkdL+i/AG+y3AzKDLu8c1TW+lmWn/sqUuHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHnD+3hAEkxV4QE+z5sdT1GH7dY6IVr/P2zYfE3ZwevUCtv+q05V573TGbwQZpteC
         h1EKdu7Ysob2aYdSmHiOwXOZFQV+xb64LxuJzP2GUbVbH7r/gJO5SkpzzbhN768/+/
         n1pmB/L87ltEwbWo9tJQxWeKVh8HlghokqvYk9KE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 09/14] ceph: fix double unlock in handle_cap_export()
Date:   Thu, 14 May 2020 14:56:20 -0400
Message-Id: <20200514185625.21753-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185625.21753-1-sashal@kernel.org>
References: <20200514185625.21753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

[ Upstream commit 4d8e28ff3106b093d98bfd2eceb9b430c70a8758 ]

If the ceph_mdsc_open_export_target_session() return fails, it will
do a "goto retry", but the session mutex has already been unlocked.
Re-lock the mutex in that case to ensure that we don't unlock it
twice.

Signed-off-by: Wu Bo <wubo40@huawei.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index efdf81ea3b5f8..3d0497421e62b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3293,6 +3293,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
 	}
 	goto retry;
 
-- 
2.20.1

