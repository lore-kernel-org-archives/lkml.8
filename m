Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3010222BA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599834900;
	bh=IdkLrxN9felV/k85cV/tWxYZltvg/docZKXEUelkiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GraM/btmHbdAzBlh2G6+cWQqOOfgCKn3B4SJI/kY+mEDSgv1gCg8lugIEXvE13pf+
	 qfsvZVRI5d5FnDZ3tCjPnloN13feN9f4g+1ARUw2JzqeMcThQL78LYnqdJ6VEoZseE
	 MtOjajLxtrZHkru/ksX04ql56aYq4V2UWA6LHLcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgIKOex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgIKNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:12:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B8222472;
        Fri, 11 Sep 2020 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829251;
        bh=IdkLrxN9felV/k85cV/tWxYZltvg/docZKXEUelkiME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gr2ggh4sEFCTOMmPEFEEU318vCX99Dp+c1FU9ndLMvnbqNTXjbLjPBa3VO6+dnHa0
         SSrbRT9P8OI/m7xWUjefR1p/DDiyxVrTSSLAcFdfiSgfJVTanwaNwmrJ6r/wM9Zg7z
         ihGdNlcYYEH5G7u0PyUbbaJyMwksG+jY6jWufHis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Sherwood <rsher@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 7/8] net: disable netpoll on fresh napis
Date:   Fri, 11 Sep 2020 14:54:54 +0200
Message-Id: <20200911125422.055844958@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911125421.695645838@linuxfoundation.org>
References: <20200911125421.695645838@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 96e97bc07e90f175a8980a22827faf702ca4cb30 ]

napi_disable() makes sure to set the NAPI_STATE_NPSVC bit to prevent
netpoll from accessing rings before init is complete. However, the
same is not done for fresh napi instances in netif_napi_add(),
even though we expect NAPI instances to be added as disabled.

This causes crashes during driver reconfiguration (enabling XDP,
changing the channel count) - if there is any printk() after
netif_napi_add() but before napi_enable().

To ensure memory ordering is correct we need to use RCU accessors.

Reported-by: Rob Sherwood <rsher@fb.com>
Fixes: 2d8bff12699a ("netpoll: Close race condition between poll_one_napi and napi_disable")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c     |    3 ++-
 net/core/netpoll.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6196,12 +6196,13 @@ void netif_napi_add(struct net_device *d
 		pr_err_once("netif_napi_add() called with weight %d on device %s\n",
 			    weight, dev->name);
 	napi->weight = weight;
-	list_add(&napi->dev_list, &dev->napi_list);
 	napi->dev = dev;
 #ifdef CONFIG_NETPOLL
 	napi->poll_owner = -1;
 #endif
 	set_bit(NAPI_STATE_SCHED, &napi->state);
+	set_bit(NAPI_STATE_NPSVC, &napi->state);
+	list_add_rcu(&napi->dev_list, &dev->napi_list);
 	napi_hash_add(napi);
 }
 EXPORT_SYMBOL(netif_napi_add);
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -161,7 +161,7 @@ static void poll_napi(struct net_device
 	struct napi_struct *napi;
 	int cpu = smp_processor_id();
 
-	list_for_each_entry(napi, &dev->napi_list, dev_list) {
+	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
 		if (cmpxchg(&napi->poll_owner, -1, cpu) == -1) {
 			poll_one_napi(napi);
 			smp_store_release(&napi->poll_owner, -1);


