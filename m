Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E2424125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUIuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:50:13 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60457 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbgAUIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:50:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHY.4t_1579596608;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHY.4t_1579596608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:50:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp/ipv4: remove AF_INET_FAMILY
Date:   Tue, 21 Jan 2020 16:50:07 +0800
Message-Id: <1579596607-258481-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
the macro isn't used anymore. remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> 
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org> 
Cc: netdev@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 net/ipv4/inet_connection_sock.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 18c0d5bffe12..ca22073cd500 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -610,12 +610,6 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(inet_csk_route_child_sock);
 
-#if IS_ENABLED(CONFIG_IPV6)
-#define AF_INET_FAMILY(fam) ((fam) == AF_INET)
-#else
-#define AF_INET_FAMILY(fam) true
-#endif
-
 /* Decide when to expire the request and when to resend SYN-ACK */
 static inline void syn_ack_recalc(struct request_sock *req, const int thresh,
 				  const int max_retries,
-- 
1.8.3.1

