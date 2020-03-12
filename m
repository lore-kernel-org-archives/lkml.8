Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAFF20637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F8GXxd/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCLWdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:33:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46354 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCLWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:33:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so9620159wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDWsgDLGuZCMn9GDO0QtBYwdt4yNCxsID/A8c6spG+w=;
        b=F8GXxd/Up9QSlBTh8YYTrd18ZkncJ/tcs2fUV2pLzyVB9dQnU5tXHAqsvFSZpS37DF
         /RP8bFO35uANJ9prIV3av3xnZJ+YXjM41536qUknZrD+kVPSkjQZjTet7qzzEd82FfCj
         50Xu0bVXaJ/pLJshtDXNTrWU0nyssx9Q7z2jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDWsgDLGuZCMn9GDO0QtBYwdt4yNCxsID/A8c6spG+w=;
        b=Wgl2xx6TSv/3wdpgJgAkKPc77IfdBw2t4FxKKV7a8M4UaN4Rvn9qL1GkMN9PxSUg5K
         ZqsDPqE6dKy8Wr+oNPKHB3jKRimYWbKOTh/B5uA13fuZTil1ZtCju4IqtF9VTWQFjENV
         k6ARBSlUjWY3oZ9vcWKJt/gn0YtsYIEjqqj855dgGpSEUf/ehfOo/PJFr2yCME62TZeh
         R1hKOZuxxvcp/iegzJ7Aeb6xVlAhbaa2qohlpIP1RtyrIHrQYmRnsW9ysHw2K2qAwu4K
         hslEcvrf1ijB/Q5e8fSzaTwrrRgjT9cSAPBOaujphq0cPcdT7Pi0cbnCYNlaUMiXvHxI
         vBpQ==
X-Gm-Message-State: ANhLgQ1QQYwxbYrtYBtIJI4XBIcZXUBaene2UqXfNa/Co7JB+JmDXEa9
        GgCC1gN1k2QmXidmstrKGwCYi6xKvBo6CNDNl/E=
X-Google-Smtp-Source: ADFU+vtnUqNpWBj7jS/ZVk56MTaBujLMSdSyvo4Y3ZV8FcL31mlYMjdAQ/fuQ5f+5qNnmf/72hXOZw==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr13392404wrw.356.1584052378564;
        Thu, 12 Mar 2020 15:32:58 -0700 (PDT)
Received: from kevin-Precision-Tower-5810.dhcp.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o10sm2964144wrs.65.2020.03.12.15.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 15:32:58 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ASoC: brcm:  DSL/PON SoC device tree bindings of audio driver
Date:   Thu, 12 Mar 2020 15:32:40 -0700
Message-Id: <20200312223242.2843-1-kevin-ke.li@broadcom.com>
X-Mailer: git-send-email 2.25.1
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
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
new file mode 100644
index 000000000000..007f524b4d15
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
+- clock-names:    One of each entry matching the clocks phandles list:
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
-- 
2.25.1

