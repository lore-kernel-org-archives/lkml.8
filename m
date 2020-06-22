Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E720702
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxhcvSlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgFVWAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgFVWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:00:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2517C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:00:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so14525652otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssWsAVdFC4LIGEQJ/VJ7yId3i3p45oukKnw+xo78VEk=;
        b=IxhcvSlpNYuQCTw0Lrdo+5HWUpG9/oG2cIvSJU0AysEb6Q3+C20QYbWhQXjpDm0NCG
         HeaMsWI9CrY+bNkFIdUMzjpo+EWdLOU+nr8+nbnw+UhwvLwYjBPL5eSHzdKl4u+Bq3Wv
         /G81w2Dj1ahzwZoNeOTnviQP/sjuRpbD1NxhB1VDIfn16Xrj7CGbl/hAj/ef6g9SB9i0
         pRBkBtd9UBh3MPHPS8Y5qHYgmYNiETTTxYWq5lfx3AfLDp9ThVGPBywsw3QFRd7mMDVY
         GqPgQHuyHGcA4wrw/LzCJX5S4Ay0Hmvzbu06ZvUHfOvkZskWpB+6h9oz8gvf8r+zJ82j
         oCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssWsAVdFC4LIGEQJ/VJ7yId3i3p45oukKnw+xo78VEk=;
        b=nuHwBoo9lH//cSxoq+atJ27muFUWcjZX3K+7gTfhmLEnX6rwKa8y4oIhK+j6zIOkGq
         b6SZCorLZ5OWi4h681VDVp0VcdbtWIApjGxLtjtr+LDJSqQjFe2WjXmenkxdXWMDzcYn
         Vu2Ol9pGxg3kwNnKBtfOWbhqg8Tzs533f1w6MBbYktWfOlFnuoZeH3sKaARZcqXzdqHP
         ykU05Ry9S1/TrXYCBdaKQBnmwC6PXg3FsaAx5YWqCqW5YAnYdM6Rbtu/UFezQpJE3Nbi
         EBEEpGM5L0an7SMYwOs2IEUb7N9kvwYrM6KaVlQQLy8G6EcI3m2eU+BWOhHNmhIuzKRr
         yG+g==
X-Gm-Message-State: AOAM533XL9w9c7fHlKKwXx57Ade6I/pub7ExZ3Z5fCP5DczfON81DytV
        cpA5pSP83kSd0rWwTsKxjQvKSs4HqNM=
X-Google-Smtp-Source: ABdhPJyYxWll1PhMA3qiAlsU+2CmqUgM/1ltQs5y0nw479HtQmeyac4j2CB/TDEIlkRuphVxnksC/Q==
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr15925806oov.71.1592863238529;
        Mon, 22 Jun 2020 15:00:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v2sm3594714otb.70.2020.06.22.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:00:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SM8250 pinctrl driver
Date:   Mon, 22 Jun 2020 15:00:48 -0700
Message-Id: <20200622220048.717073-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8250 pinctrl driver provides pin configuration, pin muxing and
GPIO pin control for many pins on the SM8250 SoC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b3d13e1a052a..bbbaaab5a4fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -469,6 +469,7 @@ CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
+CONFIG_PINCTRL_SM8250=y
 CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
-- 
2.26.2

