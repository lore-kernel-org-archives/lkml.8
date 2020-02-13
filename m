Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED728C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A7A21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rdqPEorI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgBMAfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:35:40 -0500
Received: from gateway20.websitewelcome.com ([192.185.55.25]:40784 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729190AbgBMAfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:35:39 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7A3BC400C50C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 17:22:01 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22TijibKwSl8q22TijRIH8; Wed, 12 Feb 2020 18:35:38 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fj1EsM7KBtbLu9zEu9J4LZPmGuqoK3e/mqA04voGYHM=; b=rdqPEorIYVAWijtrjXYLTv7gxJ
        bUbshf+azRdrdo4/l5HJo9EST8kvqO+WPoCpoTxXEp6YdOib1G7B7Pf404o9JEr9Jn/r7RkmdeBb4
        VV/ED7hO1B4eVQ1djz9gDGy+17mPhlNq9VXJaw6V3TDlmbbFziNWJa0UO2G/IPOxZBlqmDI7b9Wj2
        jG1r42X5XQOnBnFYACDMVJJ2klKSIyEECne1QOw3ARe3DNSKLTJr6eGd7nup0v3WtXQBaxaIa9RLi
        Aum6exNjXQiTfdnxRAmHnCaQa8+F/4T/4CTPl398yaQmDhicm9mGbzSYoBYnP+qi9GhBetsC8klC5
        N2pmV64w==;
Received: from [200.68.141.42] (port=21619 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22Th-003f1y-39; Wed, 12 Feb 2020 18:35:37 -0600
Date:   Wed, 12 Feb 2020 18:35:35 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: uniphier-mdmac: replace zero-length array with
 flexible-array member
Message-ID: <20200213003535.GA3269@embeddedor.com>
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
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22Th-003f1y-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:21619
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 47
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
 drivers/dma/uniphier-mdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index 21b8f1131d55..618839df0748 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -68,7 +68,7 @@ struct uniphier_mdmac_device {
 	struct dma_device ddev;
 	struct clk *clk;
 	void __iomem *reg_base;
-	struct uniphier_mdmac_chan channels[0];
+	struct uniphier_mdmac_chan channels[];
 };
 
 static struct uniphier_mdmac_chan *
-- 
2.23.0

