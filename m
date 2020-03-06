Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9B20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OJlbFWUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFW10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:27:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35832 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFW10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:27:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so1725681pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeWGyVhSQlBwiMFchxY/x8zvKPyDAht51wdM4LGPaMo=;
        b=OJlbFWUtTlgzus9WEg4N3tRl6P5CYlHkRBNYM3Gldbs2eQTew1H7qa/996L6qmDxXq
         IpUDapzYB+xKEOgMAmL0TaIIScu4BpnVSD6HrJtwNA2y0q9wO5Ta+2Z44/9uxpvdhasR
         oo+euUGZ2J1ZqyZgw1EwVnS54iI2yCbvBl0GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeWGyVhSQlBwiMFchxY/x8zvKPyDAht51wdM4LGPaMo=;
        b=g1qosQ1sr3EdB1GkwPZVazwqwTviXo0uhomGgYonm24IcHryNeuOqwSwEaHxZlupUc
         JhxEjgyaEvqZefri7HqYwyyFr7BW1GftNwfIJYb9JvswUvJhESYUwDjgxmmSqpK2agPv
         2VRIUJxHm1Bw2P7cagBPA4hGkoW0sJOUYsBgLBXHFCKPg7IP7b/ZalFXufli7ERAxE6e
         rTP7lS5VRBCw3qbKXOg5CrkLyPKPFyhTTT5ghRc9thU+gdk6j15bqtMOXPEgg2iaIJKK
         YQQwC6oriSRgQQkPxtl+aZk7sFBDxzAhJnfITnNGhQmo/J7Xac6095GowMk/6JBQTHmw
         eZkA==
X-Gm-Message-State: ANhLgQ2tBETV2cy7/BZxCeFSDSBZ0vz1Z4WPPOvDlmDRqrEbmqc60rcy
        X4c7rIHipin3jQCmJHIeYGyL9Q==
X-Google-Smtp-Source: ADFU+vt8dZkS4FIomsYdEorgdQI9ZuLx45WIO/FKY615N0QhD3Iqa3QnSbVOSov43AVKbWzILUMkgg==
X-Received: by 2002:a63:112:: with SMTP id 18mr5258545pgb.116.1583533644783;
        Fri, 06 Mar 2020 14:27:24 -0800 (PST)
Received: from kevin-Precision-Tower-5810.dhcp.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm10504805pjr.10.2020.03.06.14.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2020 14:27:24 -0800 (PST)
From:   Kevin Li <kevin-ke.li@broadcom.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Li <kevin-ke.li@broadcom.com>
Subject: [PATCH] ASoC: brcm: DSL/PON SoC device tree bindings of audio driver
Date:   Fri,  6 Mar 2020 14:27:05 -0800
Message-Id: <20200306222705.13309-2-kevin-ke.li@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kevin Li <kevin-ke.li@broadcom.com>
---
 .../bindings/sound/brcm,bcm63xx-audio.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
new file mode 100755
index 000000000000..88e404a8145f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
@@ -0,0 +1,29 @@
+Broadcom DSL/PON BCM63xx Audio I2S controller
+
+Required properties:
+- compatible:     Should be "brcm,bcm63xx-i2s".
+- #address-cells: 32bit valued, 1 cell.
+- #size-cells:    32bit valued, 0 cell.
+- reg:            Should contain audio registers location and length
+- interrupts:     Should contain the interrupt for the controller.
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles list:
+                  - "i2sclk" (generated clock) Required.
+                  - "i2sosc" (fixed 200MHz clock) Required.
+
+(1) : The generated clock is required only when any of TX and RX
+      works on Master Mode.
+(2) : The fixed 200MHz clock is from internal chip and always on
+
+Example:
+
+		i2s: bcm63xx-i2s {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63xx-i2s";
+			reg = <0xFF802080 0xFF>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&i2sclk>, <&osc>;
+			clock-names = "i2sclk","i2sosc"; 
+		};
\ No newline at end of file
-- 
2.25.1

