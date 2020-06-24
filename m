Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D44206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbgFXHBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388370AbgFXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:00:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C77C061755
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:00:58 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jnzOr-0006Wh-8u; Wed, 24 Jun 2020 09:00:49 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jnzOq-0002xN-GZ; Wed, 24 Jun 2020 09:00:48 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel@pengutronix.de, Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] net: ethernet: mvneta: Do not error out in non serdes modes
Date:   Wed, 24 Jun 2020 09:00:44 +0200
Message-Id: <20200624070045.8878-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mvneta_config_interface() the RGMII modes are catched by the default
case which is an error return. The RGMII modes are valid modes for the
driver, so instead of returning an error add a break statement to return
successfully.

This avoids this warning for non comphy SoCs which use RGMII, like
SolidRun Clearfog:

WARNING: CPU: 0 PID: 268 at drivers/net/ethernet/marvell/mvneta.c:3512 mvneta_start_dev+0x220/0x23c

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index af60001728481..c4552f868157c 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3571,7 +3571,7 @@ static int mvneta_config_interface(struct mvneta_port *pp,
 				    MVNETA_HSGMII_SERDES_PROTO);
 			break;
 		default:
-			return -EINVAL;
+			break;
 		}
 	}
 
-- 
2.27.0

