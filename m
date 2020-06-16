Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACE820C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322160;
	bh=R8b4aXiaDVa9gpxOJ77HU6fmfPrXxPzH9NZlAi6jZ1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePqFhQb1/XL54xPnj9IDGJSFYB1/TXk49ts/OaYkwBLGCKePlfbmPPNnHBYYbSxMe
	 a/JQhz1Y2jYsoRmxAG5aJjF/TLzqX/G1wAz0O6dl6So6Kck6hT5GC4FzJmUS2C7JX0
	 ujPzVT+zQPE4DmvQ959gc5H8T1Z3iLVTcUuAIkIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgFPPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbgFPPmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:42:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A84D20C56;
        Tue, 16 Jun 2020 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322154;
        bh=R8b4aXiaDVa9gpxOJ77HU6fmfPrXxPzH9NZlAi6jZ1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1DpcV358vQR6m6+HY5WLeVYQR/gSbhW4EDHnXoOJVnY7ZRKw2nMD9eH+BaKoRtKJ
         Zj3TD4NM/dYgOeSwNe+z22GuRl9scutu8i0ASmrNF3IS8/EkdWdyTCS7GXQcVFckLI
         DVtxQaX5bUH+WnxAcY+hbj9FXtePK7//b2Sq9X7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 003/163] net_failover: fixed rollback in net_failover_open()
Date:   Tue, 16 Jun 2020 17:32:57 +0200
Message-Id: <20200616153107.022748125@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit e8224bfe77293494626f6eec1884fee7b87d0ced ]

found by smatch:
drivers/net/net_failover.c:65 net_failover_open() error:
 we previously assumed 'primary_dev' could be null (see line 43)

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/net_failover.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -61,7 +61,8 @@ static int net_failover_open(struct net_
 	return 0;
 
 err_standby_open:
-	dev_close(primary_dev);
+	if (primary_dev)
+		dev_close(primary_dev);
 err_primary_open:
 	netif_tx_disable(dev);
 	return err;


