Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF2C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF1320736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oCYe8gxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEKPJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730462AbgEKPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B8C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so19703260wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=oCYe8gxrsb/8td/jVnM+76EnsEaUJm0Tw62USaNMXXLzhPeP2Raxa4qM2uMqbWDTpH
         tDbnc2TfFcgYOAckv78xY78GlbHkdTVS7vgeXY2VqYITf6fSe+2A6JBIqDcTPA8YbBz0
         qoBisEzlmO56MR+MjwDSHvAjpU/2YQCp9TlFHCtsSY3XHRrAVPWG07uMmyrkVf4jGZVC
         wcBGt9lfggYUVrX7j7djZTeH6NfPmR09L3x3ge5m7NDff/LBBTEKf20JwuAjnB8bPZmf
         192y26SwSsKp4UDi9f6CyHUzJ46En2MCUZQrLZTAT5GxjySYZCwjSVc6LSHKmw88+c6C
         N8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=OO6K4I24+XVAPfmK8fe7VJwOC/PE/YKuIKxuAtKJQNwLcYdXHGMNSk6KU20fmvaB7U
         suUoSBZ/7ftOIj/GNlu2BJGXJSqaKUEw0eYUF54kP6S1icT8adCjilPv9cGYi4yrErXn
         euZSMDk7VNnPIgqCPQH/mHAH/C+Ku5nJk/BCsIbub0mseDhaE4uY6Tw/LDtZn6exhnU0
         MgmJOohC/erq7mP0Qpzlr+L0zzUHXk4od9RlZw/5vXQ6shdvInBov2cgjfOpXW+VVKFr
         AJlPrYdIopHRqShRxv4NmMoLYm7H5eHzJeong0PQv615GmbmoCPGAEoCqwcKyGyTlgfe
         vonw==
X-Gm-Message-State: AGi0PuajuFNnBoY55KkENmt9w+kkpJzuJ6+7ykvCWNaZlEAT/dYjjVmK
        Cjc+/RArLRDVOINgZazRksyJDg==
X-Google-Smtp-Source: APiQypITmPETczyz929tepB6ElHqCDCdOl6rPzyocONlBGydghLbf/NhrY+/vuSp72Y0ABP9l620WQ==
X-Received: by 2002:a1c:9948:: with SMTP id b69mr30816508wme.44.1589209718831;
        Mon, 11 May 2020 08:08:38 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/14] ARM64: dts: mediatek: add ethernet pins for pumpkin boards
Date:   Mon, 11 May 2020 17:07:58 +0200
Message-Id: <20200511150759.18766-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
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

