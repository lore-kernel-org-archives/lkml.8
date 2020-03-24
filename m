Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58674C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797120753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCXNdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:33:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4422 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbgCXNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:51 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OD5A56025061;
        Tue, 24 Mar 2020 09:13:07 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs622yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 09:13:05 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02ODD3m0056615
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 24 Mar 2020 09:13:04 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 06:13:02 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 06:13:02 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 24 Mar 2020 06:13:02 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02ODCrsr000388;
        Tue, 24 Mar 2020 09:12:53 -0400
From:   Bogdan Togorean <bogdan.togorea@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     Bogdan Togorean <bogdan.togorean@analog.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Clark <robdclark@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: bridge: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 24 Mar 2020 15:10:25 +0200
Message-ID: <20200324131027.62836-1-bogdan.togorea@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=1 spamscore=0 mlxlogscore=773
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Fixes: 9c8af882bf12: ("drm: Add adv7511 encoder driver")
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 9e13e466e72c..2f8f7510f07e 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -756,8 +756,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+			0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+			0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.17.1

