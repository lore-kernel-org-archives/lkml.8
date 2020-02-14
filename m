Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348B0217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698195;
	bh=Uuaz7NNJK5HWHiGG1+MzfBTJBpbO3wnZk8aB3khNziM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM/JlhgOhpdZLNsUv5a3K6QPiV9ofv2tAnS+qxKR5AxQst+yqNlPn5n842Hac2Srx
	 dVVtSJA9qjdUzeYoLoxrTQDpRaGdWZEJCU3CE/L74wwIelCwBvqMnaEAQS8zeuA+MD
	 0D0T3+JJLPWSZiEW7xMm5WQXUyMJ1kt1wzjB+D5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393713AbgBNQgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405849AbgBNQYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FFB24791;
        Fri, 14 Feb 2020 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697457;
        bh=Uuaz7NNJK5HWHiGG1+MzfBTJBpbO3wnZk8aB3khNziM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/oEMpbu894vU9e1CrFOabepx85f0sA3UiBXft+RiOxZTis+ibT1kptwN/D9UsDHk
         t8MDKAqRNRhGkP1It2HzFnw4DZsDMEY5WSGQxkzYNJ8N1dy1o7QFNTeDpQJkiflVWk
         i/tbhmk9pw37lUrxsuH7JZ/NZENO5jpfqkkN1IsU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Milkowski <rmilkowski@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 140/141] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Fri, 14 Feb 2020 11:21:20 -0500
Message-Id: <20200214162122.19794-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

[ Upstream commit 924491f2e476f7234d722b24171a4daff61bbe13 ]

Currently, if an nfs server returns NFS4ERR_EXPIRED to open(),
we return EIO to applications without even trying to recover.

Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle revoke/expiry of a single stateid")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
Reviewed-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ca4249ae644f2..632d3c3f8dfb3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2916,6 +2916,11 @@ static struct nfs4_state *nfs4_do_open(struct inode *dir,
 			exception.retry = 1;
 			continue;
 		}
+		if (status == -NFS4ERR_EXPIRED) {
+			nfs4_schedule_lease_recovery(server->nfs_client);
+			exception.retry = 1;
+			continue;
+		}
 		if (status == -EAGAIN) {
 			/* We must have found a delegation */
 			exception.retry = 1;
-- 
2.20.1

