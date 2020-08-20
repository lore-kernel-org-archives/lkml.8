Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA731C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CA520674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930307;
	bh=yNimt8oteiua9Ywn8PfbraGv1Dkc6uXM8n1oYGvyJHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KCffkThs0hJb75OXhNBc3Pv7MeYw3ELwVNFLfBInouJ2liJdhlwAAcU4NOBdp0Km1
	 WP1Q9vXMUXI3iEmbAT4oWJ216JCLHOnK6beEEOmrPQjF/oNS6X5w+7l4Pu1P/qNkoI
	 7ONHQb/sPz2p3kqXIK5ORh0+IhmZMMdIkSjoynvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHTNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgHTJcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D90A22BED;
        Thu, 20 Aug 2020 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915952;
        bh=yNimt8oteiua9Ywn8PfbraGv1Dkc6uXM8n1oYGvyJHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmNOoKFp8KkD3okx9IZeH+71Tn+0LGrIQttC1uh+9WQTssb2We8cSz170rKuRPPYc
         uBpJInrK+3heo9oquJRMFyIjrp+rOK+8Wd7m81TAFbIxQjrIeEQcTwkAf8lGFiBTZw
         Sk7G6qaihw91ZJTBPsUhS4q44HLzsMao+e7EYafs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 162/232] i2c: rcar: slave: only send STOP event when we have been addressed
Date:   Thu, 20 Aug 2020 11:20:13 +0200
Message-Id: <20200820091620.658340785@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 314139f9f0abdba61ed9a8463bbcb0bf900ac5a2 ]

When the SSR interrupt is activated, it will detect every STOP condition
on the bus, not only the ones after we have been addressed. So, enable
this interrupt only after we have been addressed, and disable it
otherwise.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2e3e1bb750134..76c615be5acae 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -583,13 +583,14 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 			rcar_i2c_write(priv, ICSIER, SDR | SSR | SAR);
 		}
 
-		rcar_i2c_write(priv, ICSSR, ~SAR & 0xff);
+		/* Clear SSR, too, because of old STOPs to other clients than us */
+		rcar_i2c_write(priv, ICSSR, ~(SAR | SSR) & 0xff);
 	}
 
 	/* master sent stop */
 	if (ssr_filtered & SSR) {
 		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
-		rcar_i2c_write(priv, ICSIER, SAR | SSR);
+		rcar_i2c_write(priv, ICSIER, SAR);
 		rcar_i2c_write(priv, ICSSR, ~SSR & 0xff);
 	}
 
@@ -853,7 +854,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	priv->slave = slave;
 	rcar_i2c_write(priv, ICSAR, slave->addr);
 	rcar_i2c_write(priv, ICSSR, 0);
-	rcar_i2c_write(priv, ICSIER, SAR | SSR);
+	rcar_i2c_write(priv, ICSIER, SAR);
 	rcar_i2c_write(priv, ICSCR, SIE | SDBS);
 
 	return 0;
-- 
2.25.1



