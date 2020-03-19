Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B7C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D44820658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ESdCTYZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCSXEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:04:13 -0400
Received: from gateway20.websitewelcome.com ([192.185.67.41]:42757 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgCSXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:04:13 -0400
X-Greylist: delayed 1239 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 19:04:12 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7E184400CD892
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 16:28:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F3szjGuR7Sl8qF3szjpYBx; Thu, 19 Mar 2020 17:43:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AqMKlBtj27bhMrXNl4aQ/MWbKit8Mi+6SXoNTh+6hQk=; b=ESdCTYZbc+FAdhkMv5khiQQera
        21mCzk1qPKl8qVKMRV4E1lsipWGqAfOAvV5yvoqtcrKbPe2y8+X5kxpZSVdO5f0aZsqwF7fHaV9/m
        FqIXuTQiqh9Ov7rK2DA2wHWHdq1q8ZkGGlZrA4/DhDd1FFQV2MVDaX1bFyUbznxa4yZZoB13xjJ4/
        OagCnoiWffyruJiPpIdDS2tRh1aTpjA6KAPNNs0Cndh891Kkg/D23E5SFk2bvNT6k31NxXm5/ZxI5
        di2q33GWJCK7kjbxsZV9IPjPSpYpHay6QP/znAOCK/tppSmhHqB4cImyRpcFmTGybONkz3PwICMNo
        Tjj6GVcQ==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53958 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF3sw-002DJd-HZ; Thu, 19 Mar 2020 17:43:31 -0500
Date:   Thu, 19 Mar 2020 17:43:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] mtd: spi-nor: controllers: aspeed-smc: Replace
 zero-length array with flexible-array member
Message-ID: <20200319224326.GA25390@embeddedor.com>
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
X-Exim-ID: 1jF3sw-002DJd-HZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
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
 drivers/mtd/spi-nor/controllers/aspeed-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
index 395127349aa8..e26a1897db0e 100644
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
@@ -109,7 +109,7 @@ struct aspeed_smc_controller {
 	void __iomem *ahb_base;			/* per-chip windows resource */
 	u32 ahb_window_size;			/* full mapping window size */
 
-	struct aspeed_smc_chip *chips[0];	/* pointers to attached chips */
+	struct aspeed_smc_chip *chips[];	/* pointers to attached chips */
 };
 
 /*
-- 
2.23.0

