Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED129C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9185206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255731;
	bh=4c1eSCdM1d4z+8oRJemUVWfwmsfEKKuAFN9JAfMPK0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSPmq86ioZZAv2X+HVL+yCIiFFo4t6huxQhjeuGOGgOU9AxNsAqaFaDv63NPPHJyd
	 gEB9eu6SHsWvjv2c+nwxiTL5mx9Hy9OKGbfE8utWptAvU/6RGc4KUyRETUnq801L7b
	 mTO9+1Xi3Ou165JIhhGZNMCUX34JuD6Ls23iygb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgD3OIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgD3NwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B5024957;
        Thu, 30 Apr 2020 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254722;
        bh=4c1eSCdM1d4z+8oRJemUVWfwmsfEKKuAFN9JAfMPK0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZAcGseHmNsfEcHae6qg5CRgT2gZUlUfWlos1GJY4W7DLXqAPvCmw93fkNuIPnenW
         1VAUUlOVQcy0/SVd+yDE6TCoEs3IOQfPB/3vCNDbdc7dnJwwWq0RxY3FjBU+t7W9Wt
         C2SaqfVx4fGapMzGIUm4XV2bv4I9pa5HOLYBDapg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 70/79] afs: Fix to actually set AFS_SERVER_FL_HAVE_EPOCH
Date:   Thu, 30 Apr 2020 09:50:34 -0400
Message-Id: <20200430135043.19851-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 69cf3978f3ada4e54beae4ad44868b5627864884 ]

AFS keeps track of the epoch value from the rxrpc protocol to note (a) when
a fileserver appears to have restarted and (b) when different endpoints of
a fileserver do not appear to be associated with the same fileserver
(ie. all probes back from a fileserver from all of its interfaces should
carry the same epoch).

However, the AFS_SERVER_FL_HAVE_EPOCH flag that indicates that we've
received the server's epoch is never set, though it is used.

Fix this to set the flag when we first receive an epoch value from a probe
sent to the filesystem client from the fileserver.

Fixes: 3bf0fb6f33dd ("afs: Probe multiple fileservers simultaneously")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cmservice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 6765949b3aab6..380ad5ace7cfd 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -169,7 +169,7 @@ static int afs_record_cm_probe(struct afs_call *call, struct afs_server *server)
 
 	spin_lock(&server->probe_lock);
 
-	if (!test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
+	if (!test_and_set_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
 		server->cm_epoch = call->epoch;
 		server->probe.cm_epoch = call->epoch;
 		goto out;
-- 
2.20.1

