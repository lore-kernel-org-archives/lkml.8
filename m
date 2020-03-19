Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319AEC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CC52072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XX0jWltH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCSVT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:19:59 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.119]:18178 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCSVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:19:59 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id A39A012E2E6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 16:19:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F2a6jjOrRAGTXF2a6j9LTh; Thu, 19 Mar 2020 16:19:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ajq7OTNyMIVgTunyQt5eTItrR7T7jWAA7SICM0tM8GY=; b=XX0jWltHCRRmn/Ez/vLbd2cqBP
        VhHtKdcE1xu413uGkKQYEaCnZW4fA1/uArq2Rt97YRXVe7KIYOAUkcOUV4IDtXzR1VqQPi4hD9VQB
        GJKsm0XBD5wwtgNSoivsxW75Yjaznn/BMYBGBD46K6UeTEaSrdF/tUBClRVUQz/9yrKHmUrY+7hLy
        jSHHLdf4uzzkgtJpHwiTZTwVmJrzZaiF3ssrF/3pIB4yN+EFq0ySsdV4UcDyfEJcOa35e6hE33jrI
        QdZRSRPQUSZhfN884Aoo4UjFD4jxG/mSRRztdIRDrMJqjlbF46vKPD1h3yBjOenGZa9X4oioSHVZz
        gwCCWyIg==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53246 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF2a5-001XEf-8r; Thu, 19 Mar 2020 16:19:57 -0500
Date:   Thu, 19 Mar 2020 16:19:56 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] firewire: core.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319211956.GA3448@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jF2a5-001XEf-8r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53246
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/firewire/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 4b0e4ee655a1..71d5f16f311c 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -191,7 +191,7 @@ struct fw_node {
 	/* Upper layer specific data. */
 	void *data;
 
-	struct fw_node *ports[0];
+	struct fw_node *ports[];
 };
 
 static inline struct fw_node *fw_node_get(struct fw_node *node)
-- 
2.23.0

