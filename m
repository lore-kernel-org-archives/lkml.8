Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645435;
	bh=Po14qPslBUSQW5+rJhoPZzDlO390mhUWITIQyhjIjAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMejl2+jczSU0wb1P0Z7PE8RpvvgA8+TWNuLecYjbOAzXq2lCK+5C/JvUgtJECuyb
	 JYbuXlZXRn0W5v7qE5qJxvfl5gKdND/e7CxPd8FFr+ZPjcP+jJIipnCqm27zJH8v1d
	 +danoP8cln6L+ICFRYxMLxdxNCJJhs3gzQoX6Bvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgCaJDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgCaJDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154ED20787;
        Tue, 31 Mar 2020 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645428;
        bh=Po14qPslBUSQW5+rJhoPZzDlO390mhUWITIQyhjIjAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTRqATZOojkYY3PG+fHC+7h4+3W4RXfgZqLHw8U461x8Dx/TOGcj0DBlVDdJqqTL9
         XjQApSXedqINkSZy+5GAMykOHBNpryA5Q0bUFJwF8qqC8xhDYVTzGJB/u/Q+9L34Yp
         Be1mnPE4+moaBHk1Csi8NiRz1uBhH+Rfsyio52sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noam Dagan <ndagan@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 050/170] net: ena: fix continuous keep-alive resets
Date:   Tue, 31 Mar 2020 10:57:44 +0200
Message-Id: <20200331085429.726319603@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit dfdde1345bc124816f0fd42fa91b8748051e758e ]

last_keep_alive_jiffies is updated in probe and when a keep-alive
event is received.  In case the driver times-out on a keep-alive event,
it has high chances of continuously timing-out on keep-alive events.
This is because when the driver recovers from the keep-alive-timeout reset
the value of last_keep_alive_jiffies is very old, and if a keep-alive
event is not received before the next timer expires, the value of
last_keep_alive_jiffies will cause another keep-alive-timeout reset
and so forth in a loop.

Solution:
Update last_keep_alive_jiffies whenever the device is restored after
reset.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Noam Dagan <ndagan@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2832,6 +2832,7 @@ static int ena_restore_device(struct ena
 		netif_carrier_on(adapter->netdev);
 
 	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));
+	adapter->last_keep_alive_jiffies = jiffies;
 	dev_err(&pdev->dev,
 		"Device reset completed successfully, Driver info: %s\n",
 		version);


