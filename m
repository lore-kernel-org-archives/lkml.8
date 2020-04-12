Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E68FC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056D2206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 21:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056D2206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDLV2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgDLV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:28:10 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6AC6C0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:28:10 -0700 (PDT)
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d33 with ME
        id RxLd220040scBcy03xLeTr; Sun, 12 Apr 2020 23:20:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Apr 2020 23:20:39 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thomas.petazzoni@bootlin.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: mvneta: Fix a typo
Date:   Sun, 12 Apr 2020 23:20:34 +0200
Message-Id: <20200412212034.4532-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/mvmeta/mvneta/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5be61f73b6ab..51889770958d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5383,7 +5383,7 @@ static int __init mvneta_driver_init(void)
 {
 	int ret;
 
-	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "net/mvmeta:online",
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "net/mvneta:online",
 				      mvneta_cpu_online,
 				      mvneta_cpu_down_prepare);
 	if (ret < 0)
-- 
2.20.1

