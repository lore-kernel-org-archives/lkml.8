Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD9CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C83D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHNIks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:40:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgHNIkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:40:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95CAE7BD7D6C22E0B04B;
        Fri, 14 Aug 2020 16:40:45 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 14 Aug 2020
 16:40:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <christian.brauner@ubuntu.com>, <oleg@redhat.com>,
        <ebiederm@xmission.com>, <viro@zeniv.linux.org.uk>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] signal: Convert to use the preferred fallthrough macro
Date:   Fri, 14 Aug 2020 04:39:32 -0400
Message-ID: <20200814083932.4975-1-linmiaohe@huawei.com>
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

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f16f7c5d375..27505ca5be2d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -851,7 +851,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 			 */
 			if (!sid || sid == task_session(current))
 				break;
-			/* fall through */
+			fallthrough;
 		default:
 			return -EPERM;
 		}
-- 
2.19.1

