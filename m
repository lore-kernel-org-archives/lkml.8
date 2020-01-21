Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35060C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857622522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:41:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21946 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728456AbgAUIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:41:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L8be4c015298;
        Tue, 21 Jan 2020 03:41:10 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkyta6tgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 03:41:10 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00L8f9QR054542
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 21 Jan 2020 03:41:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 21 Jan
 2020 03:41:08 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 21 Jan 2020 03:41:03 -0500
Received: from btogorean-pc.ad.analog.com ([10.48.65.146])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00L8Sm9c001010;
        Tue, 21 Jan 2020 03:40:58 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <matt.redfearn@thinci.com>, <robdclark@chromium.org>,
        <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 3/3] dt-bindings: drm: bridge: adv7511: Add ADV7535 support
Date:   Tue, 21 Jan 2020 10:27:24 +0200
Message-ID: <20200121082719.27972-4-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121082719.27972-1-bogdan.togorean@analog.com>
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a part compatible with ADV7533 but it supports 1080p@60hz and
v1p2 supply is fixed to 1.8V

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../bindings/display/bridge/adi,adv7511.txt   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
index 2c887536258c..e8ddec5d9d91 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
@@ -1,10 +1,10 @@
-Analog Device ADV7511(W)/13/33 HDMI Encoders
+Analog Device ADV7511(W)/13/33/35 HDMI Encoders
 -----------------------------------------
 
-The ADV7511, ADV7511W, ADV7513 and ADV7533 are HDMI audio and video transmitters
-compatible with HDMI 1.4 and DVI 1.0. They support color space conversion,
-S/PDIF, CEC and HDCP. ADV7533 supports the DSI interface for input pixels, while
-the others support RGB interface.
+The ADV7511, ADV7511W, ADV7513, ADV7533 and ADV7535 are HDMI audio and video
+transmitters compatible with HDMI 1.4 and DVI 1.0. They support color space
+conversion, S/PDIF, CEC and HDCP. ADV7533/5 supports the DSI interface for input
+pixels, while the others support RGB interface.
 
 Required properties:
 
@@ -13,6 +13,7 @@ Required properties:
 		"adi,adv7511w"
 		"adi,adv7513"
 		"adi,adv7533"
+		"adi,adv7535"
 
 - reg: I2C slave addresses
   The ADV7511 internal registers are split into four pages exposed through
@@ -52,14 +53,14 @@ The following input format properties are required except in "rgb 1x" and
 - bgvdd-supply: A 1.8V supply that powers up the BGVDD pin. This is
   needed only for ADV7511.
 
-The following properties are required for ADV7533:
+The following properties are required for ADV7533 and ADV7535:
 
 - adi,dsi-lanes: Number of DSI data lanes connected to the DSI host. It should
   be one of 1, 2, 3 or 4.
 - a2vdd-supply: 1.8V supply that powers up the A2VDD pin on the chip.
 - v3p3-supply: A 3.3V supply that powers up the V3P3 pin on the chip.
 - v1p2-supply: A supply that powers up the V1P2 pin on the chip. It can be
-  either 1.2V or 1.8V.
+  either 1.2V or 1.8V for ADV7533 but only 1.8V for ADV7535.
 
 Optional properties:
 
@@ -71,9 +72,9 @@ Optional properties:
 - adi,embedded-sync: The input uses synchronization signals embedded in the
   data stream (similar to BT.656). Defaults to separate H/V synchronization
   signals.
-- adi,disable-timing-generator: Only for ADV7533. Disables the internal timing
-  generator. The chip will rely on the sync signals in the DSI data lanes,
-  rather than generate its own timings for HDMI output.
+- adi,disable-timing-generator: Only for ADV7533 and ADV7535. Disables the
+  internal timing generator. The chip will rely on the sync signals in the
+  DSI data lanes, rather than generate its own timings for HDMI output.
 - clocks: from common clock binding: reference to the CEC clock.
 - clock-names: from common clock binding: must be "cec".
 - reg-names : Names of maps with programmable addresses.
@@ -85,7 +86,7 @@ Required nodes:
 The ADV7511 has two video ports. Their connections are modelled using the OF
 graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
-- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533, the
+- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533/5, the
   remote endpoint phandle should be a reference to a valid mipi_dsi_host device
   node.
 - Video port 1 for the HDMI output
-- 
2.24.1

