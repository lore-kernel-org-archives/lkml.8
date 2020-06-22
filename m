Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E425C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F20C2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y41so2TC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgFVW1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgFVW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68EC0617BC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n6so14618970otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+juBxJkHGKzzKKvIVu7gHfkhqodYtvY6iJYcZHkOhCc=;
        b=y41so2TCCnlvbDE+KJrDyfB6UPI6hcbuYXAEZjoDONYl/f7tF2Y3Tc0KHevx/97i+/
         XnVL449Msiltwz4Mcp9I6pdCo6O7w4RyxH54lz1DoZzm9SREMfG1x4ub1BinKJ4kGJa1
         ijQFzPzDF77aN+rfnft5wLoDXEiZ15dVBt/NBcn6CzQoC77yPsQHXdm5l5ALG1hr27SX
         UUQd25MVCtOnc1HawsKpPIA9ntV6xWoIS+/gbFOuKC55dJA8DJ+xZQEylm7jq3jfJFXx
         fjk3/bq9z91ALoqLA7HYwYCIicA60bw+WsK2rqTEHuptB87nrJFiWqUFvo4SieH66Ux0
         bgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+juBxJkHGKzzKKvIVu7gHfkhqodYtvY6iJYcZHkOhCc=;
        b=UtFcjX5VzWIkm1Jy3kkS4D3IkcuSSJr8VOeYAGDkz9MnsxeETKS+usSMAkdMCUFNi5
         /SrLzwAavOKDhXhW943uj/rCxAMgyJdS06ZIR+Sskd/v7XW6XwoS3qKZlbgc7vrmspUY
         LdPVpxU0ZHkDHaWDRM//2ghq9ArmFSLGSyQlW7lHPdti73ci/ZWr/kBTgpm8BUisDSva
         ZiayG/Gym6zULsgTRMzlDMvRKbYrWYMAskB7RIGryXMM+yJ8IjnXyWt2vP2llOcop1yG
         Fj7uCA0mDvEvSH7x/mvQW/WJWfOWh4xugPh3D+3EN6kTrOkTV2Rsu/Rf0oEytF8MFsy4
         G1nA==
X-Gm-Message-State: AOAM5337hPEHZyNMlAEVnamfgxZBYSfHFtC88eog2x286ONm1enuqyB7
        8KICMvW+lzRkqWV1Mzn5aOduYw==
X-Google-Smtp-Source: ABdhPJzGgP62muNTyA44IB7D3xkRwJUqX16W9zjWiUZgOSB7gVom5EmeKYmkBce9IQOufHUmRXJ9xg==
X-Received: by 2002:a9d:664e:: with SMTP id q14mr16811881otm.49.1592864865002;
        Mon, 22 Jun 2020 15:27:45 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] arm64: defconfig: Enable Qualcomm IPCC driver
Date:   Mon, 22 Jun 2020 15:27:47 -0700
Message-Id: <20200622222747.717306-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPCC hardware block provides a mechanism for triggering interrupts
between co-processors in recent Qualcomm SoCs. This is used as basis for
most form of communication between co-processors, so enable this
support.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5848799dcad0..b3d13e1a052a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -834,6 +834,7 @@ CONFIG_IMX_MBOX=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
+CONFIG_QCOM_IPCC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
-- 
2.26.2

