Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD997C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9253D207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202338;
	bh=AGgoGdI6lkoG88e69AEM38n4eo6+xUlp9LBoTeoHHQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ha7/jxqU1IXgcBgMN37v1Xe/DCcpVjwrnK3yzdfHPKtzGzGysOma34pWF2Jxn5eTP
	 qx6sdIPegZgh1Zqo1RSCptcE7PbUMbTkmDbi81fZl1JDMuAeC/yR/lQxvkCsJpZqeZ
	 S50W9+wpNvzXbQAHo357+o7YlczQ/B1mMGEHgyy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgAPQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgAPQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE0921D56;
        Thu, 16 Jan 2020 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193655;
        bh=AGgoGdI6lkoG88e69AEM38n4eo6+xUlp9LBoTeoHHQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHlWlTDD/8vHRuRl7BEMEO5aLfUwF6tfpZHrmzBZG/uHpydkGh7fFM3l55B8QY2b2
         NrfLbHTJigPBw6zSCfrETnqRUgDokPs1Ut2cKxTU/B/2opkoF574+xJLTTkUhoEckb
         r1sgrieLjsGci25b1inUvWswbr3DMxpxcCmdtPXk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 184/205] tipc: fix wrong socket reference counter after tipc_sk_timeout() returns
Date:   Thu, 16 Jan 2020 11:42:39 -0500
Message-Id: <20200116164300.6705-184-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit 91a4a3eb433e4d786420c41f3c08d1d16c605962 ]

When tipc_sk_timeout() is executed but user space is grabbing
ownership, this function rearms itself and returns. However, the
socket reference counter is not reduced. This causes potential
unexpected behavior.

This commit fixes it by calling sock_put() before tipc_sk_timeout()
returns in the above-mentioned case.

Fixes: afe8792fec69 ("tipc: refactor function tipc_sk_timeout()")
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 8cbdda3d4503..05b5e5e3a0c4 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2683,6 +2683,7 @@ static void tipc_sk_timeout(struct timer_list *t)
 	if (sock_owned_by_user(sk)) {
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + HZ / 20);
 		bh_unlock_sock(sk);
+		sock_put(sk);
 		return;
 	}
 
-- 
2.20.1

