Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A442C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FACF207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UNH02mzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbgFWSZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:25:02 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51872 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1592936685; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abmRLAwiNoQr6F48QZbrxbR8G+uP7eYeNw6ktpMn+xE=;
        b=UNH02mzoo311dDHpn5/HLq1d4bSdF2wc7xA6ISYIVMgv3nEqroY9O75VlmYM5IhpPbjT+j
        z1k+0kJZWglC+RT3ausIllPlj7dPFmksk5NMq7fCZGO8+xK/7Ze78FUmcTeTNSl7/1XUQL
        Ur2kQUtbBISlv2GtBJO4By+aQmwR+tk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/7] dt-bindings: timer/ingenic,tcu: Add compatible strings for JZ4725B SoC
Date:   Tue, 23 Jun 2020 20:24:28 +0200
Message-Id: <20200623182432.187843-3-paul@crapouillou.net>
In-Reply-To: <20200623182432.187843-1-paul@crapouillou.net>
References: <20200623182432.187843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the PWM and watchdog IPs on the Ingenic
JZ4725B SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 03893e6a2f57..371fb02a4351 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -116,7 +116,9 @@ patternProperties:
             - ingenic,jz4740-watchdog
             - ingenic,jz4780-watchdog
           - items:
-            - const: ingenic,jz4770-watchdog
+            - enum:
+              - ingenic,jz4770-watchdog
+              - ingenic,jz4725b-watchdog
             - const: ingenic,jz4740-watchdog
 
       reg:
@@ -142,6 +144,7 @@ patternProperties:
         oneOf:
           - enum:
             - ingenic,jz4740-pwm
+            - ingenic,jz4725b-pwm
           - items:
             - enum:
               - ingenic,jz4770-pwm
-- 
2.27.0

