Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32537206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgFKBya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:54:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgFKBy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:54:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4998A452455622F1EEA3;
        Thu, 11 Jun 2020 09:49:33 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 11 Jun 2020
 09:49:26 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <davem@davemloft.net>
CC:     <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH] 9p/trans_fd: Fix concurrency del of req_list in p9_fd_cancelled/p9_read_work
Date:   Thu, 11 Jun 2020 09:48:55 +0800
Message-ID: <20200611014855.60550-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p9_read_work and p9_fd_cancelled may be called concurrently.
Before list_del(&m->rreq->req_list) in p9_read_work is called,
the req->req_list may have been deleted in p9_fd_cancelled.
We can fix it by setting req->status to REQ_STATUS_FLSHD after
list_del(&req->req_list) in p9_fd_cancelled.

Before list_del(&req->req_list) in p9_fd_cancelled is called,
the req->req_list may have been deleted in p9_read_work.
We should return when req->status = REQ_STATUS_RCVD which means
we just received a response for oldreq, so we need do nothing
in p9_fd_cancelled.

Fixes: 60ff779c4abb ("9p: client: remove unused code and any reference to "cancelled" function")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/9p/trans_fd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f868cf6fba79..a563699629cb 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -718,11 +718,18 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 {
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
-	/* we haven't received a response for oldreq,
-	 * remove it from the list.
+	/* If req->status == REQ_STATUS_RCVD, it means we just received a
+	 * response for oldreq, we need do nothing here. Else, remove it from
+	 * the list.
 	 */
 	spin_lock(&client->lock);
+	if (req->status == REQ_STATUS_RCVD) {
+		spin_unlock(&client->lock);
+		return 0;
+	}
+
 	list_del(&req->req_list);
+	req->status = REQ_STATUS_FLSHD;
 	spin_unlock(&client->lock);
 	p9_req_put(req);
 
-- 
2.17.1

