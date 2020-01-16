Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9926AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD872064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200479;
	bh=JgMkyUhH4t2GbX7FRMf4kH4L4nAw3+A3O18bvu3gdf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fNBD/aF8/KFkjslWW7RP3aeBnOHpORoJUfzLbFChnqSIeknVOanMgX8ex31y0CIQn
	 fdLngpcqgY18VIsLphqJl6VTU6pQQmwBiVAu56JwVnX9+vCuXTjl3YfBOaZjedaozh
	 W1TjPpqKAA5zjRMCq20mMoRqfa2fFv25h7SK5eZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgAPSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389777AbgAPRJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D6724687;
        Thu, 16 Jan 2020 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194594;
        bh=JgMkyUhH4t2GbX7FRMf4kH4L4nAw3+A3O18bvu3gdf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGBPZkdsxgGgL+tD4YQtAQew6jwp8aM591BNz6QH6kH8LQ8yYpPrwwj4+P06zwTzT
         gWPHxpHpjGw8V+TXS+FH53W1H4V0y/Tct3/2FPtOmzSNpFCtbC5Ih4HQE5d8qnPKEA
         AI/ne8p0e+TO2gVVO6ecznqL7F597F1iVNv+jsrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 464/671] xfrm interface: ifname may be wrong in logs
Date:   Thu, 16 Jan 2020 12:01:42 -0500
Message-Id: <20200116170509.12787-201-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index fb9b19a3b749..48dc1ce2170d 100644
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
index d6a3cdf7885c..4ee512622e93 100644
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

