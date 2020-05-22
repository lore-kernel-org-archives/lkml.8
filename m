Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023B32072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VhVGCTS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgEVMH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgEVMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:07:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76EAC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so1534235wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=VhVGCTS4grQt6k3HIErrSSbtbGv1Wb2NV++azMsGdLYYMvxxpy9bDLN55ZLzINOV9k
         FA4B2MGWBaHYAgatvgf2dGYKrGO8xWsZ4QKI9fTkogQYBe2HwRX4p37rG6SYWT43qr9m
         rzKobBuagWzGznsZIFsj05iy4OgSMBAR8TGedQokwHS8EPC5GmcC3wXUr9VaTZVsqePl
         FEcg341dLTGcYR88SzS5d1jPHMbs60ufBgTrfl+nqj5vy+SytnzIR3P34AHGt0pyfmvL
         djl2y9/l9gHpLihRw3dgb1o44HKCoGq741hEmx2t9uXgkpbm6wlqvo9SaJ7s0OIIeCWx
         mAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=VcgjsqIjY5ab9/8ajw38f9rda88Qzq9xlyIeSjNpo/ys22tD8Szycqd8g6yPN8o/AF
         Xy7NFolkNGS2AjkcQGJTmT0dQjENMca4pMHpqJmQeBtDhKWoDuCrWXH2naUEqKvbVwSF
         iJOZtPfYlsCjmVoBGASaz0pC4I4IQvQTPR1qVZE5cVedIkm+8Z0vTZAV/L71d/j5oMwb
         vGraijwHi3Mr3re+IdR4/gmeJOzhBETD7fo5FuP4dqvyZgburIKm9hJt61nxZgVywLfE
         QNJEoKsKmwXbfFPcqBY9AWuiQsLItZk8II2pIwWq4MdId3gARVX/BuBiYZVPoIqrhwnD
         2Q6A==
X-Gm-Message-State: AOAM531eJwCYVTuFEUOuDPfU0W+kMcQMkPYOCi6q3yUaRsgATmol7d8Y
        EBAcrr6KKT3nK286R0bfMvHDOw==
X-Google-Smtp-Source: ABdhPJzG2w/6WApFpPLpfPz5eZ2F69IZCZdA6mR68/WmlVPBV46pTlpI4dGghrWp/qiA5FGADLqR8Q==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr3365938wru.357.1590149253506;
        Fri, 22 May 2020 05:07:33 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f128sm9946233wme.1.2020.05.22.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:07:33 -0700 (PDT)
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
Subject: [PATCH v5 09/11] ARM64: dts: mediatek: add an alias for ethernet0 for pumpkin boards
Date:   Fri, 22 May 2020 14:06:58 +0200
Message-Id: <20200522120700.838-10-brgl@bgdev.pl>
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

Add the ethernet0 alias for ethernet so that u-boot can find this node
and fill in the MAC address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index a31093d7142b..97d9b000c37e 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -9,6 +9,7 @@
 / {
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &ethernet;
 	};
 
 	chosen {
-- 
2.25.0

