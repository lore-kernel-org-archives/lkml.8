Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B183C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632612078C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgEUAiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgEUAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:37:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A493C08C5C0;
        Wed, 20 May 2020 17:37:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbZD9-00CgeX-Ht; Thu, 21 May 2020 00:37:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/19] ipv6: take handling of group_source_req options into a helper
Date:   Thu, 21 May 2020 01:37:13 +0100
Message-Id: <20200521003721.3023783-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521003721.3023783-1-viro@ZenIV.linux.org.uk>
References: <20200521003657.GE23230@ZenIV.linux.org.uk>
 <20200521003721.3023783-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv6/ipv6_sockglue.c | 65 +++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 209d827950cc..bb049feeb787 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -136,6 +136,41 @@ static bool setsockopt_needs_rtnl(int optname)
 	return false;
 }
 
+static int do_ipv6_mcast_group_source(struct sock *sk, int optname,
+				      struct group_source_req *greqs)
+{
+	int omode, add;
+
+	if (greqs->gsr_group.ss_family != AF_INET6 ||
+	    greqs->gsr_source.ss_family != AF_INET6)
+		return -EADDRNOTAVAIL;
+
+	if (optname == MCAST_BLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 1;
+	} else if (optname == MCAST_UNBLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 0;
+	} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
+		struct sockaddr_in6 *psin6;
+		int retv;
+
+		psin6 = (struct sockaddr_in6 *)&greqs->gsr_group;
+		retv = ipv6_sock_mc_join_ssm(sk, greqs->gsr_interface,
+					     &psin6->sin6_addr,
+					     MCAST_INCLUDE);
+		/* prior join w/ different source is ok */
+		if (retv && retv != -EADDRINUSE)
+			return retv;
+		omode = MCAST_INCLUDE;
+		add = 1;
+	} else /* MCAST_LEAVE_SOURCE_GROUP */ {
+		omode = MCAST_INCLUDE;
+		add = 0;
+	}
+	return ip6_mc_source(add, omode, sk, greqs);
+}
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -715,7 +750,6 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	case MCAST_UNBLOCK_SOURCE:
 	{
 		struct group_source_req greqs;
-		int omode, add;
 
 		if (optlen < sizeof(struct group_source_req))
 			goto e_inval;
@@ -723,34 +757,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			retv = -EFAULT;
 			break;
 		}
-		if (greqs.gsr_group.ss_family != AF_INET6 ||
-		    greqs.gsr_source.ss_family != AF_INET6) {
-			retv = -EADDRNOTAVAIL;
-			break;
-		}
-		if (optname == MCAST_BLOCK_SOURCE) {
-			omode = MCAST_EXCLUDE;
-			add = 1;
-		} else if (optname == MCAST_UNBLOCK_SOURCE) {
-			omode = MCAST_EXCLUDE;
-			add = 0;
-		} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
-			struct sockaddr_in6 *psin6;
-
-			psin6 = (struct sockaddr_in6 *)&greqs.gsr_group;
-			retv = ipv6_sock_mc_join_ssm(sk, greqs.gsr_interface,
-						     &psin6->sin6_addr,
-						     MCAST_INCLUDE);
-			/* prior join w/ different source is ok */
-			if (retv && retv != -EADDRINUSE)
-				break;
-			omode = MCAST_INCLUDE;
-			add = 1;
-		} else /* MCAST_LEAVE_SOURCE_GROUP */ {
-			omode = MCAST_INCLUDE;
-			add = 0;
-		}
-		retv = ip6_mc_source(add, omode, sk, &greqs);
+		retv = do_ipv6_mcast_group_source(sk, optname, &greqs);
 		break;
 	}
 	case MCAST_MSFILTER:
-- 
2.11.0

