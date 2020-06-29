Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326D620663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458996;
	bh=1WGeN2iImmzjr6Ytzn0/DYV/NAlrw75kxzi1kaGueoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkkBS9h7Oif++77tbeaTJdUBrZdljwT08WAo23L2FJjwGj8wpECYsGvpJ7lguxMnf
	 K7B4VOH3eD3opVdq/+xqBnmukbIWUgCVNSa3wqoDjaq+pAK/MmRVYqqcp/V4G3scQK
	 unw/OKPdgjLW7Pg2KpsYFryYLahbFlozoavb9e5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgF2T3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732658AbgF2TZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBACF253B9;
        Mon, 29 Jun 2020 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445282;
        bh=1WGeN2iImmzjr6Ytzn0/DYV/NAlrw75kxzi1kaGueoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLnAQnplnsKkDVnSI8/jSy1UfLHN1B5Wm1NE1BpLrq2F3GBe/PGYax70GqnTVOynd
         ewc7iVABOTPaHQdm2q/gZEIw0V0tgGLzLj/ieHz2acxrsnt9ZeOQkcn7t4qA/gBmC7
         Atd7uzlr9HYgT99Q/BlGnUZ0QFw60ItcrVnVvKmk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 061/191] NFSv4.1 fix rpc_call_done assignment for BIND_CONN_TO_SESSION
Date:   Mon, 29 Jun 2020 11:37:57 -0400
Message-Id: <20200629154007.2495120-62-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

[ Upstream commit 1c709b766e73e54d64b1dde1b7cfbcf25bcb15b9 ]

Fixes: 02a95dee8cf0 ("NFS add callback_ops to nfs4_proc_bind_conn_to_session_callback")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 632d3c3f8dfb3..c189722bf9c71 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7151,7 +7151,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
-	.rpc_call_done =  &nfs4_bind_one_conn_to_session_done,
+	.rpc_call_done =  nfs4_bind_one_conn_to_session_done,
 };
 
 /*
-- 
2.25.1

