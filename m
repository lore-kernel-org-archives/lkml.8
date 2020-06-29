Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C700C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B657206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460851;
	bh=Wey9NWm6SEoUMi8gGkWxezjIJSpDGHLnsTrE9L0Do0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q3tbiWToxAVQVlgTyw5VV2jAsF3hK24M3QrMS0IDRERAEyDj8YyjvaEpqaauOLoRP
	 t0rEZTvNHUbjS1N5QB3yLDGiV1ABUKFa9mqN9cnCsJmeZL0UmjGgMYau06vtJ0mqyo
	 XpLjTk5XsYa/h4cUrrYbWaILX7RG0stGKngYw1yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgF2UAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgF2TkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961C5251BF;
        Mon, 29 Jun 2020 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444493;
        bh=Wey9NWm6SEoUMi8gGkWxezjIJSpDGHLnsTrE9L0Do0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3FhNENfVyGIk2Op5pvNMa/INtb0Y91TGxpXQJFYbx1dMxSZTqKKgRCPrY3okxZzA
         z3E1MbspWMIATaTlDlRWiWufAhbQ71Yb5fD3tRpe7yylN+CA9/VoLEO3dY0aZhibSg
         5BvWpRU2li3hLnjiytI7xcGmXF4bt+7Bg0m7xOIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Jeff Layton <jlayton@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 170/178] sunrpc: fixed rollback in rpc_gssd_dummy_populate()
Date:   Mon, 29 Jun 2020 11:25:15 -0400
Message-Id: <20200629152523.2494198-171-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit b7ade38165ca0001c5a3bd5314a314abbbfbb1b7 upstream.

__rpc_depopulate(gssd_dentry) was lost on error path

cc: stable@vger.kernel.org
Fixes: commit 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to hold open")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/rpc_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index b71a39ded930a..37792675ed571 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1317,6 +1317,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	q.len = strlen(gssd_dummy_clnt_dir[0].name);
 	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
 	if (!clnt_dentry) {
+		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
 		goto out;
 	}
-- 
2.25.1

