Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CBC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5729C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgEKEqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728299AbgEKEp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:45:57 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE1C05BD09;
        Sun, 10 May 2020 21:45:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY0KB-005jIf-LW; Mon, 11 May 2020 04:45:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] handle the group_source_req options directly
Date:   Mon, 11 May 2020 05:45:46 +0100
Message-Id: <20200511044553.1365660-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200511044553.1365660-1-viro@ZenIV.linux.org.uk>
References: <20200511044328.GP23230@ZenIV.linux.org.uk>
 <20200511044553.1365660-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Native ->setsockopt() handling of these options (MCAST_..._SOURCE_GROUP
and MCAST_{,UN}BLOCK_SOURCE) consists of copyin + call of a helper that
does the actual work.  The only change needed for ->compat_setsockopt()
is a slightly different copyin - the helpers can be reused as-is.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv4/ip_sockglue.c   | 23 +++++++++++++++++++++--
 net/ipv6/ipv6_sockglue.c | 23 +++++++++++++++++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 4f412b0bdda4..8a3b879dc0f5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1322,8 +1322,27 @@ int compat_ip_setsockopt(struct sock *sk, int level, int optname,
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
 	case MCAST_UNBLOCK_SOURCE:
-		return compat_mc_setsockopt(sk, level, optname, optval, optlen,
-			ip_setsockopt);
+	{
+		struct compat_group_source_req __user *gsr32 = (void __user *)optval;
+		struct group_source_req greqs;
+
+		if (optlen != sizeof(struct compat_group_source_req))
+			return -EINVAL;
+
+		if (get_user(greqs.gsr_interface, &gsr32->gsr_interface) ||
+		    copy_from_user(&greqs.gsr_group, &gsr32->gsr_group,
+				sizeof(greqs.gsr_group)) ||
+		    copy_from_user(&greqs.gsr_source, &gsr32->gsr_source,
+				sizeof(greqs.gsr_source)))
+			return -EFAULT;
+
+		rtnl_lock();
+		lock_sock(sk);
+		err = do_mcast_group_source(sk, optname, &greqs);
+		release_sock(sk);
+		rtnl_unlock();
+		return err;
+	}
 	case MCAST_MSFILTER:
 	{
 		const int size0 = offsetof(struct compat_group_filter, gf_slist);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index fc525ad9ed3c..4c9a9f2f83cf 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1015,8 +1015,27 @@ int compat_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
 	case MCAST_UNBLOCK_SOURCE:
-		return compat_mc_setsockopt(sk, level, optname, optval, optlen,
-			ipv6_setsockopt);
+	{
+		struct compat_group_source_req __user *gsr32 = (void __user *)optval;
+		struct group_source_req greqs;
+
+		if (optlen < sizeof(struct compat_group_source_req))
+			return -EINVAL;
+
+		if (get_user(greqs.gsr_interface, &gsr32->gsr_interface) ||
+		    copy_from_user(&greqs.gsr_group, &gsr32->gsr_group,
+				sizeof(greqs.gsr_group)) ||
+		    copy_from_user(&greqs.gsr_source, &gsr32->gsr_source,
+				sizeof(greqs.gsr_source)))
+			return -EFAULT;
+
+		rtnl_lock();
+		lock_sock(sk);
+		err = do_ipv6_mcast_group_source(sk, optname, &greqs);
+		release_sock(sk);
+		rtnl_unlock();
+		return err;
+	}
 	case MCAST_MSFILTER:
 	{
 		const int size0 = offsetof(struct compat_group_filter, gf_slist);
-- 
2.11.0

