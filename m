Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15A7C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D2F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgIDUCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:02:07 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41767 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgIDUCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:02:01 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 084K1EdA002405;
        Fri, 4 Sep 2020 22:01:27 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     devicetree@vger.kernel.org
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/6] dt-bindings: sram: allwinner,sun4i-a10-system-control: Add V3s compatibles
Date:   Fri,  4 Sep 2020 22:01:08 +0200
Message-Id: <20200904200112.5563-3-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904200112.5563-1-m.cerveny@computer.org>
References: <20200904200112.5563-1-m.cerveny@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner V3s has system control similar to that in H3.
Add compatibles for system control with SRAM C1 region.

Signed-off-by: Martin Cerveny <m.cerveny@computer.org>
---
 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index f5825935f..9577d6c14 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -33,6 +33,9 @@ properties:
           - const: allwinner,sun4i-a10-system-control
       - const: allwinner,sun8i-a23-system-control
       - const: allwinner,sun8i-h3-system-control
+      - items:
+          - const: allwinner,sun8i-v3s-system-control
+          - const: allwinner,sun8i-h3-system-control
       - const: allwinner,sun50i-a64-sram-controller
         deprecated: true
       - const: allwinner,sun50i-a64-system-control
@@ -86,6 +89,9 @@ patternProperties:
               - items:
                   - const: allwinner,sun8i-h3-sram-c1
                   - const: allwinner,sun4i-a10-sram-c1
+              - items:
+                  - const: allwinner,sun8i-v3s-sram-c1
+                  - const: allwinner,sun4i-a10-sram-c1
               - items:
                   - const: allwinner,sun50i-a64-sram-c1
                   - const: allwinner,sun4i-a10-sram-c1
-- 
2.17.1

