Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD568C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53F92075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgEUAhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgEUAhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:37:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DBC061A0E;
        Wed, 20 May 2020 17:37:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbZD7-00CgdM-H5; Thu, 21 May 2020 00:37:21 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/19] lift compat definitions of mcast [sg]etsockopt requests into net/compat.h
Date:   Thu, 21 May 2020 01:37:03 +0100
Message-Id: <20200521003721.3023783-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521003657.GE23230@ZenIV.linux.org.uk>
References: <20200521003657.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We want to get rid of compat_mc_[sg]etsockopt() and to have that stuff
handled without compat_alloc_user_space(), extra copying through
userland, etc.  To do that we'll need ipv4 and ipv6 instances of
->compat_[sg]etsockopt() to manipulate the 32bit variants of mcast
requests, so we need to move the definitions of those out of net/compat.c
and into a public header.

This patch just does a mechanical move to include/net/compat.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/compat.h | 24 ++++++++++++++++++++++++
 net/compat.c         | 25 -------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/compat.h b/include/net/compat.h
index 2b5e1f7ba153..69a8cd29c0ae 100644
--- a/include/net/compat.h
+++ b/include/net/compat.h
@@ -74,4 +74,28 @@ int compat_mc_getsockopt(struct sock *, int, int, char __user *, int __user *,
 			 int (*)(struct sock *, int, int, char __user *,
 				 int __user *));
 
+struct compat_group_req {
+	__u32				 gr_interface;
+	struct __kernel_sockaddr_storage gr_group
+		__aligned(4);
+} __packed;
+
+struct compat_group_source_req {
+	__u32				 gsr_interface;
+	struct __kernel_sockaddr_storage gsr_group
+		__aligned(4);
+	struct __kernel_sockaddr_storage gsr_source
+		__aligned(4);
+} __packed;
+
+struct compat_group_filter {
+	__u32				 gf_interface;
+	struct __kernel_sockaddr_storage gf_group
+		__aligned(4);
+	__u32				 gf_fmode;
+	__u32				 gf_numsrc;
+	struct __kernel_sockaddr_storage gf_slist[1]
+		__aligned(4);
+} __packed;
+
 #endif /* NET_COMPAT_H */
diff --git a/net/compat.c b/net/compat.c
index 69fc6d1e4e6e..032114de4fec 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -448,34 +448,9 @@ COMPAT_SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
 	return __compat_sys_getsockopt(fd, level, optname, optval, optlen);
 }
 
-struct compat_group_req {
-	__u32				 gr_interface;
-	struct __kernel_sockaddr_storage gr_group
-		__aligned(4);
-} __packed;
-
-struct compat_group_source_req {
-	__u32				 gsr_interface;
-	struct __kernel_sockaddr_storage gsr_group
-		__aligned(4);
-	struct __kernel_sockaddr_storage gsr_source
-		__aligned(4);
-} __packed;
-
-struct compat_group_filter {
-	__u32				 gf_interface;
-	struct __kernel_sockaddr_storage gf_group
-		__aligned(4);
-	__u32				 gf_fmode;
-	__u32				 gf_numsrc;
-	struct __kernel_sockaddr_storage gf_slist[1]
-		__aligned(4);
-} __packed;
-
 #define __COMPAT_GF0_SIZE (sizeof(struct compat_group_filter) - \
 			sizeof(struct __kernel_sockaddr_storage))
 
-
 int compat_mc_setsockopt(struct sock *sock, int level, int optname,
 	char __user *optval, unsigned int optlen,
 	int (*setsockopt)(struct sock *, int, int, char __user *, unsigned int))
-- 
2.11.0

