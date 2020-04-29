Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F935C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E74320B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD2NZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:25:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbgD2NZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:25:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A1037A226C13BDB86F7;
        Wed, 29 Apr 2020 21:25:40 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 21:25:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>, <tglx@linutronix.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ila: remove unused inline function ila_addr_is_ila
Date:   Wed, 29 Apr 2020 21:25:30 +0800
Message-ID: <20200429132530.6172-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore since commit 84287bb32856 ("ila: add
checksum neutral map auto").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ipv6/ila/ila.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv6/ila/ila.h b/net/ipv6/ila/ila.h
index bb6fc0d54dae..ad5f6f6ba333 100644
--- a/net/ipv6/ila/ila.h
+++ b/net/ipv6/ila/ila.h
@@ -68,11 +68,6 @@ static inline struct ila_addr *ila_a2i(struct in6_addr *addr)
 	return (struct ila_addr *)addr;
 }
 
-static inline bool ila_addr_is_ila(struct ila_addr *iaddr)
-{
-	return (iaddr->ident.type != ILA_ATYPE_IID);
-}
-
 struct ila_params {
 	struct ila_locator locator;
 	struct ila_locator locator_match;
-- 
2.17.1


