Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D94FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CEB2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0Mi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:38:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbgC0Mi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:38:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10324449DC695C7FC61B;
        Fri, 27 Mar 2020 20:38:16 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 27 Mar 2020
 20:38:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] xfrm: policy: Remove obsolete WARN while xfrm policy inserting
Date:   Fri, 27 Mar 2020 20:34:43 +0800
Message-ID: <20200327123443.12408-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7cb8a93968e3 ("xfrm: Allow inserting policies with matching
mark and different priorities"), we allow duplicate policies with
different priority, this WARN is not needed any more.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index dbda08e..5c4387c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1508,7 +1508,7 @@ static void xfrm_policy_insert_inexact_list(struct hlist_head *chain,
 		    !selector_cmp(&pol->selector, &policy->selector) &&
 		    xfrm_policy_mark_match(policy, pol) &&
 		    xfrm_sec_ctx_match(pol->security, policy->security) &&
-		    !WARN_ON(delpol)) {
+		    !delpol) {
 			delpol = pol;
 			if (policy->priority > pol->priority)
 				continue;
@@ -1543,7 +1543,7 @@ static struct xfrm_policy *xfrm_policy_insert_list(struct hlist_head *chain,
 		    !selector_cmp(&pol->selector, &policy->selector) &&
 		    xfrm_policy_mark_match(policy, pol) &&
 		    xfrm_sec_ctx_match(pol->security, policy->security) &&
-		    !WARN_ON(delpol)) {
+		    !delpol) {
 			if (excl)
 				return ERR_PTR(-EEXIST);
 			delpol = pol;
-- 
1.8.3.1


