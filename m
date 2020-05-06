Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2795C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECBE20753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JaFQGRB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgEFWRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730133AbgEFWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:17:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96552C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:17:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so4028323wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MFeWzPc1RUZtMsyR+QF2WWvfCyhWcmegLUYlhF9UuM=;
        b=JaFQGRB8TMety2Bpfl3x2Tww4yDno+k5vXFpcIGmmEwgw0PHZIuvG2a85Vs71Sfjt2
         zChciYcyifEARUUlEOlqF4kUuBrfTcx0uvVh9zmIDd8qawpW46L1qLcPkjybPHT4ttCc
         QVU7mcHUl/EXmPYSvjpzlb/FMQ9Q+Rlji8mNY+/HzIW91xBGRpAiFJn6Uw2jBMVJtdvR
         scJNxd82CB2/Zx/dLCtXEl3Wpu4xNKAbY3Mby9XqKEf+ag8b7+INndGBnAZqOPKlnNfJ
         x/9PXQ/EtDYsSYd2WPicz/HC/yX2OXROe5/PjjKDJbkflA9hsti9adA7ZxIXmoIFqugf
         AtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MFeWzPc1RUZtMsyR+QF2WWvfCyhWcmegLUYlhF9UuM=;
        b=sY9FPSFQfaYHfCS055AsKP89QZSVWg/2YximgID4Z8cM9Ua1jEO+Xyl4W57gNpGLw5
         pEGqYt0fznjBtDt3CPP5kx/eF0fNVXv4qEQDbaPgVz1O68gGVEzuYmXjuAP8EA22jCP4
         FQO2NxLXYbnWkxdb/kTnXxO9GH2vvSvhHj0GXGK4kGbykGgGibWxxc4cvpF94myjl6ws
         lTiaY0MUE8cIuDjxI9EtS/7gj7b5Y7ouGU2AxkEJmFsiQ2GD/WfCViTKIan0N9JIzbbz
         izMyeQmIlZCCeWjs0A5qLWSRcXgG5D9IDYcnO3nyHaLj8tJuPwQ2DzBnl5hz2X3OPhbj
         fhNA==
X-Gm-Message-State: AGi0PuaLVy7yAHhpVjHd5HnOrHXuNJhoL5S88vEmuJhVorvtOZ4E8/Wy
        90/3YG0J7AFp0yeLfV7okTB24A==
X-Google-Smtp-Source: APiQypLiZViN47s9MAPYRjk6QeZwCIgZBt9QugEWVSMLxczjeK4W2LTz5D+BLFR6byBDFaOO0xCSOA==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr11132976wrv.152.1588803432274;
        Wed, 06 May 2020 15:17:12 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id f5sm4760671wrp.70.2020.05.06.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:17:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: meson: g12: add internal DAC glue
Date:   Thu,  7 May 2020 00:16:56 +0200
Message-Id: <20200506221656.477379-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200506221656.477379-1-jbrunet@baylibre.com>
References: <20200506221656.477379-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the internal DAC glue support on the g12 and sm1 family
This glue connects the different TDM interfaces of the SoC to
the internal audio DAC codec.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 55d39020ec72..0d14409f509c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -343,6 +343,15 @@ spdifout_b: audio-controller@680 {
 			status = "disabled";
 		};
 
+		toacodec: audio-controller@740 {
+			compatible = "amlogic,g12a-toacodec";
+			reg = <0x0 0x740 0x0 0x4>;
+			#sound-dai-cells = <1>;
+			sound-name-prefix = "TOACODEC";
+			resets = <&clkc_audio AUD_RESET_TOACODEC>;
+			status = "disabled";
+		};
+
 		tohdmitx: audio-controller@744 {
 			compatible = "amlogic,g12a-tohdmitx";
 			reg = <0x0 0x744 0x0 0x4>;
-- 
2.25.4

