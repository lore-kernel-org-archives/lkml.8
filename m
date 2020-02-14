Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C778C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F022082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="EQ0WnNgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404522AbgBNRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:12:11 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.28]:22799 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390094AbgBNRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:12:00 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B46D52B5E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:11:59 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2eVTjsnGiAGTX2eVTj4bfG; Fri, 14 Feb 2020 11:11:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ZVD8rkyaK3hLNfOdpk0wuANy7TapkEfNgzpEqlIIX8=; b=EQ0WnNgENNRvu42vmFVTkkjxra
        aU9dZ0FLeIiApEBe20GAA+bqXNt5Gx+GGsHRdXxlQ4rwFgULaFQxxSb2IPmd7MVy+OBiWiL/GWjGT
        /lcfERtd3WshTyA5hQ9gVMa/GEQNjVKVGqrFUtWCqYR79/mw4J4jbkILUxZcy0RBWHe8DHUVwjd0f
        TmFPvcmiFcYZl6VjMpvHWiDtOKQALXcnxsMFtOpMAxuQn86PvOYAc6OHnF82tYENwBtlSAbcrIWA0
        L9RqF0TiUyzvJbAQdOFPRlzuK0xnM7ahjSw03nn1QZAH/gEJeM/kH671VxUaMFl33y/rHNLmuhTus
        +cBgopCg==;
Received: from [200.68.140.137] (port=41751 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2eVR-003eZL-TZ; Fri, 14 Feb 2020 11:11:58 -0600
Date:   Fri, 14 Feb 2020 11:14:35 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: sa11x0: Replace zero-length array with
 flexible-array member
Message-ID: <20200214171435.GA22930@embeddedor>
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
X-Source-IP: 200.68.140.137
X-Source-L: No
X-Exim-ID: 1j2eVR-003eZL-TZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.137]:41751
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
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
 drivers/dma/sa11x0-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index afb68055ed1b..0fa7f14a65a1 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -78,7 +78,7 @@ struct sa11x0_dma_desc {
 	bool			cyclic;
 
 	unsigned		sglen;
-	struct sa11x0_dma_sg	sg[0];
+	struct sa11x0_dma_sg	sg[];
 };
 
 struct sa11x0_dma_phy;
-- 
2.25.0

