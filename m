Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5676A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942573;
	bh=TZccpjyP7WEIUJAhJODJhGrdEKjU6y+Dge74SzlcJeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sY2cC0MMRsQ/rCl2iViG/7MLTSGEemNeDg00uEWqycWiD1av90VU/ZyfQj8Q64eXI
	 rawPGRMketRdNwQqYtR/KbPfDqDsfAgPKb74OMm7NNGnJIkefEWOzXRcMsVbO8Y5te
	 4iF1yV6c53g8eFh95nItH1nxpfA19bTVvWzS0Emk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbgFWUCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbgFWUCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC462080C;
        Tue, 23 Jun 2020 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942568;
        bh=TZccpjyP7WEIUJAhJODJhGrdEKjU6y+Dge74SzlcJeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJSoGaMEAuk4o3OYKCv9lqCseZCz2gvyb92rw+9KZxECJPYVs5ukA5jAxmy3A6NFn
         C1dr+FCvB1f+Fbqv1yE6FBNBUdYmADh4IgfI9DLtGDMnBrLVJcT4L/0dr4V8fbfh5i
         TCbSRI097esBCK7qfnAEtwzOEi0UokyruJ0+IX2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 050/477] RDMA/uverbs: Fix create WQ to use the given user handle
Date:   Tue, 23 Jun 2020 21:50:47 +0200
Message-Id: <20200623195409.969958562@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

[ Upstream commit dbd67252869ba58d086edfa14113e10f8059b97e ]

Fix create WQ to use the given user handle, in addition dropped some
duplicated code from this flow.

Fixes: fd3c7904db6e ("IB/core: Change idr objects to use the new schema")
Fixes: f213c0527210 ("IB/uverbs: Add WQ support")
Link: https://lore.kernel.org/r/20200506082444.14502-9-leon@kernel.org
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 060b4ebbd2ba4..d6e9cc94dd900 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2959,6 +2959,7 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
 	wq_init_attr.create_flags = cmd.create_flags;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
+	obj->uevent.uobject.user_handle = cmd.user_handle;
 
 	wq = pd->device->ops.create_wq(pd, &wq_init_attr, &attrs->driver_udata);
 	if (IS_ERR(wq)) {
@@ -2976,8 +2977,6 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	atomic_set(&wq->usecnt, 0);
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&cq->usecnt);
-	wq->uobject = obj;
-	obj->uevent.uobject.object = wq;
 
 	memset(&resp, 0, sizeof(resp));
 	resp.wq_handle = obj->uevent.uobject.id;
-- 
2.25.1



