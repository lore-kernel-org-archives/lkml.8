Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBACC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062C8206ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgATDHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:07:46 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:10789 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgATDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:07:46 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 20 Jan 2020 10:58:07 +0800
Received: from csbcas.ite.com.tw (csbmail1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 00K2w52R078454;
        Mon, 20 Jan 2020 10:58:05 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 20 Jan 2020 10:58:04 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Date:   Mon, 20 Jan 2020 10:44:31 +0800
Message-ID: <1579488364-13182-2-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579488364-13182-1-git-send-email-allen.chen@ite.com.tw>
References: <1579488364-13182-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 8033083CDB5712C5DB6CC968BC03D51C93ECFDA9958C40F9E7F3A9A6BDAE5EEB2000:8
X-MAIL: mse.ite.com.tw 00K2w52R078454
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
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f45..552f5ef 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -463,6 +463,8 @@ patternProperties:
     description: Intersil
   "^issi,.*":
     description: Integrated Silicon Solutions Inc.
+  "^ite,.*":
+    description: ITE Tech. Inc.
   "^itead,.*":
     description: ITEAD Intelligent Systems Co.Ltd
   "^iwave,.*":
-- 
1.9.1

