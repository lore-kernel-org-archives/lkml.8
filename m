Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2814C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12072067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hakBSGCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgERVzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgERVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:55:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A403C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:55:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g20so5518042qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMJq7D1TcgA0SXH41T+7SkI8WgfsBEoon2jJRC0M3OQ=;
        b=hakBSGCC/Bxhaghx3THB7aqxE1Vz4DNAXDz690ML/sque4E/hU9AQEkM4zzKbZXAq4
         cD4RsAHHUOkJvJ0tTxalqMICUWs2Wv5el+os4VOQm6gbPx27BJ8ppVGepqpSqMs9qFza
         oFHQViCLSOKBngszHtApFMbwtcIQWl8/Nq0RsN4JzwbjA4ECyMo9B8etKJvC01jJMCgL
         s5SLS0T6FZgxnqYSIFhKC7cJr3/7bihB+fxuGMJ2NCGPY6mJa6c/VN5uYwAFjfTGdxet
         cuy7vYhj8onC2NawDv1PWs7njjxWMEHQ1sTrZ5udQM/ix/X3I+J7kHGo874mk10RscbE
         5sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMJq7D1TcgA0SXH41T+7SkI8WgfsBEoon2jJRC0M3OQ=;
        b=fL/YxzKLiNz20yekeyJLpeqFuKEWwjAXM+rCfgO/I//5/GVvUYwx/Ri4hA217HxbDe
         boJJGybjPgpj7Ygr4jP4SUNpN6+Wtt3aw0l6OE9KbPXYkYkm4HQlOvlUf+0cI8zYNwyc
         KwkgxmIhGVuzFUXOxdTOLs/1yXEdCttMPB7NlUYNIt974kXtB4jTtbtmNuBHwI5BsTLO
         29l90pwIXXdNpF7W9DBQTngyvncsoB78cAepIMKm3HQZgb3trY9w4fkABnjGY86wuOc/
         yL8tAu5JMYkwjZdGfUoHdIb0y9Z92luXaTjoyGIRkzbT8X0dy3DsfwmkMM909uqYmJjx
         WuaQ==
X-Gm-Message-State: AOAM530Oq1weUniAh52SafW0O6FOluWFLBsKgt1BMaddif7cSI560sH3
        by4M4CkRTyJNt6ojSvPIewuuhg==
X-Google-Smtp-Source: ABdhPJwAGdttXy1n6tqCK8mjNtebI6rFiDe/cbeHmK4x4jbwCAfcs0Ef3huYDlF+fs+gBEz9wshcIg==
X-Received: by 2002:ad4:4c4f:: with SMTP id cs15mr17209784qvb.117.1589838899553;
        Mon, 18 May 2020 14:54:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m1sm10490739qtf.72.2020.05.18.14.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:54:59 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, evgreen@chromium.org,
        subashab@codeaurora.org, cpratapa@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: enable Qualcomm IPA and RMNet modules
Date:   Mon, 18 May 2020 16:54:55 -0500
Message-Id: <20200518215455.10095-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable building the Qualcomm IPA driver as a kernel module.  To be
useful, the IPA driver also requires RMNet, so enable building that
as a module as well.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9c6500b71bc6..56261fd7ea8d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -306,6 +306,7 @@ CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
+CONFIG_RMNET=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
@@ -313,6 +314,7 @@ CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
 CONFIG_TI_K3_AM65_CPSW_NUSS=y
+CONFIG_QCOM_IPA=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
 CONFIG_AQUANTIA_PHY=y
-- 
2.20.1

