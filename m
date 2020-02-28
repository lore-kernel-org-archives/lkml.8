Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143F246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YWFcRZqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgB1NXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:23:23 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.31]:16025 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgB1NXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:23:23 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id BDA7944805E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:23:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7fbtjIEGDRP4z7fbtjgdTR; Fri, 28 Feb 2020 07:23:21 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y+AqmC2SGru3SV3ge9VUUzpHaqfMGHl4h5dsMx1cDYo=; b=YWFcRZqkiHU+7yHmFpfrU3yzok
        lBDHXGDx4g8MGQvAmh/qrwM1Hz4zVS099snqdDp+pzdwVm1hLq8FSQLOHjVWgmWKyyufkPFZXq4dV
        jMGidt8/jsOJyQ17fiqIyKHO7E6MzhdPGz76vm9YsgR4c4ml8C/BL18NngMK2K3+OyYMlev3Q9VAS
        tChoTtyQ5qhQPKpnPSvK3TGA5afQdrJQ8b2ug8DghMjSfRD8hc6rEJzobw6FbTUyCx4D6H5Y1GV65
        +2oSV0LNPCInv8DN0/aRrj6UAiDJ6CAV57USMw0Cg4zbFheWOXzYb43TdzlT7xqxNxB9Db4qUl2pk
        QjsWJ68g==;
Received: from [201.162.240.44] (port=24168 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7fbr-001IEU-Pt; Fri, 28 Feb 2020 07:23:20 -0600
Date:   Fri, 28 Feb 2020 07:26:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net: mpls: Replace zero-length array with
 flexible-array member
Message-ID: <20200228132615.GA21172@embeddedor>
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
X-Source-IP: 201.162.240.44
X-Source-L: No
X-Exim-ID: 1j7fbr-001IEU-Pt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.44]:24168
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
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
 include/net/mpls_iptunnel.h | 2 +-
 net/mpls/internal.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/mpls_iptunnel.h b/include/net/mpls_iptunnel.h
index 6b4759eae158..9deb3a3735da 100644
--- a/include/net/mpls_iptunnel.h
+++ b/include/net/mpls_iptunnel.h
@@ -11,7 +11,7 @@ struct mpls_iptunnel_encap {
 	u8	ttl_propagate;
 	u8	default_ttl;
 	u8	reserved1;
-	u32	label[0];
+	u32	label[];
 };
 
 static inline struct mpls_iptunnel_encap *mpls_lwtunnel_encap(struct lwtunnel_state *lwtstate)
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 768a302879b4..0e9aa94adc07 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -98,7 +98,7 @@ struct mpls_nh { /* next hop label forwarding entry */
 	u8			nh_via_table;
 	u8			nh_reserved1;
 
-	u32			nh_label[0];
+	u32			nh_label[];
 };
 
 /* offset of via from beginning of mpls_nh */
@@ -154,7 +154,7 @@ struct mpls_route { /* next hop label forwarding entry */
 	u8			rt_nh_size;
 	u8			rt_via_offset;
 	u8			rt_reserved1;
-	struct mpls_nh		rt_nh[0];
+	struct mpls_nh		rt_nh[];
 };
 
 #define for_nexthops(rt) {						\
-- 
2.25.0

