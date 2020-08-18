Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B1206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRLmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:42:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbgHRLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:42:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14332AF0B9ACCF4CAC08;
        Tue, 18 Aug 2020 19:42:43 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:42:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <kafai@fb.com>, <ast@kernel.org>, <jakub@cloudflare.com>,
        <zhang.lin16@zte.com.cn>, <keescook@chromium.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: Avoid strcmp current->comm with warncomm when warned >= 5
Date:   Tue, 18 Aug 2020 07:41:32 -0400
Message-ID: <20200818114132.17510-1-linmiaohe@huawei.com>
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

We can possibly avoid strcmp warncomm with current->comm by check warned
first.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e4f40b175acb..51e13bc42791 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -417,7 +417,7 @@ static void sock_warn_obsolete_bsdism(const char *name)
 {
 	static int warned;
 	static char warncomm[TASK_COMM_LEN];
-	if (strcmp(warncomm, current->comm) && warned < 5) {
+	if (warned < 5 && strcmp(warncomm, current->comm)) {
 		strcpy(warncomm,  current->comm);
 		pr_warn("process `%s' is using obsolete %s SO_BSDCOMPAT\n",
 			warncomm, name);
-- 
2.19.1

