Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5243C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E352075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865249;
	bh=JUlF0rsjF4RXVsxOlMbOpMgAL5iLIfl+/UmI6BBmOZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xs9C0NzoRIMYnb3ZhcVx3LhnNbxHtIk3B8veDAQ4CW5hP0TbO6xfPm1WugWSQOFje
	 1hD1rj6ZqEZB3SZY6RiUlaxf43cckIs+FIE1P+AhfEh1ApQgemPMtEEDMSJKoojGy2
	 2ZeskKEK9+PX4FZt6Xy9qXjp6wLsf2B6fXtVGxhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbgAXL12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403964AbgAXL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:21 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312462077C;
        Fri, 24 Jan 2020 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865240;
        bh=JUlF0rsjF4RXVsxOlMbOpMgAL5iLIfl+/UmI6BBmOZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGX6F5hxc+iAS9at4MboKA878BYCaM1DeDybSxh0Kp0f4V2gZStUVE41HPpdTPmNt
         hqS1Wr6dNuIIP5MSDWsGgtGeC83iufY1Z4p95RAPoHGGevOi+PMcWWJjJso2+qJ40U
         059jNWF7G+EiAF/sbmyvZFO/Ge+JL4agQvQFDMEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 479/639] xfrm interface: ifname may be wrong in logs
Date:   Fri, 24 Jan 2020 10:30:49 +0100
Message-Id: <20200124093148.189524185@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit e0aaa332e6a97dae57ad59cdb19e21f83c3d081c ]

The ifname is copied when the interface is created, but is never updated
later. In fact, this property is used only in one error message, where the
netdevice pointer is available, thus let's use it.

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h        |  1 -
 net/xfrm/xfrm_interface.c | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index fb9b19a3b7496..48dc1ce2170d8 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1054,7 +1054,6 @@ static inline void xfrm_dst_destroy(struct xfrm_dst *xdst)
 void xfrm_dst_ifdown(struct dst_entry *dst, struct net_device *dev);
 
 struct xfrm_if_parms {
-	char name[IFNAMSIZ];	/* name of XFRM device */
 	int link;		/* ifindex of underlying L2 interface */
 	u32 if_id;		/* interface identifyer */
 };
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index d6a3cdf7885c3..4ee512622e93d 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -145,8 +145,6 @@ static int xfrmi_create(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	strcpy(xi->p.name, dev->name);
-
 	dev_hold(dev);
 	xfrmi_link(xfrmn, xi);
 
@@ -293,7 +291,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	if (tdev == dev) {
 		stats->collisions++;
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
-				     xi->p.name);
+				     dev->name);
 		goto tx_err_dst_release;
 	}
 
@@ -648,12 +646,6 @@ static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
 	int err;
 
 	xfrmi_netlink_parms(data, &p);
-
-	if (!tb[IFLA_IFNAME])
-		return -EINVAL;
-
-	nla_strlcpy(p.name, tb[IFLA_IFNAME], IFNAMSIZ);
-
 	xi = xfrmi_locate(net, &p);
 	if (xi)
 		return -EEXIST;
-- 
2.20.1



