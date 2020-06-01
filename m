Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B27A206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="cMk+YVu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFAP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:26:10 -0400
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:38165 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgFAP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:26:10 -0400
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id C1704140AF9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:59:18 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id fluGj0Hrp1EW3fluIjqZsY; Mon, 01 Jun 2020 08:59:18 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A7RCwZeG c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=nTHF0DUjJn0A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=wHFN-Wy_BNrSwam1PQgA:9 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gm93I/tP/3ljpDVuFJauy7WyI7MNDnanjRIlNgj8E/A=; b=cMk+YVu3/GxiaVWVWz1lE1ZrVS
        8l/GnCdb6pSKNlWiIreBfhU24IvZQsP9bF4setA9YhU33jEBs9c9ZVoSWUuS9KseMTm6/Z9tksspK
        1DUjXnjkY6XWoAKA01b74afx/hB4JQmhZycUuSsczDyPgoWH9KQTr4hFFwnn1Qfx6GQF5sn77QAl+
        juqVobIb7eoac4dHwQwFPVytuZKGpr3WSuTWapwTRvzWqThy0WwqVn9+k6JXxx9yb+7iPqcuE6uUY
        iTvC0dZic3SDry22V6cfoCUQp1aYXCKxn92fdzVFRXHm+MQRdCpRTrZ+luvxL3hK8z+7lX4Go+JXR
        wQdaXb3A==;
Received: from dslb-002-205-073-081.002.205.pools.vodafone-ip.de ([2.205.73.81]:57650 helo=arch.fritz.box)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <parthiban@linumiz.com>)
        id 1jfluF-0007Bg-Ax; Mon, 01 Jun 2020 14:59:15 +0000
From:   Parthiban Nallathambi <parthiban@linumiz.com>
To:     m.felsch@pengutronix.de, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add MYiR Tech boards
Date:   Mon,  1 Jun 2020 16:58:56 +0200
Message-Id: <20200601145857.5658-1-parthiban@linumiz.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 2.205.73.81
X-Source-L: No
X-Exim-ID: 1jfluF-0007Bg-Ax
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: dslb-002-205-073-081.002.205.pools.vodafone-ip.de (arch.fritz.box) [2.205.73.81]:57650
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 21
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for MYiR Tech imx6ULL eval boards.

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cd3fbe7e3948..592d73187da4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -264,6 +264,8 @@ properties:
               - armadeus,imx6ull-opos6uldev # OPOS6UL (i.MX6ULL) SoM on OPOS6ULDev board
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
               - kontron,imx6ull-n6411-som # Kontron N6411 SOM
+              - myir,imx6ull-mys-6ulx # MYiR Tech iMX6ULL Evaluation Board
+              - myir,imx6ull-mys-6ulx-nand # MYiR Tech iMX6ULL Evaluation Board with NAND
               - toradex,colibri-imx6ull-eval            # Colibri iMX6ULL Module on Colibri Evaluation Board
               - toradex,colibri-imx6ull-wifi-eval       # Colibri iMX6ULL Wi-Fi / Bluetooth Module on Colibri Evaluation Board
           - const: fsl,imx6ull
-- 
2.26.2

