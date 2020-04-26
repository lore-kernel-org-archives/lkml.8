Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EABC54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CB42075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuhG3pd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgDZMFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgDZMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45EC061A0E;
        Sun, 26 Apr 2020 05:04:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so17089958wmh.0;
        Sun, 26 Apr 2020 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JenE0fEHUuGOY59D+9+b4JVrWQ5bnv0TWy8Is92oGAI=;
        b=PuhG3pd4LENiw+3akKIphd684cvbNp+m+e7wETgmmogANBMf2IUlTiUv6/+ZR3twmm
         8PKUDRzyH1LZ9uTW0ChOX7OLnh6J1jFnuGyF5GQLqXvj/rpbRGM2M+aclTd/tlaA8I9S
         zoOWMUSnJXnuu3Mya8aOTklwTL67oTm398/l+tYSrhKMq0UxjjHh+//Yy9As7Jq6vUvE
         yHkYY1e+IMKM7Eud7FGWEuFZTHdqDCQY2TXTlzJX43QVU5wBEdu9IxSw9MrD7YJVirl2
         FR+1Ctk7uTjHB7otGlPl/LZb0YhL5CTw4UAcuSywFP/jD3c6ZXUJ6zv3+B6BGY1C9Fs3
         1hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JenE0fEHUuGOY59D+9+b4JVrWQ5bnv0TWy8Is92oGAI=;
        b=PHanf7MnsOwJVXrWwOViMsjDW0xQsvYxUXRN/ueOdopnEn2KJ6r9+xdZYTG18Hxye9
         Tl83afQqgPrXHXhX1Wlg8RQZOrMuQb7H80TOeDzIFeLhuTi7fL9irjrANEemdAhwRSg0
         HQrss73AFFM0J7t/MdHQdND8C0AEGYlVlkrO31AKWzTf7i0ageDg5ZxuLTlj07gLAHYj
         jPKmOkuKQJcCtSKBxdw7ZubpITUIzAVIyeUfCbuTLx+nnVy6Equ3wea7fY6v6gt8E0c9
         6BUCJZjNRKIDLRVpsG1EJZ/K2veHOqSyAuPrkR9YkMJsZLr2Olzkf1lHabhy9x9DhaE6
         js5g==
X-Gm-Message-State: AGi0PuZGsofMDrk6Yuqyw2NvWH8cwuAbzBsRrCOyswk75OaeXQRpGwqQ
        /0Yz6hjbfW1ooqKgVCCh/TM=
X-Google-Smtp-Source: APiQypIEJTvJUtupeAfilLnksXm+HBYSzaFmjg+EIAPU4aLI3y84HQ3t53IugQfHHJS+CiIW0H3ifQ==
X-Received: by 2002:a7b:c850:: with SMTP id c16mr19592486wml.108.1587902687908;
        Sun, 26 Apr 2020 05:04:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:47 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/7] arm: dts: sunxi: h3/h5: Add DAI node for HDMI
Date:   Sun, 26 Apr 2020 14:04:36 +0200
Message-Id: <20200426120442.11560-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI block for I2S2 which is used for HDMI audio.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..9be13378d4df 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -662,6 +662,19 @@
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.20.1

