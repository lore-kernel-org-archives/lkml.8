Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C241C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8F420772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHSIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:33:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgHSIdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:33:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C50E1FCE6321FB2555C7;
        Wed, 19 Aug 2020 16:33:23 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 16:33:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <kafai@fb.com>, <daniel@iogearbox.net>, <jakub@cloudflare.com>,
        <keescook@chromium.org>, <zhang.lin16@zte.com.cn>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] net: Stop warning about SO_BSDCOMPAT usage
Date:   Wed, 19 Aug 2020 04:32:08 -0400
Message-ID: <20200819083208.17825-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been warning about SO_BSDCOMPAT usage for many years. We may remove
this code completely now.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/sock.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e4f40b175acb..64d2aec5ed45 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -413,18 +413,6 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
-static void sock_warn_obsolete_bsdism(const char *name)
-{
-	static int warned;
-	static char warncomm[TASK_COMM_LEN];
-	if (strcmp(warncomm, current->comm) && warned < 5) {
-		strcpy(warncomm,  current->comm);
-		pr_warn("process `%s' is using obsolete %s SO_BSDCOMPAT\n",
-			warncomm, name);
-		warned++;
-	}
-}
-
 static bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
@@ -984,7 +972,6 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_BSDCOMPAT:
-		sock_warn_obsolete_bsdism("setsockopt");
 		break;
 
 	case SO_PASSCRED:
@@ -1387,7 +1374,6 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_BSDCOMPAT:
-		sock_warn_obsolete_bsdism("getsockopt");
 		break;
 
 	case SO_TIMESTAMP_OLD:
-- 
2.19.1

