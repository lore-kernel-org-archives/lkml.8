Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E1DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F9F208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953613;
	bh=5/HU+5mPMZDHSKhelDvZphwM7oa683qtuQ+sg6gNB/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vfC9rjl5szpk+gbv2/NH2pAMYvrGu8PcMlNaQkiBR3KXT/7wvWsafbriuMmDIBbmR
	 TPBOj68hDwgWirmz+oxKI42m/ymbTf8z4TC2oVbo9XjawDr5tghmTueovTfjHRXxD0
	 p7yO58/Utb4ikfFC65sXA0xbd+hMcbkWXBRB4WHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409855AbgDOM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409172AbgDOLp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51BE21582;
        Wed, 15 Apr 2020 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951125;
        bh=5/HU+5mPMZDHSKhelDvZphwM7oa683qtuQ+sg6gNB/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4BhK/EbQiscI/mqA6nt75eIlsi39IBKf3RCzD8Ba6GirNESsAuiErcGwbhKqsoWa
         GBf+U2DRjDrQ6DgnECUMItzDULkrN71Hrh35DUbMJs3ETPUCnM+MLDxXZW094MrbLE
         81n4iNowRb/P7IADrOkEuAGo9geR8PptvPjXDJYQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.4 38/84] cifs: Allocate encryption header through kmalloc
Date:   Wed, 15 Apr 2020 07:43:55 -0400
Message-Id: <20200415114442.14166-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

[ Upstream commit 3946d0d04bb360acca72db5efe9ae8440012d9dc ]

When encryption is used, smb2_transform_hdr is defined on the stack and is
passed to the transport. This doesn't work with RDMA as the buffer needs to
be DMA'ed.

Fix it by using kmalloc.

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/transport.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index e67a43fd037c9..fe1552cc8a0a7 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -466,7 +466,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	      struct smb_rqst *rqst, int flags)
 {
 	struct kvec iov;
-	struct smb2_transform_hdr tr_hdr;
+	struct smb2_transform_hdr *tr_hdr;
 	struct smb_rqst cur_rqst[MAX_COMPOUND];
 	int rc;
 
@@ -476,28 +476,34 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	if (num_rqst > MAX_COMPOUND - 1)
 		return -ENOMEM;
 
-	memset(&cur_rqst[0], 0, sizeof(cur_rqst));
-	memset(&iov, 0, sizeof(iov));
-	memset(&tr_hdr, 0, sizeof(tr_hdr));
-
-	iov.iov_base = &tr_hdr;
-	iov.iov_len = sizeof(tr_hdr);
-	cur_rqst[0].rq_iov = &iov;
-	cur_rqst[0].rq_nvec = 1;
-
 	if (!server->ops->init_transform_rq) {
 		cifs_server_dbg(VFS, "Encryption requested but transform "
 				"callback is missing\n");
 		return -EIO;
 	}
 
+	tr_hdr = kmalloc(sizeof(*tr_hdr), GFP_NOFS);
+	if (!tr_hdr)
+		return -ENOMEM;
+
+	memset(&cur_rqst[0], 0, sizeof(cur_rqst));
+	memset(&iov, 0, sizeof(iov));
+	memset(tr_hdr, 0, sizeof(*tr_hdr));
+
+	iov.iov_base = tr_hdr;
+	iov.iov_len = sizeof(*tr_hdr);
+	cur_rqst[0].rq_iov = &iov;
+	cur_rqst[0].rq_nvec = 1;
+
 	rc = server->ops->init_transform_rq(server, num_rqst + 1,
 					    &cur_rqst[0], rqst);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = __smb_send_rqst(server, num_rqst + 1, &cur_rqst[0]);
 	smb3_free_compound_rqst(num_rqst, &cur_rqst[1]);
+out:
+	kfree(tr_hdr);
 	return rc;
 }
 
-- 
2.20.1

