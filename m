Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE665C3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821D32468D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vSgabok4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB2A5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:57:46 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.46]:22349 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgB2A5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:57:46 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 54C08162E3E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:57:45 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7qRtj4JMhEfyq7qRtj9W1Y; Fri, 28 Feb 2020 18:57:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5zJGKP6eSAdHRVVreVQHGM36vc/G0+uFEcDovAOw10k=; b=vSgabok4xn8RNfrUuKOQZ4yqmr
        VmOjEEtxyoillPI5x+Gl59KPmauCOPhea93zjwfmBWe+nmrigx7bzu9SPqeCB2QjrQsKgnG4b8lgS
        clcgerM68QKiY+68JCxAOMySSqboKZjPy1ViqfHpeH8Kvj156DRbMjURKAoDHz5h6sNk/QJAWNDBi
        Vhto7Bqtjg9sp9GlDItiGS2sY/t2AjfB9kvwGXwOwVElLeNgOlpO1ebbcmPnf+vY5EWhpZmmRYq3H
        D4SQXSXTYa3lxQARmRHpRG94cU/ReXXwDwMg3CMwi6/KzfhWdwT/fuYv/yOCpETUAEoox4L+woBrQ
        PniqWdug==;
Received: from [200.39.15.57] (port=13359 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7qRr-002y0f-O0; Fri, 28 Feb 2020 18:57:43 -0600
Date:   Fri, 28 Feb 2020 19:00:40 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net: dn_fib: Replace zero-length array with
 flexible-array member
Message-ID: <20200229010040.GA9287@embeddedor>
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
X-Source-IP: 200.39.15.57
X-Source-L: No
X-Exim-ID: 1j7qRr-002y0f-O0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.39.15.57]:13359
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
 include/net/dn_fib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/dn_fib.h b/include/net/dn_fib.h
index 6dd2213c5eb2..ccc6e9df178b 100644
--- a/include/net/dn_fib.h
+++ b/include/net/dn_fib.h
@@ -90,7 +90,7 @@ struct dn_fib_table {
 	int (*flush)(struct dn_fib_table *t);
 	int (*dump)(struct dn_fib_table *t, struct sk_buff *skb, struct netlink_callback *cb);
 
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 #ifdef CONFIG_DECNET_ROUTER
-- 
2.25.0

