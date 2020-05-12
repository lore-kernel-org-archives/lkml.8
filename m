Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5CC2D0FC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E8620659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IkVWXnOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgELVL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731322AbgELVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:11:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC3C061A0E;
        Tue, 12 May 2020 14:11:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so17706544wrt.1;
        Tue, 12 May 2020 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyUJ8JvMJsGc3cYCEk/oX9tXJ35lckpImRBVoKxDiuw=;
        b=IkVWXnOcNw0noWwVJlSaM9F4DAuPiIUDhBHErPYnrAZkqahoBPrDGvXKfEhorxRdGM
         ZwhBeOoMFwmSfqjS3Rc2m5dKhzrtTm19oN4gEywvsSuuGwrdS5JleQ5gRbM2TsCIDekV
         cMMpkU3b9D0DCSEsknWBf2t6S67nm03Zcyi5Lgd4Nj8nx8ihf4xHp3o9eTWjHuHuqqeJ
         kobxhX70i8jXDePKLclusubDdFjnpfm24QTYCr7RfA4X8Mgcx7/Xe+YQVemebk85XnX5
         wynWisTFZIsY+0FCEbc7I6PxionoLBNKAFXNKqIAcvoU01xS0lpTtgE5ll/BBfJwH9Fm
         ji4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyUJ8JvMJsGc3cYCEk/oX9tXJ35lckpImRBVoKxDiuw=;
        b=EuM4NjwkAxektOMdtRzomhV3wgPEPhO6z71RsITAx4wQf5ubT/rR7ANSpoTj94VhG5
         ZJJg7gqyLXIdq5J+hGLetbsnr9XWkZNypajMhpPJft8STshz9fOLCIG125SIutcx1Hvp
         7d12PN3CWt1Eeui3T8Qvo2XeaNahOvT21+nzm0uB9latRiQubkLP4L3XFtdbNxJm+OOO
         izkSOIybk6FosnMgBvROzWHHRnpfiJMPuTzhP7t0OzvQYNPGLoMwWC1HZlZYX6cbbcoD
         HWcNtkONm8k3nTirgGBjNKuPGoteGXY6IdMDoOecd213sioVCk8O7nnjT4RpqX61mRXw
         nC1g==
X-Gm-Message-State: AOAM532CmnJE1LSy4DpSm4lIhgdD7JKmQXz+F+DHPUU2tUsa0o9zcwUp
        FsUxZEMhPCQzv1IVvHyPCdU=
X-Google-Smtp-Source: ABdhPJzsZwd39f5Py0zKbOGojILcU3AAoMhXT85YlKr2nSXSJ0+n1SX9DQL4m9CQffWJHRNUrocNXQ==
X-Received: by 2002:adf:806e:: with SMTP id 101mr3351863wrk.225.1589317879749;
        Tue, 12 May 2020 14:11:19 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r3sm9724228wmh.48.2020.05.12.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:11:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jianxin.pan@amlogic.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/8] net: stmmac: dwmac-meson8b: use FIELD_PREP instead of open-coding it
Date:   Tue, 12 May 2020 23:10:58 +0200
Message-Id: <20200512211103.530674-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512211103.530674-1-martin.blumenstingl@googlemail.com>
References: <20200512211103.530674-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use FIELD_PREP() to shift a value to the correct offset based on a
bitmask instead of open-coding the logic.
No functional changes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index a3934ca6a043..c9ec0cb68082 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
@@ -32,7 +33,6 @@
 #define PRG_ETH0_CLK_M250_SEL_SHIFT	4
 #define PRG_ETH0_CLK_M250_SEL_MASK	GENMASK(4, 4)
 
-#define PRG_ETH0_TXDLY_SHIFT		5
 #define PRG_ETH0_TXDLY_MASK		GENMASK(6, 5)
 
 /* divider for the result of m250_sel */
@@ -262,7 +262,8 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 					PRG_ETH0_INVERTED_RMII_CLK, 0);
 
 		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
+					FIELD_PREP(PRG_ETH0_TXDLY_MASK,
+						   tx_dly_val));
 
 		/* Configure the 125MHz RGMII TX clock, the IP block changes
 		 * the output automatically (= without us having to configure
-- 
2.26.2

