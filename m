Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BDC3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C12246C1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ADV34/l4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB2AuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:50:18 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.163]:33573 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgB2AuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:50:17 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id F11FF65C55
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:50:16 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7qKejdGALAGTX7qKejm7RK; Fri, 28 Feb 2020 18:50:16 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f8vhCCp3OOzlAffu+dZicuZhO8OF+Y4bPnu/LSD79Jo=; b=ADV34/l40VcoT5ws8TKqjwodLl
        jVADoHzrLqvLxNu+pzKpcr9OBUQi/gFuEYxaIl1BzXp1R6k5EP2LkqgSd5J/uWYkWlzBd9sM29FbW
        EKyzThtDRSpPRU6JFyXvGdHSiREvZkQs0t54pdLJpvA/5psSDGGu+/LuOf1zKvAzffvVTFER1VvsP
        s/Zp6+PfEU0a51O9xoEVfxAooecit0Y+9+QKp/+2x/uRDzY/JHgiOt2LuPUCqfEX01Wgdf3ES/2bc
        01c2Q3pRrVSCCzrABRGWCMz9fMzkEfw6bjFGWDYbpPNKDQhCUXqtS/PPDZpWdaDX3s9t4A7IGn5Xs
        7vTj5xxg==;
Received: from [200.39.15.57] (port=22066 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j7qKd-002urX-07; Fri, 28 Feb 2020 18:50:15 -0600
Date:   Fri, 28 Feb 2020 18:53:11 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ndisc: Replace zero-length array with flexible-array
 member
Message-ID: <20200229005311.GA8953@embeddedor>
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
X-Exim-ID: 1j7qKd-002urX-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.39.15.57]:22066
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
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
 include/net/ndisc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index b5ebeb3b0de0..1c61aeb3a1c0 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -80,12 +80,12 @@ extern struct neigh_table nd_tbl;
 struct nd_msg {
         struct icmp6hdr	icmph;
         struct in6_addr	target;
-	__u8		opt[0];
+	__u8		opt[];
 };
 
 struct rs_msg {
 	struct icmp6hdr	icmph;
-	__u8		opt[0];
+	__u8		opt[];
 };
 
 struct ra_msg {
@@ -98,7 +98,7 @@ struct rd_msg {
 	struct icmp6hdr icmph;
 	struct in6_addr	target;
 	struct in6_addr	dest;
-	__u8		opt[0];
+	__u8		opt[];
 };
 
 struct nd_opt_hdr {
-- 
2.25.0

