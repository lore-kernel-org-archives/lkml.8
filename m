Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14998C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93E12065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SidQb2k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgENIBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbgENIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF04C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so2645039wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=SidQb2k3EhXCryAgRq6gIPuNO1gSc1ymSxmVWmaAMjWgIA8V7nqMU6gzB5DHBHPwUA
         tbB5YxAQ3a8Y9XCmyxdwx7HmOh5WdFDKBHtWMJJxPLgeXTgBOgqAMBm+PK+eh5D7yM+v
         8HA+rZQ5NsDizXjPwTnrqGlHMsaAXQAvKtARpjRHk0erwPsnkhwsgB0cO59MoGtN4HyH
         Sso5t3yIewzdpRasYjH4Buni7el0CFRHSV9X6JcQdvImZbW9asceazSSx6KVXVW+eluY
         nN61T0d4cD8Hl5LM8eWKTtX0oGIz0iIvfzksYD3TNEzS7mmVo1utx1a2uqDICPUVNhHK
         fhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=QJ0QIyPexQK0pOa8DZDHb/RZWMux65Tnu30LWh3A6hJnAV6u7/Q6MeKygf0BIx66bs
         a8fTVlyyJdSVDP8Om1sgwcEYZIiJldPOCv6UKMu5F7yJjbUjF+KfhTfScEnS5XvhdlzM
         R0RRXPgJJgv7kCCj/vVkJCzWLLreS+aujvqZ8ZU+emknxNq1mWL+0rm0aK0gIo6PX/fv
         IOHlOuOC8y5IF8F97w5QMHHtVTNsab71vNuLlEelVXveplVYwUFy1faLXJAoS4NcUG7h
         +aOXfI2vEZrEMX4Mke6C7mUEukURUdemJkdWqMcBSpBW256v7UW4ft09mVnhQfU0QVVi
         GLZg==
X-Gm-Message-State: AOAM5311C04CLvkT7JafXJ8gdPa7wW7SqKrfk70dWywTX0EhnajNxehk
        nOWXwoq1QtYseJRDTJNThxZA3Q==
X-Google-Smtp-Source: ABdhPJyPB8tR3ALwj2/06aB+MU3MgeCuCaNoqPzuspDC4TKtFqqj7Hvg40WVJk8Hlp8ZczryagK4ew==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr4196133wrw.57.1589443211875;
        Thu, 14 May 2020 01:00:11 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v3 05/15] net: ethernet: mediatek: remove unnecessary spaces from Makefile
Date:   Thu, 14 May 2020 09:59:32 +0200
Message-Id: <20200514075942.10136-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The Makefile formatting in the kernel tree usually doesn't use tabs,
so remove them before we add a second driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index 2d8362f9341b..3362fb7ef859 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the Mediatek SoCs built-in ethernet macs
 #
 
-obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth.o
+obj-$(CONFIG_NET_MEDIATEK_SOC) += mtk_eth.o
 mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o
-- 
2.25.0

