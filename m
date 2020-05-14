Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9705C20748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1dGw+1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgENOpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgENOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:45:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDFC061A0E;
        Thu, 14 May 2020 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9UtQoI/F5BndnEZjurerNgRQRwh1y2a1S2oOi1HN0Zo=; b=k1dGw+1XweTzOQyPUqcxUkCtT7
        DdZjrD9zW7QEqX7gr5Z+h6NQ4j1f3Jj+vAzLLgAEKY5tIv0q1O8zeqWNb2F5RNRSqX+oo67kSO5QA
        UeHiCtaXOoGx7Im4uAiCiyD/sqORBRzMYWw/doyQGzpIajiwTfXUOvFRta98RWyfY3P6QZ8kl5Hgs
        H41dAhQka80hq+jDTz2UBZ4+gXPHRRbpwA9M3ewGFJPFYr4BkQQLDbboHWL5+2qCk1vBjH9eLQklK
        c8ffme2S4ITSikIk9mSFAXCeNxE9wcz1R8RrASndwFq+R+XRhSLPmzccNKf3LZyZQPCuUqp4TtE0x
        ZbBi4f2Q==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZF7J-0004jl-MM; Thu, 14 May 2020 14:45:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] appletalk: factor out a atrtr_ioctl_addrt helper
Date:   Thu, 14 May 2020 16:45:34 +0200
Message-Id: <20200514144535.3000410-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514144535.3000410-1-hch@lst.de>
References: <20200514144535.3000410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper than can be shared with the upcoming compat ioctl handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/appletalk/ddp.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index b41375d4d295d..4177a74f65436 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -867,6 +867,24 @@ static int atif_ioctl(int cmd, void __user *arg)
 	return copy_to_user(arg, &atreq, sizeof(atreq)) ? -EFAULT : 0;
 }
 
+static int atrtr_ioctl_addrt(struct rtentry *rt)
+{
+	struct net_device *dev = NULL;
+
+	if (rt->rt_dev) {
+		char name[IFNAMSIZ];
+
+		if (copy_from_user(name, rt->rt_dev, IFNAMSIZ-1))
+			return -EFAULT;
+		name[IFNAMSIZ-1] = '\0';
+
+		dev = __dev_get_by_name(&init_net, name);
+		if (!dev)
+			return -ENODEV;
+	}
+	return atrtr_create(rt, dev);
+}
+
 /* Routing ioctl() calls */
 static int atrtr_ioctl(unsigned int cmd, void __user *arg)
 {
@@ -882,19 +900,8 @@ static int atrtr_ioctl(unsigned int cmd, void __user *arg)
 		return atrtr_delete(&((struct sockaddr_at *)
 				      &rt.rt_dst)->sat_addr);
 
-	case SIOCADDRT: {
-		struct net_device *dev = NULL;
-		if (rt.rt_dev) {
-			char name[IFNAMSIZ];
-			if (copy_from_user(name, rt.rt_dev, IFNAMSIZ-1))
-				return -EFAULT;
-			name[IFNAMSIZ-1] = '\0';
-			dev = __dev_get_by_name(&init_net, name);
-			if (!dev)
-				return -ENODEV;
-		}
-		return atrtr_create(&rt, dev);
-	}
+	case SIOCADDRT:
+		return atrtr_ioctl_addrt(&rt);
 	}
 	return -EINVAL;
 }
-- 
2.26.2

