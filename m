Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A298AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8344F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lSlyl4mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgEEODi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729388AbgEEODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:03:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F28C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:03:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so2469103wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=lSlyl4mOElbeeStRAJ4CWke7R4swrfRTDDvLBAB45QOvM4+7cfviB8IS+q8YjTZ9ER
         J/ERsLiOQHNV1mTXN3jPp9K18esFG4ne5yM9GcYpMm01CSVnE/W734lRVikO4BAQNJfp
         NIJ0jLuZD/AMpS3Co94mCUYYzA7Mbr3GSRHF0qswguqdE/7M72H1HNornTVQfgBDvMBf
         J2lJdqjGdfJQJZaUMRQJG+LjJd44f4bKZ6cbr2NR816aGdFW5ioRRvqPprprQr5Q4qDe
         0CAUeW3L2CkjgSaKgHc1XyVKlBJjesE4lOuflOL1uJe3/07Mw43PRohiyBdxf3FGLcgj
         LT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=cXZUzQAiVsWJBHOlcmWpUiO2xHytHZEbBC0VcoNc0701ickmIXSou/1j3W62CMka9Y
         pCGVY492/sD7sCX5NxCWLzuyISHQzbaurBPY1DKcNF9E/KybZ3k3ORDrqeujVGAydZlh
         mJMUh8Gkk+vGzkkDlcTnTL6AZ/ysuBcQVpulDvyuc4bQ+8vYJBcq2cLU02VN9vvxPkKm
         bKJgP9u2O//w5cfuctq3lGWJs+aeD7yfCtgr5rs21Tgg9B1ARSS5KyYqKTwn5FLk8mkq
         GVaANBPJCRWMXouQ37txvfIgb8A2/dRzw3bSSeg6tmkly8kgxrNeXXMyH3+WkZrWxKUt
         y0Nw==
X-Gm-Message-State: AGi0PubWsCEdsa0ivHuclGN465Q/AlDvBQrwJUPEyfwsBZZjei1Fwrqm
        /kAc/QTHkPmQBTMEgccu7p9GGQ==
X-Google-Smtp-Source: APiQypKwmZMdeEmUAzcUU4K0jiEpe5kHCS1F6NfZ1/9dSidf/8PeL2h2zvcjETlSxePjjPJCHSUbNA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr3689658wme.139.1588687398732;
        Tue, 05 May 2020 07:03:18 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c190sm4075755wme.4.2020.05.05.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:03:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/11] ARM64: dts: mediatek: add ethernet pins for pumpkin boards
Date:   Tue,  5 May 2020 16:02:30 +0200
Message-Id: <20200505140231.16600-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200505140231.16600-1-brgl@bgdev.pl>
References: <20200505140231.16600-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Setup the pin control for the Ethernet MAC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 97d9b000c37e..4b1d5f69aba6 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -219,4 +219,19 @@ gpio_mux_int_n_pin {
 			bias-pull-up;
 		};
 	};
+
+	ethernet_pins_default: ethernet {
+		pins_ethernet {
+			pinmux = <MT8516_PIN_0_EINT0__FUNC_EXT_TXD0>,
+				 <MT8516_PIN_1_EINT1__FUNC_EXT_TXD1>,
+				 <MT8516_PIN_5_EINT5__FUNC_EXT_RXER>,
+				 <MT8516_PIN_6_EINT6__FUNC_EXT_RXC>,
+				 <MT8516_PIN_7_EINT7__FUNC_EXT_RXDV>,
+				 <MT8516_PIN_8_EINT8__FUNC_EXT_RXD0>,
+				 <MT8516_PIN_9_EINT9__FUNC_EXT_RXD1>,
+				 <MT8516_PIN_12_EINT12__FUNC_EXT_TXEN>,
+				 <MT8516_PIN_38_MRG_DI__FUNC_EXT_MDIO>,
+				 <MT8516_PIN_39_MRG_DO__FUNC_EXT_MDC>;
+		};
+	};
 };
-- 
2.25.0

