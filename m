Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3929C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17812076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458148;
	bh=LKi61odvfuxeOQtUwqVPGGDvZrvazCumDpikHda+Rgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gm7UqGvwsMYyDI0zF1e/N/bquxo7r/IMKanM67EG8eszvdYSGqHgfwHLe8XUS0KzS
	 L9JuJWIZiw2QSGktcZbSf/LY5S1tVcVQ7BFoRaoflsIpda0CswkG6v/+W20yY3A+zh
	 HO1RPuobYV81hom7R6q8pSWOZfG3FNdx4KbFniMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgHCMfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgHCMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE4B2054F;
        Mon,  3 Aug 2020 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458135;
        bh=LKi61odvfuxeOQtUwqVPGGDvZrvazCumDpikHda+Rgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez9Dug+UrOaUpz5hdQoNr3DoB1qkPRp62fSYDPzmsXjNyLrpnzZLFCFLtpYEG8byO
         13snqceAVuMNiYmyDiF3UFFloIIZ1vBdA4XKO+hchi3US94COsJFzoPy+TSQlAWbb6
         yB9Bpo05e5iuKkM7CtxQ4IB5R/vx79vVH1GYnJyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com,
        Wang Hai <wanghai38@huawei.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 21/51] 9p/trans_fd: Fix concurrency del of req_list in p9_fd_cancelled/p9_read_work
Date:   Mon,  3 Aug 2020 14:20:06 +0200
Message-Id: <20200803121850.508725738@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 74d6a5d5662975aed7f25952f62efbb6f6dadd29 ]

p9_read_work and p9_fd_cancelled may be called concurrently.
In some cases, req->req_list may be deleted by both p9_read_work
and p9_fd_cancelled.

We can fix it by ignoring replies associated with a cancelled
request and ignoring cancelled request if message has been received
before lock.

Link: http://lkml.kernel.org/r/20200612090833.36149-1-wanghai38@huawei.com
Fixes: 60ff779c4abb ("9p: client: remove unused code and any reference to "cancelled" function")
Cc: <stable@vger.kernel.org> # v3.12+
Reported-by: syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index cbd8cfafb7940..32de8afbfbf8e 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -383,6 +383,10 @@ static void p9_read_work(struct work_struct *work)
 		if (m->req->status == REQ_STATUS_SENT) {
 			list_del(&m->req->req_list);
 			p9_client_cb(m->client, m->req, REQ_STATUS_RCVD);
+		} else if (m->req->status == REQ_STATUS_FLSHD) {
+			/* Ignore replies associated with a cancelled request. */
+			p9_debug(P9_DEBUG_TRANS,
+				 "Ignore replies associated with a cancelled request\n");
 		} else {
 			spin_unlock(&m->client->lock);
 			p9_debug(P9_DEBUG_ERROR,
@@ -717,11 +721,20 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 {
 	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
 
+	spin_lock(&client->lock);
+	/* Ignore cancelled request if message has been received
+	 * before lock.
+	 */
+	if (req->status == REQ_STATUS_RCVD) {
+		spin_unlock(&client->lock);
+		return 0;
+	}
+
 	/* we haven't received a response for oldreq,
 	 * remove it from the list.
 	 */
-	spin_lock(&client->lock);
 	list_del(&req->req_list);
+	req->status = REQ_STATUS_FLSHD;
 	spin_unlock(&client->lock);
 
 	return 0;
-- 
2.25.1



