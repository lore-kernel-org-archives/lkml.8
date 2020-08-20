Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C399820658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919567;
	bh=GrXqHisVAEBfsmqbEkU2lfCyTUGM/JkarYuagrRTCc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GUNL6x2q3o9pxymh74I48tV3Q798N0QIZKWtzTL9HjF5xTtBuCGHP7ldupOmFSvIh
	 MB8bMCvVnnwxRIZFP+mucfP07IvgiC2iT76Ks2QfimwFIpP5sTl+OcyZV508hy6SpT
	 FZhqBvlpGE2Cux63ajXuI2QlC7/dWkrNb+rU4xdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgHTKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbgHTKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:19:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB01E2067C;
        Thu, 20 Aug 2020 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918795;
        bh=GrXqHisVAEBfsmqbEkU2lfCyTUGM/JkarYuagrRTCc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5psh+jiONlkrdCVVFmShkF1pxhL89GoitcIFdxs/KRkYoZg3paTgFbPBid2fquFM
         c/9HT7DrTQ4QAneVz98ZfTeWC90cdLxv3hZ1QI+wG673ZS77pwweR9hmCsMFFx8bam
         sttqUXxUYWX9nOH25n6/x1auLcj5ql+2QSXIupdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/149] net/9p: validate fds in p9_fd_open
Date:   Thu, 20 Aug 2020 11:21:57 +0200
Message-Id: <20200820092127.675555741@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit a39c46067c845a8a2d7144836e9468b7f072343e ]

p9_fd_open just fgets file descriptors passed in from userspace, but
doesn't verify that they are valid for read or writing.  This gets
cought down in the VFS when actually attempting a read or write, but
a new warning added in linux-next upsets syzcaller.

Fix this by just verifying the fds early on.

Link: http://lkml.kernel.org/r/20200710085722.435850-1-hch@lst.de
Reported-by: syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
[Dominique: amend goto as per Doug Nazar's review]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_fd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 2f68ffda3715b..eab058f93ec97 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -793,20 +793,28 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 		return -ENOMEM;
 
 	ts->rd = fget(rfd);
+	if (!ts->rd)
+		goto out_free_ts;
+	if (!(ts->rd->f_mode & FMODE_READ))
+		goto out_put_rd;
 	ts->wr = fget(wfd);
-	if (!ts->rd || !ts->wr) {
-		if (ts->rd)
-			fput(ts->rd);
-		if (ts->wr)
-			fput(ts->wr);
-		kfree(ts);
-		return -EIO;
-	}
+	if (!ts->wr)
+		goto out_put_rd;
+	if (!(ts->wr->f_mode & FMODE_WRITE))
+		goto out_put_wr;
 
 	client->trans = ts;
 	client->status = Connected;
 
 	return 0;
+
+out_put_wr:
+	fput(ts->wr);
+out_put_rd:
+	fput(ts->rd);
+out_free_ts:
+	kfree(ts);
+	return -EIO;
 }
 
 static int p9_socket_open(struct p9_client *client, struct socket *csocket)
-- 
2.25.1



