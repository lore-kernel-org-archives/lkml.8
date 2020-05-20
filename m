Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8093320758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hPUb+38Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgETLZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgETLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:25:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AAC05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so2703916wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=hPUb+38ZdEA5j+6g5LHfDwWL5eh8efRY1B/ixdvGsNR4XuXCt7sgEl2KeRlJ01EfHE
         EwHOGNPCwWkPsPu0H2xE7XhCrvUD+VrSuLITBNLMrGEkQ7QcY0s+80+VPg1swVLHURWP
         xHwAimb0cSrRccyWhXbCLPH8OB51GJEHSGjSJ1ZGPPkIvhUxXcjhQQCPpR2FZ6iw+FDE
         pMyarLDzJYC1+xU12NnxQm+UFb9ClIV1caF73rLdPiOEs14KFs7zfNQ/MYOBYO6BxrGw
         sw8ZuuR4q30AfOxECvB4qm/LO3wwL5t1niEhB547XDw+i4/coyqEUjEheZS3hEKIEu87
         psOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=BUjb53fAJQOVsub4ujJiGCripVU2IiJQkOu74fc+BpFfTHtPRcH3zO5PYBcfo2ZMyJ
         JoX0VcEL6T5A+A7H6lmXMpwjsErPty3zOL4hB5Z1r9Uhz4uE3AaeLctCPZWCgShHyFtR
         Hp1EQRr/VXQKmav/o9HNJFmAyskfe0a4QoaxYIxuESWwfA2dyl07w6QJ5Ohp8XMC5wOj
         AR8mg+wtaBLq/d5agNT4ldOmgpiUcJoq/F4+WpnaY0qXAKxKYe++Ml4jftPpM4iutkk9
         R3DHUFBbDXaJ46utjVqf5GOqGUOBiTePWt1a6aFufjwFarOP8ZNP/Gd4OXgeVbZf6X8F
         t3bQ==
X-Gm-Message-State: AOAM531PAY8AKtGmPaH9Bzsm+dg5E1d5rjxcYozNj9Mclk0BzDNBIqcS
        oxXapbvj8jAYjTCDD8sKJdJqaA==
X-Google-Smtp-Source: ABdhPJz8mA5+qKq8TXk4kO+lD9LIsszxlWW/zHrrIHr4SjCq6c8Fk/Cwl+qGKKL/YPBN3XFy4kA7Tg==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr3877082wru.308.1589973945873;
        Wed, 20 May 2020 04:25:45 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id v22sm2729265wml.21.2020.05.20.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:25:45 -0700 (PDT)
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
Subject: [PATCH v4 09/11] ARM64: dts: mediatek: add an alias for ethernet0 for pumpkin boards
Date:   Wed, 20 May 2020 13:25:21 +0200
Message-Id: <20200520112523.30995-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520112523.30995-1-brgl@bgdev.pl>
References: <20200520112523.30995-1-brgl@bgdev.pl>
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

