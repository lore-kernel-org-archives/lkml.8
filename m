Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC144221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHFUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:03:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgHFUDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:03:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10DED993A89FDCE84213;
        Thu,  6 Aug 2020 19:50:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 19:50:45 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <viro@zeniv.linux.org.uk>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] net: Set fput_needed iff FDPUT_FPUT is set
Date:   Thu, 6 Aug 2020 19:53:16 +0800
Message-ID: <1596714796-25298-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

We should fput() file iff FDPUT_FPUT is set. So we should set fput_needed
accordingly.

Fixes: 00e188ef6a7e ("sockfd_lookup_light(): switch to fdget^W^Waway from fget_light")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 6aff5aeb6728..ee9c9dac4728 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -500,7 +500,7 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
 	if (f.file) {
 		sock = sock_from_file(f.file, err);
 		if (likely(sock)) {
-			*fput_needed = f.flags;
+			*fput_needed = f.flags & FDPUT_FPUT;
 			return sock;
 		}
 		fdput(f);
-- 
2.19.1

