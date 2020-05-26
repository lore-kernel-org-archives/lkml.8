Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600E8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A06A20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520354;
	bh=XuGZ5Clj0CModmrpSHSGviwvKme1dPJp3GeVxRp3sBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DYf6zagHuJS3dDfEaTC1sP6C+6lCG0GaaGbvT11QoThN+oB7HtQyXpfaDKDQ9pC+5
	 yMuWkodBq7Mx145VFvUOtEq5Z3TjARFwdxqEmUykL0COV/YUVh/azH9Ge0GCkgAIqQ
	 hp+TxdlQ+wx9IUHhkaAJ9c5ymvZ4FM+KEKjnZ7Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392092AbgEZTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403919AbgEZTM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA7D20888;
        Tue, 26 May 2020 19:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520349;
        bh=XuGZ5Clj0CModmrpSHSGviwvKme1dPJp3GeVxRp3sBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbvTA4a9gnVKJTLHZN46MP+RdRxY27K67iXEv/Z/IDm+rgEw2yL/0aCvWQUUB1RnF
         d6OgelJJ4Z3hhUdXBU9jkxR396i/hVob9bf73kPNNA/woBFhd4cfEWaY8tD/2l5K+R
         YB+w05q5KzQevSMsXKdiKvDa+H4+MBDKKpe9xk+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wu Bo <wubo40@huawei.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 044/126] ceph: fix double unlock in handle_cap_export()
Date:   Tue, 26 May 2020 20:53:01 +0200
Message-Id: <20200526183941.683811049@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d050acc1fd5d..f50204380a65 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3707,6 +3707,7 @@ retry:
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
 	}
 	goto retry;
 
-- 
2.25.1



