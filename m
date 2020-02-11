Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB22C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2277D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aQZDQpEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgBKUxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:53:48 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.40]:18845 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgBKUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:53:47 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EB712132F447
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:53:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cXSjHYSDvBMd1cXSjbAGm; Tue, 11 Feb 2020 14:53:46 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=09Yy50q1zaBedUbH5K7LBiquQOrxktM3eLjWmlSWnEM=; b=aQZDQpEXGWwJ02U9MMNMPZm/bH
        fgdL1INynphOl24Zf+4auclQ/alj/FyI5N/5w9C1T0+MC/q95z98nNTPYb2W7ts17yrQkY7sWdW7A
        CHXg+BSDMMynOJypDpyxSNDH03fr5XbrLPMAzCoyKLXpEy5oopCtk6pPCumz7aizZpiim02CQZXBf
        Y2etP8KffbabWOVNKtKuyFnQYoEeRDssAg3m+HPAWxU1M0JqHyqi0ugX0YeF0mtDhofNPrrCm0p4i
        7lhXGfzyx7kufv+60L716QST9iAHfQz1xekYAwVI+LJuK52M3NijBOBxY7+8GLiX1zrsDX68e6XcC
        x9xGgh6Q==;
Received: from [200.68.140.36] (port=23277 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cXR-001yJu-Du; Tue, 11 Feb 2020 14:53:45 -0600
Date:   Tue, 11 Feb 2020 14:56:20 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib/ts_bm: Replace zero-length array with flexible-array
 member
Message-ID: <20200211205620.GA24694@embeddedor>
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
X-Exim-ID: 1j1cXR-001yJu-Du
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:23277
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/ts_bm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 9e66ee4020e9..9d64629fa8b8 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -56,7 +56,7 @@ struct ts_bm
 	u8 *		pattern;
 	unsigned int	patlen;
 	unsigned int 	bad_shift[ASIZE];
-	unsigned int	good_shift[0];
+	unsigned int	good_shift[];
 };
 
 static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
-- 
2.25.0

