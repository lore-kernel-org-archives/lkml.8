Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18198C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBD820724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN85WrfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHWWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHWWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA7C061575
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so7463751ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggsGppVM/HntumIRYVbA+20UkKH7XXtNQQ4sB7oN2mQ=;
        b=dN85WrfRGsTzUCZeeGEVg511kaLyqvum9uy+hMJOhW88gtwiSLkxvD/hSKIf5nmfWy
         g70CZi2MWVyl5NyulkwZWqYKdX6/I1HN5v5WFJNPCIgBfAReMxTo81NaOwDh8Zbffj/z
         95kgg9g7z9ciFB1dh3UNJEDGjPHTtd0VTtiA8K42A5jk3x6K9GwHQvv7+Bg3Y4n/DpG5
         f3TkMMmFL4wHM/i+L6+INMvBrgZieKiQkqGr/47esEpObhMtdx5PU/7qaEH49nki5nt4
         ivSAezf3LqgG0WL/VcTanunFNDBDgbm2XhWboUX93tnKRR7s+D5iGSAAEiJQj6+DhWA1
         VcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggsGppVM/HntumIRYVbA+20UkKH7XXtNQQ4sB7oN2mQ=;
        b=VK5j+vd7wLKe1VJBbAi68OibQSS5jEJNa3uUMQRlS+Iv3X4GKVjyDxV/L1MYxte6Y9
         IcaytgAIIUNlx5SlzQNoQNi0/97lSDHNmeFgw27q+Y849HwP51mFcGSN7qCc6isizH4h
         J28a5xxjeWVMhChbkSO5hR0bu7lE8lm5Ue9ddX7Z6ePlvf8EM5Dhd61O2h6Ikyx32RP4
         uM8LHceFoAAc/BV/r1hvyJpAbINqsEJO8CHSNhCiLT4wDixs0+el/oxTMKkwugSHNcfe
         ktUMY/YzTdlI0u0YPi9nStzwb0u8xcAXUXYeC0mtC0CnIuFDBICJxvV9kNFT/MbRSTTp
         ZTrQ==
X-Gm-Message-State: AOAM532jRNaVZ3MMSxpHnwcirNUszAXji6OVe3xvt5qg1ljVDqLYmOQ4
        amZ4Nac2OKI9V90C4E4lkwc=
X-Google-Smtp-Source: ABdhPJyQ+scBCD4od+R4avfpVimNAa0Z95s5NsyFUax2wvVPRfSxVTo+Ksh5jwN91DHVBIApoFfmyA==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr1235311ljj.376.1598220041907;
        Sun, 23 Aug 2020 15:00:41 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:41 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/8] phy: lantiq: vrx200-pcie: Constify ltq_vrx200_pcie_phy_ops
Date:   Mon, 24 Aug 2020 00:00:22 +0200
Message-Id: <20200823220025.17588-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage is to pass its address to devm_phy_create() which takes a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
index 2ff9a48d833e..22c5698123cf 100644
--- a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
+++ b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
@@ -349,7 +349,7 @@ static int ltq_vrx200_pcie_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static struct phy_ops ltq_vrx200_pcie_phy_ops = {
+static const struct phy_ops ltq_vrx200_pcie_phy_ops = {
 	.init		= ltq_vrx200_pcie_phy_init,
 	.exit		= ltq_vrx200_pcie_phy_exit,
 	.power_on	= ltq_vrx200_pcie_phy_power_on,
-- 
2.28.0

