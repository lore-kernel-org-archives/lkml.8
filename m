Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBE72074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036899;
	bh=R3wgwIWq66oh74rrJ+8ZLPu87VC68l8FI8TSdtRpAms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGhVtJlNILdSp2GH5stgn83QiUob30PZaDfuypOlIp4jQ+Kf0El7U6Wp5wgiRHSnN
	 4ktxx45ErHVNJVUjxT+KtQFJIpvBrMnhSXqNu2xnbzwWgrv9zasju18ubjCDfvn3Dv
	 vAe59w+djTSerFZs77pf1mrxEkf+17CzEOUqCaMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgFASli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbgFASM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:12:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEFF2068D;
        Mon,  1 Jun 2020 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035147;
        bh=R3wgwIWq66oh74rrJ+8ZLPu87VC68l8FI8TSdtRpAms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMHNpSJthfvCvuXtelOwyjIzApYuUkVTD1e0GheztZktDhkb9R4h1t+67ERMt/hck
         bTksikYTDqbjSdz7zOFs8nrd5X/aQsR0FhzhmzZ6ugo6Y+MMXMQOsJsVnKHUtrKux1
         ptW6VsAr1TVV0bdyaCjNLVVuj+xj0y2utB7QYbKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 003/177] ethtool: count header size in reply size estimate
Date:   Mon,  1 Jun 2020 19:52:21 +0200
Message-Id: <20200601174048.821023846@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>

[ Upstream commit 7c87e32d2e380228ada79d20ac5b7674718ef097 ]

As ethnl_request_ops::reply_size handlers do not include common header
size into calculated/estimated reply size, it needs to be added in
ethnl_default_doit() and ethnl_default_notify() before allocating the
message. On the other hand, strset_reply_size() should not add common
header size.

Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/netlink.c |    4 ++--
 net/ethtool/strset.c  |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -334,7 +334,7 @@ static int ethnl_default_doit(struct sk_
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
-	reply_len = ret;
+	reply_len = ret + ethnl_reply_header_size();
 	ret = -ENOMEM;
 	rskb = ethnl_reply_init(reply_len, req_info->dev, ops->reply_cmd,
 				ops->hdr_attr, info, &reply_payload);
@@ -573,7 +573,7 @@ static void ethnl_default_notify(struct
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
-	reply_len = ret;
+	reply_len = ret + ethnl_reply_header_size();
 	ret = -ENOMEM;
 	skb = genlmsg_new(reply_len, GFP_KERNEL);
 	if (!skb)
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -309,7 +309,6 @@ static int strset_reply_size(const struc
 	int len = 0;
 	int ret;
 
-	len += ethnl_reply_header_size();
 	for (i = 0; i < ETH_SS_COUNT; i++) {
 		const struct strset_info *set_info = &data->sets[i];
 


