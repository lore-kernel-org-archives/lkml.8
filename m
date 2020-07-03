Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB55F20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=danweeks.net header.i=@danweeks.net header.b="FMXGToUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGCPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:45:23 -0400
Received: from p-impout008aa.msg.pkvw.co.charter.net ([47.43.26.139]:49659
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgGCPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:45:22 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jul 2020 11:45:22 EDT
Received: from opius.danweeks.net ([74.70.107.6])
        by cmsmtp with ESMTP
        id rNlVjtwY2rzR3rNlWj41C8; Fri, 03 Jul 2020 15:38:14 +0000
X-Authority-Analysis: v=2.3 cv=Ne6YKFL4 c=1 sm=1 tr=0
 a=h7kw2a+/6g3zdzmQNwjrbw==:117 a=h7kw2a+/6g3zdzmQNwjrbw==:17
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7kYe3NcsAAAA:8
 a=noYv9r6eKZTnZH2xmfQA:9 a=CjuIK1q_8ugA:10 a=4VldaCG94jXMVy0yUZtu:22
Received: from dev.danweeks.net (dev.danweeks.net [IPv6:2001:470:1f07:699::91])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by opius.danweeks.net (Postfix) with ESMTPSA id 083624410F;
        Fri,  3 Jul 2020 11:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=danweeks.net;
        s=opius.danweeks.net; t=1593790693;
        bh=V2T+2N4lCCiebjUmaYDIhM8VGLdRvfUsoZG/BWe/uvY=;
        h=Date:From:To:Cc:Subject;
        b=FMXGToUTze8pdU99NXtup5gP8ln27pg5Sze2mTtacMLbZ18QtO0Phj15tOpE4y3oq
         xD8YuO7vdX8OnBr+a9WJ144W146v83avFJ4MPqlGdy1GFVP7D4F+/dBP5vhjK0JOiA
         4IChXZNY90RU7oZCCbzOXBBOE2Xg0ysNk4T1tgGQ=
Date:   Fri, 3 Jul 2020 11:37:48 -0400
From:   "Daniel M. Weeks" <dan@danweeks.net>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
Message-ID: <20200703153748.GA16156@dev.danweeks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfD9asncUoSFNcBiXAB2gHJXmvbabag/zMKGlIzoo9k3WTWdB0wpT8dB8m7/cIaBridhqyOJZ4vaRLy/C4qfX3QFpRPGowuxWj5I1BcAQO4kRZLaju3oZ
 s2pEKcPfIGD+DzLSSI+y950AXz+OfXrXYbnwlAepaXRcFrIriGTLcsmF+C7kq9xHiY0UG5MNDHDmrLCVMHj3rdw8CJ81b7fRbOsKdrOaiG94JUBwzdgVOB5V
 8bzhWh4CvZFMAPuU880e1DCBS0UlARlw9Elg6bDN5k5cBD1pn5l397hKb2F5Bfj/7czbFi+xHejDqdDJEVVtSR+sU7dQDguMDwb0rqhXB/IJ9CydMic1jcYJ
 dPJrwtux
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel M. Weeks <dan@danweeks.net>
---
 Documentation/devicetree/bindings/hwmon/lm75.txt | 2 +-
 drivers/hwmon/lm75.c                             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
index 273616702c51..e5bb554cd2c3 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.txt
+++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
@@ -14,10 +14,10 @@ Required properties:
 		"maxim,max6626",
 		"maxim,max31725",
 		"maxim,max31726",
-		"maxim,mcp980x",
 		"nxp,pct2075",
 		"st,stds75",
 		"st,stlm75",
+		"microchip,mcp980x",
 		"microchip,tcn75",
 		"ti,tmp100",
 		"ti,tmp101",
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ba0be48aeadd..a8cfc7e4a685 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -690,10 +690,6 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "maxim,max31726",
 		.data = (void *)max31725
 	},
-	{
-		.compatible = "maxim,mcp980x",
-		.data = (void *)mcp980x
-	},
 	{
 		.compatible = "nxp,pct2075",
 		.data = (void *)pct2075
@@ -706,6 +702,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "st,stlm75",
 		.data = (void *)stlm75
 	},
+	{
+		.compatible = "microchip,mcp980x",
+		.data = (void *)mcp980x
+	},
 	{
 		.compatible = "microchip,tcn75",
 		.data = (void *)tcn75
-- 
Daniel M. Weeks
