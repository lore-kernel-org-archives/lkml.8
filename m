Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D66C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580DD2151B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973392;
	bh=M9KTQ49n/EGr/CjzyvIbaZ+u+m0NyH0Ia9wgRoHbziQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cQP+v83uCzcZqWxzDt9BQNvnXVpq9F0AfZdhtucpYAq7EaRjVMI8oCUj7qAGnTPht
	 Ck68q+Pzj/imeybUKevzxqMGMn+y5uYd5eLzCaMmMcPQEPNyOa3InLi0kidKwS01QZ
	 49s5Bwa9VeOLpfTf8eMbafnMXbRnek2W68hzexmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgIAPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgIAPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:15:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF07D2100A;
        Tue,  1 Sep 2020 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973336;
        bh=M9KTQ49n/EGr/CjzyvIbaZ+u+m0NyH0Ia9wgRoHbziQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rz7fsj18Qpuq9uE8MOtaNx10wVPMuiz03wnUtctLNRo/G8mfokoIsYIg73qqlASAi
         3domUIWBHcuBfyrF6Nbe7vUgIb4FdKBQrcP5YoEKnqforyJEH3bFYLmG4Ulp8luSE+
         3fzqIG39k1jcvUVt1mad4qNjq4H1dwfyNqpmIQYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 39/78] i2c: rcar: in slave mode, clear NACK earlier
Date:   Tue,  1 Sep 2020 17:10:15 +0200
Message-Id: <20200901150926.687570369@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 914a7b3563b8fb92f976619bbd0fa3a4a708baae ]

Currently, a NACK in slave mode is set/cleared when SCL is held low by
the IP core right before the bit is about to be pushed out. This is too
late for clearing and then a NACK from the previous byte is still used
for the current one. Now, let's clear the NACK right after we detected
the STOP condition following the NACK.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4231673435e7b..6be02da2ccc46 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -534,6 +534,7 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 	/* master sent stop */
 	if (ssr_filtered & SSR) {
 		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
+		rcar_i2c_write(priv, ICSCR, SIE | SDBS); /* clear our NACK */
 		rcar_i2c_write(priv, ICSIER, SAR);
 		rcar_i2c_write(priv, ICSSR, ~SSR & 0xff);
 	}
-- 
2.25.1



