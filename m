Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580CAC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE12098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ebE9PrQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCGGHfLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICIMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:12:44 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56685 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbgICIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:01:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 11CC8B36;
        Thu,  3 Sep 2020 04:01:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pCHRyt9pwiHm9
        P1dZVZ3m42DEt9fo9/daatGBaOfPPw=; b=ebE9PrQaXt5uVlHUvqoOSv6/HH6a3
        UpQG5rZNZ5koOHeJKM7hcKLZYw72BDPzLfAiyeSEgi9jn6hmM2KCwjx3re5KkF1G
        4ATb6kzut3LH1g9VSInhDGP5ucEchziIW+Y+XIOI+6mQGD4+XEeBQWgxBIS18BH/
        uCDSBfsTiOCN50j2Iwekliu1+KCoauDScrpfJ81IRh4wOLjBkq7NVUHOr9vIfOd1
        42ThgZq5GrbKNWAzAFsb1YjCDSoY3RQvfhHJpj+xYLAvOS0ce1pyAG/aq83cL6PO
        RKcta0oh/v5YUCJliNdDbjsYR7XaWZ+eezmE/Q1QwZtZwJQKRG+38ub0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pCHRyt9pwiHm9P1dZVZ3m42DEt9fo9/daatGBaOfPPw=; b=NCGGHfLa
        KT9a/9dEdb9XuoKGQ+RtMvbipYCHa8hkc2059hUOUnZFpUTHXR56OrYn8sE023y4
        4Qwp1UcMYwr5/b3Wg6YeY+mdi1Q3tlliphU1QCfQxrTk7HDQWfV4PGtf23SigTN4
        O2/IXITmrpLXP4MfPfYj+4B9MCF/fN+YbLCudrnbs6V8hhuci7tZIQX5J6+Mo2ca
        a8jIon84qHTIptRR8Yvge3P2NTD6FaJ8EjaHlSYoo3q7f1ijSUeVDdlTOHZjv+gY
        bPj7GegiFcyu2X/Xg63MPEIHYtuqST4wBwS7KWVs9AK4xhVwEhqlahYkMYGokD1L
        rNI04rZLOBDOWw==
X-ME-Sender: <xms:9KJQX7UXIds2bWmEj_g1vBwl1QYWmeg7gHYR97tn4YI_lkqazoyyig>
    <xme:9KJQXznSNSGP2RiOfk0wR_rLqJSMGuyAFU5SRYLSYNpzK7iztUZmrmnhj6bLesfVY
    CAmleWd4PlWlaZZiY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9KJQX3YQtrCpvn3BLsbCQbvdBvCc0eq_slopomHYKq0vpPT6J3F_rA>
    <xmx:9KJQX2Vy-pVjHhQVgSdQj0JNY4jWj0ki806pUEU2kq7N2JVjOnFkiw>
    <xmx:9KJQX1k3ySUJ63DTmT-GYhMW-BqoO9DdEdY9RB0py3XmxEBW3vDfhg>
    <xmx:9KJQX7dxau8A-oa7FZWM3ikdhySO44APyJ_vqPab82w3HO8pw1jggF3E2vU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D90713060062;
        Thu,  3 Sep 2020 04:01:55 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 01/80] dt-bindings: display: Add support for the BCM2711 HVS
Date:   Thu,  3 Sep 2020 10:00:33 +0200
Message-Id: <a6b4c9ee03bc8f950adc6c493db70cd540c2f902.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HVS found in the BCM2711 is slightly different from the previous
generations, let's add a compatible for it.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml | 18 ++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index 02410f8d6d49..e826ab0adb75 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm2835-hvs
+    enum:
+      - brcm,bcm2711-hvs
+      - brcm,bcm2835-hvs
 
   reg:
     maxItems: 1
@@ -19,6 +21,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description: Core Clock
+
 required:
   - compatible
   - reg
@@ -26,6 +32,16 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: brcm,bcm2711-hvs"
+
+then:
+  required:
+    - clocks
+
 examples:
   - |
     hvs@7e400000 {
-- 
git-series 0.9.1
