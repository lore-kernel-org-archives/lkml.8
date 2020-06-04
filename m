Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1655207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591284895;
	bh=rs0GNkt8SntMYjYE6m+6lgJMsGQHlA2pghWlb63HaGY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NPGsU7vsjvbwrnxKC58LNicKy8ef5O7UaQqeLWL/lhfBaJhF4SXQTth0CvMmiKUGT
	 P1cTwm4wudjDmqVF+64MnePprYeUdyt8ps8HTVI70y76WjpqKPwHrtKtipHzBTL7t8
	 nPEJheoo/hqvDfIXkRBpmLqckjbr9qkzQlA+CCgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgFDPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgFDPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:34:53 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E15207D8;
        Thu,  4 Jun 2020 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591284893;
        bh=rs0GNkt8SntMYjYE6m+6lgJMsGQHlA2pghWlb63HaGY=;
        h=Date:From:To:Cc:Subject:From;
        b=k4CGIXl9fBOwmAX15L/MOGoGsvuGwga6LvktexVdBYvZDHp/IqBgshGYyLfXWbD9V
         3XCRQ84H4uH+1eWrxys+zyZu0arhxoWO5hyCel5yas+F8hjdY8AaXzUb/pGK73LmFk
         TCCoERoQ6hQnS6uAEIvrAW/COwBe/9GCCoiO/e+4=
Date:   Thu, 4 Jun 2020 10:39:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tali Perry <tali.perry1@gmail.com>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: npcm7xx: Remove unnecessary parentheses
Message-ID: <20200604153957.GA14839@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses around _bus_.

This issue was found with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index a8e75c3484f12..68951a293aae3 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2248,7 +2248,7 @@ static int npcm_i2c_probe_bus(struct platform_device *pdev)
 
 	bus->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bus->reg))
-		return PTR_ERR((bus)->reg);
+		return PTR_ERR(bus->reg);
 
 	spin_lock_init(&bus->lock);
 	init_completion(&bus->cmd_complete);
-- 
2.27.0

