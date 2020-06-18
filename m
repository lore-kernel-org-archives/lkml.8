Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A204C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B05821534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447241;
	bh=kORKvHUzmV/NBfbheBdOjgteXeEJ0yznxbX4KSGtpMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SV/dTt+mexXQXDUn9tSHrXe3kyWmIxGAR4BFE9J6w07AXDgPrCMAtHwsCWdH6epeU
	 MkL1Pb4tLrtizp8o1TZj0Sk09MwLfSoZL23n/3rt9jonBLCq/GuzKgXVkjFS8ukWra
	 BlyvlssfdnIukU0zSqHjMiflliP852pZ49p0B9/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFRBQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgFRBOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154CA221EE;
        Thu, 18 Jun 2020 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442869;
        bh=kORKvHUzmV/NBfbheBdOjgteXeEJ0yznxbX4KSGtpMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNlmPC0lFcBbJOztx5g9voCcA0VMT/lO9dloqY5EvIeYT8z6VoCpbkR3LE6vQpYmo
         qyDioeu3q9srHp8kU1zxwEnnbycr79iie+TosnBEow6Gw7R6wy5eH5sAkEyj1DnzgR
         9PNVnlE57UL16qKiQoeWQvnjYKvpDTv5Nk/VBCKM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 296/388] NFSv4.1 fix rpc_call_done assignment for BIND_CONN_TO_SESSION
Date:   Wed, 17 Jun 2020 21:06:33 -0400
Message-Id: <20200618010805.600873-296-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
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
index 9056f3dd380e..e32717fd1169 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7909,7 +7909,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
-	.rpc_call_done =  &nfs4_bind_one_conn_to_session_done,
+	.rpc_call_done =  nfs4_bind_one_conn_to_session_done,
 };
 
 /*
-- 
2.25.1

