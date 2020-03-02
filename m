Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308D4214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ALZlif2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCBL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:57:33 -0500
Received: from gateway36.websitewelcome.com ([192.185.197.22]:42289 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbgCBL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:57:33 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E8A914024C812
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 05:12:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8jhTjLrbt8vkB8jhTjG7nX; Mon, 02 Mar 2020 05:57:31 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LiBSQ0LE0yixdsEF469J2Wh45sDnPKDOgsNU7LNoc5U=; b=ALZlif2ssH12bw2MEJdivRbbvj
        2HoUrWDFHhVGOw2DSibJzrgG0p8vAl9jc142h/t6ZbIinBXzRGzviLChmToa1+pZmESfb7DCFyTF9
        akN0rcmuhPOxiVhrz7FxJYgY2FXz8s7u6KCa3pgLOGBiRw/kNMIwl6jENlEZc+YXUDGez7er2rzk2
        lbdc7mlDXUZCiSP/h6pRLJTHdppK56xSCTyx55CT5V5UOcOXhiwzf/zRGhkwbSHD6h6H1NENlwJNU
        afKfXt95BFtk/vOj+qZdmPgR5EFq9XFN9Txlsfm5SFRWyL+gWQ2fJE3u3BtnlZ+H4Ki8MXucKS5Pj
        8Ha/tzSA==;
Received: from [201.166.157.123] (port=42204 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j8jga-003oib-A9; Mon, 02 Mar 2020 05:56:36 -0600
Date:   Mon, 2 Mar 2020 05:59:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] netdevice: Replace zero-length array with
 flexible-array member
Message-ID: <20200302115933.GA15346@embeddedor>
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
X-Source-IP: 201.166.157.123
X-Source-L: No
X-Exim-ID: 1j8jga-003oib-A9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.157.123]:42204
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
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
 include/linux/netdevice.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6c3f7032e8d9..b6fedd54cd8e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -664,7 +664,7 @@ static inline void netdev_queue_numa_node_write(struct netdev_queue *q, int node
 struct rps_map {
 	unsigned int len;
 	struct rcu_head rcu;
-	u16 cpus[0];
+	u16 cpus[];
 };
 #define RPS_MAP_SIZE(_num) (sizeof(struct rps_map) + ((_num) * sizeof(u16)))
 
@@ -686,7 +686,7 @@ struct rps_dev_flow {
 struct rps_dev_flow_table {
 	unsigned int mask;
 	struct rcu_head rcu;
-	struct rps_dev_flow flows[0];
+	struct rps_dev_flow flows[];
 };
 #define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
     ((_num) * sizeof(struct rps_dev_flow)))
@@ -704,7 +704,7 @@ struct rps_dev_flow_table {
 struct rps_sock_flow_table {
 	u32	mask;
 
-	u32	ents[0] ____cacheline_aligned_in_smp;
+	u32	ents[] ____cacheline_aligned_in_smp;
 };
 #define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
 
@@ -767,7 +767,7 @@ struct xps_map {
 	unsigned int len;
 	unsigned int alloc_len;
 	struct rcu_head rcu;
-	u16 queues[0];
+	u16 queues[];
 };
 #define XPS_MAP_SIZE(_num) (sizeof(struct xps_map) + ((_num) * sizeof(u16)))
 #define XPS_MIN_MAP_ALLOC ((L1_CACHE_ALIGN(offsetof(struct xps_map, queues[1])) \
@@ -778,7 +778,7 @@ struct xps_map {
  */
 struct xps_dev_maps {
 	struct rcu_head rcu;
-	struct xps_map __rcu *attr_map[0]; /* Either CPUs map or RXQs map */
+	struct xps_map __rcu *attr_map[]; /* Either CPUs map or RXQs map */
 };
 
 #define XPS_CPU_DEV_MAPS_SIZE(_tcs) (sizeof(struct xps_dev_maps) +	\
-- 
2.25.0

