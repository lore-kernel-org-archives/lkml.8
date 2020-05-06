Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F5C54E7E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1532078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g1GtLVMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEFWRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730176AbgEFWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:17:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4147C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:17:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so4031410wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yN0HCUrRjQ5k4nIyeYJ90SMpOcbw0Xs0uvSCaOCg9cY=;
        b=g1GtLVMo3JG+hMTJIYH7JtCwyL8aI+OBkx8gezaZeT+5RwkRCBpJjWLsts3xv1MvCt
         YsuA9Rh2vrNc0RSzFGYnCnVF9HM/ZWvMO/xO/1aVV41l7+kAVqAaXqKcwL3t6c0Mkv1G
         10d+pHeAcs2BBzUQO28s+eB0HyIj+B8mZgmf8mSyVoJKhONA8XEBeN28YQVHxaii00t0
         ZDpcq0+FSAUo7+kkfM0TC8lihNBdlYrF326cILDZwvdNy6VjPtDerwC6YCWITiP0p2vr
         f/Fba1HRUctpQgx0Nn3np43yNY3pQHDpT0Z5mGhkTimFJfwImjTQ2zBr1BxamYhFri43
         zeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yN0HCUrRjQ5k4nIyeYJ90SMpOcbw0Xs0uvSCaOCg9cY=;
        b=Dc88lop5dMXeYa0UbloJsdsLue4AaEoKqxPKuuBKAZJTYip0fLAcx4denm6UEeTa2d
         TG6TbjebqCQK2zQuvU+f1wAolPv314mbEpDHyZi+YfFWri21bnqISH8AzktJ5TAv2Qk1
         DFrMel9lAkrXGYensi5dkYXztEukmW5BDCY6GqyU32HCDMer+VxyciqKpp21ELFLIDrm
         nmasFrU6TPvzxlNjUrXW6hnLy+NjG6Ny/nOraBy3qj/CoNjgCpzImWTTfLvuzZ/cjoQz
         RfnYodHk5Qbsl94pKzp8DovAP7DQtti5qxuyTMkuXePskZYv16tqo3zC706oCJyCw83p
         vQSg==
X-Gm-Message-State: AGi0PuaNvvnJfdrEWeTUbEuRGLMaLhCPR63aDDWHSaKVf42zLLIwcHqY
        YlceoYpHi5Wo7M7AP2ZxgQJJ1w==
X-Google-Smtp-Source: APiQypKmKkIATkCvRuA6L8tzWAVJ4EhdRo2Hu+9i0pkUQ8voHESzNMdPvDDbS2uufpAwDrHl0iKpoQ==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr12845202wrw.198.1588803430684;
        Wed, 06 May 2020 15:17:10 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id f5sm4760671wrp.70.2020.05.06.15.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:17:09 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: meson: g12: add internal DAC
Date:   Thu,  7 May 2020 00:16:55 +0200
Message-Id: <20200506221656.477379-7-jbrunet@baylibre.com>
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

add internal audio DAC support on the g12 and sm1 SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index c0aef7d69117..593a006f4b7b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -250,6 +250,17 @@ hwrng: rng@218 {
 				};
 			};
 
+			acodec: audio-controller@32000 {
+				compatible = "amlogic,t9015";
+				reg = <0x0 0x32000 0x0 0x14>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "ACODEC";
+				clocks = <&clkc CLKID_AUDIO_CODEC>;
+				clock-names = "pclk";
+				resets = <&reset RESET_AUDIO_CODEC>;
+				status = "disabled";
+			};
+
 			periphs: bus@34400 {
 				compatible = "simple-bus";
 				reg = <0x0 0x34400 0x0 0x400>;
-- 
2.25.4

