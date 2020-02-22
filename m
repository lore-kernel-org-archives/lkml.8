Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC87C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D4E20706
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="g2zvgk8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBVX4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:56:40 -0500
Received: from vps.xff.cz ([195.181.215.36]:34472 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgBVX4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582415797; bh=Z0fPjO8jsO2oUugd17bHa+NgwK2dmd50V02phNLazzM=;
        h=From:To:Cc:Subject:Date:From;
        b=g2zvgk8I4Vpz/PChFCmCGcei6LrRslRB6G1IKUciqWxbzc3Wq/EYI5/7RNWXiViYt
         vYid2e+SGO0W3js/ypWYe/bmIe8uPIDW/DGUcHgYnPg0sbwk3Y+GdEBeFWT1jYT8A6
         YDL7PP1DJMUeiHDnkehwc9EMlDnNWOmfUdKLYIwo=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: axp20x: Fix misleading use of negation
Date:   Sun, 23 Feb 2020 00:56:34 +0100
Message-Id: <20200222235634.243805-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It works incidentally, because AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN
is non-zero, but the false branch value really should be just 0.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/regulator/axp20x-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 16f0c85700360..1e6eb5b1f8d85 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -381,8 +381,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
 			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
-				 !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
 			break;
 		}
 
@@ -393,8 +392,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
 			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
-				 !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
 			break;
 		}
 
-- 
2.25.1

