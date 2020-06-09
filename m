Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E75C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC5D20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgFIO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:57:33 -0400
Received: from lists.gateworks.com ([108.161.130.12]:54519 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgFIO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:57:28 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jifjw-0002Dv-5T; Tue, 09 Jun 2020 15:00:36 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: mfd: gateworks-gsc: add 16bit pre-scaled voltage mode
Date:   Tue,  9 Jun 2020 07:57:19 -0700
Message-Id: <1591714640-10332-2-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a 16-bit pre-scaled voltage mode to adc and clarify that existing
pre-scaled mode is 24bit.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 487a844..ceec33f 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -79,11 +79,12 @@ properties:
             description: |
               conversion mode:
                 0 - temperature, in C*10
-                1 - pre-scaled voltage value
+                1 - pre-scaled 24-bit voltage value
                 2 - scaled voltage based on an optional resistor divider
                     and optional offset
+                3 - pre-scaled 16-bit voltage value
             $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2]
+            enum: [0, 1, 2, 3]
 
           gw,voltage-divider-ohms:
             description: Values of resistors for divider on raw ADC input
-- 
2.7.4

