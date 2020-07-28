Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FD220759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgG1Mlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:41:40 -0400
Received: from 107-174-27-60-host.colocrossing.com ([107.174.27.60]:35556 "EHLO
        ozlabs.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgG1Mlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:41:39 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id EDB48AE800ED;
        Tue, 28 Jul 2020 08:38:56 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH kernel] 9p/trans_fd: Check file mode at opening
Date:   Tue, 28 Jul 2020 22:41:29 +1000
Message-Id: <20200728124129.130856-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fd" transport layer uses 2 file descriptors passed externally
and calls kernel_write()/kernel_read() on these. If files were opened
without FMODE_WRITE/FMODE_READ, WARN_ON_ONCE() will fire.

This adds file mode checking in p9_fd_open; this returns -EBADF to
preserve the original behavior.

Found by syzkaller.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 net/9p/trans_fd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 13cd683a658a..62cdfbd01f0a 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -797,6 +797,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
 
 static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 {
+	bool perm;
 	struct p9_trans_fd *ts = kzalloc(sizeof(struct p9_trans_fd),
 					   GFP_KERNEL);
 	if (!ts)
@@ -804,12 +805,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 
 	ts->rd = fget(rfd);
 	ts->wr = fget(wfd);
-	if (!ts->rd || !ts->wr) {
+	perm = ts->rd && (ts->rd->f_mode & FMODE_READ) &&
+	       ts->wr && (ts->wr->f_mode & FMODE_WRITE);
+	if (!ts->rd || !ts->wr || !perm) {
 		if (ts->rd)
 			fput(ts->rd);
 		if (ts->wr)
 			fput(ts->wr);
 		kfree(ts);
+		if (!perm)
+			return -EBADF;
 		return -EIO;
 	}
 
-- 
2.17.1

