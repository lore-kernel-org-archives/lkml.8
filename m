Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014F62068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SvCKqq6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBCGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:06:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8696 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIBCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:06:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4efdee000f>; Tue, 01 Sep 2020 19:05:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 19:06:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 19:06:21 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 02:05:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 02:05:10 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.173.243]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4efdd50004>; Tue, 01 Sep 2020 19:05:09 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <sakari.ailus@iki.fi>,
        <hverkuil@xs4all.nl>, <jacopo+renesas@jmondi.org>,
        <luca@lucaceresoli.net>, <leonl@leopardimaging.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: media: imx274: Add optional input clock and supplies
Date:   Tue, 1 Sep 2020 19:04:37 -0700
Message-ID: <1599012278-10203-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599012278-10203-1-git-send-email-skomatineni@nvidia.com>
References: <1599012278-10203-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599012334; bh=kqUG3y/QaXY5EJx3iso8lR7gKhwVELXrem8phHGh370=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SvCKqq6FIltS6B81ajmVVW6ktTUstdcQEq+y987LyAugzay15vg5n9AvNBIcd8V7S
         WRE3jmYblhgsjfLw4hHXsG7BFBMBG2kSxGp14584AwEXRhEJNqdpQY9677WKkqPDc9
         GuOI0UnvxXbDIJzldxYdikKrww0LMG5agS6VrMQgw08OcVWomrkBx1FZeA5M4Fiscd
         05SLHZhT6/xStWDtA+WOFBEwmz1t0J8m6cPCdBNyYsC/9eisJrs0wtOV1aO4/rWFen
         BCLe/gsdBZczN5kSGNSXxYdxwM7x/Aq9W5/cHREqTUDriwpUrMx42Xa+1LTlnr3KZ5
         H8xbQYtRSQ6vA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IMX274 optional external clock input and voltage
supplies to device tree bindings.

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/media/i2c/sony,imx274.yaml  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
index 7ae47a6..57e7176 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx274.yaml
@@ -25,6 +25,27 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description: Reference to the sensor input clock
+
+  clock-names:
+    maxItems: 1
+    items:
+      - const: inck
+
+  vana-supply:
+    description:
+      Analog voltage supply, 2.8 volts
+
+  vdig-supply:
+    description:
+      Digital IO voltage supply, 1.8 volts
+
+  vddl-supply:
+    description:
+      Digital core voltage supply, 1.2 volts
+
   port:
     type: object
     description: |
-- 
2.7.4

