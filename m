Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E3C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB79E2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgEUAiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgEUAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:37:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93BC061A0E;
        Wed, 20 May 2020 17:37:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbZD9-00CgeN-Bi; Thu, 21 May 2020 00:37:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/19] ipv4: take handling of group_source_req options into a helper
Date:   Thu, 21 May 2020 01:37:12 +0100
Message-Id: <20200521003721.3023783-10-viro@ZenIV.linux.org.uk>
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
 net/ipv4/ip_sockglue.c | 83 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 34c3a43a9c98..7f065a68664e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -624,6 +624,49 @@ static int set_mcast_msfilter(struct sock *sk, int ifindex,
 	return -EADDRNOTAVAIL;
 }
 
+static int do_mcast_group_source(struct sock *sk, int optname,
+				 struct group_source_req *greqs)
+{
+	struct ip_mreq_source mreqs;
+	struct sockaddr_in *psin;
+	int omode, add, err;
+
+	if (greqs->gsr_group.ss_family != AF_INET ||
+	    greqs->gsr_source.ss_family != AF_INET)
+		return -EADDRNOTAVAIL;
+
+	psin = (struct sockaddr_in *)&greqs->gsr_group;
+	mreqs.imr_multiaddr = psin->sin_addr.s_addr;
+	psin = (struct sockaddr_in *)&greqs->gsr_source;
+	mreqs.imr_sourceaddr = psin->sin_addr.s_addr;
+	mreqs.imr_interface = 0; /* use index for mc_source */
+
+	if (optname == MCAST_BLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 1;
+	} else if (optname == MCAST_UNBLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 0;
+	} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
+		struct ip_mreqn mreq;
+
+		psin = (struct sockaddr_in *)&greqs->gsr_group;
+		mreq.imr_multiaddr = psin->sin_addr;
+		mreq.imr_address.s_addr = 0;
+		mreq.imr_ifindex = greqs->gsr_interface;
+		err = ip_mc_join_group_ssm(sk, &mreq, MCAST_INCLUDE);
+		if (err && err != -EADDRINUSE)
+			return err;
+		greqs->gsr_interface = mreq.imr_ifindex;
+		omode = MCAST_INCLUDE;
+		add = 1;
+	} else /* MCAST_LEAVE_SOURCE_GROUP */ {
+		omode = MCAST_INCLUDE;
+		add = 0;
+	}
+	return ip_mc_source(add, omode, sk, &mreqs, greqs->gsr_interface);
+}
+
 static int do_ip_setsockopt(struct sock *sk, int level,
 			    int optname, char __user *optval, unsigned int optlen)
 {
@@ -1066,9 +1109,6 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 	case MCAST_UNBLOCK_SOURCE:
 	{
 		struct group_source_req greqs;
-		struct ip_mreq_source mreqs;
-		struct sockaddr_in *psin;
-		int omode, add;
 
 		if (optlen != sizeof(struct group_source_req))
 			goto e_inval;
@@ -1076,42 +1116,7 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 			err = -EFAULT;
 			break;
 		}
-		if (greqs.gsr_group.ss_family != AF_INET ||
-		    greqs.gsr_source.ss_family != AF_INET) {
-			err = -EADDRNOTAVAIL;
-			break;
-		}
-		psin = (struct sockaddr_in *)&greqs.gsr_group;
-		mreqs.imr_multiaddr = psin->sin_addr.s_addr;
-		psin = (struct sockaddr_in *)&greqs.gsr_source;
-		mreqs.imr_sourceaddr = psin->sin_addr.s_addr;
-		mreqs.imr_interface = 0; /* use index for mc_source */
-
-		if (optname == MCAST_BLOCK_SOURCE) {
-			omode = MCAST_EXCLUDE;
-			add = 1;
-		} else if (optname == MCAST_UNBLOCK_SOURCE) {
-			omode = MCAST_EXCLUDE;
-			add = 0;
-		} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
-			struct ip_mreqn mreq;
-
-			psin = (struct sockaddr_in *)&greqs.gsr_group;
-			mreq.imr_multiaddr = psin->sin_addr;
-			mreq.imr_address.s_addr = 0;
-			mreq.imr_ifindex = greqs.gsr_interface;
-			err = ip_mc_join_group_ssm(sk, &mreq, MCAST_INCLUDE);
-			if (err && err != -EADDRINUSE)
-				break;
-			greqs.gsr_interface = mreq.imr_ifindex;
-			omode = MCAST_INCLUDE;
-			add = 1;
-		} else /* MCAST_LEAVE_SOURCE_GROUP */ {
-			omode = MCAST_INCLUDE;
-			add = 0;
-		}
-		err = ip_mc_source(add, omode, sk, &mreqs,
-				   greqs.gsr_interface);
+		err = do_mcast_group_source(sk, optname, &greqs);
 		break;
 	}
 	case MCAST_MSFILTER:
-- 
2.11.0

