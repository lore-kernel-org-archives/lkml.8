Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442BC221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgHFUBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:01:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgHFUBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:01:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 84AC9B8E5F9685071950;
        Thu,  6 Aug 2020 19:50:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 19:49:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] net: Use helper function fdput()
Date:   Thu, 6 Aug 2020 19:52:24 +0800
Message-ID: <1596714744-25247-1-git-send-email-linmiaohe@huawei.com>
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

Use helper function fdput() to fput() the file iff FDPUT_FPUT is set.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/socket.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 976426d03f09..6aff5aeb6728 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1805,8 +1805,7 @@ int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 		ret = __sys_accept4_file(f.file, 0, upeer_sockaddr,
 						upeer_addrlen, flags,
 						rlimit(RLIMIT_NOFILE));
-		if (f.flags)
-			fput(f.file);
+		fdput(f);
 	}
 
 	return ret;
@@ -1869,8 +1868,7 @@ int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
 		ret = move_addr_to_kernel(uservaddr, addrlen, &address);
 		if (!ret)
 			ret = __sys_connect_file(f.file, &address, addrlen, 0);
-		if (f.flags)
-			fput(f.file);
+		fdput(f);
 	}
 
 	return ret;
-- 
2.19.1

