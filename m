Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC09C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3C20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsEcp4lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgFYXfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgFYXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59493C08C5DE;
        Thu, 25 Jun 2020 16:34:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so5550828edr.9;
        Thu, 25 Jun 2020 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKHBQB3/jo26y5/T/I0yc88OTlZYCgKjy3NBHl/V9tw=;
        b=LsEcp4lhXTEnzdETIobnSRMHsm24mDS3VIMOZMC/8uJnxwIMITbOE2XdyblGvp8+gE
         +HovlwNh1FCKi1Oanzk4/WwJsbI3FjLTTkSIE5+y5KDA0MmG8xh8aoHMdb52VO5bCnUy
         nC9XcuxSq85AbHpzx9rYtcRqhnsKCHwLrKgyH5bnGjhZcR753Xi9KyoJZtmp0WOQ6YkB
         /LMvg3ZsnPCqHuEPUINJdpZuqSTyirXGbfX9rH0vMB8HgpWVXnVXxMnuhyLyVNBats1U
         aoLUX6Y9vmlflNwYFooN+CfxcYcFVOpubrCDPdBkpHj9uMO36rVaeN8HC28Jb7brwkOS
         6axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKHBQB3/jo26y5/T/I0yc88OTlZYCgKjy3NBHl/V9tw=;
        b=FXS4Rwzv/7LWN/YMyZU2ZUVAOmsfKwE8fqZomrxg1brwFIlo/VueZdXySmWjDA6Glc
         G3kpB9R7B/S8Vp7OdBTuOP3jvVhCCZqDAp67LoUa+1M6fnsBpzVkxpdO1nQnf3iIoRfj
         L2VI/iVwNGzPBNnZYlb8c+nTHLTwuWumwJrD6pX8BT+3NgVssVnwxEsrzTmIbdKyggBB
         mFUe3YE11YhxYkaYwHmfiU4AucsCjFw6NeSZ5qTxjBAeyQBSXikcmM0uNvH6oyOHMODs
         wbYu0lNS7VFdFUshTm98vzWzUPvHCY+qpZVTFVn+fSBOsSHhNUfnXlpUADmUywCB2LQ1
         DgDA==
X-Gm-Message-State: AOAM5328KQcWjrhdpjDBHV+1YB+XqtudIngOEXl6OFTrZQO+FiSmfZtx
        pumJ4/7kfa22/quWZmHP3Qv/EAvzO6o=
X-Google-Smtp-Source: ABdhPJzQ4NhltLSCtwQR4pKlfKRWu2vGwjE43Utf+zo4JjW7Zi5dPste6QsnY5EWhVYnwe3OyTbCBQ==
X-Received: by 2002:a05:6402:1c8b:: with SMTP id cy11mr664932edb.122.1593128073102;
        Thu, 25 Jun 2020 16:34:33 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:32 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 07/10] arm: dts: owl-s500: Add I2C nodes
Date:   Fri, 26 Jun 2020 02:34:19 +0300
Message-Id: <50b4780dfcef8d5e2bf0f4f32f6ccf36c9acc782.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C controller nodes for Actions Semi S500 SoC.

Note the Actions Semi Owl SoC's I2C driver seems to be fully compatible
with the Actions Semi S500 SoC, even though this is not explicitly
mentioned in the source code. Hence, for the moment, enable the I2C
controller node via the "actions,s900-i2c" compatible string.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 778775ac42f7..15c11af530ea 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -193,6 +193,46 @@ cmu: clock-controller@b0160000 {
 			#reset-cells = <1>;
 		};
 
+		i2c0: i2c@b0170000 {
+			compatible = "actions,s900-i2c";
+			reg = <0xb0170000 0x4000>;
+			clocks = <&cmu CLK_I2C0>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@b0174000 {
+			compatible = "actions,s900-i2c";
+			reg = <0xb0174000 0x4000>;
+			clocks = <&cmu CLK_I2C1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@b0178000 {
+			compatible = "actions,s900-i2c";
+			reg = <0xb0178000 0x4000>;
+			clocks = <&cmu CLK_I2C2>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@b017c000 {
+			compatible = "actions,s900-i2c";
+			reg = <0xb017c000 0x4000>;
+			clocks = <&cmu CLK_I2C3>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.27.0

