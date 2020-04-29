Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA86C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE512087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgD2NZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:25:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgD2NZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:25:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDD7B31A2BEF9D52F325;
        Wed, 29 Apr 2020 21:24:56 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 21:24:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <ap420073@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: hsr: remove unused inline functions
Date:   Wed, 29 Apr 2020 21:24:30 +0800
Message-ID: <20200429132430.29948-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/hsr/hsr_main.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 7321cf8d6d2c..f74193465bf5 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -62,15 +62,6 @@ struct hsr_tag {
  * with the path field in-between, which seems strange. I'm guessing the MAC
  * address definition is in error.
  */
-static inline u16 get_hsr_tag_path(struct hsr_tag *ht)
-{
-	return ntohs(ht->path_and_LSDU_size) >> 12;
-}
-
-static inline u16 get_hsr_tag_LSDU_size(struct hsr_tag *ht)
-{
-	return ntohs(ht->path_and_LSDU_size) & 0x0FFF;
-}
 
 static inline void set_hsr_tag_path(struct hsr_tag *ht, u16 path)
 {
@@ -103,16 +94,6 @@ struct hsr_sup_payload {
 	unsigned char	macaddress_A[ETH_ALEN];
 } __packed;
 
-static inline u16 get_hsr_stag_path(struct hsr_sup_tag *hst)
-{
-	return get_hsr_tag_path((struct hsr_tag *)hst);
-}
-
-static inline u16 get_hsr_stag_HSR_ver(struct hsr_sup_tag *hst)
-{
-	return get_hsr_tag_LSDU_size((struct hsr_tag *)hst);
-}
-
 static inline void set_hsr_stag_path(struct hsr_sup_tag *hst, u16 path)
 {
 	set_hsr_tag_path((struct hsr_tag *)hst, path);
-- 
2.17.1


