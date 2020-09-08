Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07387C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43C62087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592750;
	bh=vVUbIAaF8nS4HhBla1LFbTBHh9PVarnAhW6u3l2IBSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFG+tg2v2NFtkyjJO+QAHkZycKTRKE3zBz19MrHK7uF2+8hjXQHv5Ddcsz7sjQnJo
	 UK5tT5iqnkQdw8IBzedTZBX4R8l4js7xI3669JHbeKlWD/gK7h8Qe83GAI5QtDddVX
	 YFPhau7x57g5Qf/nX+XqnA3uuD6ASTNky4xj8oq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgIHTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731141AbgIHQCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804A723C92;
        Tue,  8 Sep 2020 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579406;
        bh=vVUbIAaF8nS4HhBla1LFbTBHh9PVarnAhW6u3l2IBSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1vvX6rV5GxUrz6gtOkjrceCG1OcriDWTl+NHbEvX/d60jNiyCJB5AypxqYf/Pdeq
         zhztNT2QuK7z0MYxtjqdi9IiQ7nxId5nWmphfLpLowMhEfPtLNH35ldzFe5lPI57+m
         DmR//BeKyXV8r78OAliX6qKqoH+cAi3bVLRMqEN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Gabriel Ganne <gabriel.ganne@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 064/186] gtp: add GTPA_LINK info to msg sent to userspace
Date:   Tue,  8 Sep 2020 17:23:26 +0200
Message-Id: <20200908152244.762261214@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit b274e47d9e3f4dcd4ad4028a316ec22dc4533ac7 ]

During a dump, this attribute is essential, it enables the userspace to
know on which interface the context is linked to.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Gabriel Ganne <gabriel.ganne@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 21640a035d7df..8e47d0112e5dc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1179,6 +1179,7 @@ static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 		goto nlmsg_failure;
 
 	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
+	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
 	    nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer_addr_ip4.s_addr) ||
 	    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms_addr_ip4.s_addr))
 		goto nla_put_failure;
-- 
2.25.1



