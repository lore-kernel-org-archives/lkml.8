Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6ACC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA2C2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCWFaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:30:01 -0400
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:44106 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbgCWFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:30:01 -0400
IronPort-SDR: OWPvCCyt17iYZEb6ld6JuXpHbZrmtDOXLBUNC4Ye4KJfjC2E31mddPK6Z02vhDxrLgbf0mb9+Y
 U7780spNE28A==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Mar 2020 13:29:59 +0800
Received: from CSBMAIL1.internal.ite.com.tw (csbmail1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 02N5Tscx003337;
        Mon, 23 Mar 2020 13:29:54 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 23 Mar 2020 13:29:53 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/3] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Date:   Mon, 23 Mar 2020 13:21:52 +0800
Message-ID: <1584941015-20541-2-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
References: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: B0CF1E33A6A0412E9172CD1190A42FBCE69F7F14827F2C44AF22CA4601C40CB02000:8
X-MAIL: mse.ite.com.tw 02N5Tscx003337
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITE Tech. Inc. (abbreviated as ITE ) is a professional fabless IC
design house. ITE's core technology includes PC and NB Controller chips,
Super I/O, High Speed Serial Interface, Video Codec, Touch Sensing,
Surveillance, OFDM, Sensor Fusion, and so on.

more information on: http://www.ite.com.tw/

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4c8eaa1..49b7294 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -482,7 +482,7 @@ patternProperties:
   "^issi,.*":
     description: Integrated Silicon Solutions Inc.
   "^ite,.*":
-    description: ITE Tech, Inc.
+    description: ITE Tech. Inc.
   "^itead,.*":
     description: ITEAD Intelligent Systems Co.Ltd
   "^iwave,.*":
-- 
1.9.1

