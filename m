Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2453F2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458145;
	bh=Nr2DZ258aumtJCnTDAvnz2EoPonXjfadvG+fjwqD5Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3FtpBkEzfKOIc9xfBSF+Tr1m4qilFs7Oj/qkLJaINEBw8vsMOqgQn7Ort5qCnUUp
	 QtS4uwE9N9utolHN7bK7SS5dzfycRTWh1oiXo3thriavmwHuQljMyEj/mWeqXdjN/b
	 9hZ53yCc6HW7CAVfYirgk8JVQa2GAGg9PTf2EZts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHCMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgHCMfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB8F204EC;
        Mon,  3 Aug 2020 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458132;
        bh=Nr2DZ258aumtJCnTDAvnz2EoPonXjfadvG+fjwqD5Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFpPB/9gNJ7uaBnmzE/HXLpsmgm6V3SSpqa+JdEFdRlgxcTPM1EAEg1RGUR7b0ayW
         9fiWNaXSaGjDvuj1U5o3+d+JkMRk7DCnGoEiUqkMXEhsONWAH5BrUWg+eSD6ewGQy4
         j26VE/azFAQ2C8xonhlSG43FjBA17rjMgglQY1oU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/51] 9p/trans_fd: abort p9_read_work if req status changed
Date:   Mon,  3 Aug 2020 14:20:05 +0200
Message-Id: <20200803121850.473168725@linuxfoundation.org>
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

From: Dominique Martinet <dominique.martinet@cea.fr>

[ Upstream commit e4ca13f7d075e551dc158df6af18fb412a1dba0a ]

p9_read_work would try to handle an errored req even if it got put to
error state by another thread between the lookup (that worked) and the
time it had been fully read.
The request itself is safe to use because we hold a ref to it from the
lookup (for m->rreq, so it was safe to read into the request data buffer
until this point), but the req_list has been deleted at the same time
status changed, and client_cb already has been called as well, so we
should not do either.

Link: http://lkml.kernel.org/r/1539057956-23741-1-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a9c65f13b7f51..cbd8cfafb7940 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -301,7 +301,6 @@ static void p9_read_work(struct work_struct *work)
 {
 	int n, err;
 	struct p9_conn *m;
-	int status = REQ_STATUS_ERROR;
 
 	m = container_of(work, struct p9_conn, rq);
 
@@ -381,11 +380,17 @@ static void p9_read_work(struct work_struct *work)
 	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
 		spin_lock(&m->client->lock);
-		if (m->req->status != REQ_STATUS_ERROR)
-			status = REQ_STATUS_RCVD;
-		list_del(&m->req->req_list);
-		/* update req->status while holding client->lock  */
-		p9_client_cb(m->client, m->req, status);
+		if (m->req->status == REQ_STATUS_SENT) {
+			list_del(&m->req->req_list);
+			p9_client_cb(m->client, m->req, REQ_STATUS_RCVD);
+		} else {
+			spin_unlock(&m->client->lock);
+			p9_debug(P9_DEBUG_ERROR,
+				 "Request tag %d errored out while we were reading the reply\n",
+				 m->rc.tag);
+			err = -EIO;
+			goto error;
+		}
 		spin_unlock(&m->client->lock);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
-- 
2.25.1



