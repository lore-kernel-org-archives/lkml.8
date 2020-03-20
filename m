Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA0DC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE14D2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dNQzCuD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCTXNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:13:55 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:40119 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbgCTXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:13:55 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 12759400C65AE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 18:13:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FQpujdrIEEfyqFQpujddM3; Fri, 20 Mar 2020 18:13:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c/TiK3M98rHKplFi44R9Ng7ATq6/CKljKujJKDUSPi8=; b=dNQzCuD6PdO6W88G2zEEcYemNg
        OdXkLHGIU2XyVripkUnzesZ0mMUNaR7pdg2XbWze1InWjY9IV4pXdlr6xFNjaJb2vBPEUUyhX3WG5
        RYmYEAvUzvvT9fJdS0UJPVjvOM8cyYYH2LVnlv3lshW4k4oOo19T3oScFLAxVrbOG38Ql9yOVWrM9
        Q9lJ3ER97ndnTTksoTSQ3uliFLVZGTU9mQ/Q17mdogyO5RSgtAPGC4sMydNKVc/Nfnu2R45H36tj/
        xpNdu4MszgYYMNhPrVKFx60uDQ/wqtRKdctz11b0OkxIDX18Y2632B6sneLUYCBHs4WnZvg04JvTf
        fYf4qjFw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53566 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jFQps-001HQy-FF; Fri, 20 Mar 2020 18:13:52 -0500
Date:   Fri, 20 Mar 2020 18:13:52 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] phy: samsung: phy-samsung-usb2.h: Replace zero-length
 array with flexible-array member
Message-ID: <20200320230700.GA16152@embeddedor.com>
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
X-Exim-ID: 1jFQps-001HQy-FF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53566
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
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
 drivers/phy/samsung/phy-samsung-usb2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-usb2.h b/drivers/phy/samsung/phy-samsung-usb2.h
index 2c1a7d71142b..77fb23bc218f 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.h
+++ b/drivers/phy/samsung/phy-samsung-usb2.h
@@ -43,7 +43,7 @@ struct samsung_usb2_phy_driver {
 	struct regmap *reg_pmu;
 	struct regmap *reg_sys;
 	spinlock_t lock;
-	struct samsung_usb2_phy_instance instances[0];
+	struct samsung_usb2_phy_instance instances[];
 };
 
 struct samsung_usb2_common_phy {
-- 
2.23.0

