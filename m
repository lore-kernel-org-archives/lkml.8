Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B0206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHGI7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:59:02 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48923 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbgHGI67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:58:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.BvXg_1596790735;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.BvXg_1596790735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 16:58:56 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch 1/2] bitops: simplify get_count_order_long()
Date:   Fri,  7 Aug 2020 16:58:36 +0800
Message-Id: <20200807085837.11697-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807085837.11697-1-richard.weiyang@linux.alibaba.com>
References: <20200807085837.11697-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two cases could be unified into one.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/bitops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 99f2ac30b1d9..030a98f0c452 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -206,10 +206,7 @@ static inline int get_count_order_long(unsigned long l)
 {
 	if (l == 0UL)
 		return -1;
-	else if (l & (l - 1UL))
-		return (int)fls_long(l);
-	else
-		return (int)fls_long(l) - 1;
+	return (int)fls_long(--l);
 }
 
 /**
-- 
2.20.1 (Apple Git-117)

