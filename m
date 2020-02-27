Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0890C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8BB24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cptdtmKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgB0Snv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:43:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35872 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0Snv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:43:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01RIhinI024769;
        Thu, 27 Feb 2020 12:43:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582829024;
        bh=yQMhnAs6/2i4Vbzp9EeB7/iL+FC+fpQaF/PdQma5zCc=;
        h=From:To:CC:Subject:Date;
        b=cptdtmKNqL2P3tjADAMcVPvuRBdXnEY+VkexzgJPvN7srZgpuCaOmEh55kiyOTIZ0
         dMvDYJvXo/OdqwDy06zwyhuG2VE2HBiN2InBGKeS/RbJpcw9pLeG7nNviyInrGZrNg
         rBRpa0zG6BclDPvLycK+BJC1fAsD9/zF2KaAJqV4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01RIhiE3011352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 12:43:44 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 12:43:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 12:43:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01RIhh0Q113174;
        Thu, 27 Feb 2020 12:43:43 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [RESEND PATCH can-next 1/2] can: tcan4x5x: Rename parse_config function
Date:   Thu, 27 Feb 2020 12:38:28 -0600
Message-ID: <20200227183829.21854-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the tcan4x5x_parse_config function to tcan4x5x_get_gpios since
the function retrieves the gpio configurations from the firmware.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 9821babef55e..37d53ecc560b 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -381,7 +381,7 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
 	int ret;
@@ -507,7 +507,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_parse_config(mcan_class);
+	ret = tcan4x5x_get_gpios(mcan_class);
 	if (ret)
 		goto out_power;
 
-- 
2.25.0

