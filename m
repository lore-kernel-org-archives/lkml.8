Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70642C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469B72083B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457878;
	bh=mmLLq4bPGESN35BigUKSGoPRpQeB72bEz7jTDimc6Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2B21WQdazbFZ5m9ibe9BiQ8+aABNHTx6/WuDkEcyGoq5K7QxyHdQ+X3h33Te3A8Ag
	 tfQzljLQjjQWE+SoPSouYJaTVxrxmPQa9gLjCzTkTCnPusQB4TbaghUuiJi4Yd9Rxs
	 2+4cQicNhAbtG3yqpc11RX4HaaAFK4NA8s/LEYlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgHCMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbgHCMbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:31:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB5920781;
        Mon,  3 Aug 2020 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457871;
        bh=mmLLq4bPGESN35BigUKSGoPRpQeB72bEz7jTDimc6Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExEO0IFltRA9TyUHU9muoNsQlIpjxsPTLZInY6OZhJbaKH0AvTP9om1xiRVnTkaoe
         olYBj33QWiSvMGbFCAHYv6P1vRlSrb3rMqMvzWQAgWZ25ZhPf+2GYAneF9Xq3Z8CKp
         m76dEklx5GpLubzGk5+NERjU7l+V6D34uur+Xz+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com,
        Wang Hai <wanghai38@huawei.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4.19 13/56] 9p/trans_fd: Fix concurrency del of req_list in p9_fd_cancelled/p9_read_work
Date:   Mon,  3 Aug 2020 14:19:28 +0200
Message-Id: <20200803121850.962253359@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

commit 74d6a5d5662975aed7f25952f62efbb6f6dadd29 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_fd.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -377,6 +377,10 @@ static void p9_read_work(struct work_str
 		if (m->rreq->status == REQ_STATUS_SENT) {
 			list_del(&m->rreq->req_list);
 			p9_client_cb(m->client, m->rreq, REQ_STATUS_RCVD);
+		} else if (m->rreq->status == REQ_STATUS_FLSHD) {
+			/* Ignore replies associated with a cancelled request. */
+			p9_debug(P9_DEBUG_TRANS,
+				 "Ignore replies associated with a cancelled request\n");
 		} else {
 			spin_unlock(&m->client->lock);
 			p9_debug(P9_DEBUG_ERROR,
@@ -718,11 +722,20 @@ static int p9_fd_cancelled(struct p9_cli
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
 	p9_req_put(req);
 


