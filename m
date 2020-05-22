Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0406F206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DVsXn2eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgEVMHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgEVMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:07:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB1C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so8432636wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=DVsXn2eYoFofqn541LZ4MfkWal+3Vy9fBdI9yAspaG2zAyqASOY0tqc4Nv4/+Bi62Z
         tUfQjSY+FHNzvALMKzVBCmTkLM740jnrTT30ToZZZzw5iGAWEdQKVrwkIiexpGELhLeO
         zrU088OFMx4gG4ErEwJxSrWOubMuE+9AUwAWJEOXRKSN2g6OXzZp/iTxw8DRAJlYedqz
         ngTmIuwLXT5hVEDSTz+QlHrw5qnO6fDzlZdtpPnREpOR9PzLcfhal6JyMl/WxmqcCCde
         fOpT0KAuZcee9ng8kIq8noqAJrKMD/yd0N+cE/pHu7NboS6Ct6ENqOoOjSo3cOcQ3Qx1
         gWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KiLRpfO6b7G+PZFXWrA65hqZV6E46x1U4Qg5U0775pc=;
        b=StYUrfJU5DrUfXI4aR4aBU/4bwMmc0+ib//q8fb6dsYGvitrjpYSyDM9Y6Ao1f1WmX
         7edY4u91fTQEQSemKrDXxXpx4ib56Q96/mF/zzINBpZODb4dvn5XXuO19n5Ao0Uw5EdN
         1FMYWrTOv2aCP1cogImpy3WynwFbkXnCWvBjPdWIAyn5B4ri4FtvtZTdVKu9fLHzRSGy
         KTbxxO9EB0WHHvHok3O3UGdf1TEEH8cn1YAHvtYa0+mcJZTzYs4bOV7CET7LAha/u/Wu
         lPWdyEyV/KrkXOgUSJCm9Xv6A8XnwqwS/iuCtnYsDpLw5popFIV+m2iDNwkQ3IoyeoVO
         wtBg==
X-Gm-Message-State: AOAM531n35V72TDRyrD0h8lC8sF6WQozhfQOOh9RatwBbGztdgOR1n03
        KgbW3YtD2jgz5UADf4tRqynnkA==
X-Google-Smtp-Source: ABdhPJy2dPeRTy6mlLX5UEd/lcC8TWwiaJ2T7GRkUXTF72jg1Gp3bgoI92xKzRbwpRCpK5LJsVLcOg==
X-Received: by 2002:a7b:c767:: with SMTP id x7mr13670227wmk.181.1590149254930;
        Fri, 22 May 2020 05:07:34 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f128sm9946233wme.1.2020.05.22.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:07:34 -0700 (PDT)
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
Subject: [PATCH v5 10/11] ARM64: dts: mediatek: add ethernet pins for pumpkin boards
Date:   Fri, 22 May 2020 14:06:59 +0200
Message-Id: <20200522120700.838-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522120700.838-1-brgl@bgdev.pl>
References: <20200522120700.838-1-brgl@bgdev.pl>
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

