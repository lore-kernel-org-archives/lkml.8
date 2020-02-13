Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8B206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Hiu712TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBMRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:01:21 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.12]:25074 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgBMRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:01:21 -0500
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 12:01:20 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 7E20C417F6A92
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:51:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2HUpjSLnQAGTX2HUpjeMX3; Thu, 13 Feb 2020 10:37:47 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eO6da+Y3zTKqO5U3OOMJJYMv3F/0mch/JbIXhqIP11c=; b=Hiu712TN1ZetJOVxZcK3jWptoP
        +pUR0u5zvtgiy1BTsF+uxfHsXJabE1+Z4YvgI7xzragSNLa+Pb/0+5hXlDNADOtOIWEkdmBkXcAN5
        MBY5KpUkS+9sa9yTHBmAQ1Wbl3pRP5J86wi7yocLFMZwwvw9+0h/xUMTYEeurTTx+pc2G7fdcx6Ef
        g+r5ta5DvH0BgwoB/DriEfbITkjfc8hsRwz+VmgZD0P4+be61EhuDNkl73o69uwulp9OL/F5hAstR
        ep4US3KU+Ell0oG7b3YvxRO5iX0hbfJoLxogXwlg1lQU+uWdNhT7czJGZ1H6cq8wEYq5bLkt6fmUs
        A8iiVZpA==;
Received: from [200.68.140.15] (port=4263 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2HUn-003uAK-UU; Thu, 13 Feb 2020 10:37:46 -0600
Date:   Thu, 13 Feb 2020 10:40:22 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rapidio: Replace zero-length array with flexible-array member
Message-ID: <20200213164022.GA8937@embeddedor>
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
X-Source-IP: 200.68.140.15
X-Source-L: No
X-Exim-ID: 1j2HUn-003uAK-UU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.15]:4263
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
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
 drivers/rapidio/rio-scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 0e90c5d4bb2b..eb8ed28533f8 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -39,7 +39,7 @@ struct rio_id_table {
 	u16 start;	/* logical minimal id */
 	u32 max;	/* max number of IDs in table */
 	spinlock_t lock;
-	unsigned long table[0];
+	unsigned long table[];
 };
 
 static int next_destid = 0;
-- 
2.25.0

