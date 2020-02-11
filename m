Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46CC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A37206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ptfWdyKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgBKU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:59:40 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.222]:17565 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728624AbgBKU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:59:40 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id C595448CE5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:59:39 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cd9jIjl3XVkQ1cd9jh4Iw; Tue, 11 Feb 2020 14:59:39 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IPGuh4dJHUV6jC0H2DD+K0aSPx7nJ/9fjrtidfPd1Bo=; b=ptfWdyKQkcSnaRqzN+e9PKQsaX
        PPFAU0pL1ijbOVJOaG+VQ9CmQM5Nn7elVWMpJG85ynyd5YUrrl5k2BsE7P5hs7bu8CwDooXCc89cS
        6EUPU/QWQzTRz9KDlDVbRsQ0dmfSfrR78U3FzVB+R+d0VFN9ujMMFuDbfUV8BsB5aWk4PPJaLM7XH
        FQPfJcURpt7gBQPW19Qbjl67vF/qLD93y/mZzzgylkiuCmvEspEIcjd3pBijTA3zDKVip4eMIYRZ/
        tq7m7gTMz2kjNVpvot9lsPl0kQYgxw8iCK5Wb0wQaUgru3rm3mgclfD7PoEaRmbkrnKLv5pPuXkoN
        /LD6H8yQ==;
Received: from [200.68.140.36] (port=14955 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cd8-0022a3-9c; Tue, 11 Feb 2020 14:59:38 -0600
Date:   Tue, 11 Feb 2020 15:02:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] amba: tegra-ahb: Replace zero-length array with
 flexible-array member
Message-ID: <20200211210213.GA28043@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1cd8-0022a3-9c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:14955
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
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
inadvertenly introduced[3] to the codebase from now on.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/amba/tegra-ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index b0b688c481e8..e9e5c7bb580c 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -129,7 +129,7 @@ static const u32 tegra_ahb_gizmo[] = {
 struct tegra_ahb {
 	void __iomem	*regs;
 	struct device	*dev;
-	u32		ctx[0];
+	u32		ctx[];
 };
 
 static inline u32 gizmo_readl(struct tegra_ahb *ahb, u32 offset)
-- 
2.25.0

