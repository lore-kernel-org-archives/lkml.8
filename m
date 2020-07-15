Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B7C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23AB206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JjMR5sTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgGOMsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbgGOMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8153C061755;
        Wed, 15 Jul 2020 05:48:51 -0700 (PDT)
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5EE3AE06;
        Wed, 15 Jul 2020 14:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817328;
        bh=Kgt8/WFPvU+BUMz3/GgtXlSI/EzZgvgqx/ZnKmH2xeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjMR5sTqZ0XMrKIeA062CxOdOkm3Rx1Uds4y/N86lkElLEmJfd5g2orGR7bONLJp2
         ReY+GHTjq6WgGXv2m9/qBIGrsfW8ff5E8gtyxq3AvhhOkY0VaFmfc1gZX+sQNyIC05
         T7fuL9KyGbrFG2ASj+dkEfdbwnmzp4DKosy/vkMI=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <snelson@pensando.io>,
        Colin Ian King <colin.king@canonical.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/8] drivers: net: wan: Fix trivial spelling
Date:   Wed, 15 Jul 2020 13:48:34 +0100
Message-Id: <20200715124839.252822-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptor -> descriptor

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2:
 - Fix commit message to reflect actual word replaced
---
 drivers/net/wan/lmc/lmc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
index a20f467ca48a..842def21e089 100644
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -2063,7 +2063,7 @@ static void lmc_driver_timeout(struct net_device *dev, unsigned int txqueue)
     /*
      * Chip seems to have locked up
      * Reset it
-     * This whips out all our decriptor
+     * This whips out all our descriptor
      * table and starts from scartch
      */
 
-- 
2.25.1

