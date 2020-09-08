Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF49320768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585605;
	bh=JDYV8v1+7ZrAM/vICWsPnHxOJgCjCaTnOlIEWADJcJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eSFsHZHB/3c0wSYMTRIB1dzqzvHV8QOERyNggp9MJv2StQWNdAAEoWZqERfplXNv5
	 aCgWKGxAQsdoVo7PVPhrTcSzKVm7J67cJidhb/UHYgZh4dqsdyjnn4bMga4Xh3PQZj
	 ejB8aDaOKrH7SOVFxEM+D8Qj8DKPczYL+RFR35EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIHRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbgIHQSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5C224810;
        Tue,  8 Sep 2020 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579806;
        bh=JDYV8v1+7ZrAM/vICWsPnHxOJgCjCaTnOlIEWADJcJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+A9hhpcjEqGnv08i/kzhsDPIjoRh14dduETUTrmaaL9Rl5HjDAKsGfzSW0dj3/He
         MqUUDeIwYZgDxafV9BBk0vMjq27j+MEHkx0XbbCNHoW257jZ7mP9pEExSiXwzTFrxI
         FFdxZ5oWRlGUI2hBtYrjENgq51xumjcxZA2QKyBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Gabriel Ganne <gabriel.ganne@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/129] gtp: add GTPA_LINK info to msg sent to userspace
Date:   Tue,  8 Sep 2020 17:24:41 +0200
Message-Id: <20200908152231.681088972@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
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
index d89ec99abcd63..634bdea38ecb3 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1182,6 +1182,7 @@ static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 		goto nlmsg_failure;
 
 	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
+	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
 	    nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer_addr_ip4.s_addr) ||
 	    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms_addr_ip4.s_addr))
 		goto nla_put_failure;
-- 
2.25.1



